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

// &ModuleBeg; @22
module cr_iu_hs_split(
  hs_split_iu_ctrl_inst_vld,
  hs_split_iu_dp_inst_op,
  hs_split_iu_hs_retire_mask,
  hs_split_iu_hs_switch_se,
  hs_split_iu_nsinst_gpr_rst_b,
  hs_split_iu_unstack_chgflw,
  iu_hs_split_ex_stall,
  iu_ifu_spcu_int_en,
  split_ifctrl_hs_stall,
  split_ifctrl_hs_stall_part
);

// &Ports; @23
input           iu_hs_split_ex_stall;        
input           iu_ifu_spcu_int_en;          
output          hs_split_iu_ctrl_inst_vld;   
output  [31:0]  hs_split_iu_dp_inst_op;      
output          hs_split_iu_hs_retire_mask;  
output          hs_split_iu_hs_switch_se;    
output          hs_split_iu_nsinst_gpr_rst_b; 
output          hs_split_iu_unstack_chgflw;  
output          split_ifctrl_hs_stall;       
output          split_ifctrl_hs_stall_part;  

// &Regs; @24

// &Wires; @25
wire            hs_split_iu_ctrl_inst_vld;   
wire    [31:0]  hs_split_iu_dp_inst_op;      
wire            hs_split_iu_hs_retire_mask;  
wire            hs_split_iu_hs_switch_se;    
wire            hs_split_iu_nsinst_gpr_rst_b; 
wire            hs_split_iu_unstack_chgflw;  
wire            split_ifctrl_hs_stall;       
wire            split_ifctrl_hs_stall_part;  


//==============================================================================
//                      input value when no configuration
//==============================================================================
// &Force("output","split_ifctrl_hs_stall"); @30
// &Force("input","iu_ifu_spcu_int_en"); @31
// &Instance("gated_clk_cell", "x_split_cnt_upd_clkhdr"); @36
// &Connect(.clk_in(forever_cpuclk), @37
//          .external_en(1'b0), @38
//          .global_en(cp0_yy_clk_en), @39
//          .module_en(1'b0), @40
//          .local_en(split_cnt_upd_en), @41
//          .clk_out(split_cnt_upd_clk) @42
//         ); @43
// &Instance("gated_clk_cell", "x_sm_upd_clkhdr"); @46
// &Connect(.clk_in(forever_cpuclk), @47
//          .external_en(1'b0), @48
//          .global_en(cp0_yy_clk_en), @49
//          .module_en(1'b0), @50
//          .local_en(sm_upd_en), @51
//          .clk_out(sm_upd_clk) @52
//         ); @53
// &CombBeg; @156
// &CombEnd; @263
// &CombBeg; @363
// &CombEnd; @371
assign hs_split_iu_nsinst_gpr_rst_b = 1'b1; 
assign hs_split_iu_hs_retire_mask   = 1'b0; 
assign hs_split_iu_unstack_chgflw   = 1'b0;
assign hs_split_iu_hs_switch_se     = 1'b0;
assign split_ifctrl_hs_stall_part   = 1'b0;
assign split_ifctrl_hs_stall        = 1'b0;
assign hs_split_iu_ctrl_inst_vld    = 1'b0;
//assign hs_split_iu_ex_cr_oper       = 1'b0;
//assign hs_split_iu_hs_retire_mask   = 1'b0;
assign hs_split_iu_dp_inst_op[31:0] = 32'b0;
// &Force("input","iu_hs_split_ex_stall"); @417
// 1. check fail, stall ibuf
// 2. speculation fail, stall ibuf
//assign split_ifctrl_int_acc_stall = int_spcu_check_fail 
//                                 || iu_ifu_spcu_error_without_misalign 
//                                    && int_spcu_sm_not_idle; 

//==========================================================
//               Interface to IF Data Path
//==========================================================
//the data path signal
// &ModuleEnd; @429
endmodule


