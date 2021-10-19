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
module cr_had_ddc(
  cpuclk,
  ddc_regs_ffy,
  ddc_regs_ir,
  ddc_regs_update_csr,
  ddc_regs_update_ir,
  hadrst_b,
  iu_had_xx_retire,
  jtag_xx_update_dr,
  regs_ddc_daddr_sel,
  regs_ddc_ddata_sel,
  regs_xx_ddc_en
);

// &Ports; @21
input           cpuclk;             
input           hadrst_b;           
input           iu_had_xx_retire;   
input           jtag_xx_update_dr;  
input           regs_ddc_daddr_sel; 
input           regs_ddc_ddata_sel; 
input           regs_xx_ddc_en;     
output          ddc_regs_ffy;       
output  [31:0]  ddc_regs_ir;        
output          ddc_regs_update_csr; 
output          ddc_regs_update_ir; 

// &Regs; @22
reg     [3 :0]  cur_st;             
reg     [3 :0]  nxt_st;             

// &Wires; @23
wire            addr_gen;           
wire            addr_ready;         
wire            addr_sel;           
wire            cpuclk;             
wire            data_ld_finish;     
wire            data_ready;         
wire            data_sel;           
wire            ddc_regs_ffy;       
wire    [31:0]  ddc_regs_ir;        
wire            ddc_regs_update_csr; 
wire            ddc_regs_update_ir; 
wire            hadrst_b;           
wire            iu_had_xx_retire;   
wire            jtag_xx_update_dr;  
wire            regs_ddc_daddr_sel; 
wire            regs_ddc_ddata_sel; 
wire            regs_xx_ddc_en;     
wire            stw_inst_retire;    
wire            stw_sel;            


//==============================================================================
//                           DDC control state machine 
//==============================================================================

parameter DDC_IDLE        = 4'h0;
parameter DDC_ADDR_WAIT   = 4'h1;
parameter DDC_ADDR_LD     = 4'h2;
parameter DDC_DATA_WAIT   = 4'h3;
parameter DDC_DATA_LD     = 4'h4;
parameter DDC_STW_WAIT    = 4'h5;
parameter DDC_STW_LD      = 4'h6;
parameter DDC_STW_FINISH  = 4'h7;
parameter DDC_ADDR_GEN    = 4'h8;

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    cur_st[3:0] <= DDC_IDLE;
  else
    cur_st[3:0] <= nxt_st[3:0];
end

always @( * )
begin
  case(cur_st[3:0])
    DDC_IDLE : begin
      if (regs_xx_ddc_en)
        nxt_st[3:0] = DDC_ADDR_WAIT;
      else
        nxt_st[3:0] = DDC_IDLE;
    end
    DDC_ADDR_WAIT : begin // wait addr be loaded into daddr
      if (addr_ready)
        nxt_st[3:0] = DDC_ADDR_LD;
      else
        nxt_st[3:0] = DDC_ADDR_WAIT;
    end
    DDC_ADDR_LD : begin  // load "mov r0, r0" to ir, ffy and wbbr
      nxt_st[3:0] = DDC_DATA_WAIT;
    end
    DDC_DATA_WAIT : begin
      // if (addr_ld_finish && data_ready) // wait base prepare finish and data ready.
      if (data_ready) // wait base prepare finish and data ready.
        nxt_st[3:0] = DDC_DATA_LD;
      else if (addr_ready) // re-prepare base
        nxt_st[3:0] = DDC_ADDR_LD;
      else if (!regs_xx_ddc_en)
        nxt_st[3:0] = DDC_IDLE;
      else
        nxt_st[3:0] = DDC_DATA_WAIT;
    end
    DDC_DATA_LD : begin
      nxt_st[3:0] = DDC_STW_WAIT; // load "mov r1, r1" to ir, ffy and wbbr
    end
    DDC_STW_WAIT : begin
      if (data_ld_finish)  // wait for "mov r1, r1" retire: data prepare finish
        nxt_st[3:0] = DDC_STW_LD;
      else
        nxt_st[3:0] = DDC_STW_WAIT;
    end
    DDC_STW_LD : begin      // load "stw r1, r0" to ir
      nxt_st[3:0] = DDC_STW_FINISH;
    end
    DDC_STW_FINISH : begin // wait for stw finish
      if (stw_inst_retire)
        nxt_st[3:0] = DDC_ADDR_GEN;
      else
        nxt_st[3:0] = DDC_STW_FINISH;
    end
    DDC_ADDR_GEN : begin   // increase addr and recycle
      nxt_st[3:0] = DDC_DATA_WAIT;
    end
    default : begin
      nxt_st[3:0] = DDC_IDLE;
    end
  endcase
end

// addr load finish
// always @(posedge cpuclk or negedge hadrst_b)
// begin
//   if (!hadrst_b)
//     addr_ld_finish <= 1'b0;
//   else if (cur_st[3:0] == DATA_WAIT) begin
//     if (iu_had_xx_retire)
//       addr_ld_finish <= 1'b1;
//     else
//       addr_ld_finish <= addr_ld_finish; // hold finish state
//   end
//   else
//     addr_ld_finish <= 1'b0;
// end

// data load finish will push state machine into next state, so the state
// needn't hold
assign data_ld_finish = iu_had_xx_retire;
assign stw_inst_retire = iu_had_xx_retire;

//==========================================================
// state machine control signals
assign addr_ready = jtag_xx_update_dr && regs_ddc_daddr_sel;
assign data_ready = jtag_xx_update_dr && regs_ddc_ddata_sel;

//==========================================================
// state machine status
assign addr_sel   = cur_st[3:0] == DDC_ADDR_LD;
assign data_sel   = cur_st[3:0] == DDC_DATA_LD;
assign stw_sel    = cur_st[3:0] == DDC_STW_LD;
assign addr_gen   = cur_st[3:0] == DDC_ADDR_GEN;

//==============================================================================
// DDC Data path
//==============================================================================

//==========================================================
// load data into DDC data reg from scan chain
//always @(posedge cpuclk)
//begin
//  if (data_ready)
//    ddata_reg[31:0] <= jtag_xx_data[31:0];
//  else
//    ddata_reg[31:0] <= ddata_reg[31:0];
//end

//==========================================================
// load address into DDC addr reg from scan chain
//always @(posedge cpuclk)
//begin
//  if (addr_ready)
//    daddr_reg[31:0] <= jtag_xx_data[31:0];
//  else if (addr_gen)
//    daddr_reg[31:0] <= daddr_reg[31:0] + 3'b100;
//  else
//    daddr_reg[31:0] <= daddr_reg[31:0];
//end

//==========================================================
// Update HAD Regs
// 1. WBBR
//assign ddc_regs_update_wbbr = addr_sel || data_sel;
//assign ddc_regs_wbbr[31:0] = addr_sel ? daddr_reg[31:0] : ddata_reg[31:0];
// 2. IR
assign ddc_regs_update_ir   = addr_sel || data_sel || stw_sel || addr_gen;
// by zhaocj for rv32 assign ddc_regs_ir[31:0] = addr_sel ? 32'hc4004820  // mov32 r0, r0
// by zhaocj for rv32                          : data_sel ? 32'hc4014821  // mov32 r1, r1
// by zhaocj for rv32                          : stw_sel  ? 32'hdc202000  // st32.w r1, r0, #0
// by zhaocj for rv32                          : 32'he4000003;  // addi32 r0, r0, 0x4
assign ddc_regs_ir[31:0] = addr_sel ? 32'h00008093  // mv x1, x1
                         : data_sel ? 32'h00010113  // mv x2, x2
                         : stw_sel  ? 32'h0020a023  // sw x2, 0x0(x1)
                         : 32'h00408093;  // addi x1, x1, 0x4

// 3. CSR
assign ddc_regs_update_csr  = addr_sel || data_sel || stw_sel || addr_gen;
assign ddc_regs_ffy = (addr_sel || data_sel) ? 1'b1 : 1'b0;
//// 4. DADDR
//assign ddc_regs_ddata[31:0] = ddata_reg[31:0];
//// 5. DDATA
//assign ddc_regs_daddr[31:0] = daddr_reg[31:0];

// &ModuleEnd; @185
endmodule




