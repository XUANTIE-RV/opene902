/*Copyright 2018-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
module cr_had_pin(
  clk_en,
  cpuclk,
  had_pad_jdb_pm,
  had_pad_jtg_tms_o,
  had_pad_jtg_tms_oe,
  hadrst_b,
  iu_yy_xx_dbgon,
  jtag2_pin_tms_o,
  jtag2_pin_tms_oe,
  pad_had_jtg_tms_i,
  pin_ctrl_jdb_req,
  pin_sm_tap_en,
  pin_xx_tms_i,
  regs_pin_pm,
  tclk,
  trst_b
);

// &Ports; @21
input          clk_en;            
input          cpuclk;            
input          hadrst_b;          
input          iu_yy_xx_dbgon;    
input          jtag2_pin_tms_o;   
input          jtag2_pin_tms_oe;  
input          pad_had_jtg_tms_i; 
input   [1:0]  regs_pin_pm;       
input          tclk;              
input          trst_b;            
output  [1:0]  had_pad_jdb_pm;    
output         had_pad_jtg_tms_o; 
output         had_pad_jtg_tms_oe; 
output         pin_ctrl_jdb_req;  
output         pin_sm_tap_en;     
output         pin_xx_tms_i;      

// &Regs; @22
reg            had_pad_jdb_ack_b; 
reg     [1:0]  had_pad_jdb_pm;    
reg            jdb_ack_clr;       

// &Wires; @23
wire           clk_en;            
wire           cpuclk;            
wire           had_pad_jtg_tap_on; 
wire           had_pad_jtg_tms_o; 
wire           had_pad_jtg_tms_oe; 
wire           hadrst_b;          
wire           iu_yy_xx_dbgon;    
wire    [1:0]  jdb_pm;            
wire           jdb_tap_en;        
wire           jtag2_pin_tms_o;   
wire           jtag2_pin_tms_oe;  
wire           pad_had_jtg_tap_en; 
wire           pad_had_jtg_tms_i; 
wire           pin_ctrl_jdb_req;  
wire           pin_sm_tap_en;     
wire           pin_xx_tms_i;      
wire    [1:0]  regs_pin_pm;       
wire           tclk;              
wire           trst_b;            


//==============================================================================
// Had pin in
//==============================================================================
// // &Force("input","pad_had_jdb_req_b"); @28
//==========================================================
// pad_had_jdb_req_b is asynchronous with Tclk,
// flop two Tclk cycles to generate jdb_tap_en and eleminate metastability
//==========================================================

//always @(posedge tclk or negedge trst_b)
//begin
//  if (!trst_b) begin
//    jdb_req_b_ff1 <= 1'b1;
//    jdb_req_b_ff2 <= 1'b1;
//  end
//  else begin
//    jdb_req_b_ff1 <= pad_had_jdb_req_b;
//    jdb_req_b_ff2 <= jdb_req_b_ff1;
//  end
//end

//assign jdb_tap_en = !jdb_req_b_ff2;
assign jdb_tap_en = 1'b0;

//==========================================================
// Asychronous debug request generated to HAD control path.
// flop two cpuclk to generate jbd_req and eleminate metastability
//==========================================================

//always @(posedge cpuclk or negedge hadrst_b)
//begin
//  if (!hadrst_b) begin
//    jdb_req_b_ff3 <= 1'b1;
//    jdb_req_b_ff4 <= 1'b1;
//  end
//  else begin
//    jdb_req_b_ff3 <= pad_had_jdb_req_b;
//    jdb_req_b_ff4 <= jdb_req_b_ff3;
//  end
//end

//assign pin_ctrl_jdb_req = !jdb_req_b_ff4;
assign pin_ctrl_jdb_req = 1'b0;

//==========================================================
// External tap enable signal, flop two Tclk cycles to eleminate metastability
//==========================================================

// always @(posedge tclk or negedge trst_b)
// begin
//   if (!trst_b) begin
//     jtg_tap_en_ff1 <= 1'b0;
//     jtg_tap_en_ff2 <= 1'b0;
//   end
//   else begin
//     jtg_tap_en_ff1 <= pad_had_jtg_tap_en;
//     jtg_tap_en_ff2 <= jtg_tap_en_ff1;
//   end  
// end
// 
// assign jtg_tap_en = jtg_tap_en_ff2;

//==========================================================
// TAP enable signal has two sources:
// 1. jdb_tap_en
// 2. jtg_tap_en
//==========================================================

// Modified Reason: to eleminate relucdant cycles to enter IDLE state
// and keep compatability of software.
// &Force("output", "pin_sm_tap_en"); @95
//assign pin_sm_tap_en = jdb_tap_en || jtg_tap_en;
assign pad_had_jtg_tap_en = 1'b1;
assign pin_sm_tap_en = jdb_tap_en || pad_had_jtg_tap_en;

//==============================================================================
// Had pin out
//==============================================================================

//==========================================================
// CPU mode indicator, asychronous to Tclk
//==========================================================

assign jdb_pm[1:0] = regs_pin_pm[1:0];

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
  begin
   had_pad_jdb_pm[1:0] <= 2'b0;
  end
  else if(clk_en)
  begin
   had_pad_jdb_pm[1:0] <= jdb_pm[1:0];
  end
end
//==========================================================
// CPU output debug ack signal, keep at least 2 tclk LOW. 
// No sychronization is needed though iu_yy_xx_dbgon is cpuclk signal.
//==========================================================

// &Force("nonport", "had_pad_jdb_ack_b"); @126

always @(posedge tclk or negedge trst_b)
begin
  if (!trst_b)
    had_pad_jdb_ack_b <= 1'b1;
  else if (jdb_ack_clr)
    had_pad_jdb_ack_b <= 1'b1;
  else if (iu_yy_xx_dbgon)
    had_pad_jdb_ack_b <= 1'b0;
  else
    had_pad_jdb_ack_b <= had_pad_jdb_ack_b;
end

always @(posedge tclk or negedge trst_b)
begin
  if (!trst_b)
    jdb_ack_clr <= 1'b0;
  else if (!had_pad_jdb_ack_b)
    jdb_ack_clr <= 1'b1;
  else if (!iu_yy_xx_dbgon)
    jdb_ack_clr <= 1'b0;
  else
    jdb_ack_clr <= jdb_ack_clr;
end

//==========================================================
// TAP controller status indicator
//==========================================================

assign had_pad_jtg_tap_on = pin_sm_tap_en;
// &Force("nonport", "had_pad_jtg_tap_on"); @157

assign pin_xx_tms_i = pad_had_jtg_tms_i;
assign had_pad_jtg_tms_o = jtag2_pin_tms_o;
assign had_pad_jtg_tms_oe = jtag2_pin_tms_oe;

// &ModuleEnd; @170
endmodule



