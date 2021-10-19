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

// &ModuleBeg; @23
module cr_ifu_ibuf_entry(
  cp0_yy_clk_en,
  cpuclk,
  cpurst_b,
  entry_acc_err,
  entry_create0_en,
  entry_create1_en,
  entry_inst,
  entry_part_flush,
  entry_randclk_data_mod_en_w16,
  entry_retire0_en,
  entry_retire1_en,
  entry_vld,
  forever_cpuclk,
  had_ifu_ir,
  ibuf_flush,
  ibuf_no_inst_during_pipe_down,
  ibusif_xx_acc_err,
  ibusif_xx_data,
  ifu_misc_clk,
  iu_yy_xx_dbgon,
  pad_yy_gate_clk_en_b
);

// &Ports; @24
input           cp0_yy_clk_en;                
input           cpuclk;                       
input           cpurst_b;                     
input           entry_create0_en;             
input           entry_create1_en;             
input           entry_part_flush;             
input           entry_randclk_data_mod_en_w16; 
input           entry_retire0_en;             
input           entry_retire1_en;             
input           forever_cpuclk;               
input   [31:0]  had_ifu_ir;                   
input           ibuf_flush;                   
input           ibuf_no_inst_during_pipe_down; 
input           ibusif_xx_acc_err;            
input   [31:0]  ibusif_xx_data;               
input           ifu_misc_clk;                 
input           iu_yy_xx_dbgon;               
input           pad_yy_gate_clk_en_b;         
output          entry_acc_err;                
output  [16:0]  entry_inst;                   
output          entry_vld;                    

// &Regs; @25
reg             entry_acc_err;                
reg     [16:0]  entry_inst;                   
reg             entry_vld;                    

// &Wires; @26
wire            cp0_yy_clk_en;                
wire            cpuclk;                       
wire            cpurst_b;                     
wire            entry_create;                 
wire            entry_create0_en;             
wire            entry_create1_en;             
wire            entry_part_flush;             
wire            entry_randclk_data_mod_en_w16; 
wire            entry_retire;                 
wire            entry_retire0_en;             
wire            entry_retire1_en;             
wire            forever_cpuclk;               
wire    [31:0]  had_ifu_ir;                   
wire            ibuf_data_upd_clk;            
wire            ibuf_data_upd_en;             
wire            ibuf_flush;                   
wire            ibuf_no_inst_during_pipe_down; 
wire    [16:0]  ibus_inst_info_high;          
wire    [16:0]  ibus_inst_info_low;           
wire            ibusif_xx_acc_err;            
wire    [31:0]  ibusif_xx_data;               
wire            ifu_misc_clk;                 
wire            iu_yy_xx_dbgon;               
wire            pad_yy_gate_clk_en_b;         


//==============================================================================
//                            Gated Clock
//==============================================================================
// &Instance("gated_clk_cell", "x_ibuf_data_upd_clkhdr"); @31
gated_clk_cell  x_ibuf_data_upd_clkhdr (
  .clk_in                        (forever_cpuclk               ),
  .clk_out                       (ibuf_data_upd_clk            ),
  .external_en                   (1'b0                         ),
  .global_en                     (cp0_yy_clk_en                ),
  .local_en                      (ibuf_data_upd_en             ),
  .module_en                     (entry_randclk_data_mod_en_w16),
  .pad_yy_gate_clk_en_b          (pad_yy_gate_clk_en_b         )
);

// &Connect(.clk_in(forever_cpuclk), @32
//          .external_en(1'b0), @33
//          .global_en(cp0_yy_clk_en), @34
//          .module_en(entry_randclk_data_mod_en_w16), @35
//          .local_en(ibuf_data_upd_en), @36
//          .clk_out(ibuf_data_upd_clk) @37
//         ); @38
assign ibuf_data_upd_en = entry_create0_en || entry_create1_en;

//==============================================================================
//Prefetch Buffer Entry Fields Description:
//+-------------------+-----------------+--------------+
//|     entry_vld     |     acc_err     |     inst     |
//+-------------------+-----------------+--------------+
//==============================================================================

//==============================================================================
//                       Entry Create and Retire Signal
//==============================================================================
assign entry_create  = entry_create0_en || entry_create1_en;
assign entry_retire  = entry_retire0_en || entry_retire1_en;

//==============================================================================
//                       Entry Infomation Update
//==============================================================================
// &Force("output", "entry_vld"); @57
// &Force("output", "entry_inst"); @58
// &Force("output", "entry_acc_err"); @59
//==========================================================
//                  Entry Valid Signal
//==========================================================
always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_vld <= 1'b0;
  else if(entry_part_flush)
    entry_vld <= 1'b0;
  else if(ibuf_flush)
    entry_vld <= 1'b0;
  else if(entry_create)
    entry_vld <= 1'b1;
  else if(entry_retire)
    entry_vld <= 1'b0;
  else
    entry_vld <= entry_vld;
end

//==========================================================
//                  Entry Instruction Signal
//==========================================================
assign ibus_inst_info_high[16:0] = {1'b0, ibusif_xx_data[15:0]};
assign ibus_inst_info_low[16:0]  = {1'b0, ibusif_xx_data[31:16]};

// &Force("input", "ibuf_no_inst_during_pipe_down"); @86
always @(posedge ibuf_data_upd_clk)
begin
  if(iu_yy_xx_dbgon)
    begin
      if(entry_create0_en)
        entry_inst[16:0] <= {1'b0, had_ifu_ir[15:0]};
      else if(entry_create1_en)
        entry_inst[16:0] <= {1'b0, had_ifu_ir[31:16]};
      else
        entry_inst[16:0] <= entry_inst[16:0];
    end
  else
    begin
      if(entry_create0_en)
        begin
          if(ibuf_no_inst_during_pipe_down)
            entry_inst[16:0] <= ibus_inst_info_low[16:0];
          else
            entry_inst[16:0] <= ibus_inst_info_high[16:0];
        end
      else if(entry_create1_en)
        entry_inst[16:0] <= ibus_inst_info_low[16:0];
      else
        entry_inst[16:0] <= entry_inst[16:0];
    end
end

//==========================================================
//                  Other Instruction Related Signal
//==========================================================
//When in debug mode, the access error point exception will not happen.
//When not in debug mode, the access error come from I-BUS.
always @(posedge ifu_misc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_acc_err <= 1'b0;
  else if(entry_create)
    entry_acc_err <= ibusif_xx_acc_err;
  else
    entry_acc_err <= entry_acc_err;
end

// &Force("output", "entry_inst_dbg_disable"); @141

// &ModuleEnd; @153
endmodule


