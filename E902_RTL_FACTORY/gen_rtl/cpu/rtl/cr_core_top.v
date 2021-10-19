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
module cr_core_top(
  biu_pad_haddr,
  biu_pad_hburst,
  biu_pad_hprot,
  biu_pad_hsize,
  biu_pad_htrans,
  biu_pad_hwdata,
  biu_pad_hwrite,
  bmu_tcipif_dbus_acc_deny,
  bmu_tcipif_dbus_addr,
  bmu_tcipif_dbus_chk_fail,
  bmu_tcipif_dbus_req,
  bmu_tcipif_dbus_size,
  bmu_tcipif_dbus_supv_mode,
  bmu_tcipif_dbus_wdata,
  bmu_tcipif_dbus_write,
  bmu_tcipif_ibus_acc_deny,
  bmu_tcipif_ibus_addr,
  bmu_tcipif_ibus_req,
  bmu_tcipif_ibus_write,
  clic_cpu_int_hv,
  clic_cpu_int_id,
  clic_cpu_int_il,
  clic_cpu_int_priv,
  clint_cpu_me_int,
  clk_en,
  cp0_had_cpuid_idx0,
  cp0_had_int_exit,
  cp0_had_lpmd_b,
  cp0_had_mcause_data,
  cp0_pad_mcause,
  cp0_pad_mintstatus,
  cp0_pad_mstatus,
  cp0_yy_be_v2,
  cp0_yy_priv_mode,
  cpu_clic_curid,
  cpu_clic_int_exit,
  cpu_pad_dfs_ack,
  cpu_pad_lockup,
  cpu_pad_soft_rst,
  cpurst_b,
  forever_cpuclk,
  had_core_dbg_mode_req,
  had_core_exit_dbg,
  had_idu_wbbr_data,
  had_idu_wbbr_vld,
  had_ifu_inst_bkpt_dbq_req,
  had_ifu_inst_bkpt_dbqexp_req,
  had_ifu_ir,
  had_ifu_ir_vld,
  had_iu_bkpt_trace_en,
  had_iu_dr_set_req,
  had_iu_force_dbg_en,
  had_iu_int_vld,
  had_iu_mbkpt_fsm_index_mbee,
  had_iu_mem_bkpt_exp_req,
  had_iu_mem_bkpt_mask,
  had_iu_mem_bkpt_req,
  had_iu_pc,
  had_iu_rte_pc_sel,
  had_iu_trace_req,
  had_iu_trace_req_for_dbg_disable,
  had_iu_xx_fdb,
  had_iu_xx_jdbreq,
  had_yy_xx_dbg,
  had_yy_xx_dp_index_mbee,
  iahbl_pad_haddr,
  iahbl_pad_hburst,
  iahbl_pad_hprot,
  iahbl_pad_hsize,
  iahbl_pad_htrans,
  iahbl_pad_hwdata,
  iahbl_pad_hwrite,
  ifu_had_chg_flw_inst,
  ifu_had_fetch_expt_vld,
  ifu_had_inst_dbg_disable,
  ifu_had_match_pc,
  ifu_had_split_first,
  iu_had_adr_dbg_ack,
  iu_had_chgflw_dst_pc,
  iu_had_chgflw_vld,
  iu_had_data_bkpt_occur_vld,
  iu_had_dbg_disable_for_tee,
  iu_had_dr_dbg_ack,
  iu_had_expt_vld,
  iu_had_fast_retire_acc_err_pc_update,
  iu_had_fast_retire_acc_err_pc_val,
  iu_had_flush,
  iu_had_inst_bkpt_occur_vld,
  iu_had_int_ack,
  iu_had_retire_with_had_int,
  iu_had_trace_occur_vld,
  iu_had_xx_bkpt_inst,
  iu_had_xx_data,
  iu_had_xx_data_vld,
  iu_had_xx_dbg_ack,
  iu_had_xx_mldst,
  iu_had_xx_retire,
  iu_had_xx_retire_normal,
  iu_had_xx_retire_pc,
  iu_pad_gpr_data,
  iu_pad_gpr_index,
  iu_pad_gpr_we,
  iu_pad_inst_retire,
  iu_pad_inst_split,
  iu_pad_retire_pc,
  iu_yy_xx_dbgon,
  lsu_had_addr,
  lsu_had_addr_vld,
  lsu_had_ex_cmplt,
  lsu_had_st,
  pad_biu_hrdata,
  pad_biu_hready,
  pad_biu_hresp,
  pad_bmu_iahbl_base,
  pad_bmu_iahbl_mask,
  pad_cpu_dfs_req,
  pad_cpu_ext_int_b,
  pad_cpu_nmi,
  pad_cpu_rst_addr,
  pad_cpu_sys_cnt,
  pad_cpu_wakeup_event,
  pad_iahbl_hrdata,
  pad_iahbl_hready,
  pad_iahbl_hresp,
  pad_sysio_dbgrq_b,
  pad_yy_gate_clk_en_b,
  pwrm_cpu_bus_peak_power_limit_en,
  sysio_clint_me_int,
  sysio_clint_mtime,
  sysio_had_sdb_req_b,
  sysio_pad_lpmd_b,
  tcip_cp0_clic_base,
  tcipif_bmu_dbus_acc_err,
  tcipif_bmu_dbus_data,
  tcipif_bmu_dbus_data_vld,
  tcipif_bmu_dbus_grnt,
  tcipif_bmu_dbus_trans_cmplt,
  tcipif_bmu_ibus_acc_err,
  tcipif_bmu_ibus_data,
  tcipif_bmu_ibus_data_vld,
  tcipif_bmu_ibus_grnt,
  tcipif_bmu_ibus_trans_cmplt
);

// &Ports; @26
input           clic_cpu_int_hv;                     
input   [11:0]  clic_cpu_int_id;                     
input   [7 :0]  clic_cpu_int_il;                     
input   [1 :0]  clic_cpu_int_priv;                   
input           clint_cpu_me_int;                    
input           clk_en;                              
input           cpurst_b;                            
input           forever_cpuclk;                      
input           had_core_dbg_mode_req;               
input           had_core_exit_dbg;                   
input   [31:0]  had_idu_wbbr_data;                   
input           had_idu_wbbr_vld;                    
input           had_ifu_inst_bkpt_dbq_req;           
input           had_ifu_inst_bkpt_dbqexp_req;        
input   [31:0]  had_ifu_ir;                          
input           had_ifu_ir_vld;                      
input           had_iu_bkpt_trace_en;                
input           had_iu_dr_set_req;                   
input           had_iu_force_dbg_en;                 
input           had_iu_int_vld;                      
input           had_iu_mbkpt_fsm_index_mbee;         
input           had_iu_mem_bkpt_exp_req;             
input           had_iu_mem_bkpt_mask;                
input           had_iu_mem_bkpt_req;                 
input   [30:0]  had_iu_pc;                           
input           had_iu_rte_pc_sel;                   
input           had_iu_trace_req;                    
input           had_iu_trace_req_for_dbg_disable;    
input           had_iu_xx_fdb;                       
input           had_iu_xx_jdbreq;                    
input           had_yy_xx_dbg;                       
input           had_yy_xx_dp_index_mbee;             
input   [31:0]  pad_biu_hrdata;                      
input           pad_biu_hready;                      
input           pad_biu_hresp;                       
input   [11:0]  pad_bmu_iahbl_base;                  
input   [11:0]  pad_bmu_iahbl_mask;                  
input           pad_cpu_dfs_req;                     
input           pad_cpu_ext_int_b;                   
input           pad_cpu_nmi;                         
input   [31:0]  pad_cpu_rst_addr;                    
input   [63:0]  pad_cpu_sys_cnt;                     
input           pad_cpu_wakeup_event;                
input   [31:0]  pad_iahbl_hrdata;                    
input           pad_iahbl_hready;                    
input           pad_iahbl_hresp;                     
input           pad_sysio_dbgrq_b;                   
input           pad_yy_gate_clk_en_b;                
input           pwrm_cpu_bus_peak_power_limit_en;    
input   [31:0]  tcip_cp0_clic_base;                  
input           tcipif_bmu_dbus_acc_err;             
input   [31:0]  tcipif_bmu_dbus_data;                
input           tcipif_bmu_dbus_data_vld;            
input           tcipif_bmu_dbus_grnt;                
input           tcipif_bmu_dbus_trans_cmplt;         
input           tcipif_bmu_ibus_acc_err;             
input   [31:0]  tcipif_bmu_ibus_data;                
input           tcipif_bmu_ibus_data_vld;            
input           tcipif_bmu_ibus_grnt;                
input           tcipif_bmu_ibus_trans_cmplt;         
output  [31:0]  biu_pad_haddr;                       
output  [2 :0]  biu_pad_hburst;                      
output  [3 :0]  biu_pad_hprot;                       
output  [2 :0]  biu_pad_hsize;                       
output  [1 :0]  biu_pad_htrans;                      
output  [31:0]  biu_pad_hwdata;                      
output          biu_pad_hwrite;                      
output          bmu_tcipif_dbus_acc_deny;            
output  [31:0]  bmu_tcipif_dbus_addr;                
output          bmu_tcipif_dbus_chk_fail;            
output          bmu_tcipif_dbus_req;                 
output  [1 :0]  bmu_tcipif_dbus_size;                
output          bmu_tcipif_dbus_supv_mode;           
output  [31:0]  bmu_tcipif_dbus_wdata;               
output          bmu_tcipif_dbus_write;               
output          bmu_tcipif_ibus_acc_deny;            
output  [31:0]  bmu_tcipif_ibus_addr;                
output          bmu_tcipif_ibus_req;                 
output          bmu_tcipif_ibus_write;               
output  [31:0]  cp0_had_cpuid_idx0;                  
output          cp0_had_int_exit;                    
output  [1 :0]  cp0_had_lpmd_b;                      
output  [31:0]  cp0_had_mcause_data;                 
output  [31:0]  cp0_pad_mcause;                      
output  [31:0]  cp0_pad_mintstatus;                  
output  [31:0]  cp0_pad_mstatus;                     
output          cp0_yy_be_v2;                        
output  [1 :0]  cp0_yy_priv_mode;                    
output  [11:0]  cpu_clic_curid;                      
output          cpu_clic_int_exit;                   
output          cpu_pad_dfs_ack;                     
output          cpu_pad_lockup;                      
output  [1 :0]  cpu_pad_soft_rst;                    
output  [31:0]  iahbl_pad_haddr;                     
output  [2 :0]  iahbl_pad_hburst;                    
output  [3 :0]  iahbl_pad_hprot;                     
output  [2 :0]  iahbl_pad_hsize;                     
output  [1 :0]  iahbl_pad_htrans;                    
output  [31:0]  iahbl_pad_hwdata;                    
output          iahbl_pad_hwrite;                    
output          ifu_had_chg_flw_inst;                
output          ifu_had_fetch_expt_vld;              
output          ifu_had_inst_dbg_disable;            
output  [31:0]  ifu_had_match_pc;                    
output          ifu_had_split_first;                 
output          iu_had_adr_dbg_ack;                  
output  [31:0]  iu_had_chgflw_dst_pc;                
output          iu_had_chgflw_vld;                   
output          iu_had_data_bkpt_occur_vld;          
output          iu_had_dbg_disable_for_tee;          
output          iu_had_dr_dbg_ack;                   
output          iu_had_expt_vld;                     
output          iu_had_fast_retire_acc_err_pc_update; 
output  [30:0]  iu_had_fast_retire_acc_err_pc_val;   
output          iu_had_flush;                        
output          iu_had_inst_bkpt_occur_vld;          
output          iu_had_int_ack;                      
output          iu_had_retire_with_had_int;          
output          iu_had_trace_occur_vld;              
output          iu_had_xx_bkpt_inst;                 
output  [31:0]  iu_had_xx_data;                      
output          iu_had_xx_data_vld;                  
output          iu_had_xx_dbg_ack;                   
output          iu_had_xx_mldst;                     
output          iu_had_xx_retire;                    
output          iu_had_xx_retire_normal;             
output  [31:0]  iu_had_xx_retire_pc;                 
output  [31:0]  iu_pad_gpr_data;                     
output  [4 :0]  iu_pad_gpr_index;                    
output          iu_pad_gpr_we;                       
output          iu_pad_inst_retire;                  
output          iu_pad_inst_split;                   
output  [31:0]  iu_pad_retire_pc;                    
output          iu_yy_xx_dbgon;                      
output  [31:0]  lsu_had_addr;                        
output          lsu_had_addr_vld;                    
output          lsu_had_ex_cmplt;                    
output          lsu_had_st;                          
output          sysio_clint_me_int;                  
output  [63:0]  sysio_clint_mtime;                   
output          sysio_had_sdb_req_b;                 
output  [1 :0]  sysio_pad_lpmd_b;                    

// &Regs; @27
reg             pad_cpu_halt_ff1;                    
reg             pad_cpu_halt_ff2;                    

// &Wires; @28
wire            biu_bmu_dbus_acc_err;                
wire    [31:0]  biu_bmu_dbus_data;                   
wire            biu_bmu_dbus_data_vld;               
wire            biu_bmu_dbus_grnt;                   
wire            biu_bmu_dbus_trans_cmplt;            
wire            biu_bmu_ibus_acc_err;                
wire    [31:0]  biu_bmu_ibus_data;                   
wire            biu_bmu_ibus_data_vld;               
wire            biu_bmu_ibus_grnt;                   
wire            biu_bmu_ibus_trans_cmplt;            
wire    [31:0]  biu_pad_haddr;                       
wire    [2 :0]  biu_pad_hburst;                      
wire    [3 :0]  biu_pad_hprot;                       
wire    [2 :0]  biu_pad_hsize;                       
wire    [1 :0]  biu_pad_htrans;                      
wire    [31:0]  biu_pad_hwdata;                      
wire            biu_pad_hwrite;                      
wire            bmu_biu_dbus_acc_deny;               
wire    [31:0]  bmu_biu_dbus_addr;                   
wire            bmu_biu_dbus_chk_fail;               
wire    [3 :0]  bmu_biu_dbus_prot;                   
wire            bmu_biu_dbus_req;                    
wire            bmu_biu_dbus_req_without_cmplt;      
wire    [1 :0]  bmu_biu_dbus_size;                   
wire    [31:0]  bmu_biu_dbus_wdata;                  
wire            bmu_biu_dbus_write;                  
wire            bmu_biu_ibus_acc_deny;               
wire    [31:0]  bmu_biu_ibus_addr;                   
wire            bmu_biu_ibus_hit;                    
wire    [3 :0]  bmu_biu_ibus_prot;                   
wire            bmu_biu_ibus_req;                    
wire            bmu_biu_ibus_req_no_hit;             
wire    [1 :0]  bmu_biu_ibus_size;                   
wire            bmu_biu_ibus_vec_redirect;           
wire            bmu_iahbl_dbus_acc_deny;             
wire    [31:0]  bmu_iahbl_dbus_addr;                 
wire            bmu_iahbl_dbus_chk_fail;             
wire    [3 :0]  bmu_iahbl_dbus_prot;                 
wire            bmu_iahbl_dbus_req;                  
wire            bmu_iahbl_dbus_req_without_cmplt;    
wire    [1 :0]  bmu_iahbl_dbus_size;                 
wire    [31:0]  bmu_iahbl_dbus_wdata;                
wire            bmu_iahbl_dbus_write;                
wire            bmu_iahbl_ibus_acc_deny;             
wire    [31:0]  bmu_iahbl_ibus_addr;                 
wire            bmu_iahbl_ibus_hit;                  
wire    [3 :0]  bmu_iahbl_ibus_prot;                 
wire            bmu_iahbl_ibus_req;                  
wire            bmu_iahbl_ibus_req_no_hit;           
wire    [1 :0]  bmu_iahbl_ibus_size;                 
wire            bmu_iahbl_ibus_vec_redirect;         
wire            bmu_lsu_acc_err;                     
wire            bmu_lsu_bstack_chk_fail;             
wire    [31:0]  bmu_lsu_data;                        
wire            bmu_lsu_data_vld;                    
wire            bmu_lsu_grnt;                        
wire            bmu_lsu_trans_cmplt;                 
wire            bmu_tcipif_dbus_acc_deny;            
wire    [31:0]  bmu_tcipif_dbus_addr;                
wire            bmu_tcipif_dbus_chk_fail;            
wire            bmu_tcipif_dbus_req;                 
wire    [1 :0]  bmu_tcipif_dbus_size;                
wire            bmu_tcipif_dbus_supv_mode;           
wire    [31:0]  bmu_tcipif_dbus_wdata;               
wire            bmu_tcipif_dbus_write;               
wire            bmu_tcipif_ibus_acc_deny;            
wire    [31:0]  bmu_tcipif_ibus_addr;                
wire            bmu_tcipif_ibus_req;                 
wire            bmu_tcipif_ibus_write;               
wire            bmu_xx_ibus_acc_err;                 
wire    [31:0]  bmu_xx_ibus_data;                    
wire            bmu_xx_ibus_data_vld;                
wire            bmu_xx_ibus_grnt;                    
wire            bmu_xx_ibus_trans_cmplt;             
wire            cache_cp0_lpmd_ack;                  
wire            cache_cp0_srst_ack;                  
wire            cache_iu_lockup_ack;                 
wire            clic_cpu_int_hv;                     
wire    [11:0]  clic_cpu_int_id;                     
wire    [7 :0]  clic_cpu_int_il;                     
wire    [1 :0]  clic_cpu_int_priv;                   
wire            clint_cpu_me_int;                    
wire            clk_en;                              
wire            cp0_cache_lpmd_req;                  
wire            cp0_cache_srst_req;                  
wire    [31:0]  cp0_had_cpuid_idx0;                  
wire            cp0_had_int_exit;                    
wire    [1 :0]  cp0_had_lpmd_b;                      
wire    [31:0]  cp0_had_mcause_data;                 
wire    [31:0]  cp0_pad_mcause;                      
wire    [31:0]  cp0_pad_mintstatus;                  
wire    [31:0]  cp0_pad_mstatus;                     
wire    [11:0]  cp0_pmp_csr_sel;                     
wire            cp0_pmp_csr_wen;                     
wire    [1 :0]  cp0_pmp_mstatus_mpp;                 
wire            cp0_pmp_mstatus_mprv;                
wire    [31:0]  cp0_pmp_updt_data;                   
wire            cp0_sysio_ipend_b;                   
wire    [1 :0]  cp0_sysio_lpmd_b;                    
wire    [1 :0]  cp0_sysio_srst;                      
wire            cp0_yy_be_v2;                        
wire            cp0_yy_clk_en;                       
wire            cp0_yy_machine_mode_aft_dbg;         
wire    [1 :0]  cp0_yy_priv_mode;                    
wire    [11:0]  cpu_clic_curid;                      
wire            cpu_clic_int_exit;                   
wire            cpu_pad_dfs_ack;                     
wire            cpu_pad_lockup;                      
wire    [1 :0]  cpu_pad_soft_rst;                    
wire            cpurst_b;                            
wire            dahblif_other_mask;                  
wire            dbus_idle;                           
wire            forever_cpuclk;                      
wire            had_core_dbg_mode_req;               
wire            had_core_exit_dbg;                   
wire    [31:0]  had_idu_wbbr_data;                   
wire            had_idu_wbbr_vld;                    
wire            had_ifu_inst_bkpt_dbq_req;           
wire            had_ifu_inst_bkpt_dbqexp_req;        
wire    [31:0]  had_ifu_ir;                          
wire            had_ifu_ir_vld;                      
wire            had_iu_bkpt_trace_en;                
wire            had_iu_dr_set_req;                   
wire            had_iu_force_dbg_en;                 
wire            had_iu_int_vld;                      
wire            had_iu_mbkpt_fsm_index_mbee;         
wire            had_iu_mem_bkpt_exp_req;             
wire            had_iu_mem_bkpt_mask;                
wire            had_iu_mem_bkpt_req;                 
wire    [30:0]  had_iu_pc;                           
wire            had_iu_rte_pc_sel;                   
wire            had_iu_trace_req;                    
wire            had_iu_trace_req_for_dbg_disable;    
wire            had_iu_xx_fdb;                       
wire            had_iu_xx_jdbreq;                    
wire            had_yy_xx_dbg;                       
wire            had_yy_xx_dp_index_mbee;             
wire            iahbl_bmu_dbus_acc_err;              
wire    [31:0]  iahbl_bmu_dbus_data;                 
wire            iahbl_bmu_dbus_data_vld;             
wire            iahbl_bmu_dbus_grnt;                 
wire            iahbl_bmu_dbus_trans_cmplt;          
wire            iahbl_bmu_ibus_acc_err;              
wire    [31:0]  iahbl_bmu_ibus_data;                 
wire            iahbl_bmu_ibus_data_vld;             
wire            iahbl_bmu_ibus_grnt;                 
wire            iahbl_bmu_ibus_trans_cmplt;          
wire    [31:0]  iahbl_pad_haddr;                     
wire    [2 :0]  iahbl_pad_hburst;                    
wire    [3 :0]  iahbl_pad_hprot;                     
wire    [2 :0]  iahbl_pad_hsize;                     
wire    [1 :0]  iahbl_pad_htrans;                    
wire    [31:0]  iahbl_pad_hwdata;                    
wire            iahbl_pad_hwrite;                    
wire            iahblif_other_mask;                  
wire            ibus_idle;                           
wire    [31:0]  ifu_bmu_addr;                        
wire            ifu_bmu_idle;                        
wire    [3 :0]  ifu_bmu_prot;                        
wire            ifu_bmu_req;                         
wire            ifu_bmu_wfd1;                        
wire            ifu_had_chg_flw_inst;                
wire            ifu_had_fetch_expt_vld;              
wire            ifu_had_inst_dbg_disable;            
wire    [31:0]  ifu_had_match_pc;                    
wire            ifu_had_split_first;                 
wire            iu_bmu_vec_redirect;                 
wire            iu_cache_lockup_req;                 
wire            iu_had_adr_dbg_ack;                  
wire    [31:0]  iu_had_chgflw_dst_pc;                
wire            iu_had_chgflw_vld;                   
wire            iu_had_data_bkpt_occur_vld;          
wire            iu_had_dbg_disable_for_tee;          
wire            iu_had_dr_dbg_ack;                   
wire            iu_had_expt_vld;                     
wire            iu_had_fast_retire_acc_err_pc_update; 
wire    [30:0]  iu_had_fast_retire_acc_err_pc_val;   
wire            iu_had_flush;                        
wire            iu_had_inst_bkpt_occur_vld;          
wire            iu_had_int_ack;                      
wire            iu_had_retire_with_had_int;          
wire            iu_had_trace_occur_vld;              
wire            iu_had_xx_bkpt_inst;                 
wire    [31:0]  iu_had_xx_data;                      
wire            iu_had_xx_data_vld;                  
wire            iu_had_xx_dbg_ack;                   
wire            iu_had_xx_mldst;                     
wire            iu_had_xx_retire;                    
wire            iu_had_xx_retire_normal;             
wire    [31:0]  iu_had_xx_retire_pc;                 
wire    [31:0]  iu_pad_gpr_data;                     
wire    [4 :0]  iu_pad_gpr_index;                    
wire            iu_pad_gpr_we;                       
wire            iu_pad_inst_retire;                  
wire            iu_pad_inst_split;                   
wire    [31:0]  iu_pad_retire_pc;                    
wire            iu_sys_lp_wk_int;                    
wire            iu_sysio_lockup_on;                  
wire            iu_yy_xx_dbgon;                      
wire    [31:0]  lsu_bmu_addr;                        
wire            lsu_bmu_addr_check_fail;             
wire            lsu_bmu_idle;                        
wire    [3 :0]  lsu_bmu_prot;                        
wire            lsu_bmu_req;                         
wire            lsu_bmu_req_without_cmplt;           
wire            lsu_bmu_sg_chk_fail;                 
wire    [1 :0]  lsu_bmu_size;                        
wire            lsu_bmu_store_error;                 
wire    [31:0]  lsu_bmu_wdata;                       
wire            lsu_bmu_wfd1;                        
wire            lsu_bmu_write;                       
wire    [31:0]  lsu_had_addr;                        
wire            lsu_had_addr_vld;                    
wire            lsu_had_ex_cmplt;                    
wire            lsu_had_st;                          
wire    [31:0]  pad_biu_hrdata;                      
wire            pad_biu_hready;                      
wire            pad_biu_hresp;                       
wire    [11:0]  pad_bmu_iahbl_base;                  
wire    [11:0]  pad_bmu_iahbl_mask;                  
wire            pad_cpu_dfs_req;                     
wire            pad_cpu_ext_int_b;                   
wire            pad_cpu_nmi;                         
wire    [31:0]  pad_cpu_rst_addr;                    
wire    [63:0]  pad_cpu_sys_cnt;                     
wire            pad_cpu_wakeup_event;                
wire    [31:0]  pad_iahbl_hrdata;                    
wire            pad_iahbl_hready;                    
wire            pad_iahbl_hresp;                     
wire            pad_sysio_dbgrq_b;                   
wire            pad_yy_gate_clk_en_b;                
wire            pmp_bmu_dbus_acc_deny;               
wire            pmp_bmu_ibus_acc_deny;               
wire    [31:0]  pmp_cp0_data;                        
wire            pmp_ifu_acc_scu;                     
wire            pmp_lsu_acc_scu;                     
wire            pwrm_cpu_bus_peak_power_limit_en;    
wire            sahblif_iahblif_mask;                
wire            sbus_idle;                           
wire            sysio_clint_me_int;                  
wire    [63:0]  sysio_clint_mtime;                   
wire            sysio_cp0_bigend;                    
wire    [2 :0]  sysio_cp0_clkratio;                  
wire            sysio_cp0_endian_v2;                 
wire    [31:0]  sysio_cp0_rst_addr;                  
wire    [1 :0]  sysio_cp0_sys_view_lpmd_b;           
wire            sysio_had_sdb_req_b;                 
wire    [31:0]  sysio_ifu_rst_addr;                  
wire            sysio_iu_nmi_int;                    
wire    [31:0]  sysio_iu_rst_addr;                   
wire            sysio_iu_wk_event;                   
wire    [1 :0]  sysio_pad_lpmd_b;                    
wire            sysmap_ifu_acc_ca;                   
wire            sysmap_lsu_acc_ca;                   
wire    [31:0]  tcip_cp0_clic_base;                  
wire            tcipif_bmu_dbus_acc_err;             
wire    [31:0]  tcipif_bmu_dbus_data;                
wire            tcipif_bmu_dbus_data_vld;            
wire            tcipif_bmu_dbus_grnt;                
wire            tcipif_bmu_dbus_trans_cmplt;         
wire            tcipif_bmu_ibus_acc_err;             
wire    [31:0]  tcipif_bmu_ibus_data;                
wire            tcipif_bmu_ibus_data_vld;            
wire            tcipif_bmu_ibus_grnt;                
wire            tcipif_bmu_ibus_trans_cmplt;         


//==========================================================
//  Define SCAN CHAIN
//==========================================================
// //&Force("input", "nm_top_si_1"); @33
// //&Force("input", "nm_top_si_2"); @34
// //&Force("input", "nm_top_si_3"); @35
// //&Force("input", "nm_top_si_4"); @36
// //&Force("output", "nm_top_so_1"); @37
// //&Force("output", "nm_top_so_2"); @38
// //&Force("output", "nm_top_so_3"); @39
// //&Force("output", "nm_top_so_4"); @40
// //&Force("input", "pad_yy_scan_enable"); @41


//==========================================================
//  Instance CK802 core module
//==========================================================
// &Instance("cr_core"); @47
cr_core  x_cr_core (
  .bmu_lsu_acc_err                      (bmu_lsu_acc_err                     ),
  .bmu_lsu_bstack_chk_fail              (bmu_lsu_bstack_chk_fail             ),
  .bmu_lsu_data                         (bmu_lsu_data                        ),
  .bmu_lsu_data_vld                     (bmu_lsu_data_vld                    ),
  .bmu_lsu_grnt                         (bmu_lsu_grnt                        ),
  .bmu_lsu_trans_cmplt                  (bmu_lsu_trans_cmplt                 ),
  .bmu_xx_ibus_acc_err                  (bmu_xx_ibus_acc_err                 ),
  .bmu_xx_ibus_data                     (bmu_xx_ibus_data                    ),
  .bmu_xx_ibus_data_vld                 (bmu_xx_ibus_data_vld                ),
  .bmu_xx_ibus_grnt                     (bmu_xx_ibus_grnt                    ),
  .bmu_xx_ibus_trans_cmplt              (bmu_xx_ibus_trans_cmplt             ),
  .cache_cp0_lpmd_ack                   (cache_cp0_lpmd_ack                  ),
  .cache_cp0_srst_ack                   (cache_cp0_srst_ack                  ),
  .cache_iu_lockup_ack                  (cache_iu_lockup_ack                 ),
  .clic_cpu_int_hv                      (clic_cpu_int_hv                     ),
  .clic_cpu_int_id                      (clic_cpu_int_id                     ),
  .clic_cpu_int_il                      (clic_cpu_int_il                     ),
  .clic_cpu_int_priv                    (clic_cpu_int_priv                   ),
  .clint_cpu_me_int                     (clint_cpu_me_int                    ),
  .clk_en                               (clk_en                              ),
  .cp0_cache_lpmd_req                   (cp0_cache_lpmd_req                  ),
  .cp0_cache_srst_req                   (cp0_cache_srst_req                  ),
  .cp0_had_cpuid_idx0                   (cp0_had_cpuid_idx0                  ),
  .cp0_had_int_exit                     (cp0_had_int_exit                    ),
  .cp0_had_lpmd_b                       (cp0_had_lpmd_b                      ),
  .cp0_had_mcause_data                  (cp0_had_mcause_data                 ),
  .cp0_pad_mcause                       (cp0_pad_mcause                      ),
  .cp0_pad_mintstatus                   (cp0_pad_mintstatus                  ),
  .cp0_pad_mstatus                      (cp0_pad_mstatus                     ),
  .cp0_pmp_csr_sel                      (cp0_pmp_csr_sel                     ),
  .cp0_pmp_csr_wen                      (cp0_pmp_csr_wen                     ),
  .cp0_pmp_mstatus_mpp                  (cp0_pmp_mstatus_mpp                 ),
  .cp0_pmp_mstatus_mprv                 (cp0_pmp_mstatus_mprv                ),
  .cp0_pmp_updt_data                    (cp0_pmp_updt_data                   ),
  .cp0_sysio_ipend_b                    (cp0_sysio_ipend_b                   ),
  .cp0_sysio_lpmd_b                     (cp0_sysio_lpmd_b                    ),
  .cp0_sysio_srst                       (cp0_sysio_srst                      ),
  .cp0_yy_be_v2                         (cp0_yy_be_v2                        ),
  .cp0_yy_clk_en                        (cp0_yy_clk_en                       ),
  .cp0_yy_machine_mode_aft_dbg          (cp0_yy_machine_mode_aft_dbg         ),
  .cp0_yy_priv_mode                     (cp0_yy_priv_mode                    ),
  .cpu_clic_curid                       (cpu_clic_curid                      ),
  .cpu_clic_int_exit                    (cpu_clic_int_exit                   ),
  .cpurst_b                             (cpurst_b                            ),
  .forever_cpuclk                       (forever_cpuclk                      ),
  .had_core_dbg_mode_req                (had_core_dbg_mode_req               ),
  .had_idu_wbbr_data                    (had_idu_wbbr_data                   ),
  .had_idu_wbbr_vld                     (had_idu_wbbr_vld                    ),
  .had_ifu_inst_bkpt_dbq_req            (had_ifu_inst_bkpt_dbq_req           ),
  .had_ifu_inst_bkpt_dbqexp_req         (had_ifu_inst_bkpt_dbqexp_req        ),
  .had_ifu_ir                           (had_ifu_ir                          ),
  .had_ifu_ir_vld                       (had_ifu_ir_vld                      ),
  .had_iu_bkpt_trace_en                 (had_iu_bkpt_trace_en                ),
  .had_iu_dr_set_req                    (had_iu_dr_set_req                   ),
  .had_iu_force_dbg_en                  (had_iu_force_dbg_en                 ),
  .had_iu_int_vld                       (had_iu_int_vld                      ),
  .had_iu_mbkpt_fsm_index_mbee          (had_iu_mbkpt_fsm_index_mbee         ),
  .had_iu_mem_bkpt_exp_req              (had_iu_mem_bkpt_exp_req             ),
  .had_iu_mem_bkpt_mask                 (had_iu_mem_bkpt_mask                ),
  .had_iu_mem_bkpt_req                  (had_iu_mem_bkpt_req                 ),
  .had_iu_pc                            (had_iu_pc                           ),
  .had_iu_rte_pc_sel                    (had_iu_rte_pc_sel                   ),
  .had_iu_trace_req                     (had_iu_trace_req                    ),
  .had_iu_trace_req_for_dbg_disable     (had_iu_trace_req_for_dbg_disable    ),
  .had_iu_xx_fdb                        (had_iu_xx_fdb                       ),
  .had_iu_xx_jdbreq                     (had_iu_xx_jdbreq                    ),
  .had_yy_xx_dbg                        (had_yy_xx_dbg                       ),
  .had_yy_xx_dp_index_mbee              (had_yy_xx_dp_index_mbee             ),
  .had_yy_xx_exit_dbg                   (had_core_exit_dbg                   ),
  .ifu_bmu_addr                         (ifu_bmu_addr                        ),
  .ifu_bmu_idle                         (ifu_bmu_idle                        ),
  .ifu_bmu_prot                         (ifu_bmu_prot                        ),
  .ifu_bmu_req                          (ifu_bmu_req                         ),
  .ifu_bmu_wfd1                         (ifu_bmu_wfd1                        ),
  .ifu_had_chg_flw_inst                 (ifu_had_chg_flw_inst                ),
  .ifu_had_fetch_expt_vld               (ifu_had_fetch_expt_vld              ),
  .ifu_had_inst_dbg_disable             (ifu_had_inst_dbg_disable            ),
  .ifu_had_match_pc                     (ifu_had_match_pc                    ),
  .ifu_had_split_first                  (ifu_had_split_first                 ),
  .iu_bmu_vec_redirect                  (iu_bmu_vec_redirect                 ),
  .iu_cache_lockup_req                  (iu_cache_lockup_req                 ),
  .iu_had_adr_dbg_ack                   (iu_had_adr_dbg_ack                  ),
  .iu_had_chgflw_dst_pc                 (iu_had_chgflw_dst_pc                ),
  .iu_had_chgflw_vld                    (iu_had_chgflw_vld                   ),
  .iu_had_data_bkpt_occur_vld           (iu_had_data_bkpt_occur_vld          ),
  .iu_had_dbg_disable_for_tee           (iu_had_dbg_disable_for_tee          ),
  .iu_had_dr_dbg_ack                    (iu_had_dr_dbg_ack                   ),
  .iu_had_expt_vld                      (iu_had_expt_vld                     ),
  .iu_had_fast_retire_acc_err_pc_update (iu_had_fast_retire_acc_err_pc_update),
  .iu_had_fast_retire_acc_err_pc_val    (iu_had_fast_retire_acc_err_pc_val   ),
  .iu_had_flush                         (iu_had_flush                        ),
  .iu_had_inst_bkpt_occur_vld           (iu_had_inst_bkpt_occur_vld          ),
  .iu_had_int_ack                       (iu_had_int_ack                      ),
  .iu_had_retire_with_had_int           (iu_had_retire_with_had_int          ),
  .iu_had_trace_occur_vld               (iu_had_trace_occur_vld              ),
  .iu_had_xx_bkpt_inst                  (iu_had_xx_bkpt_inst                 ),
  .iu_had_xx_data                       (iu_had_xx_data                      ),
  .iu_had_xx_data_vld                   (iu_had_xx_data_vld                  ),
  .iu_had_xx_dbg_ack                    (iu_had_xx_dbg_ack                   ),
  .iu_had_xx_mldst                      (iu_had_xx_mldst                     ),
  .iu_had_xx_retire                     (iu_had_xx_retire                    ),
  .iu_had_xx_retire_normal              (iu_had_xx_retire_normal             ),
  .iu_had_xx_retire_pc                  (iu_had_xx_retire_pc                 ),
  .iu_pad_gpr_data                      (iu_pad_gpr_data                     ),
  .iu_pad_gpr_index                     (iu_pad_gpr_index                    ),
  .iu_pad_gpr_we                        (iu_pad_gpr_we                       ),
  .iu_pad_inst_retire                   (iu_pad_inst_retire                  ),
  .iu_pad_inst_split                    (iu_pad_inst_split                   ),
  .iu_pad_retire_pc                     (iu_pad_retire_pc                    ),
  .iu_sys_lp_wk_int                     (iu_sys_lp_wk_int                    ),
  .iu_sysio_lockup_on                   (iu_sysio_lockup_on                  ),
  .iu_yy_xx_dbgon                       (iu_yy_xx_dbgon                      ),
  .lsu_bmu_addr                         (lsu_bmu_addr                        ),
  .lsu_bmu_addr_check_fail              (lsu_bmu_addr_check_fail             ),
  .lsu_bmu_idle                         (lsu_bmu_idle                        ),
  .lsu_bmu_prot                         (lsu_bmu_prot                        ),
  .lsu_bmu_req                          (lsu_bmu_req                         ),
  .lsu_bmu_req_without_cmplt            (lsu_bmu_req_without_cmplt           ),
  .lsu_bmu_sg_chk_fail                  (lsu_bmu_sg_chk_fail                 ),
  .lsu_bmu_size                         (lsu_bmu_size                        ),
  .lsu_bmu_store_error                  (lsu_bmu_store_error                 ),
  .lsu_bmu_wdata                        (lsu_bmu_wdata                       ),
  .lsu_bmu_wfd1                         (lsu_bmu_wfd1                        ),
  .lsu_bmu_write                        (lsu_bmu_write                       ),
  .lsu_had_addr                         (lsu_had_addr                        ),
  .lsu_had_addr_vld                     (lsu_had_addr_vld                    ),
  .lsu_had_ex_cmplt                     (lsu_had_ex_cmplt                    ),
  .lsu_had_st                           (lsu_had_st                          ),
  .pad_yy_gate_clk_en_b                 (pad_yy_gate_clk_en_b                ),
  .pmp_cp0_data                         (pmp_cp0_data                        ),
  .pmp_ifu_acc_scu                      (pmp_ifu_acc_scu                     ),
  .pmp_lsu_acc_scu                      (pmp_lsu_acc_scu                     ),
  .sysio_cp0_bigend                     (sysio_cp0_bigend                    ),
  .sysio_cp0_clkratio                   (sysio_cp0_clkratio                  ),
  .sysio_cp0_endian_v2                  (sysio_cp0_endian_v2                 ),
  .sysio_cp0_rst_addr                   (sysio_cp0_rst_addr                  ),
  .sysio_cp0_sys_view_lpmd_b            (sysio_cp0_sys_view_lpmd_b           ),
  .sysio_ifu_rst_addr                   (sysio_ifu_rst_addr                  ),
  .sysio_iu_nmi_int                     (sysio_iu_nmi_int                    ),
  .sysio_iu_rst_addr                    (sysio_iu_rst_addr                   ),
  .sysio_iu_wk_event                    (sysio_iu_wk_event                   ),
  .sysmap_ifu_acc_ca                    (sysmap_ifu_acc_ca                   ),
  .sysmap_lsu_acc_ca                    (sysmap_lsu_acc_ca                   ),
  .tcip_cp0_clic_base                   (tcip_cp0_clic_base                  )
);

// &Connect( @48
//          .had_yy_xx_exit_dbg    (had_core_exit_dbg       ), @49
//         ); @50
//assign cp0_had_supv_mode = cp0_yy_supv_mode;
// &Force("output", "iu_yy_xx_dbgon"); @52
// //&Force("output","cp0_yy_secu_mode"); @54

//==========================================================
//  Instance MPU module 
//==========================================================
// &Instance("cr_pmp_top"); @61
cr_pmp_top  x_cr_pmp_top (
  .cp0_pmp_csr_sel             (cp0_pmp_csr_sel            ),
  .cp0_pmp_csr_wen             (cp0_pmp_csr_wen            ),
  .cp0_pmp_mstatus_mpp         (cp0_pmp_mstatus_mpp        ),
  .cp0_pmp_mstatus_mprv        (cp0_pmp_mstatus_mprv       ),
  .cp0_pmp_updt_data           (cp0_pmp_updt_data          ),
  .cp0_yy_clk_en               (cp0_yy_clk_en              ),
  .cp0_yy_machine_mode_aft_dbg (cp0_yy_machine_mode_aft_dbg),
  .cpurst_b                    (cpurst_b                   ),
  .forever_cpuclk              (forever_cpuclk             ),
  .ifu_bmu_addr                (ifu_bmu_addr               ),
  .ifu_bmu_prot                (ifu_bmu_prot               ),
  .lsu_bmu_addr                (lsu_bmu_addr               ),
  .lsu_bmu_write               (lsu_bmu_write              ),
  .pad_yy_gate_clk_en_b        (pad_yy_gate_clk_en_b       ),
  .pmp_bmu_dbus_acc_deny       (pmp_bmu_dbus_acc_deny      ),
  .pmp_bmu_ibus_acc_deny       (pmp_bmu_ibus_acc_deny      ),
  .pmp_cp0_data                (pmp_cp0_data               ),
  .pmp_ifu_acc_scu             (pmp_ifu_acc_scu            ),
  .pmp_lsu_acc_scu             (pmp_lsu_acc_scu            )
);


//==========================================================
//  Instance BMU module 
//==========================================================
// &Instance("cr_bmu_top"); @67
cr_bmu_top  x_cr_bmu_top (
  .biu_bmu_dbus_acc_err             (biu_bmu_dbus_acc_err            ),
  .biu_bmu_dbus_data                (biu_bmu_dbus_data               ),
  .biu_bmu_dbus_data_vld            (biu_bmu_dbus_data_vld           ),
  .biu_bmu_dbus_grnt                (biu_bmu_dbus_grnt               ),
  .biu_bmu_dbus_trans_cmplt         (biu_bmu_dbus_trans_cmplt        ),
  .biu_bmu_ibus_acc_err             (biu_bmu_ibus_acc_err            ),
  .biu_bmu_ibus_data                (biu_bmu_ibus_data               ),
  .biu_bmu_ibus_data_vld            (biu_bmu_ibus_data_vld           ),
  .biu_bmu_ibus_grnt                (biu_bmu_ibus_grnt               ),
  .biu_bmu_ibus_trans_cmplt         (biu_bmu_ibus_trans_cmplt        ),
  .bmu_biu_dbus_acc_deny            (bmu_biu_dbus_acc_deny           ),
  .bmu_biu_dbus_addr                (bmu_biu_dbus_addr               ),
  .bmu_biu_dbus_chk_fail            (bmu_biu_dbus_chk_fail           ),
  .bmu_biu_dbus_prot                (bmu_biu_dbus_prot               ),
  .bmu_biu_dbus_req                 (bmu_biu_dbus_req                ),
  .bmu_biu_dbus_req_without_cmplt   (bmu_biu_dbus_req_without_cmplt  ),
  .bmu_biu_dbus_size                (bmu_biu_dbus_size               ),
  .bmu_biu_dbus_wdata               (bmu_biu_dbus_wdata              ),
  .bmu_biu_dbus_write               (bmu_biu_dbus_write              ),
  .bmu_biu_ibus_acc_deny            (bmu_biu_ibus_acc_deny           ),
  .bmu_biu_ibus_addr                (bmu_biu_ibus_addr               ),
  .bmu_biu_ibus_hit                 (bmu_biu_ibus_hit                ),
  .bmu_biu_ibus_prot                (bmu_biu_ibus_prot               ),
  .bmu_biu_ibus_req                 (bmu_biu_ibus_req                ),
  .bmu_biu_ibus_req_no_hit          (bmu_biu_ibus_req_no_hit         ),
  .bmu_biu_ibus_size                (bmu_biu_ibus_size               ),
  .bmu_biu_ibus_vec_redirect        (bmu_biu_ibus_vec_redirect       ),
  .bmu_iahbl_dbus_acc_deny          (bmu_iahbl_dbus_acc_deny         ),
  .bmu_iahbl_dbus_addr              (bmu_iahbl_dbus_addr             ),
  .bmu_iahbl_dbus_chk_fail          (bmu_iahbl_dbus_chk_fail         ),
  .bmu_iahbl_dbus_prot              (bmu_iahbl_dbus_prot             ),
  .bmu_iahbl_dbus_req               (bmu_iahbl_dbus_req              ),
  .bmu_iahbl_dbus_req_without_cmplt (bmu_iahbl_dbus_req_without_cmplt),
  .bmu_iahbl_dbus_size              (bmu_iahbl_dbus_size             ),
  .bmu_iahbl_dbus_wdata             (bmu_iahbl_dbus_wdata            ),
  .bmu_iahbl_dbus_write             (bmu_iahbl_dbus_write            ),
  .bmu_iahbl_ibus_acc_deny          (bmu_iahbl_ibus_acc_deny         ),
  .bmu_iahbl_ibus_addr              (bmu_iahbl_ibus_addr             ),
  .bmu_iahbl_ibus_hit               (bmu_iahbl_ibus_hit              ),
  .bmu_iahbl_ibus_prot              (bmu_iahbl_ibus_prot             ),
  .bmu_iahbl_ibus_req               (bmu_iahbl_ibus_req              ),
  .bmu_iahbl_ibus_req_no_hit        (bmu_iahbl_ibus_req_no_hit       ),
  .bmu_iahbl_ibus_size              (bmu_iahbl_ibus_size             ),
  .bmu_iahbl_ibus_vec_redirect      (bmu_iahbl_ibus_vec_redirect     ),
  .bmu_lsu_acc_err                  (bmu_lsu_acc_err                 ),
  .bmu_lsu_bstack_chk_fail          (bmu_lsu_bstack_chk_fail         ),
  .bmu_lsu_data                     (bmu_lsu_data                    ),
  .bmu_lsu_data_vld                 (bmu_lsu_data_vld                ),
  .bmu_lsu_grnt                     (bmu_lsu_grnt                    ),
  .bmu_lsu_trans_cmplt              (bmu_lsu_trans_cmplt             ),
  .bmu_tcipif_dbus_acc_deny         (bmu_tcipif_dbus_acc_deny        ),
  .bmu_tcipif_dbus_addr             (bmu_tcipif_dbus_addr            ),
  .bmu_tcipif_dbus_chk_fail         (bmu_tcipif_dbus_chk_fail        ),
  .bmu_tcipif_dbus_req              (bmu_tcipif_dbus_req             ),
  .bmu_tcipif_dbus_size             (bmu_tcipif_dbus_size            ),
  .bmu_tcipif_dbus_supv_mode        (bmu_tcipif_dbus_supv_mode       ),
  .bmu_tcipif_dbus_wdata            (bmu_tcipif_dbus_wdata           ),
  .bmu_tcipif_dbus_write            (bmu_tcipif_dbus_write           ),
  .bmu_tcipif_ibus_acc_deny         (bmu_tcipif_ibus_acc_deny        ),
  .bmu_tcipif_ibus_addr             (bmu_tcipif_ibus_addr            ),
  .bmu_tcipif_ibus_req              (bmu_tcipif_ibus_req             ),
  .bmu_tcipif_ibus_write            (bmu_tcipif_ibus_write           ),
  .bmu_xx_ibus_acc_err              (bmu_xx_ibus_acc_err             ),
  .bmu_xx_ibus_data                 (bmu_xx_ibus_data                ),
  .bmu_xx_ibus_data_vld             (bmu_xx_ibus_data_vld            ),
  .bmu_xx_ibus_grnt                 (bmu_xx_ibus_grnt                ),
  .bmu_xx_ibus_trans_cmplt          (bmu_xx_ibus_trans_cmplt         ),
  .cp0_yy_clk_en                    (cp0_yy_clk_en                   ),
  .cp0_yy_machine_mode_aft_dbg      (cp0_yy_machine_mode_aft_dbg     ),
  .cpurst_b                         (cpurst_b                        ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .iahbl_bmu_dbus_acc_err           (iahbl_bmu_dbus_acc_err          ),
  .iahbl_bmu_dbus_data              (iahbl_bmu_dbus_data             ),
  .iahbl_bmu_dbus_data_vld          (iahbl_bmu_dbus_data_vld         ),
  .iahbl_bmu_dbus_grnt              (iahbl_bmu_dbus_grnt             ),
  .iahbl_bmu_dbus_trans_cmplt       (iahbl_bmu_dbus_trans_cmplt      ),
  .iahbl_bmu_ibus_acc_err           (iahbl_bmu_ibus_acc_err          ),
  .iahbl_bmu_ibus_data              (iahbl_bmu_ibus_data             ),
  .iahbl_bmu_ibus_data_vld          (iahbl_bmu_ibus_data_vld         ),
  .iahbl_bmu_ibus_grnt              (iahbl_bmu_ibus_grnt             ),
  .iahbl_bmu_ibus_trans_cmplt       (iahbl_bmu_ibus_trans_cmplt      ),
  .ifu_bmu_addr                     (ifu_bmu_addr                    ),
  .ifu_bmu_idle                     (ifu_bmu_idle                    ),
  .ifu_bmu_prot                     (ifu_bmu_prot                    ),
  .ifu_bmu_req                      (ifu_bmu_req                     ),
  .ifu_bmu_wfd1                     (ifu_bmu_wfd1                    ),
  .iu_bmu_vec_redirect              (iu_bmu_vec_redirect             ),
  .lsu_bmu_addr                     (lsu_bmu_addr                    ),
  .lsu_bmu_addr_check_fail          (lsu_bmu_addr_check_fail         ),
  .lsu_bmu_idle                     (lsu_bmu_idle                    ),
  .lsu_bmu_prot                     (lsu_bmu_prot                    ),
  .lsu_bmu_req                      (lsu_bmu_req                     ),
  .lsu_bmu_req_without_cmplt        (lsu_bmu_req_without_cmplt       ),
  .lsu_bmu_sg_chk_fail              (lsu_bmu_sg_chk_fail             ),
  .lsu_bmu_size                     (lsu_bmu_size                    ),
  .lsu_bmu_store_error              (lsu_bmu_store_error             ),
  .lsu_bmu_wdata                    (lsu_bmu_wdata                   ),
  .lsu_bmu_wfd1                     (lsu_bmu_wfd1                    ),
  .lsu_bmu_write                    (lsu_bmu_write                   ),
  .pad_bmu_iahbl_base               (pad_bmu_iahbl_base              ),
  .pad_bmu_iahbl_mask               (pad_bmu_iahbl_mask              ),
  .pad_yy_gate_clk_en_b             (pad_yy_gate_clk_en_b            ),
  .pmp_bmu_dbus_acc_deny            (pmp_bmu_dbus_acc_deny           ),
  .pmp_bmu_ibus_acc_deny            (pmp_bmu_ibus_acc_deny           ),
  .tcipif_bmu_dbus_acc_err          (tcipif_bmu_dbus_acc_err         ),
  .tcipif_bmu_dbus_data             (tcipif_bmu_dbus_data            ),
  .tcipif_bmu_dbus_data_vld         (tcipif_bmu_dbus_data_vld        ),
  .tcipif_bmu_dbus_grnt             (tcipif_bmu_dbus_grnt            ),
  .tcipif_bmu_dbus_trans_cmplt      (tcipif_bmu_dbus_trans_cmplt     ),
  .tcipif_bmu_ibus_acc_err          (tcipif_bmu_ibus_acc_err         ),
  .tcipif_bmu_ibus_data             (tcipif_bmu_ibus_data            ),
  .tcipif_bmu_ibus_data_vld         (tcipif_bmu_ibus_data_vld        ),
  .tcipif_bmu_ibus_grnt             (tcipif_bmu_ibus_grnt            ),
  .tcipif_bmu_ibus_trans_cmplt      (tcipif_bmu_ibus_trans_cmplt     )
);


// &Instance("cr_cache_top"); @73
// &Connect(.cpuclk          (forever_cpuclk)); @74
// &Connect(.cache_global_en (cp0_yy_clk_en)); @75
// //&Force("output", "ifu_bmu_addr"); @76
// //&Force("output", "lsu_bmu_addr"); @77
// //&Force("output", "lsu_bmu_prot"); @78
// //&Force("output", "ifu_bmu_prot"); @79
// //&Force("output", "lsu_bmu_write"); @80
// &Instance("cr_sysmap_top"); @81
// &Force("nonport", "cp0_cache_lpmd_req"); @83
// &Force("nonport", "cp0_cache_srst_req"); @84
// &Force("nonport", "iu_cache_lockup_req"); @85
assign cache_cp0_lpmd_ack = 1'b1;
assign cache_cp0_srst_ack = 1'b1;
assign cache_iu_lockup_ack = 1'b1;
assign sysmap_ifu_acc_ca  = 1'b0;
assign sysmap_lsu_acc_ca  = 1'b0;

always @ (posedge forever_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    pad_cpu_halt_ff1 <= 1'b0;
    pad_cpu_halt_ff2 <= 1'b0;
  end
  else
  begin
    pad_cpu_halt_ff1 <= pad_cpu_dfs_req;
    pad_cpu_halt_ff2 <= pad_cpu_halt_ff1;
  end
end
assign cpu_pad_dfs_ack = ibus_idle && dbus_idle && sbus_idle
                       && pad_cpu_halt_ff2;
//==========================================================
//  Instance BIU module 
//==========================================================
// &Instance("cr_sahbl_top"); @111
cr_sahbl_top  x_cr_sahbl_top (
  .ahblif_idle                      (sbus_idle                       ),
  .biu_bmu_dbus_acc_err             (biu_bmu_dbus_acc_err            ),
  .biu_bmu_dbus_data                (biu_bmu_dbus_data               ),
  .biu_bmu_dbus_data_vld            (biu_bmu_dbus_data_vld           ),
  .biu_bmu_dbus_grnt                (biu_bmu_dbus_grnt               ),
  .biu_bmu_dbus_trans_cmplt         (biu_bmu_dbus_trans_cmplt        ),
  .biu_bmu_ibus_acc_err             (biu_bmu_ibus_acc_err            ),
  .biu_bmu_ibus_data                (biu_bmu_ibus_data               ),
  .biu_bmu_ibus_data_vld            (biu_bmu_ibus_data_vld           ),
  .biu_bmu_ibus_grnt                (biu_bmu_ibus_grnt               ),
  .biu_bmu_ibus_trans_cmplt         (biu_bmu_ibus_trans_cmplt        ),
  .biu_pad_haddr                    (biu_pad_haddr                   ),
  .biu_pad_hburst                   (biu_pad_hburst                  ),
  .biu_pad_hprot                    (biu_pad_hprot                   ),
  .biu_pad_hsize                    (biu_pad_hsize                   ),
  .biu_pad_htrans                   (biu_pad_htrans                  ),
  .biu_pad_hwdata                   (biu_pad_hwdata                  ),
  .biu_pad_hwrite                   (biu_pad_hwrite                  ),
  .bmu_biu_dbus_acc_deny            (bmu_biu_dbus_acc_deny           ),
  .bmu_biu_dbus_addr                (bmu_biu_dbus_addr               ),
  .bmu_biu_dbus_chk_fail            (bmu_biu_dbus_chk_fail           ),
  .bmu_biu_dbus_prot                (bmu_biu_dbus_prot               ),
  .bmu_biu_dbus_req                 (bmu_biu_dbus_req                ),
  .bmu_biu_dbus_req_without_cmplt   (bmu_biu_dbus_req_without_cmplt  ),
  .bmu_biu_dbus_size                (bmu_biu_dbus_size               ),
  .bmu_biu_dbus_wdata               (bmu_biu_dbus_wdata              ),
  .bmu_biu_dbus_write               (bmu_biu_dbus_write              ),
  .bmu_biu_ibus_acc_deny            (bmu_biu_ibus_acc_deny           ),
  .bmu_biu_ibus_addr                (bmu_biu_ibus_addr               ),
  .bmu_biu_ibus_hit                 (bmu_biu_ibus_hit                ),
  .bmu_biu_ibus_prot                (bmu_biu_ibus_prot               ),
  .bmu_biu_ibus_req                 (bmu_biu_ibus_req                ),
  .bmu_biu_ibus_req_no_hit          (bmu_biu_ibus_req_no_hit         ),
  .bmu_biu_ibus_size                (bmu_biu_ibus_size               ),
  .bmu_biu_ibus_vec_redirect        (bmu_biu_ibus_vec_redirect       ),
  .cpurst_b                         (cpurst_b                        ),
  .dahblif_other_mask               (dahblif_other_mask              ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .iahblif_other_mask               (iahblif_other_mask              ),
  .pad_biu_hrdata                   (pad_biu_hrdata                  ),
  .pad_biu_hready                   (pad_biu_hready                  ),
  .pad_biu_hresp                    (pad_biu_hresp                   ),
  .pad_cpu_halt_ff2                 (pad_cpu_halt_ff2                ),
  .pad_yy_gate_clk_en_b             (pad_yy_gate_clk_en_b            ),
  .pwrm_cpu_bus_peak_power_limit_en (pwrm_cpu_bus_peak_power_limit_en),
  .sahblif_iahblif_mask             (sahblif_iahblif_mask            )
);

// &Connect(.ahblif_idle (sbus_idle)); @112

//==========================================================
//  Instance IAHBLite module
//==========================================================
// &Instance("cr_iahbl_top"); @118
cr_iahbl_top  x_cr_iahbl_top (
  .ahblif_idle                      (ibus_idle                       ),
  .bmu_iahbl_dbus_acc_deny          (bmu_iahbl_dbus_acc_deny         ),
  .bmu_iahbl_dbus_addr              (bmu_iahbl_dbus_addr             ),
  .bmu_iahbl_dbus_chk_fail          (bmu_iahbl_dbus_chk_fail         ),
  .bmu_iahbl_dbus_prot              (bmu_iahbl_dbus_prot             ),
  .bmu_iahbl_dbus_req               (bmu_iahbl_dbus_req              ),
  .bmu_iahbl_dbus_req_without_cmplt (bmu_iahbl_dbus_req_without_cmplt),
  .bmu_iahbl_dbus_size              (bmu_iahbl_dbus_size             ),
  .bmu_iahbl_dbus_wdata             (bmu_iahbl_dbus_wdata            ),
  .bmu_iahbl_dbus_write             (bmu_iahbl_dbus_write            ),
  .bmu_iahbl_ibus_acc_deny          (bmu_iahbl_ibus_acc_deny         ),
  .bmu_iahbl_ibus_addr              (bmu_iahbl_ibus_addr             ),
  .bmu_iahbl_ibus_hit               (bmu_iahbl_ibus_hit              ),
  .bmu_iahbl_ibus_prot              (bmu_iahbl_ibus_prot             ),
  .bmu_iahbl_ibus_req               (bmu_iahbl_ibus_req              ),
  .bmu_iahbl_ibus_req_no_hit        (bmu_iahbl_ibus_req_no_hit       ),
  .bmu_iahbl_ibus_size              (bmu_iahbl_ibus_size             ),
  .bmu_iahbl_ibus_vec_redirect      (bmu_iahbl_ibus_vec_redirect     ),
  .cpurst_b                         (cpurst_b                        ),
  .dahblif_other_mask               (dahblif_other_mask              ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .iahbl_bmu_dbus_acc_err           (iahbl_bmu_dbus_acc_err          ),
  .iahbl_bmu_dbus_data              (iahbl_bmu_dbus_data             ),
  .iahbl_bmu_dbus_data_vld          (iahbl_bmu_dbus_data_vld         ),
  .iahbl_bmu_dbus_grnt              (iahbl_bmu_dbus_grnt             ),
  .iahbl_bmu_dbus_trans_cmplt       (iahbl_bmu_dbus_trans_cmplt      ),
  .iahbl_bmu_ibus_acc_err           (iahbl_bmu_ibus_acc_err          ),
  .iahbl_bmu_ibus_data              (iahbl_bmu_ibus_data             ),
  .iahbl_bmu_ibus_data_vld          (iahbl_bmu_ibus_data_vld         ),
  .iahbl_bmu_ibus_grnt              (iahbl_bmu_ibus_grnt             ),
  .iahbl_bmu_ibus_trans_cmplt       (iahbl_bmu_ibus_trans_cmplt      ),
  .iahbl_pad_haddr                  (iahbl_pad_haddr                 ),
  .iahbl_pad_hburst                 (iahbl_pad_hburst                ),
  .iahbl_pad_hprot                  (iahbl_pad_hprot                 ),
  .iahbl_pad_hsize                  (iahbl_pad_hsize                 ),
  .iahbl_pad_htrans                 (iahbl_pad_htrans                ),
  .iahbl_pad_hwdata                 (iahbl_pad_hwdata                ),
  .iahbl_pad_hwrite                 (iahbl_pad_hwrite                ),
  .iahblif_other_mask               (iahblif_other_mask              ),
  .pad_cpu_halt_ff2                 (pad_cpu_halt_ff2                ),
  .pad_iahbl_hrdata                 (pad_iahbl_hrdata                ),
  .pad_iahbl_hready                 (pad_iahbl_hready                ),
  .pad_iahbl_hresp                  (pad_iahbl_hresp                 ),
  .pad_yy_gate_clk_en_b             (pad_yy_gate_clk_en_b            ),
  .pwrm_cpu_bus_peak_power_limit_en (pwrm_cpu_bus_peak_power_limit_en),
  .sahblif_iahblif_mask             (sahblif_iahblif_mask            )
);

// &Connect(.ahblif_idle (ibus_idle)); @119

// &Instance("cr_dahbl_top"); @129
// &Connect(.ahblif_idle (dbus_idle)); @130
assign dahblif_other_mask = 1'b0;  
assign dbus_idle = 1'b1;

//==========================================================
//  Instance SYSTEM IO module
//==========================================================
// &Instance("cr_sys_io","x_cr_sys_io"); @139
cr_sys_io  x_cr_sys_io (
  .clk_en                    (clk_en                   ),
  .cp0_sysio_ipend_b         (cp0_sysio_ipend_b        ),
  .cp0_sysio_lpmd_b          (cp0_sysio_lpmd_b         ),
  .cp0_sysio_srst            (cp0_sysio_srst           ),
  .cpu_pad_lockup            (cpu_pad_lockup           ),
  .cpu_pad_soft_rst          (cpu_pad_soft_rst         ),
  .cpurst_b                  (cpurst_b                 ),
  .forever_cpuclk            (forever_cpuclk           ),
  .had_yy_xx_dbg             (had_yy_xx_dbg            ),
  .iu_sys_lp_wk_int          (iu_sys_lp_wk_int         ),
  .iu_sysio_lockup_on        (iu_sysio_lockup_on       ),
  .iu_yy_xx_dbgon            (iu_yy_xx_dbgon           ),
  .pad_cpu_ext_int_b         (pad_cpu_ext_int_b        ),
  .pad_cpu_nmi               (pad_cpu_nmi              ),
  .pad_cpu_rst_addr          (pad_cpu_rst_addr         ),
  .pad_cpu_sys_cnt           (pad_cpu_sys_cnt          ),
  .pad_cpu_wakeup_event      (pad_cpu_wakeup_event     ),
  .pad_sysio_dbgrq_b         (pad_sysio_dbgrq_b        ),
  .pad_yy_gate_clk_en_b      (pad_yy_gate_clk_en_b     ),
  .sysio_clint_me_int        (sysio_clint_me_int       ),
  .sysio_clint_mtime         (sysio_clint_mtime        ),
  .sysio_cp0_bigend          (sysio_cp0_bigend         ),
  .sysio_cp0_clkratio        (sysio_cp0_clkratio       ),
  .sysio_cp0_endian_v2       (sysio_cp0_endian_v2      ),
  .sysio_cp0_rst_addr        (sysio_cp0_rst_addr       ),
  .sysio_cp0_sys_view_lpmd_b (sysio_cp0_sys_view_lpmd_b),
  .sysio_had_sdb_req_b       (sysio_had_sdb_req_b      ),
  .sysio_ifu_rst_addr        (sysio_ifu_rst_addr       ),
  .sysio_iu_nmi_int          (sysio_iu_nmi_int         ),
  .sysio_iu_rst_addr         (sysio_iu_rst_addr        ),
  .sysio_iu_wk_event         (sysio_iu_wk_event        ),
  .sysio_pad_lpmd_b          (sysio_pad_lpmd_b         )
);


// &ModuleEnd; @141
endmodule


