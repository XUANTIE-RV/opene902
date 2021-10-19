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
module cr_ifu_ifdp(
  had_core_dbg_mode_req,
  had_ifu_inst_bkpt_dbq_req,
  had_ifu_inst_bkpt_dbqexp_req,
  had_yy_xx_dp_index_mbee,
  ifu_had_inst_dbg_disable,
  ifu_had_split_first,
  ifu_iu_ex_inst_bkpt,
  ifu_iu_ex_inst_dbg_disable,
  ifu_iu_ex_int_spcu_mask,
  ifu_iu_ex_int_spcu_vld,
  ifu_iu_ex_ni,
  ifu_iu_ex_prvlg_expt_vld,
  ifu_iu_ex_rand_vld,
  ifu_iu_ex_sp_oper,
  ifu_iu_inst_bkpt_dbg_occur_vld,
  ifu_iu_inst_bkpt_dbgexp_occur_vld,
  ifu_iu_spcu_retire_mask,
  iu_ifu_kill_inst
);

// &Ports; @23
input        had_core_dbg_mode_req;            
input        had_ifu_inst_bkpt_dbq_req;        
input        had_ifu_inst_bkpt_dbqexp_req;     
input        had_yy_xx_dp_index_mbee;          
input        iu_ifu_kill_inst;                 
output       ifu_had_inst_dbg_disable;         
output       ifu_had_split_first;              
output       ifu_iu_ex_inst_bkpt;              
output       ifu_iu_ex_inst_dbg_disable;       
output       ifu_iu_ex_int_spcu_mask;          
output       ifu_iu_ex_int_spcu_vld;           
output       ifu_iu_ex_ni;                     
output       ifu_iu_ex_prvlg_expt_vld;         
output       ifu_iu_ex_rand_vld;               
output       ifu_iu_ex_sp_oper;                
output       ifu_iu_inst_bkpt_dbg_occur_vld;   
output       ifu_iu_inst_bkpt_dbgexp_occur_vld; 
output       ifu_iu_spcu_retire_mask;          

// &Regs; @24

// &Wires; @25
wire         had_core_dbg_mode_req;            
wire         had_ifu_inst_bkpt_dbq_req;        
wire         had_ifu_inst_bkpt_dbqexp_req;     
wire         had_yy_xx_dp_index_mbee;          
wire         if_bkpt_vld;                      
wire         ifu_had_inst_dbg_disable;         
wire         ifu_had_split_first;              
wire         ifu_iu_ex_inst_bkpt;              
wire         ifu_iu_ex_inst_dbg_disable;       
wire         ifu_iu_ex_int_spcu_mask;          
wire         ifu_iu_ex_int_spcu_vld;           
wire         ifu_iu_ex_ni;                     
wire         ifu_iu_ex_prvlg_expt_vld;         
wire         ifu_iu_ex_rand_vld;               
wire         ifu_iu_ex_sp_oper;                
wire         ifu_iu_inst_bkpt_dbg_occur_vld;   
wire         ifu_iu_inst_bkpt_dbgexp_occur_vld; 
wire         ifu_iu_spcu_retire_mask;          
wire         inst_bkpt;                        
wire         inst_bkpt_aft_hs;                 
wire         iu_ifu_kill_inst;                 


parameter EBREAK = 32'h00100073;

// &CombBeg; @30
// &CombEnd; @37

//when HAD assert the had_core_dbg_mode_req or had_ifu_inst_bkpt_dbq_req, 
//the inst in IF stage will be replaced as ebreak, then when this
//inst get to EX stage, cpu will enter into dbg mode
assign if_bkpt_vld = had_core_dbg_mode_req || had_ifu_inst_bkpt_dbq_req
                  || had_ifu_inst_bkpt_dbqexp_req
                  || iu_ifu_kill_inst && had_yy_xx_dp_index_mbee;

assign inst_bkpt = if_bkpt_vld;

//==========================================================
//               Other Signal
//==========================================================
//The singal below seldom vary ,they should be clock gated

// &Force("output","ifu_iu_ex_inst_dbg_disable"); @63
// &Instance("gated_clk_cell", "x_ifdp_other_info_upd_clkhdr"); @65
// &Connect(.clk_in(forever_cpuclk), @66
//          .external_en(1'b0), @67
//          .global_en(cp0_yy_clk_en), @68
//          .module_en(randclk_ifdp_other_info_mod_en_w8), @69
//          .local_en(ifdp_other_info_upd_en), @70
//          .clk_out(ifdp_other_info_upd_clk) @71
//         ); @72
assign ifu_iu_ex_inst_dbg_disable  = 1'b0;
//assign inst_dbg_disable = 1'b0;

// &Force("output","ifu_iu_ex_inst_bkpt"); @89
assign inst_bkpt_aft_hs = inst_bkpt;
assign ifu_iu_ex_inst_bkpt = inst_bkpt_aft_hs;

assign ifu_iu_ex_int_spcu_mask = 1'b0;
assign ifu_iu_ex_int_spcu_vld = 1'b0;
assign ifu_iu_ex_ni = 1'b0;
assign ifu_iu_ex_prvlg_expt_vld = 1'b0;
assign ifu_iu_ex_rand_vld = 1'b0;
assign ifu_iu_ex_sp_oper = 1'b0;
assign ifu_iu_spcu_retire_mask = 1'b0;

//==============================================================================
//               Interface to other Module
//==============================================================================
//for HAD inst bkpt
assign ifu_had_split_first    = 1'b1;
assign ifu_had_inst_dbg_disable = 1'b0;
assign ifu_iu_inst_bkpt_dbg_occur_vld = had_ifu_inst_bkpt_dbq_req;

assign ifu_iu_inst_bkpt_dbgexp_occur_vld = 1'b0;


// &ModuleEnd; @135
endmodule


