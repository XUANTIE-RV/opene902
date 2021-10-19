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
module cr_had_jtag2(
  cpuclk,
  hadrst_b,
  jtag2_pin_tms_o,
  jtag2_pin_tms_oe,
  jtag_regs_srst,
  jtag_regs_update_hacr,
  jtag_xx_capture_dr,
  jtag_xx_capture_dr_mask,
  jtag_xx_data,
  jtag_xx_update_dr,
  pin_sm_tap_en,
  pin_xx_tms_i,
  regs_jtag_data,
  regs_jtag_hacr_rw,
  regs_jtag_reg16_sel,
  regs_jtag_reg8_sel,
  sm_xx_tap_on,
  tclk,
  trst_b
);

// &Ports; @21
input           cpuclk;                 
input           hadrst_b;               
input           pin_sm_tap_en;          
input           pin_xx_tms_i;           
input   [31:0]  regs_jtag_data;         
input           regs_jtag_hacr_rw;      
input           regs_jtag_reg16_sel;    
input           regs_jtag_reg8_sel;     
input           tclk;                   
input           trst_b;                 
output          jtag2_pin_tms_o;        
output          jtag2_pin_tms_oe;       
output          jtag_regs_srst;         
output          jtag_regs_update_hacr;  
output          jtag_xx_capture_dr;     
output          jtag_xx_capture_dr_mask; 
output  [31:0]  jtag_xx_data;           
output          jtag_xx_update_dr;      
output          sm_xx_tap_on;           

// &Regs; @22
reg             parity;                 
reg     [31:0]  shifter;                
reg     [31:0]  shifter_pre;            
reg     [3 :0]  sm2_cur_st;             
reg     [4 :0]  sm2_data_counter;       
reg     [3 :0]  sm2_nxt_st;             
reg             sm2_parity;             
reg             sm2_read_vld;           
reg     [1 :0]  sm2_rs;                 
reg             sm2_rs_counter;         
reg     [6 :0]  sm2_rst_cnt;            
reg             tdo;                    
reg             tms_oe;                 

// &Wires; @23
wire            cpuclk;                 
wire            had_pad_wakeup_req_b;   
wire            hadrst_b;               
wire            jtag2_pin_tms_o;        
wire            jtag2_pin_tms_oe;       
wire            jtag_regs_srst;         
wire            jtag_regs_update_hacr;  
wire            jtag_xx_capture_dr;     
wire            jtag_xx_capture_dr_mask; 
wire    [31:0]  jtag_xx_data;           
wire            jtag_xx_update_dr;      
wire            pin_sm_tap_en;          
wire            pin_xx_tms_i;           
wire    [31:0]  regs_jtag_data;         
wire            sm2_capture_dr;         
wire            sm2_capture_dr_cpu;     
wire            sm2_capture_dr_mask;    
wire            sm2_capture_dr_mask_cpu; 
wire            sm2_load_rw;            
wire            sm2_parity_vld;         
wire            sm2_rs_cdic_dr_sel;     
wire            sm2_rs_had_dr_sel;      
wire            sm2_rs_had_ir_sel;      
wire            sm2_rst_vld;            
wire            sm2_rst_vld_cpu;        
wire            sm2_shift_dr;           
wire            sm2_shift_ir;           
wire            sm2_shift_par;          
wire            sm2_shift_sync;         
wire            sm2_shift_vld;          
wire            sm2_start_vld;          
wire            sm2_sync_vld;           
wire            sm2_trn1;               
wire            sm2_trn2;               
wire            sm2_update_dr;          
wire            sm2_update_dr_cpu;      
wire            sm2_update_ir;          
wire            sm2_update_ir_cpu;      
wire            sm_xx_tap_on;           
wire            tclk;                   
wire            tdi;                    
wire            tms_i;                  
wire            trst_b;                 


//==============================================================================
// TAP controller state encoding: using Gray code for low power
// TAP controller state machine: Tclk domain
//==============================================================================
// state machine state definition
parameter TAP2_IDLE   = 4'b0000;
parameter TAP2_START  = 4'b0001;
parameter TAP2_RW     = 4'b0011;
parameter TAP2_RS     = 4'b0010;
parameter TAP2_TRN1   = 4'b0110;
parameter TAP2_DATA   = 4'b0111;
parameter TAP2_SYNC   = 4'b0101;
parameter TAP2_PARITY = 4'b0100;
parameter TAP2_TRN2   = 4'b1100;

// state machine statement No. 1
// state machine state transfer, tclk trigged
always @(posedge tclk or negedge trst_b)
begin
  if (!trst_b)
    sm2_cur_st[3:0] <= TAP2_IDLE;
  else if (sm2_rst_vld && tms_i)
    sm2_cur_st[3:0] <= TAP2_IDLE;
  else
    sm2_cur_st[3:0] <= sm2_nxt_st[3:0];
end

// jtag2 syncronous reset logic
always @(posedge tclk or negedge trst_b)
begin
  if (!trst_b)
    sm2_rst_cnt[6:0] <= 7'd80;
  else begin
    if (!tms_i)
      sm2_rst_cnt[6:0] <= 7'd80;
    else if (sm2_rst_cnt[6:0] != 7'd0)
      sm2_rst_cnt[6:0] <= sm2_rst_cnt[6:0] - 7'd1;
    else
      sm2_rst_cnt[6:0] <= 7'd80;
  end
end

assign sm2_rst_vld = (sm2_rst_cnt[6:0] == 7'd00);

//==========================================================
// sm2_rst_vld is used to reset registers in cpuclk domain,
// thus synchronization is needed.
//==========================================================
// &Instance("cr_had_sync", "x_cr_had_sync_sm2_rst"); @73
cr_had_sync  x_cr_had_sync_sm2_rst (
  .clk1            (cpuclk         ),
  .clk2            (tclk           ),
  .rst1_b          (hadrst_b       ),
  .rst2_b          (trst_b         ),
  .sync_in         (sm2_rst_vld    ),
  .sync_out        (sm2_rst_vld_cpu)
);

// &Connect(.clk1           (cpuclk), @74
//          .clk2           (tclk), @75
//          .rst1_b         (hadrst_b), @76
//          .rst2_b         (trst_b), @77
//          .sync_in        (sm2_rst_vld), @78
//          .sync_out       (sm2_rst_vld_cpu) @79
//         ); @80
assign jtag_regs_srst = sm2_rst_vld_cpu;

// state machine statement No. 2
always @( * )
begin
  case (sm2_cur_st[3:0])
    TAP2_IDLE : begin
      if (pin_sm_tap_en) begin
        if (!tms_i)
          sm2_nxt_st[3:0] = TAP2_RW;
        else
          sm2_nxt_st[3:0] = TAP2_START;
      end
      else
        sm2_nxt_st[3:0] = TAP2_IDLE;
    end
    TAP2_START : begin
      if (!tms_i) // sample START bit, logic 0
        sm2_nxt_st[3:0] = TAP2_RW;
      else
        sm2_nxt_st[3:0] = TAP2_START;
    end
    TAP2_RW : begin  // RnW bit, 1=Read Op, 0=Write Op
      sm2_nxt_st[3:0] = TAP2_RS;
    end
    TAP2_RS : begin // RS[1:0] - Register Group Select
      if (sm2_rs_counter == 1'b0)
        sm2_nxt_st[3:0] = TAP2_TRN1;
      else
        sm2_nxt_st[3:0] = TAP2_RS;
    end
    TAP2_TRN1 : begin // Turn Around 1
      if (sm2_read_vld)  // Read operation need a sync cycle
        sm2_nxt_st[3:0] = TAP2_SYNC;
      else               // write operation
        sm2_nxt_st[3:0] = TAP2_DATA;
    end
    TAP2_SYNC : begin
      sm2_nxt_st[3:0] = TAP2_DATA;
    end
    TAP2_DATA : begin // IR or DR, Sample or Set
      if (sm2_data_counter[4:0] == 5'b0)
        sm2_nxt_st[3:0] = TAP2_PARITY;
      else
        sm2_nxt_st[3:0] = TAP2_DATA;
    end
    TAP2_PARITY : begin
      sm2_nxt_st[3:0] = TAP2_TRN2;
    end
    TAP2_TRN2 : begin
      sm2_nxt_st[3:0] = TAP2_START;
    end
    default : begin
      sm2_nxt_st[3:0] = TAP2_IDLE;
    end
  endcase
end

// state machine statement No. 3
//==========================================================
// state machine status
assign sm2_load_rw    = sm2_cur_st[3:0] == TAP2_RW;
assign sm2_trn1       = sm2_cur_st[3:0] == TAP2_TRN1;
assign sm2_trn2       = sm2_cur_st[3:0] == TAP2_TRN2;
assign sm2_start_vld  = sm2_cur_st[3:0] == TAP2_RW;
assign sm2_shift_vld  = sm2_cur_st[3:0] == TAP2_DATA;
assign sm2_parity_vld = sm2_cur_st[3:0] == TAP2_PARITY;
assign sm2_sync_vld   = sm2_cur_st[3:0] == TAP2_SYNC;

assign sm2_shift_par  = sm2_parity_vld;
assign sm2_shift_sync = sm2_sync_vld;

//======================================
// update IR, DR, sync with cpuclk
assign sm2_shift_ir   = sm2_rs_had_ir_sel && sm2_shift_vld;
assign sm2_shift_dr   = sm2_rs_had_dr_sel && sm2_shift_vld;
assign sm2_update_ir  = sm2_rs_had_ir_sel && sm2_trn2      && (!sm2_parity);
assign sm2_update_dr  = sm2_rs_had_dr_sel && !sm2_read_vld && sm2_trn2 && (!sm2_parity);
assign sm2_capture_dr = sm2_rs_had_dr_sel &&  sm2_read_vld && sm2_trn1;

// &Instance("cr_had_sync", "x_cr_had_sync_ir"); @161
cr_had_sync  x_cr_had_sync_ir (
  .clk1              (cpuclk           ),
  .clk2              (tclk             ),
  .rst1_b            (hadrst_b         ),
  .rst2_b            (trst_b           ),
  .sync_in           (sm2_update_ir    ),
  .sync_out          (sm2_update_ir_cpu)
);

// &Connect(.clk1           (cpuclk), @162
//          .clk2           (tclk), @163
//          .rst1_b         (hadrst_b), @164
//          .rst2_b         (trst_b), @165
//          .sync_in        (sm2_update_ir), @166
//          .sync_out       (sm2_update_ir_cpu) @167
//         ); @168

// &Instance("cr_had_sync", "x_cr_had_sync_dr"); @170
cr_had_sync  x_cr_had_sync_dr (
  .clk1              (cpuclk           ),
  .clk2              (tclk             ),
  .rst1_b            (hadrst_b         ),
  .rst2_b            (trst_b           ),
  .sync_in           (sm2_update_dr    ),
  .sync_out          (sm2_update_dr_cpu)
);

// &Connect(.clk1           (cpuclk), @171
//          .clk2           (tclk), @172
//          .rst1_b         (hadrst_b), @173
//          .rst2_b         (trst_b), @174
//          .sync_in        (sm2_update_dr), @175
//          .sync_out       (sm2_update_dr_cpu) @176
//         ); @177

// &Instance("cr_had_sync", "x_cr_had_sync_cap_dr"); @180
cr_had_sync  x_cr_had_sync_cap_dr (
  .clk1               (cpuclk            ),
  .clk2               (tclk              ),
  .rst1_b             (hadrst_b          ),
  .rst2_b             (trst_b            ),
  .sync_in            (sm2_capture_dr    ),
  .sync_out           (sm2_capture_dr_cpu)
);

// &Connect(.clk1           (cpuclk), @181
//          .clk2           (tclk), @182
//          .rst1_b         (hadrst_b), @183
//          .rst2_b         (trst_b), @184
//          .sync_in        (sm2_capture_dr), @185
//          .sync_out       (sm2_capture_dr_cpu) @186
//         ); @187
assign jtag_xx_capture_dr    = sm2_capture_dr_cpu; 

// &Instance("cr_had_sync", "x_cr_had_sync_cap_dr"); @194
// &Connect(.clk1           (cpuclk), @195
//          .clk2           (tclk), @196
//          .rst1_b         (hadrst_b), @197
//          .rst2_b         (trst_b), @198
//          .sync_in        (sm2_capture_dr), @199
//          .sync_out       (sm2_capture_dr_cpu) @200
//         );   @201

// &Instance("cr_had_sync_level", "x_cr_had_sync_cap_dr_mask"); @209
// &Connect(.clk1           (cpuclk), @210
//          .clk2           (tclk), @211
//          .rst1_b         (hadrst_b), @212
//          .rst2_b         (trst_b), @213
//          .sync_in        (sm2_capture_dr_mask), @214
//          .sync_out       (sm2_capture_dr_mask_cpu) @215
//         ); @216
  assign sm2_capture_dr_mask = (sm2_cur_st[3:0] == TAP2_RS)
                            || (sm2_cur_st[3:0] == TAP2_TRN1);
//   &Instance("cr_had_sync_level", "x_cr_had_sync_cap_dr_mask"); @222
cr_had_sync_level  x_cr_had_sync_cap_dr_mask (
  .clk1                    (cpuclk                 ),
  .clk2                    (tclk                   ),
  .rst1_b                  (hadrst_b               ),
  .rst2_b                  (trst_b                 ),
  .sync_in                 (sm2_capture_dr_mask    ),
  .sync_out                (sm2_capture_dr_mask_cpu)
);

//   &Connect(.clk1           (cpuclk), @223
//            .clk2           (tclk), @224
//            .rst1_b         (hadrst_b), @225
//            .rst2_b         (trst_b), @226
//            .sync_in        (sm2_capture_dr_mask), @227
//            .sync_out       (sm2_capture_dr_mask_cpu) @228
//           ); @229
  assign jtag_xx_capture_dr_mask    = sm2_capture_dr_mask_cpu;

assign jtag_regs_update_hacr = sm2_update_ir_cpu;
assign jtag_xx_update_dr     = sm2_update_dr_cpu;

//the wake up signal from jtag when CPU is in lpmd
assign had_pad_wakeup_req_b = (sm2_cur_st[3:0] == TAP2_IDLE)
                           || (sm2_cur_st[3:0] == TAP2_START);
// &Force("nonport", "had_pad_wakeup_req_b"); @240
//======================================
// load the RW
// &Force("input", "regs_jtag_hacr_rw"); @243
always @(posedge tclk)
begin
  if (sm2_load_rw)
    sm2_read_vld <= pin_xx_tms_i;
end

//======================================
// load the RS[1:0]
always @(posedge tclk)
begin
  if (sm2_start_vld)
    sm2_rs_counter <= 1'b1;
  else if (sm2_cur_st[3:0] == TAP2_RS)
    sm2_rs_counter <= 1'b0;
  else
    sm2_rs_counter <= sm2_rs_counter;
end

always @(posedge tclk)
begin
  if (sm2_cur_st[3:0] == TAP2_RS)
    sm2_rs[1:0] <= {pin_xx_tms_i, sm2_rs[1]};
  else
    sm2_rs[1:0] <= sm2_rs[1:0];
end

// assign sm2_rs_cdic_ir_sel = sm2_rs[1:0] == 2'b00;
assign sm2_rs_cdic_dr_sel = sm2_rs[1:0] == 2'b01;
assign sm2_rs_had_ir_sel  = sm2_rs[1:0] == 2'b10;
assign sm2_rs_had_dr_sel  = sm2_rs[1:0] == 2'b11;

//======================================
// DATA shift length
// 8-bit for HAD_IR, 32-bit for HAD_DR
always @(posedge tclk)
begin
  if (sm2_cur_st[3:0] == TAP2_TRN1) begin
    if (sm2_rs_had_dr_sel || sm2_rs_cdic_dr_sel)
      sm2_data_counter[4:0] <= 5'b11111;
    else
      sm2_data_counter[4:0] <= 5'b00111;
  end
  else if (sm2_shift_vld)
    sm2_data_counter[4:0] <= sm2_data_counter[4:0] - 5'b1;
end

//======================================
// TMS output Enable
always @(posedge tclk or negedge trst_b)
begin
  if (!trst_b)
    tms_oe <= 1'b0; // default is input
  else if (sm2_rst_vld)
    tms_oe <= 1'b0;
  else if (sm2_trn1 && sm2_read_vld)
    tms_oe <= 1'b1;
  else if (sm2_trn2)
    tms_oe <= 1'b0;
  else
    tms_oe <= tms_oe;
end

//======================================
// Parity Check
always @(posedge tclk)
begin
  if (sm2_start_vld)
    sm2_parity <= 1'b1;
  else if ((sm2_rs_had_dr_sel || sm2_rs_had_ir_sel) && sm2_shift_vld)
    sm2_parity <= sm2_parity ^ pin_xx_tms_i; // calculate the parity bit
  else if (sm2_parity_vld)
    sm2_parity <= sm2_parity ^ pin_xx_tms_i; // check received parity bit
  else
    sm2_parity <= sm2_parity;
end

//==============================================================================
// TAP controller on signal to enable had clock (for low power)
//==============================================================================
// &Force("output", "sm_xx_tap_on"); @326
assign sm_xx_tap_on = 1'b1;

//==============================================================================
// data shift in and out 
//==============================================================================
// &Force("input", "regs_jtag_reg8_sel"); @344
// &Force("input", "regs_jtag_reg16_sel"); @345

always @( * )
begin
  shifter_pre[31:0] = 32'b0;
  if (sm2_shift_ir)        // shift ir (ir register is write only)
    shifter_pre[7:0]  = {tdi, shifter[7:1]};
  else if (sm2_capture_dr) // capture dr
    shifter_pre[31:0] = regs_jtag_data[31:0];
  else if (sm2_shift_dr)   // shift dr
    shifter_pre[31:0] = {tdi, shifter[31:1]};
  else 
    shifter_pre[31:0] = shifter[31:0];
end

assign jtag_xx_data[31:0] = shifter[31:0];

// sample tms_i on the posedge of tclk
always @(posedge tclk)
begin
  shifter[31:0] <= shifter_pre[31:0];
end

// set tms_o on the negedge of tclk
// set tms_o to logic 1 when IDLE
always @(negedge tclk or negedge trst_b)
begin
  if (!trst_b)
    tdo <= 1'b1;
  else if (sm2_shift_sync)
    tdo <= 1'b0;
  else if (sm2_shift_dr && sm2_read_vld)
    tdo <= shifter[0];
  else if (sm2_shift_par && sm2_read_vld)
    tdo <= parity;
  else
    tdo <= 1'b1;
end

// calculate the parity bit when read DR
always @(posedge tclk)
begin
  if (sm2_capture_dr)
    parity <= 1'b1;
  else if (sm2_shift_dr && sm2_read_vld)
    parity <= parity ^ shifter[0];
  else
    parity <= parity;
end

//==============================================================================
// JTAG data input and output signal
//==============================================================================
assign jtag2_pin_tms_oe = tms_oe;
assign jtag2_pin_tms_o  = tdo;
assign tms_i            = pin_xx_tms_i;
assign tdi              = pin_xx_tms_i;

// &ModuleEnd; @403
endmodule



