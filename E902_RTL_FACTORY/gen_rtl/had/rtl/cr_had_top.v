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
module cr_had_top(
  clk_en,
  cp0_had_cpuid_idx0,
  cp0_had_int_exit,
  cp0_had_lpmd_b,
  cp0_had_mcause_data,
  forever_cpuclk_nogated,
  had_core_dbg_mode_req,
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
  had_pad_jdb_pm,
  had_pad_jtg_tms_o,
  had_pad_jtg_tms_oe,
  had_tcipif_cmplt,
  had_tcipif_rdata,
  had_yy_xx_dbg,
  had_yy_xx_dp_index_mbee,
  had_yy_xx_exit_dbg,
  hadrst_b,
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
  iu_yy_xx_dbgon,
  lsu_had_addr,
  lsu_had_addr_vld,
  lsu_had_ex_cmplt,
  lsu_had_st,
  pad_had_jtg_tms_i,
  pad_yy_gate_clk_en_b,
  sysio_had_sdb_req_b,
  tcipif_had_addr,
  tcipif_had_sel,
  tcipif_had_wdata,
  tcipif_had_write,
  tclk,
  trst_b
);

// &Ports; @24
input           clk_en;                              
input   [31:0]  cp0_had_cpuid_idx0;                  
input           cp0_had_int_exit;                    
input   [1 :0]  cp0_had_lpmd_b;                      
input   [31:0]  cp0_had_mcause_data;                 
input           forever_cpuclk_nogated;              
input           hadrst_b;                            
input           ifu_had_chg_flw_inst;                
input           ifu_had_fetch_expt_vld;              
input           ifu_had_inst_dbg_disable;            
input   [31:0]  ifu_had_match_pc;                    
input           ifu_had_split_first;                 
input           iu_had_adr_dbg_ack;                  
input   [31:0]  iu_had_chgflw_dst_pc;                
input           iu_had_chgflw_vld;                   
input           iu_had_data_bkpt_occur_vld;          
input           iu_had_dbg_disable_for_tee;          
input           iu_had_dr_dbg_ack;                   
input           iu_had_expt_vld;                     
input           iu_had_fast_retire_acc_err_pc_update; 
input   [30:0]  iu_had_fast_retire_acc_err_pc_val;   
input           iu_had_flush;                        
input           iu_had_inst_bkpt_occur_vld;          
input           iu_had_int_ack;                      
input           iu_had_retire_with_had_int;          
input           iu_had_trace_occur_vld;              
input           iu_had_xx_bkpt_inst;                 
input   [31:0]  iu_had_xx_data;                      
input           iu_had_xx_data_vld;                  
input           iu_had_xx_dbg_ack;                   
input           iu_had_xx_mldst;                     
input           iu_had_xx_retire;                    
input           iu_had_xx_retire_normal;             
input   [31:0]  iu_had_xx_retire_pc;                 
input           iu_yy_xx_dbgon;                      
input   [31:0]  lsu_had_addr;                        
input           lsu_had_addr_vld;                    
input           lsu_had_ex_cmplt;                    
input           lsu_had_st;                          
input           pad_had_jtg_tms_i;                   
input           pad_yy_gate_clk_en_b;                
input           sysio_had_sdb_req_b;                 
input   [15:0]  tcipif_had_addr;                     
input           tcipif_had_sel;                      
input   [31:0]  tcipif_had_wdata;                    
input           tcipif_had_write;                    
input           tclk;                                
input           trst_b;                              
output          had_core_dbg_mode_req;               
output  [31:0]  had_idu_wbbr_data;                   
output          had_idu_wbbr_vld;                    
output          had_ifu_inst_bkpt_dbq_req;           
output          had_ifu_inst_bkpt_dbqexp_req;        
output  [31:0]  had_ifu_ir;                          
output          had_ifu_ir_vld;                      
output          had_iu_bkpt_trace_en;                
output          had_iu_dr_set_req;                   
output          had_iu_force_dbg_en;                 
output          had_iu_int_vld;                      
output          had_iu_mbkpt_fsm_index_mbee;         
output          had_iu_mem_bkpt_exp_req;             
output          had_iu_mem_bkpt_mask;                
output          had_iu_mem_bkpt_req;                 
output  [30:0]  had_iu_pc;                           
output          had_iu_rte_pc_sel;                   
output          had_iu_trace_req;                    
output          had_iu_trace_req_for_dbg_disable;    
output          had_iu_xx_fdb;                       
output          had_iu_xx_jdbreq;                    
output  [1 :0]  had_pad_jdb_pm;                      
output          had_pad_jtg_tms_o;                   
output          had_pad_jtg_tms_oe;                  
output          had_tcipif_cmplt;                    
output  [31:0]  had_tcipif_rdata;                    
output          had_yy_xx_dbg;                       
output          had_yy_xx_dp_index_mbee;             
output          had_yy_xx_exit_dbg;                  

// &Regs; @25

// &Wires; @26
wire            bkpta_ctrl_inst_fetch_dbq_req;       
wire            bkpta_ctrl_req;                      
wire            bkptb_ctrl_inst_fetch_dbq_req;       
wire            bkptb_ctrl_req;                      
wire            bkptc_ctrl_inst_fetch_dbq_req;       
wire            bkptc_ctrl_req;                      
wire            bkptd_ctrl_inst_fetch_dbq_req;       
wire            bkptd_ctrl_req;                      
wire            bkpte_ctrl_inst_fetch_dbq_req;       
wire            bkpte_ctrl_req;                      
wire            clk_en;                              
wire    [31:0]  cp0_had_cpuid_idx0;                  
wire            cp0_had_int_exit;                    
wire    [1 :0]  cp0_had_lpmd_b;                      
wire    [31:0]  cp0_had_mcause_data;                 
wire            cpuclk;                              
wire            ctrl_regs_exit_dbg;                  
wire            ctrl_regs_update_adro;               
wire            ctrl_regs_update_dro;                
wire            ctrl_regs_update_mbo;                
wire            ctrl_regs_update_swo;                
wire            ctrl_regs_update_to;                 
wire            ddc_regs_ffy;                        
wire    [31:0]  ddc_regs_ir;                         
wire            ddc_regs_update_csr;                 
wire            ddc_regs_update_ir;                  
wire            forever_cpuclk_nogated;              
wire            had_clk_en;                          
wire            had_core_dbg_mode_req;               
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
wire    [1 :0]  had_pad_jdb_pm;                      
wire            had_pad_jtg_tms_o;                   
wire            had_pad_jtg_tms_oe;                  
wire            had_tcipif_cmplt;                    
wire    [31:0]  had_tcipif_rdata;                    
wire            had_yy_xx_dbg;                       
wire            had_yy_xx_dp_index_mbee;             
wire            had_yy_xx_exit_dbg;                  
wire            hadrst_b;                            
wire            ifu_had_chg_flw_inst;                
wire            ifu_had_fetch_expt_vld;              
wire            ifu_had_inst_dbg_disable;            
wire    [31:0]  ifu_had_match_pc;                    
wire            ifu_had_split_first;                 
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
wire            iu_yy_xx_dbgon;                      
wire            jtag2_pin_tms_o;                     
wire            jtag2_pin_tms_oe;                    
wire            jtag_regs_srst;                      
wire            jtag_regs_update_hacr;               
wire            jtag_xx_capture_dr;                  
wire            jtag_xx_capture_dr_mask;             
wire    [31:0]  jtag_xx_data;                        
wire            jtag_xx_update_dr;                   
wire    [31:0]  lsu_had_addr;                        
wire            lsu_had_addr_vld;                    
wire            lsu_had_ex_cmplt;                    
wire            lsu_had_st;                          
wire            pad_had_jtg_tms_i;                   
wire            pad_yy_gate_clk_en_b;                
wire            pin_ctrl_jdb_req;                    
wire            pin_sm_tap_en;                       
wire            pin_xx_tms_i;                        
wire    [31:0]  regs_bkpta_base;                     
wire            regs_bkpta_bkpti_en;                 
wire    [2 :0]  regs_bkpta_ctrl;                     
wire    [7 :0]  regs_bkpta_mask;                     
wire    [31:0]  regs_bkptb_base;                     
wire    [2 :0]  regs_bkptb_ctrl;                     
wire    [7 :0]  regs_bkptb_mask;                     
wire    [31:0]  regs_bkptc_base;                     
wire            regs_bkptc_en;                       
wire    [31:0]  regs_bkptd_base;                     
wire            regs_bkptd_en;                       
wire    [31:0]  regs_bkpte_base;                     
wire            regs_bkpte_en;                       
wire            regs_ctrl_adr;                       
wire            regs_ctrl_dr;                        
wire            regs_ctrl_exit_sel;                  
wire            regs_ctrl_hacr_ex;                   
wire            regs_ctrl_hacr_go;                   
wire            regs_ctrl_had_int_on;                
wire    [8 :0]  regs_ctrl_mbee;                      
wire            regs_ddc_daddr_sel;                  
wire            regs_ddc_ddata_sel;                  
wire    [31:0]  regs_jtag_data;                      
wire            regs_jtag_hacr_rw;                   
wire            regs_jtag_reg16_sel;                 
wire            regs_jtag_reg8_sel;                  
wire    [1 :0]  regs_pin_pm;                         
wire            regs_trace_en;                       
wire            regs_xx_ddc_en;                      
wire            sm_xx_tap_on;                        
wire            sysio_had_sdb_req_b;                 
wire    [15:0]  tcipif_had_addr;                     
wire            tcipif_had_sel;                      
wire    [31:0]  tcipif_had_wdata;                    
wire            tcipif_had_write;                    
wire            tclk;                                
wire            trace_ctrl_req;                      
wire            trace_ctrl_req_for_dbg_disable;      
wire            trst_b;                              


// &Instance("gated_clk_cell", "x_cr_had_gated_clk"); @28
gated_clk_cell  x_cr_had_gated_clk (
  .clk_in                 (forever_cpuclk_nogated),
  .clk_out                (cpuclk                ),
  .external_en            (1'b0                  ),
  .global_en              (1'b1                  ),
  .local_en               (1'b0                  ),
  .module_en              (had_clk_en            ),
  .pad_yy_gate_clk_en_b   (pad_yy_gate_clk_en_b  )
);

// &Connect(.clk_in             (forever_cpuclk_nogated), @29
//          .clk_out            (cpuclk), @30
//          .external_en        (1'b0), @31
//          .global_en          (1'b1), @32
//          .local_en           (1'b0), @33
//          .module_en          (had_clk_en) @34
//         ); @35
assign had_clk_en = sm_xx_tap_on || tcipif_had_sel;

// &ConnRule("s/bkpt/bkpta/"); @42
// &Instance("cr_had_bkpt", "x_cr_had_bkpta"); @43
cr_had_bkpt  x_cr_had_bkpta (
  .bkpt_ctrl_inst_fetch_dbq_req  (bkpta_ctrl_inst_fetch_dbq_req),
  .bkpt_ctrl_req                 (bkpta_ctrl_req               ),
  .cpuclk                        (cpuclk                       ),
  .had_core_dbg_mode_req         (had_core_dbg_mode_req        ),
  .hadrst_b                      (hadrst_b                     ),
  .ifu_had_chg_flw_inst          (ifu_had_chg_flw_inst         ),
  .ifu_had_fetch_expt_vld        (ifu_had_fetch_expt_vld       ),
  .ifu_had_inst_dbg_disable      (ifu_had_inst_dbg_disable     ),
  .ifu_had_match_pc              (ifu_had_match_pc             ),
  .ifu_had_split_first           (ifu_had_split_first          ),
  .iu_had_expt_vld               (iu_had_expt_vld              ),
  .iu_had_flush                  (iu_had_flush                 ),
  .iu_had_xx_mldst               (iu_had_xx_mldst              ),
  .iu_had_xx_retire              (iu_had_xx_retire             ),
  .iu_had_xx_retire_normal       (iu_had_xx_retire_normal      ),
  .iu_yy_xx_dbgon                (iu_yy_xx_dbgon               ),
  .lsu_had_addr                  (lsu_had_addr                 ),
  .lsu_had_addr_vld              (lsu_had_addr_vld             ),
  .lsu_had_ex_cmplt              (lsu_had_ex_cmplt             ),
  .lsu_had_st                    (lsu_had_st                   ),
  .regs_bkpt_base                (regs_bkpta_base              ),
  .regs_bkpt_ctrl                (regs_bkpta_ctrl              ),
  .regs_bkpt_mask                (regs_bkpta_mask              )
);


// &ConnRule("s/bkpt/bkptb/"); @46
// &Instance("cr_had_bkpt", "x_cr_had_bkptb"); @47
cr_had_bkpt  x_cr_had_bkptb (
  .bkpt_ctrl_inst_fetch_dbq_req  (bkptb_ctrl_inst_fetch_dbq_req),
  .bkpt_ctrl_req                 (bkptb_ctrl_req               ),
  .cpuclk                        (cpuclk                       ),
  .had_core_dbg_mode_req         (had_core_dbg_mode_req        ),
  .hadrst_b                      (hadrst_b                     ),
  .ifu_had_chg_flw_inst          (ifu_had_chg_flw_inst         ),
  .ifu_had_fetch_expt_vld        (ifu_had_fetch_expt_vld       ),
  .ifu_had_inst_dbg_disable      (ifu_had_inst_dbg_disable     ),
  .ifu_had_match_pc              (ifu_had_match_pc             ),
  .ifu_had_split_first           (ifu_had_split_first          ),
  .iu_had_expt_vld               (iu_had_expt_vld              ),
  .iu_had_flush                  (iu_had_flush                 ),
  .iu_had_xx_mldst               (iu_had_xx_mldst              ),
  .iu_had_xx_retire              (iu_had_xx_retire             ),
  .iu_had_xx_retire_normal       (iu_had_xx_retire_normal      ),
  .iu_yy_xx_dbgon                (iu_yy_xx_dbgon               ),
  .lsu_had_addr                  (lsu_had_addr                 ),
  .lsu_had_addr_vld              (lsu_had_addr_vld             ),
  .lsu_had_ex_cmplt              (lsu_had_ex_cmplt             ),
  .lsu_had_st                    (lsu_had_st                   ),
  .regs_bkpt_base                (regs_bkptb_base              ),
  .regs_bkpt_ctrl                (regs_bkptb_ctrl              ),
  .regs_bkpt_mask                (regs_bkptb_mask              )
);


// &ConnRule("s/bkpt/bkptc/"); @49
// &Instance("cr_had_inst_bkpt_lite", "x_cr_had_bkptc"); @50
cr_had_inst_bkpt_lite  x_cr_had_bkptc (
  .bkpt_ctrl_inst_fetch_dbq_req  (bkptc_ctrl_inst_fetch_dbq_req),
  .bkpt_ctrl_req                 (bkptc_ctrl_req               ),
  .had_core_dbg_mode_req         (had_core_dbg_mode_req        ),
  .ifu_had_fetch_expt_vld        (ifu_had_fetch_expt_vld       ),
  .ifu_had_inst_dbg_disable      (ifu_had_inst_dbg_disable     ),
  .ifu_had_match_pc              (ifu_had_match_pc             ),
  .ifu_had_split_first           (ifu_had_split_first          ),
  .iu_yy_xx_dbgon                (iu_yy_xx_dbgon               ),
  .regs_bkpt_base                (regs_bkptc_base              ),
  .regs_bkpt_en                  (regs_bkptc_en                )
);


// &ConnRule("s/bkpt/bkptd/"); @52
// &Instance("cr_had_inst_bkpt_lite", "x_cr_had_bkptd"); @53
cr_had_inst_bkpt_lite  x_cr_had_bkptd (
  .bkpt_ctrl_inst_fetch_dbq_req  (bkptd_ctrl_inst_fetch_dbq_req),
  .bkpt_ctrl_req                 (bkptd_ctrl_req               ),
  .had_core_dbg_mode_req         (had_core_dbg_mode_req        ),
  .ifu_had_fetch_expt_vld        (ifu_had_fetch_expt_vld       ),
  .ifu_had_inst_dbg_disable      (ifu_had_inst_dbg_disable     ),
  .ifu_had_match_pc              (ifu_had_match_pc             ),
  .ifu_had_split_first           (ifu_had_split_first          ),
  .iu_yy_xx_dbgon                (iu_yy_xx_dbgon               ),
  .regs_bkpt_base                (regs_bkptd_base              ),
  .regs_bkpt_en                  (regs_bkptd_en                )
);


// &ConnRule("s/bkpt/bkpte/"); @55
// &Instance("cr_had_inst_bkpt_lite", "x_cr_had_bkpte"); @56
cr_had_inst_bkpt_lite  x_cr_had_bkpte (
  .bkpt_ctrl_inst_fetch_dbq_req  (bkpte_ctrl_inst_fetch_dbq_req),
  .bkpt_ctrl_req                 (bkpte_ctrl_req               ),
  .had_core_dbg_mode_req         (had_core_dbg_mode_req        ),
  .ifu_had_fetch_expt_vld        (ifu_had_fetch_expt_vld       ),
  .ifu_had_inst_dbg_disable      (ifu_had_inst_dbg_disable     ),
  .ifu_had_match_pc              (ifu_had_match_pc             ),
  .ifu_had_split_first           (ifu_had_split_first          ),
  .iu_yy_xx_dbgon                (iu_yy_xx_dbgon               ),
  .regs_bkpt_base                (regs_bkpte_base              ),
  .regs_bkpt_en                  (regs_bkpte_en                )
);


// &ConnRule("s/bkpt/bkptf/"); @60
// &Instance("cr_had_inst_bkpt_lite", "x_cr_had_bkptf"); @61
// &ConnRule("s/bkpt/bkptg/"); @63
// &Instance("cr_had_inst_bkpt_lite", "x_cr_had_bkptg"); @64

// &ConnRule("s/bkpt/bkptf/"); @68
// &Instance("cr_had_inst_bkpt_lite", "x_cr_had_bkptf"); @69
// &ConnRule("s/bkpt/bkptg/"); @71
// &Instance("cr_had_inst_bkpt_lite", "x_cr_had_bkptg"); @72
// &ConnRule("s/bkpt/bkpth/"); @74
// &Instance("cr_had_inst_bkpt_lite", "x_cr_had_bkpth"); @75
// &ConnRule("s/bkpt/bkpti/"); @77
// &Instance("cr_had_inst_bkpt_lite", "x_cr_had_bkpti"); @78

// &Instance("cr_had_ctrl"); @81
cr_had_ctrl  x_cr_had_ctrl (
  .bkpta_ctrl_inst_fetch_dbq_req    (bkpta_ctrl_inst_fetch_dbq_req   ),
  .bkpta_ctrl_req                   (bkpta_ctrl_req                  ),
  .bkptb_ctrl_inst_fetch_dbq_req    (bkptb_ctrl_inst_fetch_dbq_req   ),
  .bkptb_ctrl_req                   (bkptb_ctrl_req                  ),
  .bkptc_ctrl_inst_fetch_dbq_req    (bkptc_ctrl_inst_fetch_dbq_req   ),
  .bkptc_ctrl_req                   (bkptc_ctrl_req                  ),
  .bkptd_ctrl_inst_fetch_dbq_req    (bkptd_ctrl_inst_fetch_dbq_req   ),
  .bkptd_ctrl_req                   (bkptd_ctrl_req                  ),
  .bkpte_ctrl_inst_fetch_dbq_req    (bkpte_ctrl_inst_fetch_dbq_req   ),
  .bkpte_ctrl_req                   (bkpte_ctrl_req                  ),
  .cpuclk                           (cpuclk                          ),
  .ctrl_regs_exit_dbg               (ctrl_regs_exit_dbg              ),
  .ctrl_regs_update_adro            (ctrl_regs_update_adro           ),
  .ctrl_regs_update_dro             (ctrl_regs_update_dro            ),
  .ctrl_regs_update_mbo             (ctrl_regs_update_mbo            ),
  .ctrl_regs_update_swo             (ctrl_regs_update_swo            ),
  .ctrl_regs_update_to              (ctrl_regs_update_to             ),
  .had_ifu_inst_bkpt_dbq_req        (had_ifu_inst_bkpt_dbq_req       ),
  .had_ifu_inst_bkpt_dbqexp_req     (had_ifu_inst_bkpt_dbqexp_req    ),
  .had_iu_bkpt_trace_en             (had_iu_bkpt_trace_en            ),
  .had_iu_dr_set_req                (had_iu_dr_set_req               ),
  .had_iu_mbkpt_fsm_index_mbee      (had_iu_mbkpt_fsm_index_mbee     ),
  .had_iu_mem_bkpt_exp_req          (had_iu_mem_bkpt_exp_req         ),
  .had_iu_mem_bkpt_mask             (had_iu_mem_bkpt_mask            ),
  .had_iu_mem_bkpt_req              (had_iu_mem_bkpt_req             ),
  .had_iu_trace_req                 (had_iu_trace_req                ),
  .had_iu_trace_req_for_dbg_disable (had_iu_trace_req_for_dbg_disable),
  .had_iu_xx_jdbreq                 (had_iu_xx_jdbreq                ),
  .had_yy_xx_dbg                    (had_yy_xx_dbg                   ),
  .had_yy_xx_dp_index_mbee          (had_yy_xx_dp_index_mbee         ),
  .had_yy_xx_exit_dbg               (had_yy_xx_exit_dbg              ),
  .hadrst_b                         (hadrst_b                        ),
  .iu_had_adr_dbg_ack               (iu_had_adr_dbg_ack              ),
  .iu_had_chgflw_dst_pc             (iu_had_chgflw_dst_pc            ),
  .iu_had_chgflw_vld                (iu_had_chgflw_vld               ),
  .iu_had_data_bkpt_occur_vld       (iu_had_data_bkpt_occur_vld      ),
  .iu_had_dbg_disable_for_tee       (iu_had_dbg_disable_for_tee      ),
  .iu_had_dr_dbg_ack                (iu_had_dr_dbg_ack               ),
  .iu_had_inst_bkpt_occur_vld       (iu_had_inst_bkpt_occur_vld      ),
  .iu_had_trace_occur_vld           (iu_had_trace_occur_vld          ),
  .iu_had_xx_bkpt_inst              (iu_had_xx_bkpt_inst             ),
  .iu_yy_xx_dbgon                   (iu_yy_xx_dbgon                  ),
  .jtag_xx_update_dr                (jtag_xx_update_dr               ),
  .pin_ctrl_jdb_req                 (pin_ctrl_jdb_req                ),
  .regs_bkpta_bkpti_en              (regs_bkpta_bkpti_en             ),
  .regs_ctrl_adr                    (regs_ctrl_adr                   ),
  .regs_ctrl_dr                     (regs_ctrl_dr                    ),
  .regs_ctrl_exit_sel               (regs_ctrl_exit_sel              ),
  .regs_ctrl_hacr_ex                (regs_ctrl_hacr_ex               ),
  .regs_ctrl_hacr_go                (regs_ctrl_hacr_go               ),
  .regs_ctrl_had_int_on             (regs_ctrl_had_int_on            ),
  .regs_ctrl_mbee                   (regs_ctrl_mbee                  ),
  .regs_trace_en                    (regs_trace_en                   ),
  .sysio_had_sdb_req_b              (sysio_had_sdb_req_b             ),
  .trace_ctrl_req                   (trace_ctrl_req                  ),
  .trace_ctrl_req_for_dbg_disable   (trace_ctrl_req_for_dbg_disable  )
);


// &Instance("cr_had_ddc"); @83
cr_had_ddc  x_cr_had_ddc (
  .cpuclk              (cpuclk             ),
  .ddc_regs_ffy        (ddc_regs_ffy       ),
  .ddc_regs_ir         (ddc_regs_ir        ),
  .ddc_regs_update_csr (ddc_regs_update_csr),
  .ddc_regs_update_ir  (ddc_regs_update_ir ),
  .hadrst_b            (hadrst_b           ),
  .iu_had_xx_retire    (iu_had_xx_retire   ),
  .jtag_xx_update_dr   (jtag_xx_update_dr  ),
  .regs_ddc_daddr_sel  (regs_ddc_daddr_sel ),
  .regs_ddc_ddata_sel  (regs_ddc_ddata_sel ),
  .regs_xx_ddc_en      (regs_xx_ddc_en     )
);


// &Instance("cr_had_pin"); @85
cr_had_pin  x_cr_had_pin (
  .clk_en             (clk_en            ),
  .cpuclk             (cpuclk            ),
  .had_pad_jdb_pm     (had_pad_jdb_pm    ),
  .had_pad_jtg_tms_o  (had_pad_jtg_tms_o ),
  .had_pad_jtg_tms_oe (had_pad_jtg_tms_oe),
  .hadrst_b           (hadrst_b          ),
  .iu_yy_xx_dbgon     (iu_yy_xx_dbgon    ),
  .jtag2_pin_tms_o    (jtag2_pin_tms_o   ),
  .jtag2_pin_tms_oe   (jtag2_pin_tms_oe  ),
  .pad_had_jtg_tms_i  (pad_had_jtg_tms_i ),
  .pin_ctrl_jdb_req   (pin_ctrl_jdb_req  ),
  .pin_sm_tap_en      (pin_sm_tap_en     ),
  .pin_xx_tms_i       (pin_xx_tms_i      ),
  .regs_pin_pm        (regs_pin_pm       ),
  .tclk               (tclk              ),
  .trst_b             (trst_b            )
);


// &Instance("cr_had_regs"); @87
cr_had_regs  x_cr_had_regs (
  .cp0_had_cpuid_idx0                   (cp0_had_cpuid_idx0                  ),
  .cp0_had_int_exit                     (cp0_had_int_exit                    ),
  .cp0_had_lpmd_b                       (cp0_had_lpmd_b                      ),
  .cp0_had_mcause_data                  (cp0_had_mcause_data                 ),
  .cpuclk                               (cpuclk                              ),
  .ctrl_regs_exit_dbg                   (ctrl_regs_exit_dbg                  ),
  .ctrl_regs_update_adro                (ctrl_regs_update_adro               ),
  .ctrl_regs_update_dro                 (ctrl_regs_update_dro                ),
  .ctrl_regs_update_mbo                 (ctrl_regs_update_mbo                ),
  .ctrl_regs_update_swo                 (ctrl_regs_update_swo                ),
  .ctrl_regs_update_to                  (ctrl_regs_update_to                 ),
  .ddc_regs_ffy                         (ddc_regs_ffy                        ),
  .ddc_regs_ir                          (ddc_regs_ir                         ),
  .ddc_regs_update_csr                  (ddc_regs_update_csr                 ),
  .ddc_regs_update_ir                   (ddc_regs_update_ir                  ),
  .had_core_dbg_mode_req                (had_core_dbg_mode_req               ),
  .had_idu_wbbr_data                    (had_idu_wbbr_data                   ),
  .had_idu_wbbr_vld                     (had_idu_wbbr_vld                    ),
  .had_ifu_ir                           (had_ifu_ir                          ),
  .had_ifu_ir_vld                       (had_ifu_ir_vld                      ),
  .had_iu_force_dbg_en                  (had_iu_force_dbg_en                 ),
  .had_iu_int_vld                       (had_iu_int_vld                      ),
  .had_iu_pc                            (had_iu_pc                           ),
  .had_iu_rte_pc_sel                    (had_iu_rte_pc_sel                   ),
  .had_iu_xx_fdb                        (had_iu_xx_fdb                       ),
  .had_tcipif_cmplt                     (had_tcipif_cmplt                    ),
  .had_tcipif_rdata                     (had_tcipif_rdata                    ),
  .hadrst_b                             (hadrst_b                            ),
  .iu_had_fast_retire_acc_err_pc_update (iu_had_fast_retire_acc_err_pc_update),
  .iu_had_fast_retire_acc_err_pc_val    (iu_had_fast_retire_acc_err_pc_val   ),
  .iu_had_int_ack                       (iu_had_int_ack                      ),
  .iu_had_retire_with_had_int           (iu_had_retire_with_had_int          ),
  .iu_had_xx_data                       (iu_had_xx_data                      ),
  .iu_had_xx_data_vld                   (iu_had_xx_data_vld                  ),
  .iu_had_xx_dbg_ack                    (iu_had_xx_dbg_ack                   ),
  .iu_had_xx_retire_pc                  (iu_had_xx_retire_pc                 ),
  .iu_yy_xx_dbgon                       (iu_yy_xx_dbgon                      ),
  .jtag_regs_srst                       (jtag_regs_srst                      ),
  .jtag_regs_update_hacr                (jtag_regs_update_hacr               ),
  .jtag_xx_capture_dr                   (jtag_xx_capture_dr                  ),
  .jtag_xx_capture_dr_mask              (jtag_xx_capture_dr_mask             ),
  .jtag_xx_data                         (jtag_xx_data                        ),
  .jtag_xx_update_dr                    (jtag_xx_update_dr                   ),
  .regs_bkpta_base                      (regs_bkpta_base                     ),
  .regs_bkpta_bkpti_en                  (regs_bkpta_bkpti_en                 ),
  .regs_bkpta_ctrl                      (regs_bkpta_ctrl                     ),
  .regs_bkpta_mask                      (regs_bkpta_mask                     ),
  .regs_bkptb_base                      (regs_bkptb_base                     ),
  .regs_bkptb_ctrl                      (regs_bkptb_ctrl                     ),
  .regs_bkptb_mask                      (regs_bkptb_mask                     ),
  .regs_bkptc_base                      (regs_bkptc_base                     ),
  .regs_bkptc_en                        (regs_bkptc_en                       ),
  .regs_bkptd_base                      (regs_bkptd_base                     ),
  .regs_bkptd_en                        (regs_bkptd_en                       ),
  .regs_bkpte_base                      (regs_bkpte_base                     ),
  .regs_bkpte_en                        (regs_bkpte_en                       ),
  .regs_ctrl_adr                        (regs_ctrl_adr                       ),
  .regs_ctrl_dr                         (regs_ctrl_dr                        ),
  .regs_ctrl_exit_sel                   (regs_ctrl_exit_sel                  ),
  .regs_ctrl_hacr_ex                    (regs_ctrl_hacr_ex                   ),
  .regs_ctrl_hacr_go                    (regs_ctrl_hacr_go                   ),
  .regs_ctrl_had_int_on                 (regs_ctrl_had_int_on                ),
  .regs_ctrl_mbee                       (regs_ctrl_mbee                      ),
  .regs_ddc_daddr_sel                   (regs_ddc_daddr_sel                  ),
  .regs_ddc_ddata_sel                   (regs_ddc_ddata_sel                  ),
  .regs_jtag_data                       (regs_jtag_data                      ),
  .regs_jtag_hacr_rw                    (regs_jtag_hacr_rw                   ),
  .regs_jtag_reg16_sel                  (regs_jtag_reg16_sel                 ),
  .regs_jtag_reg8_sel                   (regs_jtag_reg8_sel                  ),
  .regs_pin_pm                          (regs_pin_pm                         ),
  .regs_trace_en                        (regs_trace_en                       ),
  .regs_xx_ddc_en                       (regs_xx_ddc_en                      ),
  .tcipif_had_addr                      (tcipif_had_addr                     ),
  .tcipif_had_sel                       (tcipif_had_sel                      ),
  .tcipif_had_wdata                     (tcipif_had_wdata                    ),
  .tcipif_had_write                     (tcipif_had_write                    )
);

// &Force("output","had_core_dbg_mode_req"); @88

// &Instance("cr_had_jtag2"); @91
cr_had_jtag2  x_cr_had_jtag2 (
  .cpuclk                  (cpuclk                 ),
  .hadrst_b                (hadrst_b               ),
  .jtag2_pin_tms_o         (jtag2_pin_tms_o        ),
  .jtag2_pin_tms_oe        (jtag2_pin_tms_oe       ),
  .jtag_regs_srst          (jtag_regs_srst         ),
  .jtag_regs_update_hacr   (jtag_regs_update_hacr  ),
  .jtag_xx_capture_dr      (jtag_xx_capture_dr     ),
  .jtag_xx_capture_dr_mask (jtag_xx_capture_dr_mask),
  .jtag_xx_data            (jtag_xx_data           ),
  .jtag_xx_update_dr       (jtag_xx_update_dr      ),
  .pin_sm_tap_en           (pin_sm_tap_en          ),
  .pin_xx_tms_i            (pin_xx_tms_i           ),
  .regs_jtag_data          (regs_jtag_data         ),
  .regs_jtag_hacr_rw       (regs_jtag_hacr_rw      ),
  .regs_jtag_reg16_sel     (regs_jtag_reg16_sel    ),
  .regs_jtag_reg8_sel      (regs_jtag_reg8_sel     ),
  .sm_xx_tap_on            (sm_xx_tap_on           ),
  .tclk                    (tclk                   ),
  .trst_b                  (trst_b                 )
);

// &Instance("cr_had_jtag5"); @93

// &Instance("cr_had_trace"); @96
cr_had_trace  x_cr_had_trace (
  .had_core_dbg_mode_req          (had_core_dbg_mode_req         ),
  .iu_had_xx_mldst                (iu_had_xx_mldst               ),
  .iu_had_xx_retire               (iu_had_xx_retire              ),
  .iu_had_xx_retire_normal        (iu_had_xx_retire_normal       ),
  .iu_yy_xx_dbgon                 (iu_yy_xx_dbgon                ),
  .regs_trace_en                  (regs_trace_en                 ),
  .trace_ctrl_req                 (trace_ctrl_req                ),
  .trace_ctrl_req_for_dbg_disable (trace_ctrl_req_for_dbg_disable)
);

// &Instance("cr_had_pcfifo"); @98
// &ModuleEnd; @100
endmodule



