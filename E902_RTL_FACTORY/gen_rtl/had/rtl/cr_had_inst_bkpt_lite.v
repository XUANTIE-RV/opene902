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
module cr_had_inst_bkpt_lite(
  bkpt_ctrl_inst_fetch_dbq_req,
  bkpt_ctrl_req,
  had_core_dbg_mode_req,
  ifu_had_fetch_expt_vld,
  ifu_had_inst_dbg_disable,
  ifu_had_match_pc,
  ifu_had_split_first,
  iu_yy_xx_dbgon,
  regs_bkpt_base,
  regs_bkpt_en
);

// &Ports; @23
input           had_core_dbg_mode_req;       
input           ifu_had_fetch_expt_vld;      
input           ifu_had_inst_dbg_disable;    
input   [31:0]  ifu_had_match_pc;            
input           ifu_had_split_first;         
input           iu_yy_xx_dbgon;              
input   [31:0]  regs_bkpt_base;              
input           regs_bkpt_en;                
output          bkpt_ctrl_inst_fetch_dbq_req; 
output          bkpt_ctrl_req;               

// &Regs; @24

// &Wires; @25
wire            bkpt_ctrl_inst_fetch_dbq_req; 
wire            bkpt_ctrl_req;               
wire            bkpt_en;                     
wire            had_core_dbg_mode_req;       
wire            ifu_had_fetch_expt_vld;      
wire            ifu_had_inst_dbg_disable;    
wire    [31:0]  ifu_had_match_pc;            
wire            ifu_had_split_first;         
wire            inst_addr_match;             
wire            inst_bkpt_occur;             
wire            inst_bkpt_vld;               
wire            iu_yy_xx_dbgon;              
wire    [31:0]  regs_bkpt_base;              
wire            regs_bkpt_en;                


assign bkpt_en = regs_bkpt_en;

//==============================================================================
// inst bkpt occur condition (AND):
// 1. inst retire address match
// 2. memory bkpt is enabled;
// 3. the current instruction in EX stage is retiring normally.
//==============================================================================

//assign inst_addr_match = ((ifu_had_match_pc[31:0] & {24'hFF_FFFF, regs_bkpt_mask[7:0]})
//                             == regs_bkpt_base[31:0]);
assign inst_addr_match = (ifu_had_match_pc[31:0] == regs_bkpt_base[31:0]);                             

assign inst_bkpt_occur = inst_addr_match
                         && !ifu_had_fetch_expt_vld
                         && !ifu_had_inst_dbg_disable
                         && ifu_had_split_first
                         && !iu_yy_xx_dbgon
                         && !had_core_dbg_mode_req;
                             

assign inst_bkpt_vld = bkpt_en ? inst_bkpt_occur : 1'b0;

//==============================================================================
// memory bkpt request condition(AND):
// 1. inst_bkpt_vld or data_bkpt_vld or both vld;
// 2. not in debug mode.
//==============================================================================
assign bkpt_ctrl_inst_fetch_dbq_req = inst_bkpt_vld;

assign bkpt_ctrl_req = 1'b0;
// assign bkpt_expt_reset = iu_had_expt_vld;
// 
// //the counter to record the bkpt hit when split
// always @(posedge cpuclk or negedge hadrst_b)
// begin
//   if(!hadrst_b)
//     bkpt_counter <= 1'b0;
//   else if (bkpt_ctrl_req || bkpt_expt_reset)
//     bkpt_counter <= 1'b0;
//   else if (!bkpt_counter && data_bkpt_vld && iu_had_xx_mldst)
//     bkpt_counter <= 1'b1;
//   else
//     bkpt_counter <= bkpt_counter;
// end
// 
// assign data_bkpt_dbg_req   = !bkpt_counter && data_bkpt_vld && !iu_had_xx_mldst;
// 
// assign counter_neg_dbg_req = bkpt_counter && !iu_had_xx_mldst
//                              && iu_had_xx_retire;
// 
// // &Force("output","bkpt_ctrl_req"); @78
// assign bkpt_ctrl_req = (data_bkpt_dbg_req || counter_neg_dbg_req)
//                        && !iu_yy_xx_dbgon
//                        && iu_had_xx_retire_normal
//                        && bkpt_en;

// &ModuleEnd; @84
endmodule



