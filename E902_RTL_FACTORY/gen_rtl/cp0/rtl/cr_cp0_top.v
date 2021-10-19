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

// &ModuleBeg; @24
module cr_cp0_top(
  cache_cp0_lpmd_ack,
  cache_cp0_srst_ack,
  clic_cpu_int_id,
  cp0_cache_lpmd_req,
  cp0_cache_srst_req,
  cp0_had_cpuid_idx0,
  cp0_had_int_exit,
  cp0_had_lpmd_b,
  cp0_had_mcause_data,
  cp0_ifu_in_lpmd,
  cp0_ifu_lpmd_req,
  cp0_ifu_rst_inv_done,
  cp0_ifu_srst_mask,
  cp0_ifu_srst_req,
  cp0_iu_cache_inv_done,
  cp0_iu_cskyisaee,
  cp0_iu_data,
  cp0_iu_data_vld,
  cp0_iu_dbg_disable_for_tee,
  cp0_iu_epc_for_chgflw,
  cp0_iu_expt_vec,
  cp0_iu_expt_vld,
  cp0_iu_flush,
  cp0_iu_flush_chgflw_vld,
  cp0_iu_il,
  cp0_iu_in_expt,
  cp0_iu_in_nmi,
  cp0_iu_inst_mret,
  cp0_iu_meie,
  cp0_iu_mie_for_int,
  cp0_iu_mret,
  cp0_iu_req,
  cp0_iu_rte_chgflw_vld,
  cp0_iu_rte_chgflw_vld_for_data,
  cp0_iu_stall,
  cp0_iu_stall_noinput,
  cp0_iu_vbr,
  cp0_iu_vec_mode,
  cp0_iu_wfe_en,
  cp0_pad_mcause,
  cp0_pad_mintstatus,
  cp0_pad_mstatus,
  cp0_pmp_csr_sel,
  cp0_pmp_csr_wen,
  cp0_pmp_mstatus_mpp,
  cp0_pmp_mstatus_mprv,
  cp0_pmp_updt_data,
  cp0_sysio_ipend_b,
  cp0_sysio_lpmd_b,
  cp0_sysio_srst,
  cp0_vector_vec_err_vbr,
  cp0_yy_be_v1,
  cp0_yy_be_v2,
  cp0_yy_clk_en,
  cp0_yy_machine_mode_aft_dbg,
  cp0_yy_priv_mode,
  cpu_clic_curid,
  cpu_clic_int_exit,
  cpurst_b,
  forever_cpuclk,
  had_iu_force_dbg_en,
  had_yy_xx_dbg,
  ifu_cp0_lpmd_ack,
  ifu_cp0_rst_inv_req,
  ifu_cp0_srst_ack,
  iu_cp0_ecall,
  iu_cp0_epc,
  iu_cp0_epc_update,
  iu_cp0_ex_csrrc,
  iu_cp0_ex_csrrci,
  iu_cp0_ex_csrrs,
  iu_cp0_ex_csrrsi,
  iu_cp0_ex_csrrw,
  iu_cp0_ex_csrrwi,
  iu_cp0_ex_data_sel,
  iu_cp0_ex_func3,
  iu_cp0_ex_mret,
  iu_cp0_ex_rd_reg,
  iu_cp0_ex_rs1_reg,
  iu_cp0_ex_sel,
  iu_cp0_ex_wfi,
  iu_cp0_expt_tval,
  iu_cp0_expt_vld,
  iu_cp0_imm,
  iu_cp0_int_vld,
  iu_cp0_lockup_clr,
  iu_cp0_lockup_vld,
  iu_cp0_lp_wk_int,
  iu_cp0_mtval_updt_vld,
  iu_cp0_nmi_vld,
  iu_cp0_nt_int_pending_vld,
  iu_cp0_oper_mux_en,
  iu_cp0_rs1,
  iu_cp0_syc_rst_b,
  iu_yy_xx_dbgon,
  iu_yy_xx_expt_vec,
  iu_yy_xx_flush,
  iu_yy_xx_int_hv,
  iu_yy_xx_int_il,
  iu_yy_xx_int_pending_hv,
  iu_yy_xx_int_pending_id,
  iu_yy_xx_int_pending_il,
  iu_yy_xx_int_pending_priv,
  pad_yy_gate_clk_en_b,
  pmp_cp0_data,
  sysio_cp0_bigend,
  sysio_cp0_clkratio,
  sysio_cp0_endian_v2,
  sysio_cp0_rst_addr,
  sysio_cp0_sys_view_lpmd_b,
  tcip_cp0_clic_base,
  vector_cp0_vec_err,
  vector_cp0_vec_err_epc,
  vector_cp0_vec_succeed
);

// &Ports; @25
input           cache_cp0_lpmd_ack;            
input           cache_cp0_srst_ack;            
input   [11:0]  clic_cpu_int_id;               
input           cpurst_b;                      
input           forever_cpuclk;                
input           had_iu_force_dbg_en;           
input           had_yy_xx_dbg;                 
input           ifu_cp0_lpmd_ack;              
input           ifu_cp0_rst_inv_req;           
input           ifu_cp0_srst_ack;              
input           iu_cp0_ecall;                  
input   [30:0]  iu_cp0_epc;                    
input           iu_cp0_epc_update;             
input           iu_cp0_ex_csrrc;               
input           iu_cp0_ex_csrrci;              
input           iu_cp0_ex_csrrs;               
input           iu_cp0_ex_csrrsi;              
input           iu_cp0_ex_csrrw;               
input           iu_cp0_ex_csrrwi;              
input           iu_cp0_ex_data_sel;            
input   [2 :0]  iu_cp0_ex_func3;               
input           iu_cp0_ex_mret;                
input   [4 :0]  iu_cp0_ex_rd_reg;              
input   [4 :0]  iu_cp0_ex_rs1_reg;             
input           iu_cp0_ex_sel;                 
input           iu_cp0_ex_wfi;                 
input   [31:0]  iu_cp0_expt_tval;              
input           iu_cp0_expt_vld;               
input   [11:0]  iu_cp0_imm;                    
input           iu_cp0_int_vld;                
input           iu_cp0_lockup_clr;             
input           iu_cp0_lockup_vld;             
input           iu_cp0_lp_wk_int;              
input           iu_cp0_mtval_updt_vld;         
input           iu_cp0_nmi_vld;                
input           iu_cp0_nt_int_pending_vld;     
input           iu_cp0_oper_mux_en;            
input   [31:0]  iu_cp0_rs1;                    
input           iu_cp0_syc_rst_b;              
input           iu_yy_xx_dbgon;                
input   [9 :0]  iu_yy_xx_expt_vec;             
input           iu_yy_xx_flush;                
input           iu_yy_xx_int_hv;               
input   [7 :0]  iu_yy_xx_int_il;               
input           iu_yy_xx_int_pending_hv;       
input   [9 :0]  iu_yy_xx_int_pending_id;       
input   [7 :0]  iu_yy_xx_int_pending_il;       
input   [1 :0]  iu_yy_xx_int_pending_priv;     
input           pad_yy_gate_clk_en_b;          
input   [31:0]  pmp_cp0_data;                  
input           sysio_cp0_bigend;              
input   [2 :0]  sysio_cp0_clkratio;            
input           sysio_cp0_endian_v2;           
input   [31:0]  sysio_cp0_rst_addr;            
input   [1 :0]  sysio_cp0_sys_view_lpmd_b;     
input   [31:0]  tcip_cp0_clic_base;            
input           vector_cp0_vec_err;            
input   [29:0]  vector_cp0_vec_err_epc;        
input           vector_cp0_vec_succeed;        
output          cp0_cache_lpmd_req;            
output          cp0_cache_srst_req;            
output  [31:0]  cp0_had_cpuid_idx0;            
output          cp0_had_int_exit;              
output  [1 :0]  cp0_had_lpmd_b;                
output  [31:0]  cp0_had_mcause_data;           
output          cp0_ifu_in_lpmd;               
output          cp0_ifu_lpmd_req;              
output          cp0_ifu_rst_inv_done;          
output          cp0_ifu_srst_mask;             
output          cp0_ifu_srst_req;              
output          cp0_iu_cache_inv_done;         
output          cp0_iu_cskyisaee;              
output  [31:0]  cp0_iu_data;                   
output          cp0_iu_data_vld;               
output          cp0_iu_dbg_disable_for_tee;    
output  [30:0]  cp0_iu_epc_for_chgflw;         
output  [4 :0]  cp0_iu_expt_vec;               
output          cp0_iu_expt_vld;               
output          cp0_iu_flush;                  
output          cp0_iu_flush_chgflw_vld;       
output  [7 :0]  cp0_iu_il;                     
output          cp0_iu_in_expt;                
output          cp0_iu_in_nmi;                 
output          cp0_iu_inst_mret;              
output          cp0_iu_meie;                   
output          cp0_iu_mie_for_int;            
output          cp0_iu_mret;                   
output          cp0_iu_req;                    
output          cp0_iu_rte_chgflw_vld;         
output          cp0_iu_rte_chgflw_vld_for_data; 
output          cp0_iu_stall;                  
output          cp0_iu_stall_noinput;          
output  [29:0]  cp0_iu_vbr;                    
output  [1 :0]  cp0_iu_vec_mode;               
output          cp0_iu_wfe_en;                 
output  [31:0]  cp0_pad_mcause;                
output  [31:0]  cp0_pad_mintstatus;            
output  [31:0]  cp0_pad_mstatus;               
output  [11:0]  cp0_pmp_csr_sel;               
output          cp0_pmp_csr_wen;               
output  [1 :0]  cp0_pmp_mstatus_mpp;           
output          cp0_pmp_mstatus_mprv;          
output  [31:0]  cp0_pmp_updt_data;             
output          cp0_sysio_ipend_b;             
output  [1 :0]  cp0_sysio_lpmd_b;              
output  [1 :0]  cp0_sysio_srst;                
output  [29:0]  cp0_vector_vec_err_vbr;        
output          cp0_yy_be_v1;                  
output          cp0_yy_be_v2;                  
output          cp0_yy_clk_en;                 
output          cp0_yy_machine_mode_aft_dbg;   
output  [1 :0]  cp0_yy_priv_mode;              
output  [11:0]  cpu_clic_curid;                
output          cpu_clic_int_exit;             

// &Regs; @26

// &Wires; @27
wire            cache_cp0_lpmd_ack;            
wire            cache_cp0_srst_ack;            
wire    [11:0]  clic_cpu_int_id;               
wire            cp0_cache_lpmd_req;            
wire            cp0_cache_srst_req;            
wire    [31:0]  cp0_had_cpuid_idx0;            
wire            cp0_had_int_exit;              
wire    [1 :0]  cp0_had_lpmd_b;                
wire    [31:0]  cp0_had_mcause_data;           
wire            cp0_ifu_in_lpmd;               
wire            cp0_ifu_lpmd_req;              
wire            cp0_ifu_rst_inv_done;          
wire            cp0_ifu_srst_mask;             
wire            cp0_ifu_srst_req;              
wire            cp0_iu_cache_inv_done;         
wire            cp0_iu_cskyisaee;              
wire    [31:0]  cp0_iu_data;                   
wire            cp0_iu_data_vld;               
wire            cp0_iu_dbg_disable_for_tee;    
wire    [30:0]  cp0_iu_epc_for_chgflw;         
wire    [4 :0]  cp0_iu_expt_vec;               
wire            cp0_iu_expt_vld;               
wire            cp0_iu_flush;                  
wire            cp0_iu_flush_chgflw_vld;       
wire    [7 :0]  cp0_iu_il;                     
wire            cp0_iu_in_expt;                
wire            cp0_iu_in_nmi;                 
wire            cp0_iu_inst_mret;              
wire            cp0_iu_meie;                   
wire            cp0_iu_mie_for_int;            
wire            cp0_iu_mret;                   
wire            cp0_iu_req;                    
wire            cp0_iu_rte_chgflw_vld;         
wire            cp0_iu_rte_chgflw_vld_for_data; 
wire            cp0_iu_stall;                  
wire            cp0_iu_stall_noinput;          
wire    [29:0]  cp0_iu_vbr;                    
wire    [1 :0]  cp0_iu_vec_mode;               
wire            cp0_iu_wfe_en;                 
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
wire    [29:0]  cp0_vector_vec_err_vbr;        
wire            cp0_yy_be_v1;                  
wire            cp0_yy_be_v2;                  
wire            cp0_yy_clk_en;                 
wire            cp0_yy_machine_mode_aft_dbg;   
wire    [1 :0]  cp0_yy_priv_mode;              
wire    [11:0]  cpu_clic_curid;                
wire            cpu_clic_int_exit;             
wire            cpurst_b;                      
wire            forever_cpuclk;                
wire            had_iu_force_dbg_en;           
wire            had_yy_xx_dbg;                 
wire            ifu_cp0_lpmd_ack;              
wire            ifu_cp0_rst_inv_req;           
wire            ifu_cp0_srst_ack;              
wire            inst_lpmd;                     
wire            iu_cp0_ecall;                  
wire    [30:0]  iu_cp0_epc;                    
wire            iu_cp0_epc_update;             
wire            iu_cp0_ex_csrrc;               
wire            iu_cp0_ex_csrrci;              
wire            iu_cp0_ex_csrrs;               
wire            iu_cp0_ex_csrrsi;              
wire            iu_cp0_ex_csrrw;               
wire            iu_cp0_ex_csrrwi;              
wire            iu_cp0_ex_data_sel;            
wire    [2 :0]  iu_cp0_ex_func3;               
wire            iu_cp0_ex_mret;                
wire    [4 :0]  iu_cp0_ex_rd_reg;              
wire    [4 :0]  iu_cp0_ex_rs1_reg;             
wire            iu_cp0_ex_sel;                 
wire            iu_cp0_ex_wfi;                 
wire    [31:0]  iu_cp0_expt_tval;              
wire            iu_cp0_expt_vld;               
wire    [11:0]  iu_cp0_imm;                    
wire            iu_cp0_int_vld;                
wire            iu_cp0_lockup_clr;             
wire            iu_cp0_lockup_vld;             
wire            iu_cp0_lp_wk_int;              
wire            iu_cp0_mtval_updt_vld;         
wire            iu_cp0_nmi_vld;                
wire            iu_cp0_nt_int_pending_vld;     
wire            iu_cp0_oper_mux_en;            
wire    [31:0]  iu_cp0_rs1;                    
wire            iu_cp0_syc_rst_b;              
wire            iu_yy_xx_dbgon;                
wire    [9 :0]  iu_yy_xx_expt_vec;             
wire            iu_yy_xx_flush;                
wire            iu_yy_xx_int_hv;               
wire    [7 :0]  iu_yy_xx_int_il;               
wire            iu_yy_xx_int_pending_hv;       
wire    [9 :0]  iu_yy_xx_int_pending_id;       
wire    [7 :0]  iu_yy_xx_int_pending_il;       
wire    [1 :0]  iu_yy_xx_int_pending_priv;     
wire            iui_lpmd_inst_lpmd_for_data;   
wire            iui_oreg_csr_acc;              
wire            iui_oreg_expt;                 
wire    [11:0]  iui_oreg_imm;                  
wire            iui_oreg_inst_csr;             
wire            iui_oreg_inst_mret;            
wire            iui_oreg_nmi_mret;             
wire            iui_oreg_rd_x0;                
wire    [31:0]  iui_oreg_rs1;                  
wire    [31:0]  iui_oreg_rs1_raw;              
wire            iui_oreg_rs1_x0;               
wire    [31:0]  iui_oreg_tval;                 
wire            lpmd_iui_stall;                
wire            lpmd_sm_clk;                   
wire            lpmd_sm_clk_en;                
wire    [31:0]  marchid_value;                 
wire    [31:0]  mcause_value;                  
wire    [31:0]  mclicbase_value;               
wire    [31:0]  mcpuid_value;                  
wire    [31:0]  mcycle_value;                  
wire    [31:0]  mcycleh_value;                 
wire    [31:0]  mepc_value;                    
wire            mexstatus_local_en;            
wire            mexstatus_sel;                 
wire    [31:0]  mexstatus_value;               
wire    [31:0]  mhartid_value;                 
wire    [31:0]  mhcr_value;                    
wire    [31:0]  mie_value;                     
wire    [31:0]  mimpid_value;                  
wire    [31:0]  minstret_value;                
wire    [31:0]  minstreth_value;               
wire    [31:0]  mintstatus_value;              
wire    [31:0]  mip_value;                     
wire    [31:0]  misa_value;                    
wire            mnmicause_local_en;            
wire    [31:0]  mnmicause_value;               
wire    [31:0]  mnmipc_value;                  
wire    [31:0]  mnxti_value;                   
wire            mnxti_vld_int_pending;         
wire    [31:0]  mraddr_value;                  
wire    [31:0]  mscratch_value;                
wire    [31:0]  mscratchcsw_value;             
wire    [31:0]  mscratchcswl_value;            
wire    [31:0]  mstatus_value;                 
wire    [31:0]  mtval_value;                   
wire    [31:0]  mtvec_value;                   
wire    [31:0]  mtvt_value;                    
wire    [31:0]  mvendorid_value;               
wire    [31:0]  mxstatus_value;                
wire            oreg_clk;                      
wire            oreg_clk_en;                   
wire    [1 :0]  oreg_iui_priv_mode;            
wire            oreg_iui_wr_rdonly;            
wire    [1 :0]  oreg_status_mode;              
wire            pad_yy_gate_clk_en_b;          
wire    [31:0]  pmp_cp0_data;                  
wire            psr_oreg_lpmd_sm_clk;          
wire            psr_oreg_lpmd_sm_clk_en;       
wire            randclk_psr_mod_en_w13;        
wire            srst_iui_stall;                
wire            srst_iui_stall_noinput;        
wire            srst_sm_clk;                   
wire            srst_sm_clk_en;                
wire    [1 :0]  status_lpmd_lpmd;              
wire            status_oreg_intr;              
wire    [7 :0]  status_oreg_mil;               
wire    [7 :0]  status_oreg_mpil;              
wire    [1 :0]  status_oreg_mpp;               
wire            status_oreg_mxstatus_t;        
wire    [1 :0]  status_oreg_pm;                
wire    [9 :0]  status_oreg_vector;            
wire            status_srst_req_valid;         
wire            status_srst_req_valid_noinput; 
wire    [1 :0]  status_srst_value;             
wire            status_xx_nmi;                 
wire            sysio_cp0_bigend;              
wire    [2 :0]  sysio_cp0_clkratio;            
wire            sysio_cp0_endian_v2;           
wire    [31:0]  sysio_cp0_rst_addr;            
wire    [1 :0]  sysio_cp0_sys_view_lpmd_b;     
wire    [31:0]  tcip_cp0_clic_base;            
wire            vector_cp0_vec_err;            
wire    [29:0]  vector_cp0_vec_err_epc;        
wire            vector_cp0_vec_succeed;        


//This gatecell is shared by psr, oreg and lpmd state machine
assign psr_oreg_lpmd_sm_clk_en = oreg_clk_en || lpmd_sm_clk_en || srst_sm_clk_en
                              || iu_cp0_nmi_vld || iu_cp0_lockup_vld;
// &Instance("gated_clk_cell", "x_psr_lpmd_gated_clk"); @32
gated_clk_cell  x_psr_lpmd_gated_clk (
  .clk_in                  (forever_cpuclk         ),
  .clk_out                 (psr_oreg_lpmd_sm_clk   ),
  .external_en             (1'b0                   ),
  .global_en               (cp0_yy_clk_en          ),
  .local_en                (psr_oreg_lpmd_sm_clk_en),
  .module_en               (randclk_psr_mod_en_w13 ),
  .pad_yy_gate_clk_en_b    (pad_yy_gate_clk_en_b   )
);

// &Connect(.clk_in      (forever_cpuclk), @33
//          .external_en (1'b0), @34
//          .global_en   (cp0_yy_clk_en), @35
//          .module_en   (randclk_psr_mod_en_w13), @36
//          .local_en    (psr_oreg_lpmd_sm_clk_en), @37
//          .clk_out     (psr_oreg_lpmd_sm_clk)); @38

assign oreg_clk    = psr_oreg_lpmd_sm_clk;
assign lpmd_sm_clk = psr_oreg_lpmd_sm_clk;
assign srst_sm_clk = psr_oreg_lpmd_sm_clk;
//assign psr_clk     = psr_oreg_lpmd_sm_clk;
// &Instance("gated_clk_cell", "x_status_reg_clk"); @45
// &Connect(.clk_in      (forever_cpuclk), @46
//          .external_en (1'b0), @47
//          .global_en   (cp0_yy_clk_en), @48
//          .module_en   (randclk_psr_mod_en_w13), @49
//          .local_en    (status_clk_en), @50
//          .clk_out     (status_clk)); @51


// &Instance("cr_cp0_iui", "x_cr_cp0_iui"); @55
cr_cp0_iui  x_cr_cp0_iui (
  .cp0_iu_data                    (cp0_iu_data                   ),
  .cp0_iu_data_vld                (cp0_iu_data_vld               ),
  .cp0_iu_dbg_disable_for_tee     (cp0_iu_dbg_disable_for_tee    ),
  .cp0_iu_expt_vec                (cp0_iu_expt_vec               ),
  .cp0_iu_expt_vld                (cp0_iu_expt_vld               ),
  .cp0_iu_flush                   (cp0_iu_flush                  ),
  .cp0_iu_flush_chgflw_vld        (cp0_iu_flush_chgflw_vld       ),
  .cp0_iu_inst_mret               (cp0_iu_inst_mret              ),
  .cp0_iu_req                     (cp0_iu_req                    ),
  .cp0_iu_rte_chgflw_vld          (cp0_iu_rte_chgflw_vld         ),
  .cp0_iu_rte_chgflw_vld_for_data (cp0_iu_rte_chgflw_vld_for_data),
  .cp0_iu_stall                   (cp0_iu_stall                  ),
  .cp0_iu_stall_noinput           (cp0_iu_stall_noinput          ),
  .inst_lpmd                      (inst_lpmd                     ),
  .iu_cp0_ex_csrrc                (iu_cp0_ex_csrrc               ),
  .iu_cp0_ex_csrrci               (iu_cp0_ex_csrrci              ),
  .iu_cp0_ex_csrrs                (iu_cp0_ex_csrrs               ),
  .iu_cp0_ex_csrrsi               (iu_cp0_ex_csrrsi              ),
  .iu_cp0_ex_csrrw                (iu_cp0_ex_csrrw               ),
  .iu_cp0_ex_csrrwi               (iu_cp0_ex_csrrwi              ),
  .iu_cp0_ex_data_sel             (iu_cp0_ex_data_sel            ),
  .iu_cp0_ex_func3                (iu_cp0_ex_func3               ),
  .iu_cp0_ex_mret                 (iu_cp0_ex_mret                ),
  .iu_cp0_ex_rd_reg               (iu_cp0_ex_rd_reg              ),
  .iu_cp0_ex_rs1_reg              (iu_cp0_ex_rs1_reg             ),
  .iu_cp0_ex_sel                  (iu_cp0_ex_sel                 ),
  .iu_cp0_ex_wfi                  (iu_cp0_ex_wfi                 ),
  .iu_cp0_imm                     (iu_cp0_imm                    ),
  .iu_cp0_oper_mux_en             (iu_cp0_oper_mux_en            ),
  .iu_cp0_rs1                     (iu_cp0_rs1                    ),
  .iu_cp0_syc_rst_b               (iu_cp0_syc_rst_b              ),
  .iu_yy_xx_dbgon                 (iu_yy_xx_dbgon                ),
  .iui_lpmd_inst_lpmd_for_data    (iui_lpmd_inst_lpmd_for_data   ),
  .iui_oreg_csr_acc               (iui_oreg_csr_acc              ),
  .iui_oreg_expt                  (iui_oreg_expt                 ),
  .iui_oreg_imm                   (iui_oreg_imm                  ),
  .iui_oreg_inst_csr              (iui_oreg_inst_csr             ),
  .iui_oreg_inst_mret             (iui_oreg_inst_mret            ),
  .iui_oreg_nmi_mret              (iui_oreg_nmi_mret             ),
  .iui_oreg_rd_x0                 (iui_oreg_rd_x0                ),
  .iui_oreg_rs1                   (iui_oreg_rs1                  ),
  .iui_oreg_rs1_raw               (iui_oreg_rs1_raw              ),
  .iui_oreg_rs1_x0                (iui_oreg_rs1_x0               ),
  .iui_oreg_tval                  (iui_oreg_tval                 ),
  .lpmd_iui_stall                 (lpmd_iui_stall                ),
  .marchid_value                  (marchid_value                 ),
  .mcause_value                   (mcause_value                  ),
  .mclicbase_value                (mclicbase_value               ),
  .mcpuid_value                   (mcpuid_value                  ),
  .mcycle_value                   (mcycle_value                  ),
  .mcycleh_value                  (mcycleh_value                 ),
  .mepc_value                     (mepc_value                    ),
  .mexstatus_value                (mexstatus_value               ),
  .mhartid_value                  (mhartid_value                 ),
  .mhcr_value                     (mhcr_value                    ),
  .mie_value                      (mie_value                     ),
  .mimpid_value                   (mimpid_value                  ),
  .minstret_value                 (minstret_value                ),
  .minstreth_value                (minstreth_value               ),
  .mintstatus_value               (mintstatus_value              ),
  .mip_value                      (mip_value                     ),
  .misa_value                     (misa_value                    ),
  .mnmicause_value                (mnmicause_value               ),
  .mnmipc_value                   (mnmipc_value                  ),
  .mnxti_value                    (mnxti_value                   ),
  .mraddr_value                   (mraddr_value                  ),
  .mscratch_value                 (mscratch_value                ),
  .mscratchcsw_value              (mscratchcsw_value             ),
  .mscratchcswl_value             (mscratchcswl_value            ),
  .mstatus_value                  (mstatus_value                 ),
  .mtval_value                    (mtval_value                   ),
  .mtvec_value                    (mtvec_value                   ),
  .mtvt_value                     (mtvt_value                    ),
  .mvendorid_value                (mvendorid_value               ),
  .mxstatus_value                 (mxstatus_value                ),
  .oreg_iui_priv_mode             (oreg_iui_priv_mode            ),
  .oreg_iui_wr_rdonly             (oreg_iui_wr_rdonly            ),
  .pmp_cp0_data                   (pmp_cp0_data                  ),
  .srst_iui_stall                 (srst_iui_stall                ),
  .srst_iui_stall_noinput         (srst_iui_stall_noinput        ),
  .status_xx_nmi                  (status_xx_nmi                 )
);


// &Instance("cr_cp0_oreg", "x_cr_cp0_oreg"); @57
cr_cp0_oreg  x_cr_cp0_oreg (
  .cp0_had_cpuid_idx0        (cp0_had_cpuid_idx0       ),
  .cp0_ifu_rst_inv_done      (cp0_ifu_rst_inv_done     ),
  .cp0_iu_cache_inv_done     (cp0_iu_cache_inv_done    ),
  .cp0_iu_epc_for_chgflw     (cp0_iu_epc_for_chgflw    ),
  .cp0_iu_meie               (cp0_iu_meie              ),
  .cp0_iu_vbr                (cp0_iu_vbr               ),
  .cp0_iu_vec_mode           (cp0_iu_vec_mode          ),
  .cp0_pmp_csr_sel           (cp0_pmp_csr_sel          ),
  .cp0_pmp_csr_wen           (cp0_pmp_csr_wen          ),
  .cp0_pmp_updt_data         (cp0_pmp_updt_data        ),
  .cp0_vector_vec_err_vbr    (cp0_vector_vec_err_vbr   ),
  .cp0_yy_be_v1              (cp0_yy_be_v1             ),
  .cp0_yy_be_v2              (cp0_yy_be_v2             ),
  .cpurst_b                  (cpurst_b                 ),
  .forever_cpuclk            (forever_cpuclk           ),
  .had_iu_force_dbg_en       (had_iu_force_dbg_en      ),
  .ifu_cp0_rst_inv_req       (ifu_cp0_rst_inv_req      ),
  .iu_cp0_ecall              (iu_cp0_ecall             ),
  .iu_cp0_epc                (iu_cp0_epc               ),
  .iu_cp0_epc_update         (iu_cp0_epc_update        ),
  .iu_cp0_ex_data_sel        (iu_cp0_ex_data_sel       ),
  .iu_cp0_ex_sel             (iu_cp0_ex_sel            ),
  .iu_cp0_expt_tval          (iu_cp0_expt_tval         ),
  .iu_cp0_expt_vld           (iu_cp0_expt_vld          ),
  .iu_cp0_int_vld            (iu_cp0_int_vld           ),
  .iu_cp0_lockup_clr         (iu_cp0_lockup_clr        ),
  .iu_cp0_lockup_vld         (iu_cp0_lockup_vld        ),
  .iu_cp0_mtval_updt_vld     (iu_cp0_mtval_updt_vld    ),
  .iu_cp0_nmi_vld            (iu_cp0_nmi_vld           ),
  .iu_cp0_nt_int_pending_vld (iu_cp0_nt_int_pending_vld),
  .iu_cp0_syc_rst_b          (iu_cp0_syc_rst_b         ),
  .iu_yy_xx_dbgon            (iu_yy_xx_dbgon           ),
  .iu_yy_xx_int_hv           (iu_yy_xx_int_hv          ),
  .iu_yy_xx_int_pending_hv   (iu_yy_xx_int_pending_hv  ),
  .iu_yy_xx_int_pending_id   (iu_yy_xx_int_pending_id  ),
  .iu_yy_xx_int_pending_il   (iu_yy_xx_int_pending_il  ),
  .iu_yy_xx_int_pending_priv (iu_yy_xx_int_pending_priv),
  .iui_oreg_csr_acc          (iui_oreg_csr_acc         ),
  .iui_oreg_expt             (iui_oreg_expt            ),
  .iui_oreg_imm              (iui_oreg_imm             ),
  .iui_oreg_inst_csr         (iui_oreg_inst_csr        ),
  .iui_oreg_inst_mret        (iui_oreg_inst_mret       ),
  .iui_oreg_nmi_mret         (iui_oreg_nmi_mret        ),
  .iui_oreg_rs1              (iui_oreg_rs1             ),
  .iui_oreg_rs1_raw          (iui_oreg_rs1_raw         ),
  .iui_oreg_tval             (iui_oreg_tval            ),
  .marchid_value             (marchid_value            ),
  .mclicbase_value           (mclicbase_value          ),
  .mcpuid_value              (mcpuid_value             ),
  .mcycle_value              (mcycle_value             ),
  .mcycleh_value             (mcycleh_value            ),
  .mepc_value                (mepc_value               ),
  .mexstatus_local_en        (mexstatus_local_en       ),
  .mexstatus_sel             (mexstatus_sel            ),
  .mhartid_value             (mhartid_value            ),
  .mhcr_value                (mhcr_value               ),
  .mie_value                 (mie_value                ),
  .mimpid_value              (mimpid_value             ),
  .minstret_value            (minstret_value           ),
  .minstreth_value           (minstreth_value          ),
  .mip_value                 (mip_value                ),
  .misa_value                (misa_value               ),
  .mnmicause_local_en        (mnmicause_local_en       ),
  .mnmipc_value              (mnmipc_value             ),
  .mnxti_value               (mnxti_value              ),
  .mnxti_vld_int_pending     (mnxti_vld_int_pending    ),
  .mraddr_value              (mraddr_value             ),
  .mscratch_value            (mscratch_value           ),
  .mscratchcsw_value         (mscratchcsw_value        ),
  .mscratchcswl_value        (mscratchcswl_value       ),
  .mtval_value               (mtval_value              ),
  .mtvec_value               (mtvec_value              ),
  .mtvt_value                (mtvt_value               ),
  .mvendorid_value           (mvendorid_value          ),
  .oreg_clk                  (oreg_clk                 ),
  .oreg_clk_en               (oreg_clk_en              ),
  .oreg_iui_priv_mode        (oreg_iui_priv_mode       ),
  .oreg_iui_wr_rdonly        (oreg_iui_wr_rdonly       ),
  .oreg_status_mode          (oreg_status_mode         ),
  .status_oreg_intr          (status_oreg_intr         ),
  .status_oreg_mil           (status_oreg_mil          ),
  .status_oreg_mpil          (status_oreg_mpil         ),
  .status_oreg_mpp           (status_oreg_mpp          ),
  .status_oreg_mxstatus_t    (status_oreg_mxstatus_t   ),
  .status_oreg_pm            (status_oreg_pm           ),
  .status_oreg_vector        (status_oreg_vector       ),
  .sysio_cp0_bigend          (sysio_cp0_bigend         ),
  .sysio_cp0_clkratio        (sysio_cp0_clkratio       ),
  .sysio_cp0_endian_v2       (sysio_cp0_endian_v2      ),
  .sysio_cp0_rst_addr        (sysio_cp0_rst_addr       ),
  .tcip_cp0_clic_base        (tcip_cp0_clic_base       ),
  .vector_cp0_vec_err        (vector_cp0_vec_err       ),
  .vector_cp0_vec_err_epc    (vector_cp0_vec_err_epc   ),
  .vector_cp0_vec_succeed    (vector_cp0_vec_succeed   )
);

// &Instance("cr_cp0_status_tee","x_cr_cp0_status"); @59
// &Instance("cr_cp0_status","x_cr_cp0_status"); @61
cr_cp0_status  x_cr_cp0_status (
  .clic_cpu_int_id               (clic_cpu_int_id              ),
  .cp0_had_int_exit              (cp0_had_int_exit             ),
  .cp0_had_mcause_data           (cp0_had_mcause_data          ),
  .cp0_iu_cskyisaee              (cp0_iu_cskyisaee             ),
  .cp0_iu_il                     (cp0_iu_il                    ),
  .cp0_iu_in_expt                (cp0_iu_in_expt               ),
  .cp0_iu_in_nmi                 (cp0_iu_in_nmi                ),
  .cp0_iu_mie_for_int            (cp0_iu_mie_for_int           ),
  .cp0_iu_mret                   (cp0_iu_mret                  ),
  .cp0_iu_wfe_en                 (cp0_iu_wfe_en                ),
  .cp0_pad_mcause                (cp0_pad_mcause               ),
  .cp0_pad_mintstatus            (cp0_pad_mintstatus           ),
  .cp0_pad_mstatus               (cp0_pad_mstatus              ),
  .cp0_pmp_mstatus_mpp           (cp0_pmp_mstatus_mpp          ),
  .cp0_pmp_mstatus_mprv          (cp0_pmp_mstatus_mprv         ),
  .cp0_yy_machine_mode_aft_dbg   (cp0_yy_machine_mode_aft_dbg  ),
  .cp0_yy_priv_mode              (cp0_yy_priv_mode             ),
  .cpu_clic_curid                (cpu_clic_curid               ),
  .cpu_clic_int_exit             (cpu_clic_int_exit            ),
  .cpurst_b                      (cpurst_b                     ),
  .iu_cp0_expt_vld               (iu_cp0_expt_vld              ),
  .iu_cp0_int_vld                (iu_cp0_int_vld               ),
  .iu_cp0_lockup_clr             (iu_cp0_lockup_clr            ),
  .iu_cp0_lockup_vld             (iu_cp0_lockup_vld            ),
  .iu_cp0_nmi_vld                (iu_cp0_nmi_vld               ),
  .iu_cp0_syc_rst_b              (iu_cp0_syc_rst_b             ),
  .iu_yy_xx_dbgon                (iu_yy_xx_dbgon               ),
  .iu_yy_xx_expt_vec             (iu_yy_xx_expt_vec            ),
  .iu_yy_xx_int_hv               (iu_yy_xx_int_hv              ),
  .iu_yy_xx_int_il               (iu_yy_xx_int_il              ),
  .iu_yy_xx_int_pending_id       (iu_yy_xx_int_pending_id      ),
  .iu_yy_xx_int_pending_il       (iu_yy_xx_int_pending_il      ),
  .iui_oreg_imm                  (iui_oreg_imm                 ),
  .iui_oreg_inst_csr             (iui_oreg_inst_csr            ),
  .iui_oreg_inst_mret            (iui_oreg_inst_mret           ),
  .iui_oreg_nmi_mret             (iui_oreg_nmi_mret            ),
  .iui_oreg_rd_x0                (iui_oreg_rd_x0               ),
  .iui_oreg_rs1                  (iui_oreg_rs1                 ),
  .iui_oreg_rs1_raw              (iui_oreg_rs1_raw             ),
  .iui_oreg_rs1_x0               (iui_oreg_rs1_x0              ),
  .mcause_value                  (mcause_value                 ),
  .mexstatus_local_en            (mexstatus_local_en           ),
  .mexstatus_sel                 (mexstatus_sel                ),
  .mexstatus_value               (mexstatus_value              ),
  .mintstatus_value              (mintstatus_value             ),
  .mnmicause_local_en            (mnmicause_local_en           ),
  .mnmicause_value               (mnmicause_value              ),
  .mnxti_vld_int_pending         (mnxti_vld_int_pending        ),
  .mstatus_value                 (mstatus_value                ),
  .mxstatus_value                (mxstatus_value               ),
  .oreg_clk                      (oreg_clk                     ),
  .oreg_iui_priv_mode            (oreg_iui_priv_mode           ),
  .oreg_status_mode              (oreg_status_mode             ),
  .status_lpmd_lpmd              (status_lpmd_lpmd             ),
  .status_oreg_intr              (status_oreg_intr             ),
  .status_oreg_mil               (status_oreg_mil              ),
  .status_oreg_mpil              (status_oreg_mpil             ),
  .status_oreg_mpp               (status_oreg_mpp              ),
  .status_oreg_mxstatus_t        (status_oreg_mxstatus_t       ),
  .status_oreg_pm                (status_oreg_pm               ),
  .status_oreg_vector            (status_oreg_vector           ),
  .status_srst_req_valid         (status_srst_req_valid        ),
  .status_srst_req_valid_noinput (status_srst_req_valid_noinput),
  .status_srst_value             (status_srst_value            ),
  .status_xx_nmi                 (status_xx_nmi                ),
  .vector_cp0_vec_succeed        (vector_cp0_vec_succeed       )
);

// &Instance("cr_cp0_lpmd", "x_cr_cp0_lpmd"); @63
cr_cp0_lpmd  x_cr_cp0_lpmd (
  .cache_cp0_lpmd_ack          (cache_cp0_lpmd_ack         ),
  .cp0_cache_lpmd_req          (cp0_cache_lpmd_req         ),
  .cp0_had_lpmd_b              (cp0_had_lpmd_b             ),
  .cp0_ifu_in_lpmd             (cp0_ifu_in_lpmd            ),
  .cp0_ifu_lpmd_req            (cp0_ifu_lpmd_req           ),
  .cp0_sysio_ipend_b           (cp0_sysio_ipend_b          ),
  .cp0_sysio_lpmd_b            (cp0_sysio_lpmd_b           ),
  .cp0_yy_clk_en               (cp0_yy_clk_en              ),
  .cpurst_b                    (cpurst_b                   ),
  .forever_cpuclk              (forever_cpuclk             ),
  .had_yy_xx_dbg               (had_yy_xx_dbg              ),
  .ifu_cp0_lpmd_ack            (ifu_cp0_lpmd_ack           ),
  .inst_lpmd                   (inst_lpmd                  ),
  .iu_cp0_ex_sel               (iu_cp0_ex_sel              ),
  .iu_cp0_lp_wk_int            (iu_cp0_lp_wk_int           ),
  .iu_yy_xx_dbgon              (iu_yy_xx_dbgon             ),
  .iu_yy_xx_flush              (iu_yy_xx_flush             ),
  .iui_lpmd_inst_lpmd_for_data (iui_lpmd_inst_lpmd_for_data),
  .lpmd_iui_stall              (lpmd_iui_stall             ),
  .lpmd_sm_clk                 (lpmd_sm_clk                ),
  .lpmd_sm_clk_en              (lpmd_sm_clk_en             ),
  .pad_yy_gate_clk_en_b        (pad_yy_gate_clk_en_b       ),
  .status_lpmd_lpmd            (status_lpmd_lpmd           ),
  .sysio_cp0_sys_view_lpmd_b   (sysio_cp0_sys_view_lpmd_b  )
);

// &Instance("cr_cp0_srst", "x_cr_cp0_srst"); @64
cr_cp0_srst  x_cr_cp0_srst (
  .cache_cp0_srst_ack            (cache_cp0_srst_ack           ),
  .cp0_cache_srst_req            (cp0_cache_srst_req           ),
  .cp0_ifu_srst_mask             (cp0_ifu_srst_mask            ),
  .cp0_ifu_srst_req              (cp0_ifu_srst_req             ),
  .cp0_sysio_srst                (cp0_sysio_srst               ),
  .cpurst_b                      (cpurst_b                     ),
  .ifu_cp0_srst_ack              (ifu_cp0_srst_ack             ),
  .iu_cp0_ex_sel                 (iu_cp0_ex_sel                ),
  .iu_yy_xx_flush                (iu_yy_xx_flush               ),
  .srst_iui_stall                (srst_iui_stall               ),
  .srst_iui_stall_noinput        (srst_iui_stall_noinput       ),
  .srst_sm_clk                   (srst_sm_clk                  ),
  .srst_sm_clk_en                (srst_sm_clk_en               ),
  .status_srst_req_valid         (status_srst_req_valid        ),
  .status_srst_req_valid_noinput (status_srst_req_valid_noinput),
  .status_srst_value             (status_srst_value            )
);

// &Force ("output","cp0_yy_clk_en"); @65
// //&Force ("output","cp0_yy_intsp_sel_post"); @66
//assign cp0_yy_intsp_sel_post = 1'b0;
// &Instance("cr_cp0_randclk", "x_cr_cp0_randclk"); @68
cr_cp0_randclk  x_cr_cp0_randclk (
  .randclk_psr_mod_en_w13 (randclk_psr_mod_en_w13)
);


// &ModuleEnd; @70
endmodule


