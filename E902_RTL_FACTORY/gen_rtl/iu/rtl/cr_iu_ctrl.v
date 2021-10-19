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

// &ModuleBeg; @25
module cr_iu_ctrl(
  branch_ctrl_stall,
  cp0_iu_stall,
  cp0_iu_stall_noinput,
  cp0_yy_priv_mode,
  ctrl_alu_ex_data_sel,
  ctrl_alu_ex_sel,
  ctrl_alu_mad_oper_mux_en,
  ctrl_alu_oper_mux_en,
  ctrl_branch_ex_data_sel,
  ctrl_branch_ex_sel,
  ctrl_cp0_ex_data_sel,
  ctrl_lsu_ex_data_sel,
  ctrl_mad_ex_data_sel,
  ctrl_mad_ex_sel,
  ctrl_mad_oper_mux_en,
  ctrl_oper_lsu_data_sel,
  ctrl_retire_ni_vld,
  ctrl_special_ex_data_sel,
  ctrl_special_ex_sel,
  ctrl_special_expt_vec,
  ctrl_special_expt_vld,
  ctrl_xx_sp_adjust,
  decd_ctrl_alu_sel,
  decd_ctrl_branch_sel,
  decd_ctrl_cp0_sel,
  decd_ctrl_expt_bkpt,
  decd_ctrl_expt_ecall,
  decd_ctrl_expt_inv,
  decd_ctrl_expt_wsc,
  decd_ctrl_lsu_sel,
  decd_ctrl_mad_sel,
  decd_xx_unit_special_sel,
  hs_split_iu_ctrl_inst_vld,
  ifu_iu_ex_expt_vld,
  ifu_iu_ex_inst_vld,
  ifu_iu_ex_ni,
  ifu_iu_ex_prvlg_expt_vld,
  ifu_iu_ex_rand_vld,
  iu_cp0_ecall,
  iu_cp0_ex_data_sel,
  iu_cp0_ex_sel,
  iu_cp0_oper_mux_en,
  iu_hs_split_ex_stall,
  iu_ifu_ex_stall,
  iu_ifu_ex_stall_noinput,
  iu_ifu_ex_vld,
  iu_ifu_wb_stall,
  iu_lsu_ex_data_sel,
  iu_lsu_ex_sel,
  iu_lsu_oper_mux_en,
  lsu_iu_stall,
  lsu_iu_stall_noinput,
  mad_ctrl_stall,
  mad_ctrl_stall_noinput,
  pcgen_ctrl_stall,
  special_ctrl_stall,
  special_ctrl_stall_noinput,
  vector_ctrl_stall,
  wb_ctrl_stall
);

// &Ports; @26
input          branch_ctrl_stall;          
input          cp0_iu_stall;               
input          cp0_iu_stall_noinput;       
input   [1:0]  cp0_yy_priv_mode;           
input          decd_ctrl_alu_sel;          
input          decd_ctrl_branch_sel;       
input          decd_ctrl_cp0_sel;          
input          decd_ctrl_expt_bkpt;        
input          decd_ctrl_expt_ecall;       
input          decd_ctrl_expt_inv;         
input          decd_ctrl_expt_wsc;         
input          decd_ctrl_lsu_sel;          
input          decd_ctrl_mad_sel;          
input          decd_xx_unit_special_sel;   
input          hs_split_iu_ctrl_inst_vld;  
input          ifu_iu_ex_expt_vld;         
input          ifu_iu_ex_inst_vld;         
input          ifu_iu_ex_ni;               
input          ifu_iu_ex_prvlg_expt_vld;   
input          ifu_iu_ex_rand_vld;         
input          lsu_iu_stall;               
input          lsu_iu_stall_noinput;       
input          mad_ctrl_stall;             
input          mad_ctrl_stall_noinput;     
input          pcgen_ctrl_stall;           
input          special_ctrl_stall;         
input          special_ctrl_stall_noinput; 
input          vector_ctrl_stall;          
input          wb_ctrl_stall;              
output         ctrl_alu_ex_data_sel;       
output         ctrl_alu_ex_sel;            
output         ctrl_alu_mad_oper_mux_en;   
output         ctrl_alu_oper_mux_en;       
output         ctrl_branch_ex_data_sel;    
output         ctrl_branch_ex_sel;         
output         ctrl_cp0_ex_data_sel;       
output         ctrl_lsu_ex_data_sel;       
output         ctrl_mad_ex_data_sel;       
output         ctrl_mad_ex_sel;            
output         ctrl_mad_oper_mux_en;       
output         ctrl_oper_lsu_data_sel;     
output         ctrl_retire_ni_vld;         
output         ctrl_special_ex_data_sel;   
output         ctrl_special_ex_sel;        
output  [4:0]  ctrl_special_expt_vec;      
output         ctrl_special_expt_vld;      
output         ctrl_xx_sp_adjust;          
output         iu_cp0_ecall;               
output         iu_cp0_ex_data_sel;         
output         iu_cp0_ex_sel;              
output         iu_cp0_oper_mux_en;         
output         iu_hs_split_ex_stall;       
output         iu_ifu_ex_stall;            
output         iu_ifu_ex_stall_noinput;    
output         iu_ifu_ex_vld;              
output         iu_ifu_wb_stall;            
output         iu_lsu_ex_data_sel;         
output         iu_lsu_ex_sel;              
output         iu_lsu_oper_mux_en;         

// &Regs; @27
reg     [4:0]  ctrl_special_expt_vec;      

// &Wires; @28
wire           bctm_ctrl_stall;            
wire           branch_ctrl_stall;          
wire           cp0_iu_stall;               
wire           cp0_iu_stall_noinput;       
wire    [1:0]  cp0_yy_priv_mode;           
wire           ctrl_alu_ex_data_sel;       
wire           ctrl_alu_ex_sel;            
wire           ctrl_alu_mad_oper_mux_en;   
wire           ctrl_alu_oper_mux_en;       
wire           ctrl_branch_ex_data_sel;    
wire           ctrl_branch_ex_sel;         
wire           ctrl_cp0_ex_data_sel;       
wire           ctrl_ex_inst_vld;           
wire           ctrl_internal_stall;        
wire           ctrl_lsu_ex_data_sel;       
wire           ctrl_mad_ex_data_sel;       
wire           ctrl_mad_ex_sel;            
wire           ctrl_mad_oper_mux_en;       
wire           ctrl_oper_lsu_data_sel;     
wire           ctrl_retire_ni_vld;         
wire           ctrl_special_ex_data_sel;   
wire           ctrl_special_ex_sel;        
wire           ctrl_special_expt_vld;      
wire           ctrl_xx_sp_adjust;          
wire           decd_ctrl_alu_sel;          
wire           decd_ctrl_branch_sel;       
wire           decd_ctrl_cp0_sel;          
wire           decd_ctrl_expt_bkpt;        
wire           decd_ctrl_expt_ecall;       
wire           decd_ctrl_expt_inv;         
wire           decd_ctrl_expt_wsc;         
wire           decd_ctrl_lsu_sel;          
wire           decd_ctrl_mad_sel;          
wire           decd_xx_unit_special_sel;   
wire           hs_split_iu_ctrl_inst_vld;  
wire           ifu_iu_ex_expt_vld;         
wire           ifu_iu_ex_hs_split_expt_vld; 
wire           ifu_iu_ex_hs_split_inst_vld; 
wire           ifu_iu_ex_inst_vld;         
wire           ifu_iu_ex_ni;               
wire           ifu_iu_ex_prvlg_expt_vld;   
wire           ifu_iu_ex_rand_vld;         
wire           iu_cp0_ecall;               
wire           iu_cp0_ex_data_sel;         
wire           iu_cp0_ex_sel;              
wire           iu_cp0_oper_mux_en;         
wire           iu_hs_split_ex_stall;       
wire           iu_ifu_ex_stall;            
wire           iu_ifu_ex_stall_noinput;    
wire           iu_ifu_ex_vld;              
wire           iu_ifu_wb_stall;            
wire           iu_lsu_ex_data_sel;         
wire           iu_lsu_ex_sel;              
wire           iu_lsu_oper_mux_en;         
wire           lsu_iu_stall;               
wire           lsu_iu_stall_noinput;       
wire           mad_ctrl_stall;             
wire           mad_ctrl_stall_noinput;     
wire           pcgen_ctrl_stall;           
wire           predec_lsu_sel;             
wire           sec_ctrl_stall;             
wire           special_ctrl_stall;         
wire           special_ctrl_stall_noinput; 
wire           vector_ctrl_stall;          
wire           wb_ctrl_stall;              


//==========================================================
//                  IU internal stall
//==========================================================
//1.write buffer will stall when load/store not complete
//2.jump register source cannot forward from load value
//  set stall in this condition
assign ifu_iu_ex_hs_split_inst_vld = ifu_iu_ex_inst_vld || hs_split_iu_ctrl_inst_vld;
assign ctrl_internal_stall  = ifu_iu_ex_hs_split_inst_vld
                              && wb_ctrl_stall;
assign iu_ifu_wb_stall = ctrl_internal_stall;

//==========================================================
//                  Generate stall signal
//==========================================================
assign bctm_ctrl_stall = 1'b0;
assign sec_ctrl_stall = 1'b0;
//the stall signal does not contain ex_inst_vld here, each
//execution unit will signal stall when it is valid
assign iu_ifu_ex_stall = ctrl_internal_stall
                         || branch_ctrl_stall
                         || pcgen_ctrl_stall
                         || vector_ctrl_stall
                         || cp0_iu_stall
                         || lsu_iu_stall
                         || mad_ctrl_stall
                         || special_ctrl_stall
                         || bctm_ctrl_stall
                         || sec_ctrl_stall;
assign iu_hs_split_ex_stall = ctrl_internal_stall || lsu_iu_stall;
// &Force("output","iu_ifu_ex_stall"); @65
assign iu_ifu_ex_vld  = ifu_iu_ex_hs_split_inst_vld;
assign iu_ifu_ex_stall_noinput = 
                            branch_ctrl_stall
                         || pcgen_ctrl_stall
                         || vector_ctrl_stall
                         || cp0_iu_stall_noinput
                         || lsu_iu_stall_noinput
                         || mad_ctrl_stall_noinput
                         || special_ctrl_stall_noinput
                         || bctm_ctrl_stall
                         || sec_ctrl_stall;

//==========================================================
//                Random Isntruction Valid
//==========================================================
//1.write buffer stall will make ex pipeline not valid
//2.random instruction does not generate control
//  path selection but turns on data path selection
assign ctrl_ex_inst_vld      = ifu_iu_ex_hs_split_inst_vld
                               && !ifu_iu_ex_rand_vld
                               && !ctrl_internal_stall;

//==========================================================
//             Execution Unit selection signal
//==========================================================
assign predec_lsu_sel    = decd_ctrl_lsu_sel;

// &Force("bus","decd_xx_unit_sel",6,0); @93
assign ctrl_alu_ex_sel       = ctrl_ex_inst_vld && !decd_xx_unit_special_sel && decd_ctrl_alu_sel;
assign ctrl_mad_ex_sel       = ctrl_ex_inst_vld && !decd_xx_unit_special_sel && decd_ctrl_mad_sel;
assign iu_lsu_ex_sel         = ctrl_ex_inst_vld && !decd_xx_unit_special_sel && predec_lsu_sel;
assign ctrl_special_ex_sel   = ctrl_ex_inst_vld &&  decd_xx_unit_special_sel;
assign iu_cp0_ex_sel         = ctrl_ex_inst_vld && !decd_xx_unit_special_sel && decd_ctrl_cp0_sel;
//branch unit is decd precisely, need't to see decd_xx_unit_special_sel
assign ctrl_branch_ex_sel    = ctrl_ex_inst_vld && decd_ctrl_branch_sel;
assign ctrl_alu_oper_mux_en     = decd_ctrl_alu_sel || ifu_iu_ex_rand_vld;
assign ctrl_mad_oper_mux_en     = decd_ctrl_mad_sel;
assign ctrl_alu_mad_oper_mux_en = decd_ctrl_mad_sel;
//assign iu_cp0_oper_mux_en       = (seu_xx_oper_mux_en[4] || decd_ctrl_cp0_sel);
assign iu_cp0_oper_mux_en       = decd_ctrl_cp0_sel;
assign iu_cp0_ecall             = decd_ctrl_expt_ecall;

assign iu_lsu_oper_mux_en       = predec_lsu_sel;

//the data path selection signal is only from decode information,
assign ctrl_alu_ex_data_sel     = ifu_iu_ex_hs_split_inst_vld && !ifu_iu_ex_rand_vld && decd_ctrl_alu_sel;
assign ctrl_mad_ex_data_sel     = ifu_iu_ex_hs_split_inst_vld && !ifu_iu_ex_rand_vld && decd_ctrl_mad_sel;
assign ctrl_lsu_ex_data_sel     = ifu_iu_ex_hs_split_inst_vld && !ifu_iu_ex_rand_vld && predec_lsu_sel;
assign ctrl_special_ex_data_sel = ifu_iu_ex_hs_split_inst_vld && !ifu_iu_ex_rand_vld && decd_xx_unit_special_sel;
assign ctrl_cp0_ex_data_sel     = ifu_iu_ex_hs_split_inst_vld && !ifu_iu_ex_rand_vld && decd_ctrl_cp0_sel;
assign ctrl_branch_ex_data_sel  = ifu_iu_ex_hs_split_inst_vld && !ifu_iu_ex_rand_vld && decd_ctrl_branch_sel;
assign ctrl_oper_lsu_data_sel   = ifu_iu_ex_hs_split_inst_vld && !ifu_iu_ex_rand_vld && predec_lsu_sel;

//when illeagle inst, lsu req cannot be asserted
assign iu_lsu_ex_data_sel       = ifu_iu_ex_hs_split_inst_vld && !ifu_iu_ex_rand_vld && predec_lsu_sel
                                  && !decd_xx_unit_special_sel;
assign iu_cp0_ex_data_sel       = ifu_iu_ex_hs_split_inst_vld && !ifu_iu_ex_rand_vld && decd_ctrl_cp0_sel;



//==========================================================
//                 Other Control signals
//==========================================================
//ignore internal stall signal to avoid memory transcmplt 
//path to get in
//EX stage instruction write back valid
//pay attention that bctm writes back r15 at the next
//cycle of check fail, but at that time there is no inst_vld
//in EX pipeline, so any write back/forward signal with
//following ex_inst_vld signals should be carefully designed.
//for examples, please refer to iu_wb

//when the sub_sp of nie, ee ie in PSR need to be asserted
// &Force("output","iu_cp0_nest_int_en"); @150
//assign ctrl_wb_nie_nir_vld = ifu_iu_ex_cr_oper;
assign ctrl_xx_sp_adjust = 1'b0;



//==========================================================
//               Non Interruptable Instruction
//==========================================================
assign ctrl_retire_ni_vld       = ifu_iu_ex_hs_split_inst_vld && ifu_iu_ex_ni;

//==========================================================
//                    Handle Exceptions
//==========================================================
assign ifu_iu_ex_hs_split_expt_vld   = ifu_iu_ex_expt_vld && !hs_split_iu_ctrl_inst_vld;
assign ctrl_special_expt_vld = ifu_iu_ex_hs_split_expt_vld
                            || ifu_iu_ex_prvlg_expt_vld
                            || decd_ctrl_expt_inv
                            || decd_ctrl_expt_bkpt
                            || decd_ctrl_expt_ecall
                            || decd_ctrl_expt_wsc;
// &CombBeg; @181
always @( cp0_yy_priv_mode[1:0]
       or decd_ctrl_expt_inv
       or decd_ctrl_expt_bkpt
       or ifu_iu_ex_hs_split_expt_vld
       or decd_ctrl_expt_ecall)
begin
  if(ifu_iu_ex_hs_split_expt_vld)       // Instruction access fault
  begin
    ctrl_special_expt_vec[4:0] = 5'b1;
  end
  else if(decd_ctrl_expt_inv )  // Illegal Instruction
  begin
    ctrl_special_expt_vec[4:0] = 5'b10;
  end
  else if(decd_ctrl_expt_bkpt) // Breakpoint
  begin
    ctrl_special_expt_vec[4:0] = 5'b11;
  end
  else if(decd_ctrl_expt_ecall) // Ecall from M-mode/U-mode
  begin
    ctrl_special_expt_vec[4:0] = {5{(cp0_yy_priv_mode[1:0] == 2'b11)}} & 5'b1011 |
                                 {5{(cp0_yy_priv_mode[1:0] == 2'b00)}} & 5'b1000 |
                                 {5{(cp0_yy_priv_mode[1:0] == 2'b01)}} & 5'b1001;
  end
  else  // no exception in before execution units, use reserved value
  begin
    ctrl_special_expt_vec[4:0] = 5'b01010;
  end
// &CombEnd; @204
end

// &ModuleEnd; @206
endmodule


