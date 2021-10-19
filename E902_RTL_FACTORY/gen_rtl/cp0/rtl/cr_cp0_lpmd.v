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

// &ModuleBeg; @24
module cr_cp0_lpmd(
  cache_cp0_lpmd_ack,
  cp0_cache_lpmd_req,
  cp0_had_lpmd_b,
  cp0_ifu_in_lpmd,
  cp0_ifu_lpmd_req,
  cp0_sysio_ipend_b,
  cp0_sysio_lpmd_b,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  had_yy_xx_dbg,
  ifu_cp0_lpmd_ack,
  inst_lpmd,
  iu_cp0_ex_sel,
  iu_cp0_lp_wk_int,
  iu_yy_xx_dbgon,
  iu_yy_xx_flush,
  iui_lpmd_inst_lpmd_for_data,
  lpmd_iui_stall,
  lpmd_sm_clk,
  lpmd_sm_clk_en,
  pad_yy_gate_clk_en_b,
  status_lpmd_lpmd,
  sysio_cp0_sys_view_lpmd_b
);

// &Ports; @25
input          cache_cp0_lpmd_ack;         
input          cpurst_b;                   
input          forever_cpuclk;             
input          had_yy_xx_dbg;              
input          ifu_cp0_lpmd_ack;           
input          inst_lpmd;                  
input          iu_cp0_ex_sel;              
input          iu_cp0_lp_wk_int;           
input          iu_yy_xx_dbgon;             
input          iu_yy_xx_flush;             
input          iui_lpmd_inst_lpmd_for_data; 
input          lpmd_sm_clk;                
input          pad_yy_gate_clk_en_b;       
input   [1:0]  status_lpmd_lpmd;           
input   [1:0]  sysio_cp0_sys_view_lpmd_b;  
output         cp0_cache_lpmd_req;         
output  [1:0]  cp0_had_lpmd_b;             
output         cp0_ifu_in_lpmd;            
output         cp0_ifu_lpmd_req;           
output         cp0_sysio_ipend_b;          
output  [1:0]  cp0_sysio_lpmd_b;           
output         cp0_yy_clk_en;              
output         lpmd_iui_stall;             
output         lpmd_sm_clk_en;             

// &Regs; @26
reg     [1:0]  cur_state;                  
reg     [1:0]  lpmd_b;                     
reg     [1:0]  next_state;                 

// &Wires; @27
wire           cache_cp0_lpmd_ack;         
wire           cp0_cache_lpmd_req;         
wire    [1:0]  cp0_had_lpmd_b;             
wire           cp0_ifu_in_lpmd;            
wire           cp0_ifu_lpmd_req;           
wire           cp0_sysio_ipend_b;          
wire    [1:0]  cp0_sysio_lpmd_b;           
wire           cp0_yy_clk_en;              
wire           cpu_in_lpmd;                
wire           cpu_in_lpmd_core_view;      
wire           cpu_in_lpmd_sys_view;       
wire           cpurst_b;                   
wire           forever_cpuclk;             
wire           had_yy_xx_dbg;              
wire           ifu_cp0_lpmd_ack;           
wire           inst_lpmd;                  
wire           iu_cp0_ex_sel;              
wire           iu_cp0_lp_wk_int;           
wire           iu_yy_xx_dbgon;             
wire           iu_yy_xx_flush;             
wire           iui_lpmd_inst_lpmd_for_data; 
wire           lpmd_ack;                   
wire           lpmd_clk;                   
wire           lpmd_clk_en;                
wire           lpmd_in_wait_state;         
wire           lpmd_iui_stall;             
wire           lpmd_sm_clk;                
wire           lpmd_sm_clk_en;             
wire           lpmd_start;                 
wire           pad_yy_gate_clk_en_b;       
wire    [1:0]  status_lpmd_lpmd;           
wire    [1:0]  sys_lpmd_b;                 
wire    [1:0]  sysio_cp0_sys_view_lpmd_b;  


parameter IDLE   = 2'b00;
parameter WFACK  = 2'b01;
parameter WFCPLT = 2'b11;
parameter CPLT   = 2'b10;

//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign lpmd_sm_clk_en = iu_cp0_ex_sel || (cur_state != IDLE); 

assign lpmd_clk_en = had_yy_xx_dbg || iu_cp0_lp_wk_int || iu_yy_xx_dbgon
                     || lpmd_start;
// &Instance("gated_clk_cell", "x_lpmd_gated_clk"); @41
gated_clk_cell  x_lpmd_gated_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (lpmd_clk            ),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (1'b0                ),
  .module_en            (lpmd_clk_en         ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in      (forever_cpuclk), @42
//          .external_en (1'b0), @43
//          .global_en   (1'b1), @44
//          .module_en   (lpmd_clk_en), @45
//          .local_en    (1'b0), @46
//          .clk_out     (lpmd_clk)); @47

//-----------------------------------------------
//   Handling the low power operating modes
//-----------------------------------------------

//-----------------------------------------------------
// Request the BIU to enter low power mode and do
// not accept any more transaction from IFU or LSU
//-----------------------------------------------------

//-------------------FSM of lpmd req logic-----------------
// State Description:
// IDLE     : no lpmd instruction (wait,stop,doze)
// WFACK    : request sysio and wait for sysio ack
//           the lpmd request        
//-----------------------------------------------------

always @(posedge lpmd_sm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cur_state[1:0] <= IDLE;
  else if(iu_yy_xx_flush)
    cur_state[1:0] <= IDLE;
  else
    cur_state[1:0] <= next_state[1:0];
end

// &CombBeg; @75
always @( cur_state
       or lpmd_start
       or inst_lpmd
       or cpu_in_lpmd)
begin
  case(cur_state)
  IDLE       : if(inst_lpmd)
                next_state = WFACK;
              else
                next_state = IDLE;
  WFACK      : if(lpmd_start)
                next_state = WFCPLT;
              else
                next_state = WFACK;
  WFCPLT    : if(!cpu_in_lpmd)
                next_state = CPLT;
              else
                next_state = WFCPLT;
  CPLT      :   next_state = IDLE;
  default   :   next_state = IDLE;
  endcase
// &CombEnd; @92
end

assign lpmd_in_wait_state = (cur_state == WFACK);

//-------------------control signal by lpmd FSM-------------
assign lpmd_iui_stall = (cur_state == IDLE) && iui_lpmd_inst_lpmd_for_data 
                        || (cur_state == WFACK)
                        || (cur_state == WFCPLT);
//req if entering into WFACK state
//in CK802, lsu transfer will take up EX stage, when low power
//instruction executing, no load/store is in process, so do not
//need handshake with LSU
assign cp0_ifu_lpmd_req = lpmd_in_wait_state;
assign cp0_cache_lpmd_req = lpmd_in_wait_state;

//-----------------------------------------------------
//               lpmd request ack 
//-----------------------------------------------------
assign lpmd_ack = ifu_cp0_lpmd_ack && cache_cp0_lpmd_ack;
assign lpmd_start = lpmd_ack;

//-----------------------------------------------------
// Send lpmd bits to BIU and HAD, when
// cp0 can enter low power mode (get sysio_cp0_no_op)
//-----------------------------------------------------
// &Force("output","cp0_sysio_lpmd_b"); @117

always @(posedge lpmd_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    lpmd_b[1:0] <= 2'b11;
  else if(had_yy_xx_dbg || iu_cp0_lp_wk_int || iu_yy_xx_dbgon)
    lpmd_b[1:0] <= 2'b11;
  else if(lpmd_start && !cpu_in_lpmd)
  begin
    lpmd_b[1:0] <= status_lpmd_lpmd[1:0];
  end
  else
    lpmd_b[1:0] <= lpmd_b[1:0];
end

assign cp0_had_lpmd_b[1:0] = lpmd_b[1:0];
assign cp0_sysio_lpmd_b[1:0] = lpmd_b[1:0];
//the cpu condsider both pm bit in cp0(cpu view) and sysio(soc view)
assign sys_lpmd_b[1:0] = sysio_cp0_sys_view_lpmd_b[1:0];
assign cpu_in_lpmd_sys_view = !(sys_lpmd_b[1] & sys_lpmd_b[0]);
//cpu ack in debug mode
assign cpu_in_lpmd_core_view = !(lpmd_b[1] & lpmd_b[0]);

assign cpu_in_lpmd = cpu_in_lpmd_sys_view || cpu_in_lpmd_core_view;

//Indicate in lpmd mode for IFU request mask
assign cp0_ifu_in_lpmd  = cpu_in_lpmd;

//======================================================
//Generate clock enable signal to clock module
//Disable the clock when low power mode is entered
//======================================================
// &Force("output","cp0_yy_clk_en"); @150
assign cp0_yy_clk_en = !cpu_in_lpmd;

//--------------------------------------------------------
//Indicate that an asynchronous raw interrupt request 
//has been recognized internally by the processor.
//--------------------------------------------------------
assign cp0_sysio_ipend_b = !iu_cp0_lp_wk_int;

// &ModuleEnd; @159
endmodule


