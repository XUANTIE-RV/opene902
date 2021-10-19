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

// &ModuleBeg; @26
module cr_iu_wb(
  branch_wb_cmp,
  branch_wb_jmp_reg,
  cp0_yy_clk_en,
  cp0_yy_priv_mode,
  cpurst_b,
  ctrl_alu_ex_data_sel,
  ctrl_mad_ex_data_sel,
  decd_wb_tval,
  decd_xx_inst_32bit,
  decd_xx_unit_special_sel,
  forever_cpuclk,
  ifu_iu_ex_inst_vld,
  ifu_iu_ex_int_spcu_mask,
  ifu_iu_ex_int_spcu_vld,
  ifu_iu_ex_split_on,
  iu_cp0_expt_tval,
  iu_had_flush,
  iu_had_xx_data,
  iu_had_xx_data_vld,
  iu_ifu_wb_ldst,
  iu_lsu_stall_without_hready,
  iu_lsu_wb_ldst,
  iu_lsu_wb_load,
  iu_lsu_wb_store,
  iu_pad_gpr_data,
  iu_pad_gpr_index,
  iu_pad_gpr_we,
  iu_yy_xx_dbgon,
  iu_yy_xx_flush,
  lsu_iu_addr,
  lsu_iu_addr_vld,
  lsu_iu_fast_retire,
  lsu_iu_wb_acc_err,
  lsu_iu_wb_bstack_chk_fail,
  lsu_iu_wb_cmplt,
  lsu_iu_wb_data_vld,
  lsu_iu_wb_load_data,
  misc_clk,
  oper_wb_rs1_equal_to_dst,
  oper_wb_rs2_equal_to_dst,
  pad_yy_gate_clk_en_b,
  pcgen_xx_cur_pc,
  randclk_wb_buf_mod_en_w32,
  randclk_wb_ctrl_mod_en_w2,
  randclk_wb_idx_mod_en_w5,
  rbus_wb_cmplt,
  rbus_wb_data,
  rbus_wb_dst_reg,
  rbus_wb_inst_cmplt,
  rbus_wb_load,
  rbus_wb_store,
  retire_wb_dbg_in_ack,
  retire_wb_hs_err_epc_sel,
  retire_wb_mem_bkpt_fast_retire,
  wb_branch_dep_ld,
  wb_ctrl_stall,
  wb_ctrl_stall_without_hready,
  wb_oper_fwd_data_no_load,
  wb_oper_fwd_en,
  wb_oper_write_data,
  wb_oper_write_en,
  wb_oper_write_idx,
  wb_oper_write_idx_for_dep,
  wb_pcgen_ldst_stall,
  wb_pcgen_pc_updt_val,
  wb_pcgen_switch_ld_pc,
  wb_rbus_lsu_vec,
  wb_rbus_st_aft_load,
  wb_retire_fast_retire_load_pc,
  wb_special_st_uncmplt,
  wb_top_machine_mode_clk_en,
  wb_top_machine_sp_en_clk_en,
  wb_top_secu_mode_clk_en,
  wb_top_sp_adjust_clk_en,
  wb_vector_ldst_wait_cmplt,
  wb_xx_acc_err_after_retire,
  wb_xx_lsu_check_fail_after_retire
);

// &Ports; @27
input           branch_wb_cmp;                            
input           branch_wb_jmp_reg;                        
input           cp0_yy_clk_en;                            
input   [1 :0]  cp0_yy_priv_mode;                         
input           cpurst_b;                                 
input           ctrl_alu_ex_data_sel;                     
input           ctrl_mad_ex_data_sel;                     
input   [31:0]  decd_wb_tval;                             
input           decd_xx_inst_32bit;                       
input           decd_xx_unit_special_sel;                 
input           forever_cpuclk;                           
input           ifu_iu_ex_inst_vld;                       
input           ifu_iu_ex_int_spcu_mask;                  
input           ifu_iu_ex_int_spcu_vld;                   
input           ifu_iu_ex_split_on;                       
input           iu_yy_xx_dbgon;                           
input           iu_yy_xx_flush;                           
input   [31:0]  lsu_iu_addr;                              
input           lsu_iu_addr_vld;                          
input           lsu_iu_fast_retire;                       
input           lsu_iu_wb_acc_err;                        
input           lsu_iu_wb_bstack_chk_fail;                
input           lsu_iu_wb_cmplt;                          
input           lsu_iu_wb_data_vld;                       
input   [31:0]  lsu_iu_wb_load_data;                      
input           misc_clk;                                 
input           oper_wb_rs1_equal_to_dst;                 
input           oper_wb_rs2_equal_to_dst;                 
input           pad_yy_gate_clk_en_b;                     
input   [30:0]  pcgen_xx_cur_pc;                          
input           randclk_wb_buf_mod_en_w32;                
input           randclk_wb_ctrl_mod_en_w2;                
input           randclk_wb_idx_mod_en_w5;                 
input           rbus_wb_cmplt;                            
input   [31:0]  rbus_wb_data;                             
input   [4 :0]  rbus_wb_dst_reg;                          
input           rbus_wb_inst_cmplt;                       
input           rbus_wb_load;                             
input           rbus_wb_store;                            
input           retire_wb_dbg_in_ack;                     
input           retire_wb_hs_err_epc_sel;                 
input           retire_wb_mem_bkpt_fast_retire;           
output  [31:0]  iu_cp0_expt_tval;                         
output          iu_had_flush;                             
output  [31:0]  iu_had_xx_data;                           
output          iu_had_xx_data_vld;                       
output          iu_ifu_wb_ldst;                           
output          iu_lsu_stall_without_hready;              
output          iu_lsu_wb_ldst;                           
output          iu_lsu_wb_load;                           
output          iu_lsu_wb_store;                          
output  [31:0]  iu_pad_gpr_data;                          
output  [4 :0]  iu_pad_gpr_index;                         
output          iu_pad_gpr_we;                            
output          wb_branch_dep_ld;                         
output          wb_ctrl_stall;                            
output          wb_ctrl_stall_without_hready;             
output  [31:0]  wb_oper_fwd_data_no_load;                 
output          wb_oper_fwd_en;                           
output  [31:0]  wb_oper_write_data;                       
output          wb_oper_write_en;                         
output  [4 :0]  wb_oper_write_idx;                        
output  [4 :0]  wb_oper_write_idx_for_dep;                
output          wb_pcgen_ldst_stall;                      
output  [30:0]  wb_pcgen_pc_updt_val;                     
output          wb_pcgen_switch_ld_pc;                    
output  [4 :0]  wb_rbus_lsu_vec;                          
output          wb_rbus_st_aft_load;                      
output  [30:0]  wb_retire_fast_retire_load_pc;            
output          wb_special_st_uncmplt;                    
output          wb_top_machine_mode_clk_en;               
output          wb_top_machine_sp_en_clk_en;              
output          wb_top_secu_mode_clk_en;                  
output          wb_top_sp_adjust_clk_en;                  
output          wb_vector_ldst_wait_cmplt;                
output          wb_xx_acc_err_after_retire;               
output          wb_xx_lsu_check_fail_after_retire;        

// &Regs; @28
reg     [1 :0]  cur_state;                                
reg             ex_wb_split_on;                           
reg     [1 :0]  next_state;                               
reg     [31:0]  wb_data_buffer;                           
reg     [4 :0]  wb_idx_buffer;                            
reg             wb_inst_32;                               
reg             wb_int_spcu_inst;                         
reg             wb_int_spcu_mask;                         

// &Wires; @29
wire            branch_wb_cmp;                            
wire            cp0_yy_clk_en;                            
wire            cp0_yy_machine_mode;                      
wire            cp0_yy_machine_mode_post;                 
wire    [1 :0]  cp0_yy_priv_mode;                         
wire            cpurst_b;                                 
wire            ctrl_alu_ex_data_sel;                     
wire            ctrl_mad_ex_data_sel;                     
wire    [31:0]  decd_wb_tval;                             
wire            decd_xx_inst_32bit;                       
wire            decd_xx_unit_special_sel;                 
wire            forever_cpuclk;                           
wire            ifu_iu_ex_inst_vld;                       
wire            ifu_iu_ex_int_spcu_mask;                  
wire            ifu_iu_ex_int_spcu_vld;                   
wire            ifu_iu_ex_split_on;                       
wire    [31:0]  iu_cp0_expt_tval;                         
wire            iu_had_flush;                             
wire    [31:0]  iu_had_xx_data;                           
wire            iu_had_xx_data_vld;                       
wire            iu_ifu_wb_ldst;                           
wire            iu_lsu_stall_without_hready;              
wire            iu_lsu_wb_ldst;                           
wire            iu_lsu_wb_load;                           
wire            iu_lsu_wb_store;                          
wire    [31:0]  iu_pad_gpr_data;                          
wire    [4 :0]  iu_pad_gpr_index;                         
wire            iu_pad_gpr_we;                            
wire            iu_yy_xx_dbgon;                           
wire            iu_yy_xx_flush;                           
wire            ldst_stall;                               
wire    [31:0]  lsu_iu_addr;                              
wire            lsu_iu_addr_vld;                          
wire            lsu_iu_fast_retire;                       
wire            lsu_iu_wb_acc_err;                        
wire            lsu_iu_wb_bstack_chk_fail;                
wire            lsu_iu_wb_cmplt;                          
wire            lsu_iu_wb_data_vld;                       
wire    [31:0]  lsu_iu_wb_load_data;                      
wire            misc_clk;                                 
wire    [1 :0]  next_cmplt_state;                         
wire            oper_wb_rs1_equal_to_dst;                 
wire            oper_wb_rs2_equal_to_dst;                 
wire            pad_yy_gate_clk_en_b;                     
wire    [30:0]  pcgen_xx_cur_pc;                          
wire    [30:0]  pcgen_xx_cur_pc_mask;                     
wire            randclk_wb_buf_mod_en_w32;                
wire            randclk_wb_ctrl_mod_en_w2;                
wire            randclk_wb_idx_mod_en_w5;                 
wire            rbus_wb_cmplt;                            
wire    [31:0]  rbus_wb_data;                             
wire    [4 :0]  rbus_wb_dst_reg;                          
wire            rbus_wb_inst_cmplt;                       
wire            rbus_wb_load;                             
wire            rbus_wb_store;                            
wire            retire_wb_dbg_in_ack;                     
wire            retire_wb_hs_err_epc_sel;                 
wire            retire_wb_mem_bkpt_fast_retire;           
wire            wb_acc_err_after_retire;                  
wire            wb_alu_or_load_wen;                       
wire            wb_branch_dep_ld;                         
wire            wb_buf_stall;                             
wire            wb_buf_stall_without_hready;              
wire            wb_check_fail_after_retire;               
wire            wb_clk;                                   
wire            wb_clk_en;                                
wire            wb_cmplt_write_back;                      
wire            wb_ctrl_load_fwd_non_alu;                 
wire            wb_ctrl_stall;                            
wire            wb_ctrl_stall_without_bctm;               
wire            wb_ctrl_stall_without_bctm_without_hready; 
wire            wb_ctrl_stall_without_hready;             
wire            wb_data_buf_0_16_update;                  
wire            wb_data_buf_16_0_clk;                     
wire            wb_data_buf_16_0_clk_en;                  
wire    [31:0]  wb_data_buffer_post;                      
wire            wb_data_buffer_update;                    
wire            wb_dst_reg_22;                            
wire            wb_dst_reg_23;                            
wire            wb_dst_reg_24;                            
wire            wb_dst_reg_25;                            
wire            wb_dst_reg_30;                            
wire            wb_dst_reg_high_16;                       
wire            wb_dst_reg_valid;                         
wire            wb_ex_cmplt;                              
wire            wb_fast_retire_pc_mask;                   
wire    [1 :0]  wb_fast_retire_pc_offset;                 
wire            wb_idx_buf_3_0_clk;                       
wire            wb_idx_buf_3_0_clk_en;                    
wire            wb_idx_buf_3_0_update;                    
wire            wb_idx_buf_update;                        
wire    [4 :0]  wb_idx_for_dep;                           
wire            wb_int_spcu_epc_mask;                     
wire            wb_int_spcu_expt_mask;                    
wire            wb_ldst;                                  
wire            wb_load_fwd_mad;                          
wire    [31:0]  wb_oper_fwd_data_no_load;                 
wire            wb_oper_fwd_en;                           
wire            wb_oper_machine_mode;                     
wire    [31:0]  wb_oper_write_data;                       
wire            wb_oper_write_en;                         
wire    [4 :0]  wb_oper_write_idx;                        
wire    [4 :0]  wb_oper_write_idx_for_dep;                
wire            wb_pcgen_ldst_stall;                      
wire    [30:0]  wb_pcgen_pc_updt_val;                     
wire            wb_pcgen_switch_ld_pc;                    
wire    [4 :0]  wb_rbus_lsu_vec;                          
wire            wb_rbus_st_aft_load;                      
wire    [30:0]  wb_retire_fast_retire_load_pc;            
wire            wb_sp_wen_stall;                          
wire            wb_special_st_uncmplt;                    
wire            wb_store_aft_load;                        
wire            wb_top_machine_mode_clk_en;               
wire            wb_top_machine_sp_en_clk_en;              
wire            wb_top_secu_mode_clk_en;                  
wire            wb_top_sp_adjust_clk_en;                  
wire            wb_uncmplt_load;                          
wire            wb_uncmplt_store;                         
wire            wb_vector_ldst_wait_cmplt;                
wire            wb_write_back;                            
wire    [31:0]  wb_write_back_data;                       
wire    [31:0]  wb_write_back_data_without_pol;           
wire            wb_write_back_en;                         
wire            wb_xx_acc_err_after_retire;               
wire            wb_xx_lsu_check_fail_after_retire;        



// &Force("bus","rbus_wb_dst_reg",4,0); @52
// //&Force("input", "cp0_yy_intsp_sel_post"); @97
// &Force("input", "ifu_iu_ex_int_spcu_vld"); @98
// &Force("input", "retire_wb_mem_bkpt_fast_retire"); @99
// //&Force("input", "retire_wb_acked_int"); @100
// //&Force("input", "cp0_yy_machine_sp_en"); @101
// &Force("input", "lsu_iu_addr_vld"); @119



//==========================================================
//             With Load Fast Retire Implement
//==========================================================

parameter IDLE  = 2'b00;
parameter LOAD  = 2'b11;
parameter STORE = 2'b10;
parameter ALU   = 2'b01;

//==========================================================
//                 Instance of Gated Cell  
//==========================================================
//1.wb_data_buffer[4:0] is reused by uncompleted load inst to buffer data size,
//  this kind of situation seldom happens.So we can sepearate wb_data_buffer[31:0]
//  into two parts:wb_data_buffer[4:0] and wb_data_buffer[31:5] to reduce power
//2.Depending on principle of locality ,data for a certain program varies in certain
//  range, so we can separate wb_data_buffer[31:5] into two part to reduce power

assign wb_clk_en = (cur_state != IDLE) || wb_ex_cmplt;
// &Instance("gated_clk_cell", "x_wb_gated_clk"); @149
gated_clk_cell  x_wb_gated_clk (
  .clk_in                    (forever_cpuclk           ),
  .clk_out                   (wb_clk                   ),
  .external_en               (1'b0                     ),
  .global_en                 (cp0_yy_clk_en            ),
  .local_en                  (wb_clk_en                ),
  .module_en                 (randclk_wb_ctrl_mod_en_w2),
  .pad_yy_gate_clk_en_b      (pad_yy_gate_clk_en_b     )
);

// &Connect(.clk_in      (forever_cpuclk), @150
//          .external_en (1'b0), @151
//          .global_en   (cp0_yy_clk_en), @152
//          .module_en   (randclk_wb_ctrl_mod_en_w2), @153
//          .local_en    (wb_clk_en), @154
//          .clk_out     (wb_clk)); @155

assign wb_data_buf_16_0_clk_en = wb_data_buf_0_16_update;
// &Instance("gated_clk_cell", "x_wb_data_buf_16_0_gated_clk"); @158
gated_clk_cell  x_wb_data_buf_16_0_gated_clk (
  .clk_in                    (forever_cpuclk           ),
  .clk_out                   (wb_data_buf_16_0_clk     ),
  .external_en               (1'b0                     ),
  .global_en                 (cp0_yy_clk_en            ),
  .local_en                  (wb_data_buf_16_0_clk_en  ),
  .module_en                 (randclk_wb_buf_mod_en_w32),
  .pad_yy_gate_clk_en_b      (pad_yy_gate_clk_en_b     )
);

// &Connect(.clk_in      (forever_cpuclk), @159
//          .external_en (1'b0), @160
//          .global_en   (cp0_yy_clk_en), @161
//          .module_en   (randclk_wb_buf_mod_en_w32), @162
//          .local_en    (wb_data_buf_16_0_clk_en), @163
//          .clk_out     (wb_data_buf_16_0_clk)); @164

assign wb_idx_buf_update     = wb_cmplt_write_back || wb_uncmplt_load;
assign wb_idx_buf_3_0_update = wb_idx_buf_update;
assign wb_idx_buf_3_0_clk_en = wb_idx_buf_3_0_update;
// &Instance("gated_clk_cell", "x_idx_buf_3_0_gated_clk"); @169
gated_clk_cell  x_idx_buf_3_0_gated_clk (
  .clk_in                   (forever_cpuclk          ),
  .clk_out                  (wb_idx_buf_3_0_clk      ),
  .external_en              (1'b0                    ),
  .global_en                (cp0_yy_clk_en           ),
  .local_en                 (wb_idx_buf_3_0_clk_en   ),
  .module_en                (randclk_wb_idx_mod_en_w5),
  .pad_yy_gate_clk_en_b     (pad_yy_gate_clk_en_b    )
);

// &Connect(.clk_in      (forever_cpuclk), @170
//          .external_en (1'b0), @171
//          .global_en   (cp0_yy_clk_en), @172
//          .module_en   (randclk_wb_idx_mod_en_w5), @173
//          .local_en    (wb_idx_buf_3_0_clk_en), @174
//          .clk_out     (wb_idx_buf_3_0_clk)); @175

//==========================================================
//       Write Buffer Control State Machine
//==========================================================

//-----------------------------------------------------
// buffer the write back data for retired instruction
//-----------------------------------------------------

//-------------------FSM of wb logic------------------
// State Description:
// IDLE  : there is no retired instruction needs write back
// LOAD  : there is load instruction waiting for data
// STORE : buffer store instruction write data
// ALU   : buffer other instruction needs to write back
//-----------------------------------------------------

always @(posedge wb_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cur_state[1:0] <= IDLE;
  else
    cur_state[1:0] <= next_state[1:0];
end

//-----------------------------------------------------
// State change signals
//-----------------------------------------------------
assign wb_uncmplt_load     = rbus_wb_load;
assign wb_uncmplt_store    = rbus_wb_store;
assign wb_cmplt_write_back = rbus_wb_cmplt;

assign wb_ex_cmplt         = wb_uncmplt_load
                             || wb_uncmplt_store
                             || wb_cmplt_write_back;

assign next_cmplt_state[1:0] = {2{wb_uncmplt_load}}     & LOAD
                             | {2{wb_uncmplt_store}}    & STORE
                             | {2{wb_cmplt_write_back}} & ALU;

// &CombBeg; @216
always @( cur_state
       or wb_ex_cmplt
       or next_cmplt_state
       or lsu_iu_wb_cmplt)
begin
  case(cur_state)
  IDLE       : if(wb_ex_cmplt)
                 next_state = next_cmplt_state;
               else
                 next_state = IDLE;
  LOAD       : if(lsu_iu_wb_cmplt && wb_ex_cmplt)
                 next_state = next_cmplt_state;
               else if(lsu_iu_wb_cmplt && !wb_ex_cmplt)
                 next_state = IDLE;
               else
                 next_state = LOAD;
  STORE      : if(lsu_iu_wb_cmplt && wb_ex_cmplt)
                 next_state = next_cmplt_state;
               else if(lsu_iu_wb_cmplt && !wb_ex_cmplt)
                 next_state = IDLE;
               else
                 next_state = STORE;
  ALU        : if(wb_ex_cmplt)
                 next_state = next_cmplt_state;
               else
                 next_state = IDLE;
  default    :   next_state = IDLE;
  endcase
// &CombEnd; @240
end

//-----------------------------------------------------
//                  Control Signals
//-----------------------------------------------------
//in ALU state write back data, and in LOAD state, write
//back data when complete
assign wb_alu_or_load_wen = ((cur_state == LOAD)
                               && lsu_iu_wb_cmplt
                               && lsu_iu_wb_data_vld
                          || (cur_state == ALU));
assign wb_write_back_en   = wb_alu_or_load_wen 
                            && wb_dst_reg_valid;
//ALU and LOAD need to write back
assign wb_write_back      = ((cur_state == ALU)
                             || (cur_state == LOAD))
                            && wb_dst_reg_valid;
//when wb is load, it takes lsu load data process logic
//assign iu_lsu_wb_load_vld = (cur_state == LOAD);

//when the ld or st is fast retired, the expt signal maybe come
//back after the inst retire
assign wb_acc_err_after_retire = ((cur_state == LOAD) || (cur_state == STORE)) 
                                  && lsu_iu_wb_cmplt
                                  && lsu_iu_wb_acc_err
                                  && !wb_int_spcu_expt_mask;

assign wb_xx_acc_err_after_retire = wb_acc_err_after_retire;

assign wb_ldst = ((cur_state == LOAD) || (cur_state == STORE));
assign iu_lsu_wb_ldst = wb_ldst;

assign iu_ifu_wb_ldst = wb_ldst;

assign iu_lsu_wb_load  = cur_state == LOAD;
assign iu_lsu_wb_store = cur_state == STORE;

//assign wb_special_store = cur_state == STORE;
assign wb_special_st_uncmplt = cur_state == STORE && !lsu_iu_wb_cmplt;

// &Force("output","wb_oper_machine_mode"); @286
assign wb_oper_machine_mode = 1'b0;

assign cp0_yy_machine_mode_post   = cp0_yy_machine_mode;
assign wb_top_machine_mode_clk_en = cp0_yy_machine_mode_post ^ wb_oper_machine_mode;
assign cp0_yy_machine_mode        = cp0_yy_priv_mode[1:0] == 2'b11;
// //&Force("output","wb_intsp_sel"); @305
//always @(posedge misc_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    wb_intsp_sel <= 1'b1;
//  else if(rbus_wb_inst_cmplt)
//    wb_intsp_sel <= cp0_yy_intsp_sel_post;
//end 
//
//assign wb_top_sp_sel_clk_en = cp0_yy_intsp_sel_post  ^  wb_intsp_sel ;

// &Force("output","wb_oper_secu_mode"); @317
assign wb_top_secu_mode_clk_en = 1'b0;
assign wb_top_machine_sp_en_clk_en = 1'b0;
// &Force("output","wb_oper_machine_sp_en"); @342
always @(posedge misc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    wb_int_spcu_inst <= 1'b0;
  else if(rbus_wb_inst_cmplt)
    wb_int_spcu_inst <= ifu_iu_ex_int_spcu_vld;
end

always @(posedge misc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    wb_int_spcu_mask <= 1'b0;
  else if(rbus_wb_inst_cmplt)
    wb_int_spcu_mask <= ifu_iu_ex_int_spcu_mask;
end

assign wb_int_spcu_epc_mask  = wb_int_spcu_inst;
assign wb_int_spcu_expt_mask = wb_int_spcu_mask;

assign wb_top_sp_adjust_clk_en = (ifu_iu_ex_int_spcu_vld ^ wb_int_spcu_inst)
                              || (ifu_iu_ex_int_spcu_mask ^ wb_int_spcu_mask);


always @(posedge wb_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    wb_inst_32 <= 1'b0;
  else if(lsu_iu_fast_retire)
    wb_inst_32 <= decd_xx_inst_32bit;
end

always @(posedge wb_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ex_wb_split_on <= 1'b0;
  else if(lsu_iu_fast_retire)
    ex_wb_split_on <= ifu_iu_ex_split_on;
end

//for check fail of fast retired ld st
assign wb_check_fail_after_retire = ((cur_state == LOAD) || (cur_state == STORE))
                                     && lsu_iu_wb_bstack_chk_fail;
assign wb_xx_lsu_check_fail_after_retire = wb_check_fail_after_retire;


//==========================================================
//          Interface with IU EX stage modules
//==========================================================

//-----------------------------------------------------
//                    stall signal
//-----------------------------------------------------
//write buffer will stall when load/store not complete
assign wb_buf_stall  = ((cur_state == LOAD) || (cur_state == STORE))
                         && !(lsu_iu_wb_cmplt
                              && !lsu_iu_wb_acc_err 
                              && !lsu_iu_wb_bstack_chk_fail)
                    || retire_wb_dbg_in_ack;

assign wb_buf_stall_without_hready = ((cur_state == LOAD)    || (cur_state == STORE))
                                       && (lsu_iu_wb_acc_err || lsu_iu_wb_bstack_chk_fail)
                                  || retire_wb_dbg_in_ack;

assign ldst_stall = ((cur_state == LOAD) || (cur_state == STORE))
                             && !lsu_iu_wb_cmplt;
assign wb_pcgen_ldst_stall = ldst_stall;
//==========================================================
//              Write Back Buffer Implement
//==========================================================

//-----------------------------------------------------
//                  Write Back Buffer
//-----------------------------------------------------
assign wb_data_buffer_post[31:0]  = lsu_iu_addr_vld ? lsu_iu_addr[31:0]
                                                    : rbus_wb_data[31:0];
assign wb_data_buffer_update = wb_cmplt_write_back
                            || rbus_wb_inst_cmplt
                            || lsu_iu_addr_vld && !ldst_stall;
assign wb_store_aft_load     = (cur_state == LOAD)
                               && (wb_uncmplt_store || (next_state == IDLE));
assign wb_rbus_st_aft_load   = wb_store_aft_load;
assign wb_rbus_lsu_vec[4:0] = cur_state == LOAD ? 5'b00101 : 5'b00111;

assign wb_data_buf_0_16_update = wb_data_buffer_update || wb_store_aft_load;
always @(posedge wb_data_buf_16_0_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    wb_data_buffer[31:0] <= 32'b0;
  else if(wb_data_buf_0_16_update)
    wb_data_buffer[31:0] <= wb_data_buffer_post[31:0];
  else
    wb_data_buffer[31:0] <= wb_data_buffer[31:0];
end 



//-----------------------------------------------------
//              Buffer info of fast retire ld st
//-----------------------------------------------------
//when ld st is fast retired, the size and split info need to be buffered
assign wb_fast_retire_pc_mask = !ex_wb_split_on && lsu_iu_wb_acc_err
                             && !wb_int_spcu_epc_mask;
assign wb_fast_retire_pc_offset[1:0] = {2{wb_fast_retire_pc_mask}}
                                     & {wb_inst_32,!wb_inst_32} | {retire_wb_hs_err_epc_sel,1'b0};// this is for wsc, when wsc with hs-err
assign pcgen_xx_cur_pc_mask[30:8] = pcgen_xx_cur_pc[30:8];
assign pcgen_xx_cur_pc_mask[7:0]  = pcgen_xx_cur_pc[7:0]
                                  & {8{lsu_iu_wb_acc_err || retire_wb_hs_err_epc_sel}};
assign wb_retire_fast_retire_load_pc[30:0] = pcgen_xx_cur_pc_mask[30:0] 
                                              - {29'b0, wb_fast_retire_pc_offset[1:0]};

//when int is vld when ld st is fast retired, the expt SM needs to wait for
//the cmplt from dbus
assign wb_vector_ldst_wait_cmplt = ((cur_state == LOAD) || (cur_state == STORE))
                                   && !lsu_iu_wb_cmplt;

//-----------------------------------------------------
//              Write Back Index Buffer
//-----------------------------------------------------
always @(posedge wb_idx_buf_3_0_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    wb_idx_buffer[4:0] <= 5'b0;
  else if(wb_idx_buf_3_0_update)
    wb_idx_buffer[4:0] <= rbus_wb_dst_reg[4:0];
  else
    wb_idx_buffer[4:0] <= wb_idx_buffer[4:0];
end
//assign wb_cr_oper = 1'b0;

//if write back to undefined register, the write buffer should
//perform no write back, to avoid incorrect forward
assign wb_dst_reg_30            = 1'b0;
assign wb_dst_reg_25            = 1'b0;
assign wb_dst_reg_24            = 1'b0;
assign wb_dst_reg_23            = 1'b0;
assign wb_dst_reg_22            = 1'b0;

assign wb_dst_reg_high_16       = wb_idx_buffer[4]
                               && !wb_dst_reg_30
                               && !wb_dst_reg_25
                               && !wb_dst_reg_24
                               && !wb_dst_reg_23
                               && !wb_dst_reg_22;
assign wb_dst_reg_valid         = !wb_dst_reg_high_16 && wb_idx_buffer[4:0] != 5'd0;

//==========================================================
//              Write Back Data Selection
//==========================================================
assign wb_write_back_data[31:0] = (cur_state == LOAD)
                                  ? lsu_iu_wb_load_data[31:0]
                                  : wb_data_buffer[31:0];
assign wb_write_back_data_without_pol[31:0] = wb_write_back_data[31:0];

//==========================================================
//              Write Back Signal for GPR
//==========================================================
assign wb_oper_write_en         = wb_write_back_en;

//assign iu_cp0_epsr_wen_for_nir  = 1'b0;
//assign iu_cp0_epc_wen_for_nir   = 1'b0;
//assign iu_cp0_updt_val[31:0]    = 32'b0;

assign wb_pcgen_switch_ld_pc      = 1'b0;
assign wb_pcgen_pc_updt_val[30:0] = 31'b0;


assign wb_oper_write_idx[4:0]   = wb_idx_buffer[4:0];
assign wb_idx_for_dep[4:0] = wb_idx_buffer[4:0];
assign wb_oper_write_idx_for_dep[4:0] = wb_idx_for_dep[4:0];
assign wb_oper_write_data[31:0] = wb_write_back_data[31:0];

//for operand forward without load value
assign wb_oper_fwd_en           = wb_write_back;
assign wb_oper_fwd_data_no_load[31:0] = wb_data_buffer[31:0];

//for pad signal
assign iu_pad_gpr_we            = wb_write_back_en;
assign iu_pad_gpr_index[4:0]    = wb_idx_buffer[4:0];
assign iu_pad_gpr_data[31:0]    = wb_write_back_data_without_pol[31:0];

//for had signal
assign iu_had_xx_data_vld       = wb_write_back_en && iu_yy_xx_dbgon;
assign iu_had_xx_data[31:0]     = wb_write_back_data_without_pol[31:0];
assign iu_had_flush             = iu_yy_xx_flush;

//==========================================================
//                Invalid Forward Path
//==========================================================
//-----------------------------------------------------
//      Forward from load to EX unit expt ALU/MAD
//-----------------------------------------------------
//indicate control logic that EX stage following sources
//should not forward from load:
//1.jump register expcept jmp x1
//2.load/store base register
//3.cp0
//4.jmpix rx

// &Force("input", "branch_wb_jmp_reg"); @624
assign wb_ctrl_load_fwd_non_alu = (cur_state == LOAD)
                               && (oper_wb_rs1_equal_to_dst && ifu_iu_ex_inst_vld
                               || (oper_wb_rs2_equal_to_dst 
                               && (ctrl_alu_ex_data_sel || ctrl_mad_ex_data_sel || branch_wb_cmp))
                                     );

assign wb_branch_dep_ld = wb_ctrl_load_fwd_non_alu;
assign wb_load_fwd_mad = 1'b0;

assign wb_sp_wen_stall = 1'b0;
//==========================================================
//                  Control stall signal
//==========================================================
//1.write buffer will stall when load/store not complete
//2.jump register source cannot forward from load value
//  set stall in this condition
//3.svbr source cannot forward from all instructon to bctm
//  (ifdef BCTM)
assign wb_ctrl_stall_without_bctm = wb_buf_stall
                       || wb_ctrl_load_fwd_non_alu
                       || wb_load_fwd_mad
                       || wb_sp_wen_stall;
assign wb_ctrl_stall_without_bctm_without_hready = wb_buf_stall_without_hready
                                                || wb_ctrl_load_fwd_non_alu
                                                || wb_load_fwd_mad
                                                || wb_sp_wen_stall;

assign wb_ctrl_stall = wb_ctrl_stall_without_bctm;
assign wb_ctrl_stall_without_hready = wb_ctrl_stall_without_bctm_without_hready;

// &Force("output","wb_ctrl_stall_without_hready"); @656
assign iu_lsu_stall_without_hready = wb_ctrl_stall_without_hready;

// for exception tval to CP0
assign iu_cp0_expt_tval[31:0] = wb_acc_err_after_retire ? wb_data_buffer[31:0]:
                                decd_xx_unit_special_sel ? decd_wb_tval[31:0]:
                                retire_wb_mem_bkpt_fast_retire ? wb_data_buffer[31:0]:
                                                                 lsu_iu_addr[31:0];


// &ModuleEnd; @667
endmodule


