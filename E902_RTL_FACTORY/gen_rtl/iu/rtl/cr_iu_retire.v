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

// &ModuleBeg; @30
module cr_iu_retire(
  clic_cpu_int_hv,
  clic_cpu_int_id,
  clic_cpu_int_il,
  clic_cpu_int_priv,
  clint_cpu_me_int,
  cp0_iu_dbg_disable_for_tee,
  cp0_iu_il,
  cp0_iu_in_nmi,
  cp0_iu_inst_mret,
  cp0_iu_meie,
  cp0_iu_mie_for_int,
  cp0_iu_vec_mode,
  cp0_iu_wfe_en,
  cp0_yy_clk_en,
  cp0_yy_priv_mode,
  cpurst_b,
  ctrl_branch_ex_sel,
  ctrl_retire_ni_vld,
  decd_retire_cp0_inst,
  decd_retire_inst_mret,
  forever_cpuclk,
  had_core_dbg_mode_req,
  had_iu_bkpt_trace_en,
  had_iu_dr_set_req,
  had_iu_force_dbg_en,
  had_iu_int_vld,
  had_iu_mbkpt_fsm_index_mbee,
  had_iu_mem_bkpt_exp_req,
  had_iu_mem_bkpt_mask,
  had_iu_mem_bkpt_req,
  had_iu_rte_pc_sel,
  had_iu_trace_req,
  had_iu_trace_req_for_dbg_disable,
  had_iu_xx_fdb,
  had_iu_xx_jdbreq,
  had_yy_xx_exit_dbg,
  hs_split_iu_hs_retire_mask,
  hs_split_iu_hs_switch_se,
  ifu_iu_ex_inst_dbg_disable,
  ifu_iu_ex_sp_oper,
  ifu_iu_ex_split_on,
  ifu_iu_ibus_idle,
  ifu_iu_inst_bkpt_dbg_occur_vld,
  ifu_iu_inst_bkpt_dbgexp_occur_vld,
  ifu_iu_inst_buf_inst_dbg_disable,
  ifu_iu_inst_buf_inst_vld,
  iu_cp0_epc,
  iu_cp0_epc_update,
  iu_cp0_expt_vld,
  iu_cp0_int_vld,
  iu_cp0_lp_wk_int,
  iu_cp0_mtval_updt_vld,
  iu_cp0_nmi_vld,
  iu_cp0_nt_int_pending_vld,
  iu_had_adr_dbg_ack,
  iu_had_data_bkpt_occur_vld,
  iu_had_dbg_disable_for_tee,
  iu_had_dr_dbg_ack,
  iu_had_expt_vld,
  iu_had_fast_retire_acc_err_pc_update,
  iu_had_fast_retire_acc_err_pc_val,
  iu_had_inst_bkpt_occur_vld,
  iu_had_int_ack,
  iu_had_retire_with_had_int,
  iu_had_trace_occur_vld,
  iu_had_xx_bkpt_inst,
  iu_had_xx_dbg_ack,
  iu_had_xx_mldst,
  iu_had_xx_retire,
  iu_had_xx_retire_normal,
  iu_had_xx_retire_pc,
  iu_ifu_kill_inst,
  iu_ifu_spcu_int_en,
  iu_pad_inst_retire,
  iu_pad_inst_split,
  iu_pad_retire_pc,
  iu_sys_lp_wk_int,
  iu_yy_xx_dbgon,
  iu_yy_xx_expt_vec,
  iu_yy_xx_flush,
  iu_yy_xx_int_hv,
  iu_yy_xx_int_il,
  iu_yy_xx_int_pending_hv,
  iu_yy_xx_int_pending_id,
  iu_yy_xx_int_pending_il,
  iu_yy_xx_int_pending_priv,
  iu_yy_xx_reg_rst_b,
  iu_yy_xx_retire,
  lockup_retire_dbg_vld,
  lockup_retire_mask,
  lockup_retire_nmi_vld,
  lsu_iu_wb_acc_err,
  lsu_iu_wb_cmplt,
  nie_flush_chgflw,
  pad_yy_gate_clk_en_b,
  pcgen_retire_updt_pc,
  pcgen_xx_cur_pc,
  randclk_retire_mod_en_w2,
  rbus_retire_cmplt,
  rbus_retire_expt_vec,
  rbus_retire_expt_vld,
  rbus_retire_flush,
  rbus_retire_split_inst,
  rbus_wb_load,
  rbus_wb_store,
  retire_branch_stall,
  retire_lockup_dbg_on,
  retire_lockup_dbg_vld,
  retire_lockup_expt_vld,
  retire_lockup_inst_retire,
  retire_lockup_nmi_vld,
  retire_lockup_retire_pc,
  retire_mad_ex_cancel,
  retire_pcgen_curpc_update,
  retire_vector_expt_int_hv,
  retire_vector_expt_vld,
  retire_wb_dbg_in_ack,
  retire_wb_hs_err_epc_sel,
  retire_wb_mem_bkpt_fast_retire,
  retire_xx_normal_retire,
  special_retire_inst_wsc,
  sysio_iu_nmi_int,
  sysio_iu_wk_event,
  wb_retire_fast_retire_load_pc,
  wb_xx_acc_err_after_retire,
  wb_xx_lsu_check_fail_after_retire
);

// &Ports; @31
input           clic_cpu_int_hv;                     
input   [11:0]  clic_cpu_int_id;                     
input   [7 :0]  clic_cpu_int_il;                     
input   [1 :0]  clic_cpu_int_priv;                   
input           clint_cpu_me_int;                    
input           cp0_iu_dbg_disable_for_tee;          
input   [7 :0]  cp0_iu_il;                           
input           cp0_iu_in_nmi;                       
input           cp0_iu_inst_mret;                    
input           cp0_iu_meie;                         
input           cp0_iu_mie_for_int;                  
input   [1 :0]  cp0_iu_vec_mode;                     
input           cp0_iu_wfe_en;                       
input           cp0_yy_clk_en;                       
input   [1 :0]  cp0_yy_priv_mode;                    
input           cpurst_b;                            
input           ctrl_branch_ex_sel;                  
input           ctrl_retire_ni_vld;                  
input           decd_retire_cp0_inst;                
input           decd_retire_inst_mret;               
input           forever_cpuclk;                      
input           had_core_dbg_mode_req;               
input           had_iu_bkpt_trace_en;                
input           had_iu_dr_set_req;                   
input           had_iu_force_dbg_en;                 
input           had_iu_int_vld;                      
input           had_iu_mbkpt_fsm_index_mbee;         
input           had_iu_mem_bkpt_exp_req;             
input           had_iu_mem_bkpt_mask;                
input           had_iu_mem_bkpt_req;                 
input           had_iu_rte_pc_sel;                   
input           had_iu_trace_req;                    
input           had_iu_trace_req_for_dbg_disable;    
input           had_iu_xx_fdb;                       
input           had_iu_xx_jdbreq;                    
input           had_yy_xx_exit_dbg;                  
input           hs_split_iu_hs_retire_mask;          
input           hs_split_iu_hs_switch_se;            
input           ifu_iu_ex_inst_dbg_disable;          
input           ifu_iu_ex_sp_oper;                   
input           ifu_iu_ex_split_on;                  
input           ifu_iu_ibus_idle;                    
input           ifu_iu_inst_bkpt_dbg_occur_vld;      
input           ifu_iu_inst_bkpt_dbgexp_occur_vld;   
input           ifu_iu_inst_buf_inst_dbg_disable;    
input           ifu_iu_inst_buf_inst_vld;            
input           iu_yy_xx_reg_rst_b;                  
input           lockup_retire_dbg_vld;               
input           lockup_retire_mask;                  
input           lockup_retire_nmi_vld;               
input           lsu_iu_wb_acc_err;                   
input           lsu_iu_wb_cmplt;                     
input           pad_yy_gate_clk_en_b;                
input   [30:0]  pcgen_retire_updt_pc;                
input   [30:0]  pcgen_xx_cur_pc;                     
input           randclk_retire_mod_en_w2;            
input           rbus_retire_cmplt;                   
input   [4 :0]  rbus_retire_expt_vec;                
input           rbus_retire_expt_vld;                
input           rbus_retire_flush;                   
input           rbus_retire_split_inst;              
input           rbus_wb_load;                        
input           rbus_wb_store;                       
input           special_retire_inst_wsc;             
input           sysio_iu_nmi_int;                    
input           sysio_iu_wk_event;                   
input   [30:0]  wb_retire_fast_retire_load_pc;       
input           wb_xx_acc_err_after_retire;          
input           wb_xx_lsu_check_fail_after_retire;   
output  [30:0]  iu_cp0_epc;                          
output          iu_cp0_epc_update;                   
output          iu_cp0_expt_vld;                     
output          iu_cp0_int_vld;                      
output          iu_cp0_lp_wk_int;                    
output          iu_cp0_mtval_updt_vld;               
output          iu_cp0_nmi_vld;                      
output          iu_cp0_nt_int_pending_vld;           
output          iu_had_adr_dbg_ack;                  
output          iu_had_data_bkpt_occur_vld;          
output          iu_had_dbg_disable_for_tee;          
output          iu_had_dr_dbg_ack;                   
output          iu_had_expt_vld;                     
output          iu_had_fast_retire_acc_err_pc_update; 
output  [30:0]  iu_had_fast_retire_acc_err_pc_val;   
output          iu_had_inst_bkpt_occur_vld;          
output          iu_had_int_ack;                      
output          iu_had_retire_with_had_int;          
output          iu_had_trace_occur_vld;              
output          iu_had_xx_bkpt_inst;                 
output          iu_had_xx_dbg_ack;                   
output          iu_had_xx_mldst;                     
output          iu_had_xx_retire;                    
output          iu_had_xx_retire_normal;             
output  [31:0]  iu_had_xx_retire_pc;                 
output          iu_ifu_kill_inst;                    
output          iu_ifu_spcu_int_en;                  
output          iu_pad_inst_retire;                  
output          iu_pad_inst_split;                   
output  [31:0]  iu_pad_retire_pc;                    
output          iu_sys_lp_wk_int;                    
output          iu_yy_xx_dbgon;                      
output  [9 :0]  iu_yy_xx_expt_vec;                   
output          iu_yy_xx_flush;                      
output          iu_yy_xx_int_hv;                     
output  [7 :0]  iu_yy_xx_int_il;                     
output          iu_yy_xx_int_pending_hv;             
output  [9 :0]  iu_yy_xx_int_pending_id;             
output  [7 :0]  iu_yy_xx_int_pending_il;             
output  [1 :0]  iu_yy_xx_int_pending_priv;           
output          iu_yy_xx_retire;                     
output          nie_flush_chgflw;                    
output          retire_branch_stall;                 
output          retire_lockup_dbg_on;                
output          retire_lockup_dbg_vld;               
output          retire_lockup_expt_vld;              
output          retire_lockup_inst_retire;           
output          retire_lockup_nmi_vld;               
output  [31:0]  retire_lockup_retire_pc;             
output          retire_mad_ex_cancel;                
output          retire_pcgen_curpc_update;           
output          retire_vector_expt_int_hv;           
output          retire_vector_expt_vld;              
output          retire_wb_dbg_in_ack;                
output          retire_wb_hs_err_epc_sel;            
output          retire_wb_mem_bkpt_fast_retire;      
output          retire_xx_normal_retire;             

// &Regs; @32
reg             bkpt_cur_state;                      
reg             bkpt_next_state;                     
reg     [1 :0]  br_cur_state;                        
reg     [1 :0]  br_next_state;                       
reg             cpu_nmi_int_f;                       
reg             cpu_wk_event_f1;                     
reg             cpu_wk_event_f2;                     
reg             dbg_mode_on;                         
reg             dbgreq_ack_ff;                       
reg     [9 :0]  expt_vec;                            
reg             retire_ack_expt;                     
reg             retire_ack_int;                      
reg             retire_nmi_int_req_raw;              
reg             retire_with_ack_dbg;                 
reg             retire_with_ack_int;                 
reg             trace_cur_state;                     
reg             trace_next_state;                    
reg             wb_split_inst;                       

// &Wires; @33
wire            bctm_retire_epc_updt_vld;            
wire            bctm_retire_had_pc_updt_vld;         
wire            bkpt_fsm_trigger;                    
wire            clic_cpu_int_hv;                     
wire    [11:0]  clic_cpu_int_id;                     
wire    [7 :0]  clic_cpu_int_il;                     
wire    [1 :0]  clic_cpu_int_priv;                   
wire            clic_int_pending_vld;                
wire            clic_lp_wk_int;                      
wire            clic_pending_int_need_ack;           
wire            clint_cpu_me_int;                    
wire            clint_lp_wk_int;                     
wire            cp0_iu_dbg_disable_for_tee;          
wire            cp0_iu_ee;                           
wire            cp0_iu_ic;                           
wire    [7 :0]  cp0_iu_il;                           
wire            cp0_iu_in_nmi;                       
wire            cp0_iu_inst_mret;                    
wire            cp0_iu_int_spcu_en;                  
wire            cp0_iu_meie;                         
wire            cp0_iu_mie_for_int;                  
wire    [1 :0]  cp0_iu_vec_mode;                     
wire            cp0_iu_wfe_en;                       
wire            cp0_yy_clk_en;                       
wire    [1 :0]  cp0_yy_priv_mode;                    
wire            cpu_ext_int;                         
wire            cpu_int_vld;                         
wire            cpurst_b;                            
wire            ctrl_branch_ex_sel;                  
wire            ctrl_retire_ni_vld;                  
wire            dbg_clk;                             
wire            dbg_clk_en;                          
wire            dbgreq_ack;                          
wire            dbgreq_ack_aft_force;                
wire            decd_retire_cp0_inst;                
wire            decd_retire_inst_mret;               
wire            epc_update_after_retire;             
wire            ex_inst_dbg_disable;                 
wire    [30:0]  fast_retire_acc_err_epc;             
wire            flop_cpuclk;                         
wire            flop_cpuclk_en;                      
wire            forever_cpuclk;                      
wire            had_core_dbg_mode_req;               
wire            had_iu_bkpt_trace_en;                
wire            had_iu_dr_set_req;                   
wire            had_iu_force_dbg_en;                 
wire            had_iu_int_vld;                      
wire            had_iu_mbkpt_fsm_index_mbee;         
wire            had_iu_mem_bkpt_exp_req;             
wire            had_iu_mem_bkpt_mask;                
wire            had_iu_mem_bkpt_req;                 
wire            had_iu_rte_pc_sel;                   
wire            had_iu_trace_req;                    
wire            had_iu_trace_req_for_dbg_disable;    
wire            had_iu_xx_fdb;                       
wire            had_iu_xx_jdbreq;                    
wire            had_yy_xx_exit_dbg;                  
wire            hadpc_update_after_retire;           
wire            hs_split_iu_hs_retire_mask;          
wire            hs_split_iu_hs_switch_se;            
wire            ifu_iu_ex_inst_dbg_disable;          
wire            ifu_iu_ex_sp_oper;                   
wire            ifu_iu_ex_split_on;                  
wire            ifu_iu_ibus_idle;                    
wire            ifu_iu_inst_bkpt_dbg_occur_vld;      
wire            ifu_iu_inst_bkpt_dbgexp_occur_vld;   
wire            ifu_iu_inst_buf_inst_dbg_disable;    
wire            ifu_iu_inst_buf_inst_vld;            
wire            inst_dbg_disable;                    
wire            int_enable_with_ee_ie;               
wire            int_ic_aft_sec_sel;                  
wire            intc_cpu_int_vld;                    
wire    [30:0]  iu_cp0_epc;                          
wire            iu_cp0_epc_update;                   
wire            iu_cp0_expt_vld;                     
wire            iu_cp0_int_vld;                      
wire            iu_cp0_lp_wk_int;                    
wire            iu_cp0_mtval_updt_vld;               
wire            iu_cp0_nmi_vld;                      
wire            iu_cp0_nt_int_pending_vld;           
wire            iu_had_adr_dbg_ack;                  
wire            iu_had_data_bkpt_occur_vld;          
wire            iu_had_dbg_disable_for_tee;          
wire            iu_had_dr_dbg_ack;                   
wire            iu_had_expt_vld;                     
wire            iu_had_fast_retire_acc_err_pc_update; 
wire    [30:0]  iu_had_fast_retire_acc_err_pc_val;   
wire            iu_had_inst_bkpt_occur_vld;          
wire            iu_had_int_ack;                      
wire            iu_had_retire_with_had_int;          
wire            iu_had_trace_occur_vld;              
wire            iu_had_xx_bkpt_inst;                 
wire            iu_had_xx_dbg_ack;                   
wire            iu_had_xx_mldst;                     
wire            iu_had_xx_retire;                    
wire            iu_had_xx_retire_normal;             
wire    [31:0]  iu_had_xx_retire_pc;                 
wire            iu_ifu_kill_inst;                    
wire            iu_ifu_spcu_int_en;                  
wire            iu_pad_inst_retire;                  
wire            iu_pad_inst_split;                   
wire    [31:0]  iu_pad_retire_pc;                    
wire            iu_sys_lp_wk_int;                    
wire            iu_yy_xx_dbgon;                      
wire    [9 :0]  iu_yy_xx_expt_vec;                   
wire            iu_yy_xx_flush;                      
wire            iu_yy_xx_int_hv;                     
wire    [7 :0]  iu_yy_xx_int_il;                     
wire            iu_yy_xx_int_pending_hv;             
wire    [9 :0]  iu_yy_xx_int_pending_id;             
wire    [7 :0]  iu_yy_xx_int_pending_il;             
wire    [1 :0]  iu_yy_xx_int_pending_priv;           
wire            iu_yy_xx_reg_rst_b;                  
wire            iu_yy_xx_retire;                     
wire            load_store_fast_retire;              
wire            lockup_retire_dbg_vld;               
wire            lockup_retire_mask;                  
wire            lockup_retire_nmi_vld;               
wire            lsu_iu_wb_acc_err;                   
wire            lsu_iu_wb_cmplt;                     
wire            nie_flush;                           
wire            nie_flush_chgflw;                    
wire            pad_yy_gate_clk_en_b;                
wire    [30:0]  pcgen_retire_updt_pc;                
wire    [30:0]  pcgen_xx_cur_pc;                     
wire            randclk_retire_mod_en_w2;            
wire            rbus_flush;                          
wire            rbus_retire_cmplt;                   
wire    [4 :0]  rbus_retire_expt_vec;                
wire            rbus_retire_expt_vld;                
wire            rbus_retire_flush;                   
wire            rbus_retire_split_inst;              
wire            rbus_wb_load;                        
wire            rbus_wb_store;                       
wire            retire_ack_bkpt;                     
wire            retire_ack_dr_set_req;               
wire            retire_ack_expt_vld;                 
wire            retire_ack_int_vld;                  
wire            retire_ack_jdbreq;                   
wire            retire_ack_mem_bkpt_fast_retire;     
wire            retire_ack_mem_bkpt_req;             
wire            retire_ack_mem_bkpt_vld;             
wire            retire_ack_mem_bkpt_vld_idle;        
wire            retire_ack_trace_fast_retire;        
wire            retire_ack_trace_req;                
wire            retire_ack_trace_vld;                
wire            retire_ack_trace_vld_idle;           
wire            retire_branch_dbg_idle;              
wire            retire_branch_stall;                 
wire            retire_dbg_disable;                  
wire            retire_dbg_disable_pre;              
wire            retire_dbg_expt;                     
wire            retire_dbg_mask;                     
wire    [30:0]  retire_epc_or_hadpc;                 
wire            retire_expt_int_vld;                 
wire            retire_expt_vld;                     
wire            retire_hs_acc_err;                   
wire            retire_hs_err_epc_sel;               
wire            retire_in_nmi;                       
wire            retire_inst_expt;                    
wire            retire_int;                          
wire            retire_int_mask_from_had;            
wire            retire_int_vld;                      
wire            retire_lockup_dbg_on;                
wire            retire_lockup_dbg_vld;               
wire            retire_lockup_expt_vld;              
wire            retire_lockup_inst_retire;           
wire            retire_lockup_nmi_vld;               
wire    [31:0]  retire_lockup_retire_pc;             
wire            retire_mad_ex_cancel;                
wire            retire_nmi_int_raw;                  
wire            retire_nmi_int_req;                  
wire            retire_nmi_int_vld;                  
wire            retire_pc_expt_vld;                  
wire            retire_pcgen_curpc_update;           
wire            retire_split_inst_no_dbg;            
wire            retire_split_inst_no_dbg_for_pad;    
wire            retire_split_inst_with_dbg_ack;      
wire            retire_vector_expt_int_hv;           
wire            retire_vector_expt_vld;              
wire            retire_wakeup_event_vld;             
wire            retire_wb_dbg_in_ack;                
wire            retire_wb_hs_err_epc_sel;            
wire            retire_wb_mem_bkpt_fast_retire;      
wire            retire_with_ack_had_int;             
wire            retire_with_ack_vic_int;             
wire            retire_xx_normal_retire;             
wire            sec_retire_flush;                    
wire            soft_reset_vld;                      
wire            special_retire_inst_wsc;             
wire            sysio_iu_nmi_int;                    
wire            sysio_iu_wk_event;                   
wire            wb_dbg_exp_after_retire;             
wire    [30:0]  wb_retire_fast_retire_load_pc;       
wire            wb_split_inst_clk_en;                
wire            wb_xx_acc_err_after_retire;          
wire            wb_xx_lsu_check_fail_after_retire;   


// for old csky wires
assign cp0_iu_ee = 1'b1;
assign cp0_iu_int_spcu_en = 1'b0;
//assign cp0_iu_intsp_we = 1'b0;

//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign dbg_clk_en = dbgreq_ack_aft_force || dbg_mode_on || dbgreq_ack_ff
                 || retire_int_vld
                 || retire_with_ack_int || retire_with_ack_dbg
                 || wb_split_inst_clk_en
                 || had_iu_mem_bkpt_req || had_iu_trace_req
                 || had_iu_trace_req_for_dbg_disable
                 || retire_wb_dbg_in_ack || had_iu_mem_bkpt_exp_req;
// &Instance("gated_clk_cell", "x_dbg_gated_clk"); @51
gated_clk_cell  x_dbg_gated_clk (
  .clk_in                   (forever_cpuclk          ),
  .clk_out                  (dbg_clk                 ),
  .external_en              (1'b0                    ),
  .global_en                (cp0_yy_clk_en           ),
  .local_en                 (dbg_clk_en              ),
  .module_en                (randclk_retire_mod_en_w2),
  .pad_yy_gate_clk_en_b     (pad_yy_gate_clk_en_b    )
);

// &Connect(.clk_in      (forever_cpuclk), @52
//          .external_en (1'b0), @53
//          .global_en   (cp0_yy_clk_en), @54
//          .module_en   (randclk_retire_mod_en_w2), @55
//          .local_en    (dbg_clk_en), @56
//          .clk_out     (dbg_clk)); @57
// &Instance("gated_clk_cell", "x_dbg_gated_clk"); @60
// &Connect(.clk_in      (forever_cpuclk), @61
//          .external_en (1'b0), @62
//          .global_en   (cp0_yy_clk_en), @63
//          .module_en   (randclk_retire_mod_en_w2), @64
//          .local_en    (dbg_clk_en), @65
//          .clk_out     (dbg_clk)); @66
// &Instance("gated_clk_cell", "x_dbg_gated_clk"); @69
// &Connect(.clk_in      (forever_cpuclk), @70
//          .external_en (1'b0), @71
//          .global_en   (cp0_yy_clk_en), @72
//          .module_en   (randclk_retire_mod_en_w2), @73
//          .local_en    (dbg_clk_en), @74
//          .clk_out     (dbg_clk)); @75
// &Force("nonport","dbg_clk_en"); @77
// &Force("input","randclk_retire_mod_en_w2"); @78


//==============================================================================
// Instruction retire and result write back
//==============================================================================
// &Force("output","iu_yy_xx_retire"); @87
assign iu_yy_xx_retire      = rbus_retire_cmplt;

//==============================================================================
// 1. Synchronous/asynchronous interrupt process
// 2. Exception Handle
//==============================================================================
// &Force("bus", "clic_cpu_int_id", 11, 0); @94
// &Force("nonport","iu_yy_xx_int_pending_hv"); @106
// &Force("nonport","iu_yy_xx_int_pending_id"); @107
// &Force("nonport","iu_yy_xx_int_pending_il"); @108
// &Force("nonport","iu_yy_xx_int_pending_priv"); @109
// &Force("nonport","iu_yy_xx_int_hv"); @110
// &Force("nonport","iu_yy_xx_int_il"); @111
//============================
// external interrput flop
//============================
assign cpu_ext_int = clint_cpu_me_int;


assign flop_cpuclk_en = cpu_nmi_int_f ^ sysio_iu_nmi_int
                     || cpu_wk_event_f1 ^ sysio_iu_wk_event
                     || cpu_wk_event_f2 ^ cpu_wk_event_f1
                     || retire_nmi_int_raw
                     || retire_nmi_int_vld;
// &Instance("gated_clk_cell", "x_flop_cpuclk"); @137
gated_clk_cell  x_flop_cpuclk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (flop_cpuclk         ),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (flop_cpuclk_en      ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in      (forever_cpuclk), @138
//          .external_en (1'b0), @139
//          .global_en   (1'b1), @140
//          .module_en   (1'b0), @141
//          .local_en    (flop_cpuclk_en), @142
//          .clk_out     (flop_cpuclk)); @143

always @ (posedge flop_cpuclk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    cpu_nmi_int_f   <= 1'b0;
    cpu_wk_event_f1 <= 1'b0;
    cpu_wk_event_f2 <= 1'b0;
  end
  else begin
    cpu_nmi_int_f  <= sysio_iu_nmi_int;
    cpu_wk_event_f1 <= sysio_iu_wk_event;
    cpu_wk_event_f2 <= cpu_wk_event_f1;
  end
end
assign retire_nmi_int_raw = !cpu_nmi_int_f && sysio_iu_nmi_int;
assign retire_wakeup_event_vld = !cpu_wk_event_f2 && cpu_wk_event_f1;

always @ (posedge flop_cpuclk or negedge cpurst_b)
begin
  if (!cpurst_b)
    retire_nmi_int_req_raw <= 1'b0;
  else if (retire_nmi_int_raw)
    retire_nmi_int_req_raw <= retire_nmi_int_raw;
  else if (retire_nmi_int_vld)
    retire_nmi_int_req_raw <= 1'b0;
  else
    retire_nmi_int_req_raw <= retire_nmi_int_req_raw;
end

assign retire_in_nmi = cp0_iu_in_nmi && !cp0_iu_inst_mret;
assign retire_nmi_int_req = retire_nmi_int_req_raw && !retire_in_nmi;
assign retire_nmi_int_vld = retire_int_vld && retire_nmi_int_req;
assign retire_lockup_nmi_vld = retire_nmi_int_req;
assign retire_lockup_inst_retire = iu_yy_xx_retire;
assign retire_lockup_dbg_on = dbg_mode_on;
assign retire_lockup_retire_pc[31:0] = {pcgen_xx_cur_pc[30:0],1'b0};

assign cpu_int_vld = (cp0_iu_vec_mode[1] ? clic_pending_int_need_ack : intc_cpu_int_vld && (int_enable_with_ee_ie))
                  || retire_nmi_int_req;
assign clic_pending_int_need_ack = clic_int_pending_vld && 
                                   (
                                   (int_enable_with_ee_ie && 
                                   (clic_cpu_int_il[7:0] > cp0_iu_il[7:0])));
assign clic_int_pending_vld      = |clic_cpu_int_il[7:0];
assign clint_lp_wk_int                = cpu_ext_int && cp0_iu_meie;
assign iu_cp0_nt_int_pending_vld      = cpu_ext_int;

assign iu_yy_xx_int_pending_priv[1:0] = clic_cpu_int_priv[1:0];
assign iu_yy_xx_int_pending_hv        = clic_cpu_int_hv;
assign iu_yy_xx_int_pending_il[7:0]   = clic_cpu_int_il[7:0];
assign iu_yy_xx_int_pending_id[9:0]   = clic_cpu_int_id[9:0];
assign iu_yy_xx_int_il[7:0]           = clic_cpu_int_il[7:0];
assign iu_yy_xx_int_hv                = clic_cpu_int_hv;
assign iu_cp0_lp_wk_int               = (cp0_iu_vec_mode[1] ? clic_lp_wk_int : clint_lp_wk_int)
                                      || retire_nmi_int_req
                                      || cp0_iu_wfe_en && retire_wakeup_event_vld;
assign iu_sys_lp_wk_int               = iu_cp0_lp_wk_int;
// &Force("output","iu_cp0_lp_wk_int"); @216
assign clic_lp_wk_int                 = clic_int_pending_vld && 
                                   ((clic_cpu_int_priv[1:0] > cp0_yy_priv_mode[1:0]) || 
                                   (clic_cpu_int_il[7:0] > cp0_iu_il[7:0]) ||
                                   cp0_iu_wfe_en);


assign int_enable_with_ee_ie = cp0_iu_mie_for_int;
assign intc_cpu_int_vld      = cpu_ext_int && cp0_iu_meie;
assign int_ic_aft_sec_sel = cp0_iu_ic;
assign cp0_iu_ic = 1'b0;
assign retire_int = (cpu_int_vld && !had_iu_int_vld
                  || had_iu_int_vld
                       && !decd_retire_cp0_inst
                    )
                && !retire_in_nmi
                && !special_retire_inst_wsc
                && !decd_retire_inst_mret
                && !had_iu_rte_pc_sel
                && !(ctrl_retire_ni_vld || wb_xx_acc_err_after_retire)
                && (  !int_ic_aft_sec_sel && !rbus_retire_split_inst 
                    || int_ic_aft_sec_sel);
//the auto vector is always set to 1
//assign int_vec[7:0]  = had_iu_int_vld ? 8'b00001101 : ~intc_cpu_vec_b[7:0];

//assign retire_srst_misalign_expt =  cp0_iu_ee
//                                 && rbus_retire_expt_vld
//                                 && (rbus_retire_expt_vec[4:1] == 4'b0000);
//assign retire_srst_misalign_expt = 1'b0;
assign retire_inst_expt     =  rbus_retire_expt_vld;

// &Instance("gated_clk_cell", "x_dp_gated_clk"); @269
// &Connect(.clk_in      (forever_cpuclk), @270
//          .external_en (1'b0), @271
//          .global_en   (cp0_yy_clk_en), @272
//          .module_en   (1'b0), @273
//          .local_en    (dp_clk_en), @274
//          .clk_out     (dp_cpuclk)); @275
// &Force("output","iu_had_dp_mbkpt_index"); @373
assign retire_dbg_expt = 1'b0;
//assign retire_dbg_inst_expt = 1'b0;
assign iu_ifu_kill_inst = 1'b0;

// &CombBeg; @392
always @( rbus_retire_expt_vec[4:0]
       or retire_dbg_expt
       or retire_int
       or retire_inst_expt
       or had_iu_int_vld
       or cp0_iu_vec_mode[1]
       or clic_cpu_int_id[9:0])
begin
  expt_vec[9:0]   = 10'b0;
  retire_ack_expt = 1'b0;
  retire_ack_int  = 1'b0;
  if(retire_dbg_expt)
  begin
    retire_ack_expt = 1'b1;
    expt_vec[9:0] = {7'b0,3'b11};
  end
  else if(retire_int)
  begin
    retire_ack_int  = 1'b1;
    expt_vec[9:0]   =  had_iu_int_vld ? {6'b0,4'b1101} : cp0_iu_vec_mode[1] ? clic_cpu_int_id[9:0] : {6'b0,4'b1011};
  end
  else if(retire_inst_expt)
  begin
    retire_ack_expt = 1'b1;
    expt_vec[9:0] = {5'b0,rbus_retire_expt_vec[4:0]};
  end
// &CombEnd; @411
end

// &Force("output","iu_yy_xx_hs_acc_err"); @416
assign retire_hs_acc_err = 1'b0;

//the expt valid need to be asserted when acc_err happen after retire
assign retire_ack_expt_vld = (retire_ack_expt && iu_yy_xx_retire)
                          || (wb_xx_acc_err_after_retire
                              && !retire_with_ack_int)
                          || wb_dbg_exp_after_retire && cp0_iu_ee;

assign retire_ack_int_vld  = retire_ack_int && iu_yy_xx_retire
                          || lockup_retire_nmi_vld;

assign retire_expt_vld = retire_ack_expt_vld && (!dbg_mode_on || soft_reset_vld)
                      && !dbgreq_ack_aft_force;

//when mem bkpt or trace req, the dbg ack may be not with retire, so the int
//when retire need to be masked
assign retire_int_mask_from_had = had_iu_mem_bkpt_mask || had_iu_trace_req;
assign retire_int_vld  = retire_ack_int_vld  && !dbg_mode_on && !dbgreq_ack_aft_force
                         && !retire_int_mask_from_had;

assign iu_yy_xx_expt_vec[9:0] = retire_hs_acc_err ? {5'b0,rbus_retire_expt_vec[4:0]}: expt_vec[9:0];

assign retire_expt_int_vld = retire_expt_vld || retire_int_vld;

//assign retire_split_inst   = rbus_retire_split_inst && !retire_expt_int_vld;

assign retire_split_inst_no_dbg = rbus_retire_split_inst
                                  && !(iu_yy_xx_retire && retire_int);

//the split inst to pad need to be 0 when dbg ack, so the retite signal is
//valid
assign retire_split_inst_no_dbg_for_pad = rbus_retire_split_inst
                                          && !(retire_ack_expt_vld || retire_ack_int_vld);
assign retire_split_inst_with_dbg_ack = retire_split_inst_no_dbg_for_pad && !dbgreq_ack_aft_force;

//the exception and interrupt valid signal for pc update:
//when entering into debug mode, these logic should see exception valid
//if the instruction gets exception itself when interruption, the pc should
//update as exception way
assign retire_pc_expt_vld = retire_inst_expt && !dbg_mode_on;
//assign retire_pc_int_vld  = (retire_ack_int && !retire_inst_expt) && !dbg_mode_on;

//rename for output
// &Force("output","iu_cp0_expt_vld"); @462
assign iu_cp0_expt_vld             = retire_expt_int_vld;
assign iu_cp0_mtval_updt_vld       = retire_expt_int_vld && !special_retire_inst_wsc && !retire_nmi_int_vld
                                    || retire_hs_acc_err
                                    ||(iu_yy_xx_retire && ifu_iu_inst_bkpt_dbg_occur_vld)
                                    || retire_ack_mem_bkpt_req 
                                    || retire_ack_mem_bkpt_fast_retire;
assign retire_wb_mem_bkpt_fast_retire = retire_ack_mem_bkpt_fast_retire;
// &Force("output","iu_cp0_ntint_vld"); @471

assign iu_cp0_int_vld              = retire_int_vld && !retire_nmi_int_req;
assign iu_cp0_nmi_vld              = retire_nmi_int_vld;
//assign iu_cp0_int_num[7:0]         = int_vec[7:0];
assign iu_ifu_spcu_int_en          = retire_int_vld && !had_iu_bkpt_trace_en
                                     && cp0_iu_int_spcu_en;

//assign retire_pcgen_expt_vld       = retire_pc_expt_vld || retire_pc_int_vld;
//assign retire_pcgen_int_vld        = retire_pc_int_vld;
assign retire_vector_expt_vld      = retire_expt_int_vld && !lockup_retire_mask;
assign retire_vector_expt_int_hv   = retire_ack_int & !retire_nmi_int_vld ?
                                     cp0_iu_vec_mode[1] && clic_cpu_int_hv
                                     : 1'b0;
assign retire_lockup_expt_vld      = retire_expt_vld && expt_vec[3:0] != 4'd11 && expt_vec[3:0] != 4'd3;
assign retire_lockup_dbg_vld       = had_iu_dr_set_req || had_iu_xx_jdbreq;
//assign cpu_intc_int_ack            = retire_int_vld && !had_iu_int_vld;
//assign cpu_intc_ack_vec[7:0]       = ~intc_cpu_vec_b[7:0];

//assign retire_special_ack_expt_vld = retire_ack_expt_vld;
//assign retire_special_clear_cnt_with_ack_dbg = retire_with_ack_dbg 
//                                            && (wb_xx_acc_err_after_retire || wb_dbg_exp_after_retire && cp0_iu_ee);

assign soft_reset_vld              = 1'b0;


//==========================================================
//the retire info with interrupt and dbg ack
//==========================================================
//when LOAD_FAST_RETIRE or BCTM is defined, the retire info 
//needs to be recorded
//when both LOAD_FAST_RETIRE and BCTM are not defined, the
//retire info is set to ZERO
always @(posedge dbg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    retire_with_ack_int <= 1'b0;
  else if(retire_int_vld)
    retire_with_ack_int <= 1'b1;
  else if(iu_yy_xx_retire)
    retire_with_ack_int <= 1'b0;
end

always @(posedge dbg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    retire_with_ack_dbg <= 1'b0;
  else if(dbgreq_ack_aft_force)
    retire_with_ack_dbg <= 1'b1;
  else if(iu_yy_xx_retire)
    retire_with_ack_dbg <= 1'b0;
end

assign retire_with_ack_vic_int = retire_with_ack_int && !had_iu_rte_pc_sel;
assign retire_with_ack_had_int = retire_with_ack_int && had_iu_rte_pc_sel;


//the retire info to BCTM, according to which BCTM decide whether update EPC
//or HAD PC
assign bctm_retire_epc_updt_vld = 1'b0;
assign bctm_retire_had_pc_updt_vld = 1'b0;


//==========================================================
//the EPC updata to CP0
//==========================================================
//the update pc from pcgen is the value been updated into
//current pc, that is, for instruction with exception, it
//is current pc, for interrupt, it is next pc

//when fast acc_err happens, but the ldst which has been fast retired
//get into an interrupt, the expt_vld signal should not be asserted,
//the one thing need to do is updating the right PC into epc, so when
//exit from interrupt, the ldst inst can be fetch and excute again
assign fast_retire_acc_err_epc[30:0] = wb_retire_fast_retire_load_pc[30:0];
assign retire_hs_err_epc_sel         = retire_hs_acc_err && !retire_with_ack_int;
assign retire_wb_hs_err_epc_sel      = retire_hs_err_epc_sel;
assign retire_epc_or_hadpc[30:0] = (wb_xx_acc_err_after_retire 
                                     && !retire_hs_acc_err
                                   || retire_hs_err_epc_sel)
                                      ? fast_retire_acc_err_epc[30:0]
                                      : pcgen_retire_updt_pc[30:0];

assign iu_cp0_epc[30:0] = retire_epc_or_hadpc[30:0];
//when hw stacking, epc does not need to be updt
assign epc_update_after_retire = wb_xx_acc_err_after_retire && retire_with_ack_vic_int
                              || bctm_retire_epc_updt_vld;
assign iu_cp0_epc_update = epc_update_after_retire
                        && !hs_split_iu_hs_retire_mask;
//assign iu_cp0_cur_epc_update = 1'b0;


//when hw stacking, acc err aft retire will not updt curpc in pcgen
assign retire_pcgen_curpc_update = (epc_update_after_retire
                                      || hadpc_update_after_retire)
                                && hs_split_iu_hs_retire_mask && !retire_hs_acc_err;
//==============================================================================
// IU/HAD Interface
//==============================================================================
//when CSKY_TEE, rte and wsc cannot ack dr and trace dbg req
assign inst_dbg_disable    = 1'b0;

assign retire_ack_jdbreq  = had_iu_xx_jdbreq
                          && !hs_split_iu_hs_switch_se
                          && !inst_dbg_disable
                          && !retire_dbg_disable;

//when addsp or subsp in split, and it is not the last beat of split, cpu
//cannot ack dbg
assign retire_dbg_mask = ifu_iu_ex_sp_oper && ifu_iu_ex_split_on;
assign retire_ack_dr_set_req   = iu_yy_xx_retire && had_iu_dr_set_req
                                 && !retire_dbg_mask
                                 && !inst_dbg_disable
                                 && !had_iu_rte_pc_sel
                                 && !retire_dbg_disable;

assign retire_ack_bkpt    =  iu_yy_xx_retire && rbus_retire_expt_vld
                          && (rbus_retire_expt_vec[4:0] == 5'b00011)
                          && (had_iu_xx_fdb || had_core_dbg_mode_req
                          ||  ifu_iu_inst_bkpt_dbg_occur_vld)
                          && !dbg_mode_on
                          && !inst_dbg_disable
                          && !had_iu_rte_pc_sel
                          && !retire_dbg_disable
                          && !(ifu_iu_inst_bkpt_dbgexp_occur_vld
                          &&  !ifu_iu_inst_bkpt_dbg_occur_vld);

//the mem bkpt and trace dbg req ack_vld is asserted when fast retired ldst
//complete without exception
assign retire_ack_mem_bkpt_req         = retire_ack_mem_bkpt_vld_idle 
                                         && had_iu_mem_bkpt_req
                                         && !inst_dbg_disable
                                         && !had_iu_rte_pc_sel
                                         && !retire_dbg_disable;
assign retire_ack_mem_bkpt_fast_retire = retire_ack_mem_bkpt_vld
                                     && !had_iu_mbkpt_fsm_index_mbee;

assign retire_ack_trace_req            = retire_ack_trace_vld_idle    
                                         && had_iu_trace_req
                                         && !inst_dbg_disable
                                         && !had_iu_rte_pc_sel
                                         && !retire_dbg_disable;
assign retire_ack_trace_fast_retire    = retire_ack_trace_vld; 

assign dbgreq_ack = retire_ack_jdbreq     || retire_ack_bkpt
                 || retire_ack_dr_set_req || retire_ack_mem_bkpt_req
                 || retire_ack_trace_req
                 || retire_ack_mem_bkpt_fast_retire
                 || retire_ack_trace_fast_retire;

assign dbgreq_ack_aft_force = dbgreq_ack || had_iu_force_dbg_en || lockup_retire_dbg_vld;


always @(posedge dbg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    dbgreq_ack_ff <= 1'b0;
  else
    dbgreq_ack_ff <= dbgreq_ack_aft_force;
end

assign iu_had_xx_dbg_ack = dbgreq_ack_ff;

always @(posedge dbg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    dbg_mode_on <= 1'b0;
  else if(had_yy_xx_exit_dbg || !iu_yy_xx_reg_rst_b)
    dbg_mode_on <= 1'b0;
  else if(dbgreq_ack_aft_force)
    dbg_mode_on <= 1'b1;
  else
    dbg_mode_on <= dbg_mode_on;
end

// &Force("output","iu_yy_xx_dbgon"); @733
assign iu_yy_xx_dbgon            = dbg_mode_on;

assign iu_had_xx_retire          = iu_yy_xx_retire;

assign iu_had_xx_retire_pc[31:0] = {pcgen_xx_cur_pc[30:0],1'b0};

assign iu_had_xx_mldst           = retire_split_inst_no_dbg;

assign iu_had_xx_retire_normal   = !rbus_retire_expt_vld;

//assign iu_had_chg_flw_inst       = rbus_retire_chg_flw_inst;


//had int ack when DCC
assign iu_had_int_ack = retire_int_vld && had_iu_int_vld; 
assign iu_had_retire_with_had_int = retire_with_ack_had_int;

//dbg ack to HAD, to updt dbg info
assign iu_had_dbg_disable_for_tee = cp0_iu_dbg_disable_for_tee;
//for adr
assign iu_had_adr_dbg_ack = retire_ack_jdbreq;
//for dr
assign iu_had_dr_dbg_ack  = retire_ack_dr_set_req;
//for HW bkpt
assign iu_had_inst_bkpt_occur_vld = retire_ack_bkpt
                                 && ifu_iu_inst_bkpt_dbg_occur_vld;
assign iu_had_data_bkpt_occur_vld = retire_ack_mem_bkpt_req
                                 || retire_ack_mem_bkpt_fast_retire;
//for SW bkpt
assign iu_had_xx_bkpt_inst       = retire_ack_bkpt
                               && !ifu_iu_inst_bkpt_dbg_occur_vld
                               && !had_core_dbg_mode_req;
//for trace
assign iu_had_trace_occur_vld     = retire_ack_trace_req
                                 || retire_ack_trace_fast_retire;

////for inst bkpt counter dec
//assign iu_had_inst_bkpta_hit      = ifu_iu_inst_bkpta_hit; 
//assign iu_had_inst_bkptb_hit      = ifu_iu_inst_bkptb_hit;

//when expt, the counter of mem bkpt will be reset to zero
assign iu_had_expt_vld            = retire_expt_int_vld;

////the trace coutner need to be dec when expt during split when fast retire
//assign iu_had_expt_during_split   = wb_xx_acc_err_after_retire
//                                    && !retire_with_ack_int
//                                    && wb_split_inst;

assign wb_split_inst_clk_en = wb_split_inst ^ retire_split_inst_no_dbg;
always @(posedge dbg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    wb_split_inst <= 1'b0;
  else if(iu_yy_xx_retire)
    wb_split_inst <= retire_split_inst_no_dbg;
end


//when the fast retired ldst get into debug mode, and than the 
//acc_err come from dbus after cpu is in debug mode, the PC 
//in HAD is not corrcet and need to be updated with the PC of
//fast retired ldst
assign hadpc_update_after_retire = wb_xx_acc_err_after_retire
                                     && (retire_with_ack_dbg
                                      || retire_with_ack_had_int)
                                || bctm_retire_had_pc_updt_vld;
assign iu_had_fast_retire_acc_err_pc_update = hadpc_update_after_retire
                                           && !retire_hs_acc_err;
assign iu_had_fast_retire_acc_err_pc_val[30:0] = retire_epc_or_hadpc[30:0];


//======================================
//  the mem bkpt and trace ack signal
//======================================
//the fast retire ld st will not ack dbg req before complete
assign load_store_fast_retire = rbus_wb_load || rbus_wb_store;

//the mem bkpt ack SM
parameter BKPT_IDLE = 1'b0;
parameter BKPT_ACK  = 1'b1;

always @(posedge dbg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bkpt_cur_state <= BKPT_IDLE;
  else
    bkpt_cur_state <= bkpt_next_state;
end

assign bkpt_fsm_trigger = (had_iu_mem_bkpt_req
                        || had_iu_mem_bkpt_exp_req)
                        && load_store_fast_retire
                        && !ex_inst_dbg_disable && !had_iu_rte_pc_sel;

// &CombBeg; @863
always @( bkpt_cur_state
       or bkpt_fsm_trigger
       or lsu_iu_wb_cmplt)
begin
  case(bkpt_cur_state)
  BKPT_IDLE : if(bkpt_fsm_trigger)
                bkpt_next_state = BKPT_ACK;
              else
                bkpt_next_state = BKPT_IDLE;
  BKPT_ACK  : if(lsu_iu_wb_cmplt)
                bkpt_next_state = BKPT_IDLE;
              else
                bkpt_next_state = BKPT_ACK;
  default   :   bkpt_next_state = BKPT_IDLE;
  endcase
// &CombEnd; @875
end


assign retire_ack_mem_bkpt_vld_idle = (bkpt_cur_state == BKPT_IDLE)
                                      && !load_store_fast_retire;
assign retire_ack_mem_bkpt_vld = (bkpt_cur_state == BKPT_ACK)
                                 && lsu_iu_wb_cmplt
                                 && !lsu_iu_wb_acc_err;
assign wb_dbg_exp_after_retire = (bkpt_cur_state == BKPT_ACK) 
                                 && lsu_iu_wb_cmplt
                                 && !lsu_iu_wb_acc_err
                                 && had_iu_mbkpt_fsm_index_mbee;

//the trace ack SM
parameter TRACE_IDLE = 1'b0;
parameter TRACE_ACK  = 1'b1;

always @(posedge dbg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    trace_cur_state <= TRACE_IDLE;
  else
    trace_cur_state <= trace_next_state;
end

// &CombBeg; @911
always @( trace_cur_state
       or ex_inst_dbg_disable
       or load_store_fast_retire
       or had_iu_rte_pc_sel
       or had_iu_trace_req
       or lsu_iu_wb_cmplt)
begin
  case(trace_cur_state)
  TRACE_IDLE : if(had_iu_trace_req && load_store_fast_retire
                  && !ex_inst_dbg_disable && !had_iu_rte_pc_sel)
                trace_next_state = TRACE_ACK;
              else
                trace_next_state = TRACE_IDLE;
  TRACE_ACK  : if(lsu_iu_wb_cmplt)
                trace_next_state = TRACE_IDLE;
              else
                trace_next_state = TRACE_ACK;
  default    :  trace_next_state = TRACE_IDLE;
  endcase
// &CombEnd; @924
end

assign retire_ack_trace_vld_idle = (trace_cur_state == TRACE_IDLE)
                                   && !load_store_fast_retire;
assign retire_ack_trace_vld = (trace_cur_state == TRACE_ACK)
                              && lsu_iu_wb_cmplt
                              && !lsu_iu_wb_acc_err;

//when dbg in ack, the internal stall in EX need to be asserted
// &Force("output","retire_wb_dbg_in_ack"); @933
assign retire_wb_dbg_in_ack = (bkpt_cur_state  == BKPT_ACK)
                           || (trace_cur_state == TRACE_ACK);


//==============================================================================
//                Branch Debug Disable Handle Logic
//==============================================================================
parameter BR_DBG_IDLE = 2'b00;
parameter BR_DBG_ACK  = 2'b10;

always @(posedge dbg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    br_cur_state[1:0] <= BR_DBG_IDLE;
  else
    br_cur_state[1:0] <= br_next_state[1:0];
end

// &CombBeg; @960
always @( ctrl_branch_ex_sel
       or br_cur_state
       or ifu_iu_ibus_idle
       or had_iu_trace_req_for_dbg_disable
       or ifu_iu_inst_buf_inst_vld)
begin
  case(br_cur_state)
  BR_DBG_IDLE : if(ctrl_branch_ex_sel && ifu_iu_ibus_idle && had_iu_trace_req_for_dbg_disable)
                  br_next_state = BR_DBG_ACK;
                else
                  br_next_state = BR_DBG_IDLE;
  BR_DBG_ACK  : if(ifu_iu_inst_buf_inst_vld)
                  br_next_state = BR_DBG_IDLE;
                else
                  br_next_state = BR_DBG_ACK;
  default     :   br_next_state = BR_DBG_IDLE;
  endcase
// &CombEnd; @972
end

assign retire_branch_stall = (br_cur_state == BR_DBG_IDLE)
                                && had_iu_trace_req_for_dbg_disable
                          || (br_cur_state == BR_DBG_ACK)
                                && !ifu_iu_inst_buf_inst_vld;

assign retire_branch_dbg_idle = (br_cur_state == BR_DBG_IDLE);

//for peak power, when dbg disable, no peak power mask
//assign iu_ifu_not_wait_for_dbg_disable = retire_branch_dbg_idle;

assign retire_dbg_disable = retire_dbg_disable_pre || cp0_iu_dbg_disable_for_tee;

assign retire_dbg_disable_pre = retire_branch_dbg_idle
                                  ? ex_inst_dbg_disable
                                  : ifu_iu_inst_buf_inst_dbg_disable;

assign ex_inst_dbg_disable = ifu_iu_ex_inst_dbg_disable || cp0_iu_dbg_disable_for_tee;


//normal retire without exception, used for increase pc update
//the interrupt should update increase pc. so set when
//1.normal instruction retire without exception
//2.normal instruction retire with interruption
//3.last split instruction retire with interruption
assign retire_xx_normal_retire = iu_yy_xx_retire
                                    && !rbus_retire_split_inst
                                    && !(retire_pc_expt_vld && !special_retire_inst_wsc);


//==============================================================================
// Flush
//==============================================================================
assign sec_retire_flush = 1'b0;

assign rbus_flush      = iu_yy_xx_retire && rbus_retire_flush;

assign nie_flush = 1'b0;
assign nie_flush_chgflw = 1'b0;
assign retire_mad_ex_cancel = dbgreq_ack_aft_force;
assign iu_yy_xx_flush  = rbus_flush
                         || iu_cp0_expt_vld
                         || dbgreq_ack_aft_force
                         || wb_xx_lsu_check_fail_after_retire
                         || retire_hs_acc_err
                         || sec_retire_flush
                         || nie_flush;


//==============================================================================
// Retire corresponding signals for gate-level simulation
//==============================================================================
assign iu_pad_inst_retire     = iu_yy_xx_retire && !retire_split_inst_with_dbg_ack;

assign iu_pad_inst_split      = retire_split_inst_with_dbg_ack;

assign iu_pad_retire_pc[31:0] = {pcgen_xx_cur_pc[30:0],1'b0};

// &Force("bus", "cp0_iu_vec_mode", 1, 0); @1061
// &ModuleEnd; @1062
endmodule


