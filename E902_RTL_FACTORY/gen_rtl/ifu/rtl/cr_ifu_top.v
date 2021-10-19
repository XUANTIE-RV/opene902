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
module cr_ifu_top(
  bmu_xx_ibus_acc_err,
  bmu_xx_ibus_data,
  bmu_xx_ibus_grnt,
  bmu_xx_ibus_trans_cmplt,
  cp0_ifu_in_lpmd,
  cp0_ifu_lpmd_req,
  cp0_ifu_rst_inv_done,
  cp0_ifu_srst_mask,
  cp0_ifu_srst_req,
  cp0_yy_clk_en,
  cp0_yy_machine_mode_aft_dbg,
  cpurst_b,
  forever_cpuclk,
  had_core_dbg_mode_req,
  had_ifu_inst_bkpt_dbq_req,
  had_ifu_inst_bkpt_dbqexp_req,
  had_ifu_ir,
  had_ifu_ir_vld,
  had_yy_xx_dp_index_mbee,
  ifu_bmu_addr,
  ifu_bmu_idle,
  ifu_bmu_prot,
  ifu_bmu_req,
  ifu_bmu_wfd1,
  ifu_cp0_lpmd_ack,
  ifu_cp0_rst_inv_req,
  ifu_cp0_srst_ack,
  ifu_had_fetch_expt_vld,
  ifu_had_inst_dbg_disable,
  ifu_had_split_first,
  ifu_iu_ex_expt_cur,
  ifu_iu_ex_expt_vld,
  ifu_iu_ex_inst,
  ifu_iu_ex_inst_bkpt,
  ifu_iu_ex_inst_dbg_disable,
  ifu_iu_ex_inst_vld,
  ifu_iu_ex_int_spcu_mask,
  ifu_iu_ex_int_spcu_vld,
  ifu_iu_ex_ni,
  ifu_iu_ex_prvlg_expt_vld,
  ifu_iu_ex_rand_vld,
  ifu_iu_ex_sp_oper,
  ifu_iu_ibus_idle,
  ifu_iu_inst_bkpt_dbg_occur_vld,
  ifu_iu_inst_bkpt_dbgexp_occur_vld,
  ifu_iu_inst_buf_inst_dbg_disable,
  ifu_iu_inst_buf_inst_vld,
  ifu_iu_lockup_ack,
  ifu_iu_spcu_retire_mask,
  ifu_iu_vector_ibus_in_idle,
  ifu_iu_xx_ibus_data,
  iu_ifu_addr,
  iu_ifu_data_fetch,
  iu_ifu_data_fetch_for_data,
  iu_ifu_ex_stall,
  iu_ifu_ex_stall_noinput,
  iu_ifu_ex_vld,
  iu_ifu_inst_fetch,
  iu_ifu_inst_fetch_for_data,
  iu_ifu_inst_fetch_mask,
  iu_ifu_inst_fetch_without_dbg_disable,
  iu_ifu_kill_inst,
  iu_ifu_lockup_mask,
  iu_ifu_lockup_on,
  iu_ifu_lockup_req,
  iu_ifu_lsu_inst,
  iu_ifu_reset_vld,
  iu_ifu_security_violation,
  iu_ifu_wb_ldst,
  iu_ifu_wb_stall,
  iu_yy_xx_dbgon,
  iu_yy_xx_flush,
  pad_yy_gate_clk_en_b,
  pmp_ifu_acc_scu,
  split_ifctrl_hs_stall,
  split_ifctrl_hs_stall_part,
  sysio_ifu_rst_addr,
  sysmap_ifu_acc_ca
);

// &Ports; @24
input           bmu_xx_ibus_acc_err;                  
input   [31:0]  bmu_xx_ibus_data;                     
input           bmu_xx_ibus_grnt;                     
input           bmu_xx_ibus_trans_cmplt;              
input           cp0_ifu_in_lpmd;                      
input           cp0_ifu_lpmd_req;                     
input           cp0_ifu_rst_inv_done;                 
input           cp0_ifu_srst_mask;                    
input           cp0_ifu_srst_req;                     
input           cp0_yy_clk_en;                        
input           cp0_yy_machine_mode_aft_dbg;          
input           cpurst_b;                             
input           forever_cpuclk;                       
input           had_core_dbg_mode_req;                
input           had_ifu_inst_bkpt_dbq_req;            
input           had_ifu_inst_bkpt_dbqexp_req;         
input   [31:0]  had_ifu_ir;                           
input           had_ifu_ir_vld;                       
input           had_yy_xx_dp_index_mbee;              
input   [30:0]  iu_ifu_addr;                          
input           iu_ifu_data_fetch;                    
input           iu_ifu_data_fetch_for_data;           
input           iu_ifu_ex_stall;                      
input           iu_ifu_ex_stall_noinput;              
input           iu_ifu_ex_vld;                        
input           iu_ifu_inst_fetch;                    
input           iu_ifu_inst_fetch_for_data;           
input           iu_ifu_inst_fetch_mask;               
input           iu_ifu_inst_fetch_without_dbg_disable; 
input           iu_ifu_kill_inst;                     
input           iu_ifu_lockup_mask;                   
input           iu_ifu_lockup_on;                     
input           iu_ifu_lockup_req;                    
input           iu_ifu_lsu_inst;                      
input           iu_ifu_reset_vld;                     
input           iu_ifu_security_violation;            
input           iu_ifu_wb_ldst;                       
input           iu_ifu_wb_stall;                      
input           iu_yy_xx_dbgon;                       
input           iu_yy_xx_flush;                       
input           pad_yy_gate_clk_en_b;                 
input           pmp_ifu_acc_scu;                      
input           split_ifctrl_hs_stall;                
input           split_ifctrl_hs_stall_part;           
input   [31:0]  sysio_ifu_rst_addr;                   
input           sysmap_ifu_acc_ca;                    
output  [31:0]  ifu_bmu_addr;                         
output          ifu_bmu_idle;                         
output  [3 :0]  ifu_bmu_prot;                         
output          ifu_bmu_req;                          
output          ifu_bmu_wfd1;                         
output          ifu_cp0_lpmd_ack;                     
output          ifu_cp0_rst_inv_req;                  
output          ifu_cp0_srst_ack;                     
output          ifu_had_fetch_expt_vld;               
output          ifu_had_inst_dbg_disable;             
output          ifu_had_split_first;                  
output          ifu_iu_ex_expt_cur;                   
output          ifu_iu_ex_expt_vld;                   
output  [31:0]  ifu_iu_ex_inst;                       
output          ifu_iu_ex_inst_bkpt;                  
output          ifu_iu_ex_inst_dbg_disable;           
output          ifu_iu_ex_inst_vld;                   
output          ifu_iu_ex_int_spcu_mask;              
output          ifu_iu_ex_int_spcu_vld;               
output          ifu_iu_ex_ni;                         
output          ifu_iu_ex_prvlg_expt_vld;             
output          ifu_iu_ex_rand_vld;                   
output          ifu_iu_ex_sp_oper;                    
output          ifu_iu_ibus_idle;                     
output          ifu_iu_inst_bkpt_dbg_occur_vld;       
output          ifu_iu_inst_bkpt_dbgexp_occur_vld;    
output          ifu_iu_inst_buf_inst_dbg_disable;     
output          ifu_iu_inst_buf_inst_vld;             
output          ifu_iu_lockup_ack;                    
output          ifu_iu_spcu_retire_mask;              
output          ifu_iu_vector_ibus_in_idle;           
output  [31:0]  ifu_iu_xx_ibus_data;                  

// &Regs; @25

// &Wires; @26
wire            bmu_xx_ibus_acc_err;                  
wire    [31:0]  bmu_xx_ibus_data;                     
wire            bmu_xx_ibus_grnt;                     
wire            bmu_xx_ibus_trans_cmplt;              
wire            cp0_ifu_in_lpmd;                      
wire            cp0_ifu_lpmd_req;                     
wire            cp0_ifu_rst_inv_done;                 
wire            cp0_ifu_srst_mask;                    
wire            cp0_ifu_srst_req;                     
wire            cp0_yy_clk_en;                        
wire            cp0_yy_machine_mode_aft_dbg;          
wire            cpurst_b;                             
wire            forever_cpuclk;                       
wire            forever_cpuclk_gated_ifu;             
wire            had_core_dbg_mode_req;                
wire            had_ifu_inst_bkpt_dbq_req;            
wire            had_ifu_inst_bkpt_dbqexp_req;         
wire    [31:0]  had_ifu_ir;                           
wire            had_ifu_ir_vld;                       
wire            had_yy_xx_dp_index_mbee;              
wire            ibuf_ibusif_inst_fetch;               
wire            ibuf_ifctrl_inst32_low;               
wire            ibuf_ifctrl_inst_vld;                 
wire            ibuf_ifctrl_pop0_mad32_low;           
wire            ibuf_ifdp_inst_dbg_disable;           
wire            ibuf_top_clk_en;                      
wire            ibuf_xx_empty;                        
wire            ibusif_ibuf_no_trans;                 
wire            ibusif_ifctrl_inst_mad32_high;        
wire            ibusif_ifctrl_inst_no_bypass;         
wire            ibusif_top_clk_en;                    
wire            ibusif_xx_16bit_inst;                 
wire            ibusif_xx_acc_err;                    
wire    [31:0]  ibusif_xx_data;                       
wire            ibusif_xx_ibus_idle;                  
wire            ibusif_xx_trans_cmplt;                
wire            ibusif_xx_unalign_fetch;              
wire            ifctrl_ibuf_bypass_vld;               
wire            ifctrl_ibuf_inst_pipe_down;           
wire            ifctrl_ibuf_pop_en;                   
wire            ifctrl_xx_ifcancel;                   
wire    [31:0]  ifu_bmu_addr;                         
wire            ifu_bmu_idle;                         
wire    [3 :0]  ifu_bmu_prot;                         
wire            ifu_bmu_req;                          
wire            ifu_bmu_wfd1;                         
wire            ifu_cp0_lpmd_ack;                     
wire            ifu_cp0_rst_inv_req;                  
wire            ifu_cp0_srst_ack;                     
wire            ifu_had_fetch_expt_vld;               
wire            ifu_had_inst_dbg_disable;             
wire            ifu_had_split_first;                  
wire            ifu_iu_ex_expt_cur;                   
wire            ifu_iu_ex_expt_vld;                   
wire    [31:0]  ifu_iu_ex_inst;                       
wire            ifu_iu_ex_inst_bkpt;                  
wire            ifu_iu_ex_inst_dbg_disable;           
wire            ifu_iu_ex_inst_vld;                   
wire            ifu_iu_ex_int_spcu_mask;              
wire            ifu_iu_ex_int_spcu_vld;               
wire            ifu_iu_ex_ni;                         
wire            ifu_iu_ex_prvlg_expt_vld;             
wire            ifu_iu_ex_rand_vld;                   
wire            ifu_iu_ex_sp_oper;                    
wire            ifu_iu_ibus_idle;                     
wire            ifu_iu_inst_bkpt_dbg_occur_vld;       
wire            ifu_iu_inst_bkpt_dbgexp_occur_vld;    
wire            ifu_iu_inst_buf_inst_dbg_disable;     
wire            ifu_iu_inst_buf_inst_vld;             
wire            ifu_iu_lockup_ack;                    
wire            ifu_iu_spcu_retire_mask;              
wire            ifu_iu_vector_ibus_in_idle;           
wire    [31:0]  ifu_iu_xx_ibus_data;                  
wire            ifu_misc_clk;                         
wire            ifu_misc_upd_en;                      
wire    [30:0]  iu_ifu_addr;                          
wire            iu_ifu_data_fetch;                    
wire            iu_ifu_data_fetch_for_data;           
wire            iu_ifu_ex_stall;                      
wire            iu_ifu_ex_stall_noinput;              
wire            iu_ifu_ex_vld;                        
wire            iu_ifu_inst_fetch;                    
wire            iu_ifu_inst_fetch_for_data;           
wire            iu_ifu_inst_fetch_mask;               
wire            iu_ifu_inst_fetch_without_dbg_disable; 
wire            iu_ifu_kill_inst;                     
wire            iu_ifu_lockup_mask;                   
wire            iu_ifu_lockup_on;                     
wire            iu_ifu_lockup_req;                    
wire            iu_ifu_lsu_inst;                      
wire            iu_ifu_reset_vld;                     
wire            iu_ifu_security_violation;            
wire            iu_ifu_wb_ldst;                       
wire            iu_ifu_wb_stall;                      
wire            iu_yy_xx_dbgon;                       
wire            iu_yy_xx_flush;                       
wire            pad_yy_gate_clk_en_b;                 
wire            pmp_ifu_acc_scu;                      
wire    [3 :0]  randclk_ibuf_entry_data_mod_en_w16;   
wire            randclk_ibuf_pop_mod_en_w3;           
wire            randclk_ibuf_push_mod_en_w3;          
wire            split_ifctrl_hs_stall;                
wire            split_ifctrl_hs_stall_part;           
wire    [31:0]  sysio_ifu_rst_addr;                   
wire            sysmap_ifu_acc_ca;                    



//==============================================================================
//                             IFU Module Gated Cell
//==============================================================================
// &Instance("gated_clk_cell","x_gated_cpuclk_cell_ifu"); @32
gated_clk_cell  x_gated_cpuclk_cell_ifu (
  .clk_in                   (forever_cpuclk          ),
  .clk_out                  (forever_cpuclk_gated_ifu),
  .external_en              (1'b0                    ),
  .global_en                (cp0_yy_clk_en           ),
  .local_en                 (1'b1                    ),
  .module_en                (1'b1                    ),
  .pad_yy_gate_clk_en_b     (pad_yy_gate_clk_en_b    )
);

// &Connect( @33
//   .clk_in              (forever_cpuclk          ), @34
//   .clk_out             (forever_cpuclk_gated_ifu), @35
//   .external_en         (1'b0                    ), @36
//   .global_en           (cp0_yy_clk_en           ), @37
//   .local_en            (1'b1                    ), @38
//   .module_en           (1'b1                    ) @39
// ); @40

// &Instance("gated_clk_cell", "x_entry_ifu_misc_clkhdr"); @42
gated_clk_cell  x_entry_ifu_misc_clkhdr (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (ifu_misc_clk        ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (ifu_misc_upd_en     ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in(forever_cpuclk), @43
//          .external_en(1'b0), @44
//          .global_en(cp0_yy_clk_en), @45
//          .module_en(1'b0), @46
//          .local_en(ifu_misc_upd_en), @47
//          .clk_out(ifu_misc_clk) @48
//         ); @49

assign ifu_misc_upd_en = ibuf_top_clk_en
                      || ibusif_top_clk_en;

//==============================================================================
//                             IFU Module Instance
//==============================================================================
// &Instance("cr_ifu_ibusif","x_ibusif"); @57
cr_ifu_ibusif  x_ibusif (
  .bmu_xx_ibus_acc_err           (bmu_xx_ibus_acc_err          ),
  .bmu_xx_ibus_data              (bmu_xx_ibus_data             ),
  .bmu_xx_ibus_grnt              (bmu_xx_ibus_grnt             ),
  .bmu_xx_ibus_trans_cmplt       (bmu_xx_ibus_trans_cmplt      ),
  .cp0_ifu_in_lpmd               (cp0_ifu_in_lpmd              ),
  .cp0_ifu_lpmd_req              (cp0_ifu_lpmd_req             ),
  .cp0_ifu_rst_inv_done          (cp0_ifu_rst_inv_done         ),
  .cp0_ifu_srst_mask             (cp0_ifu_srst_mask            ),
  .cp0_ifu_srst_req              (cp0_ifu_srst_req             ),
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .cp0_yy_machine_mode_aft_dbg   (cp0_yy_machine_mode_aft_dbg  ),
  .cpurst_b                      (cpurst_b                     ),
  .forever_cpuclk                (forever_cpuclk               ),
  .ibuf_ibusif_inst_fetch        (ibuf_ibusif_inst_fetch       ),
  .ibusif_ibuf_no_trans          (ibusif_ibuf_no_trans         ),
  .ibusif_ifctrl_inst_mad32_high (ibusif_ifctrl_inst_mad32_high),
  .ibusif_ifctrl_inst_no_bypass  (ibusif_ifctrl_inst_no_bypass ),
  .ibusif_top_clk_en             (ibusif_top_clk_en            ),
  .ibusif_xx_16bit_inst          (ibusif_xx_16bit_inst         ),
  .ibusif_xx_acc_err             (ibusif_xx_acc_err            ),
  .ibusif_xx_data                (ibusif_xx_data               ),
  .ibusif_xx_ibus_idle           (ibusif_xx_ibus_idle          ),
  .ibusif_xx_trans_cmplt         (ibusif_xx_trans_cmplt        ),
  .ibusif_xx_unalign_fetch       (ibusif_xx_unalign_fetch      ),
  .ifu_bmu_addr                  (ifu_bmu_addr                 ),
  .ifu_bmu_idle                  (ifu_bmu_idle                 ),
  .ifu_bmu_prot                  (ifu_bmu_prot                 ),
  .ifu_bmu_req                   (ifu_bmu_req                  ),
  .ifu_bmu_wfd1                  (ifu_bmu_wfd1                 ),
  .ifu_cp0_lpmd_ack              (ifu_cp0_lpmd_ack             ),
  .ifu_cp0_rst_inv_req           (ifu_cp0_rst_inv_req          ),
  .ifu_cp0_srst_ack              (ifu_cp0_srst_ack             ),
  .ifu_iu_ibus_idle              (ifu_iu_ibus_idle             ),
  .ifu_iu_lockup_ack             (ifu_iu_lockup_ack            ),
  .ifu_iu_vector_ibus_in_idle    (ifu_iu_vector_ibus_in_idle   ),
  .ifu_iu_xx_ibus_data           (ifu_iu_xx_ibus_data          ),
  .ifu_misc_clk                  (ifu_misc_clk                 ),
  .iu_ifu_addr                   (iu_ifu_addr                  ),
  .iu_ifu_data_fetch             (iu_ifu_data_fetch            ),
  .iu_ifu_data_fetch_for_data    (iu_ifu_data_fetch_for_data   ),
  .iu_ifu_inst_fetch             (iu_ifu_inst_fetch            ),
  .iu_ifu_inst_fetch_for_data    (iu_ifu_inst_fetch_for_data   ),
  .iu_ifu_inst_fetch_mask        (iu_ifu_inst_fetch_mask       ),
  .iu_ifu_lockup_mask            (iu_ifu_lockup_mask           ),
  .iu_ifu_lockup_on              (iu_ifu_lockup_on             ),
  .iu_ifu_lockup_req             (iu_ifu_lockup_req            ),
  .iu_ifu_reset_vld              (iu_ifu_reset_vld             ),
  .iu_ifu_security_violation     (iu_ifu_security_violation    ),
  .iu_yy_xx_dbgon                (iu_yy_xx_dbgon               ),
  .pad_yy_gate_clk_en_b          (pad_yy_gate_clk_en_b         ),
  .pmp_ifu_acc_scu               (pmp_ifu_acc_scu              ),
  .sysio_ifu_rst_addr            (sysio_ifu_rst_addr           ),
  .sysmap_ifu_acc_ca             (sysmap_ifu_acc_ca            )
);


// &Connect(.pmp_ifu_acc_scu(1'b0)); @63


// &Connect(.cru_ifu_acc_ca(1'b0)); @70

// &Instance("cr_ifu_ibuf","x_ibuf"); @73
cr_ifu_ibuf  x_ibuf (
  .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),
  .cpuclk                             (forever_cpuclk_gated_ifu          ),
  .cpurst_b                           (cpurst_b                          ),
  .forever_cpuclk                     (forever_cpuclk                    ),
  .had_ifu_ir                         (had_ifu_ir                        ),
  .had_ifu_ir_vld                     (had_ifu_ir_vld                    ),
  .ibuf_ibusif_inst_fetch             (ibuf_ibusif_inst_fetch            ),
  .ibuf_ifctrl_inst32_low             (ibuf_ifctrl_inst32_low            ),
  .ibuf_ifctrl_inst_vld               (ibuf_ifctrl_inst_vld              ),
  .ibuf_ifctrl_pop0_mad32_low         (ibuf_ifctrl_pop0_mad32_low        ),
  .ibuf_ifdp_inst_dbg_disable         (ibuf_ifdp_inst_dbg_disable        ),
  .ibuf_top_clk_en                    (ibuf_top_clk_en                   ),
  .ibuf_xx_empty                      (ibuf_xx_empty                     ),
  .ibusif_ibuf_no_trans               (ibusif_ibuf_no_trans              ),
  .ibusif_xx_16bit_inst               (ibusif_xx_16bit_inst              ),
  .ibusif_xx_acc_err                  (ibusif_xx_acc_err                 ),
  .ibusif_xx_data                     (ibusif_xx_data                    ),
  .ibusif_xx_ibus_idle                (ibusif_xx_ibus_idle               ),
  .ibusif_xx_trans_cmplt              (ibusif_xx_trans_cmplt             ),
  .ibusif_xx_unalign_fetch            (ibusif_xx_unalign_fetch           ),
  .ifctrl_ibuf_bypass_vld             (ifctrl_ibuf_bypass_vld            ),
  .ifctrl_ibuf_inst_pipe_down         (ifctrl_ibuf_inst_pipe_down        ),
  .ifctrl_ibuf_pop_en                 (ifctrl_ibuf_pop_en                ),
  .ifctrl_xx_ifcancel                 (ifctrl_xx_ifcancel                ),
  .ifu_had_fetch_expt_vld             (ifu_had_fetch_expt_vld            ),
  .ifu_iu_ex_expt_cur                 (ifu_iu_ex_expt_cur                ),
  .ifu_iu_ex_expt_vld                 (ifu_iu_ex_expt_vld                ),
  .ifu_iu_ex_inst                     (ifu_iu_ex_inst                    ),
  .ifu_misc_clk                       (ifu_misc_clk                      ),
  .iu_ifu_ex_stall_noinput            (iu_ifu_ex_stall_noinput           ),
  .iu_ifu_ex_vld                      (iu_ifu_ex_vld                     ),
  .iu_ifu_inst_fetch                  (iu_ifu_inst_fetch                 ),
  .iu_ifu_lsu_inst                    (iu_ifu_lsu_inst                   ),
  .iu_ifu_wb_ldst                     (iu_ifu_wb_ldst                    ),
  .iu_ifu_wb_stall                    (iu_ifu_wb_stall                   ),
  .iu_yy_xx_dbgon                     (iu_yy_xx_dbgon                    ),
  .pad_yy_gate_clk_en_b               (pad_yy_gate_clk_en_b              ),
  .randclk_ibuf_entry_data_mod_en_w16 (randclk_ibuf_entry_data_mod_en_w16),
  .randclk_ibuf_pop_mod_en_w3         (randclk_ibuf_pop_mod_en_w3        ),
  .randclk_ibuf_push_mod_en_w3        (randclk_ibuf_push_mod_en_w3       )
);

// &Connect(.cpuclk (forever_cpuclk_gated_ifu)); @74

//&Instance("cr_ifu_addrgen","x_addrgen");
// //&Connect(.cpuclk (forever_cpuclk_gated_ifu)); @77

//&Instance("cr_ifu_split","x_split");

// &Instance("cr_ifu_ifdp","x_ifdp"); @81
cr_ifu_ifdp  x_ifdp (
  .had_core_dbg_mode_req             (had_core_dbg_mode_req            ),
  .had_ifu_inst_bkpt_dbq_req         (had_ifu_inst_bkpt_dbq_req        ),
  .had_ifu_inst_bkpt_dbqexp_req      (had_ifu_inst_bkpt_dbqexp_req     ),
  .had_yy_xx_dp_index_mbee           (had_yy_xx_dp_index_mbee          ),
  .ifu_had_inst_dbg_disable          (ifu_had_inst_dbg_disable         ),
  .ifu_had_split_first               (ifu_had_split_first              ),
  .ifu_iu_ex_inst_bkpt               (ifu_iu_ex_inst_bkpt              ),
  .ifu_iu_ex_inst_dbg_disable        (ifu_iu_ex_inst_dbg_disable       ),
  .ifu_iu_ex_int_spcu_mask           (ifu_iu_ex_int_spcu_mask          ),
  .ifu_iu_ex_int_spcu_vld            (ifu_iu_ex_int_spcu_vld           ),
  .ifu_iu_ex_ni                      (ifu_iu_ex_ni                     ),
  .ifu_iu_ex_prvlg_expt_vld          (ifu_iu_ex_prvlg_expt_vld         ),
  .ifu_iu_ex_rand_vld                (ifu_iu_ex_rand_vld               ),
  .ifu_iu_ex_sp_oper                 (ifu_iu_ex_sp_oper                ),
  .ifu_iu_inst_bkpt_dbg_occur_vld    (ifu_iu_inst_bkpt_dbg_occur_vld   ),
  .ifu_iu_inst_bkpt_dbgexp_occur_vld (ifu_iu_inst_bkpt_dbgexp_occur_vld),
  .ifu_iu_spcu_retire_mask           (ifu_iu_spcu_retire_mask          ),
  .iu_ifu_kill_inst                  (iu_ifu_kill_inst                 )
);


// &Instance("cr_ifu_ifctrl","x_ifctrl"); @83
cr_ifu_ifctrl  x_ifctrl (
  .cpuclk                                (forever_cpuclk_gated_ifu             ),
  .cpurst_b                              (cpurst_b                             ),
  .had_ifu_ir_vld                        (had_ifu_ir_vld                       ),
  .ibuf_ifctrl_inst32_low                (ibuf_ifctrl_inst32_low               ),
  .ibuf_ifctrl_inst_vld                  (ibuf_ifctrl_inst_vld                 ),
  .ibuf_ifctrl_pop0_mad32_low            (ibuf_ifctrl_pop0_mad32_low           ),
  .ibuf_ifdp_inst_dbg_disable            (ibuf_ifdp_inst_dbg_disable           ),
  .ibuf_xx_empty                         (ibuf_xx_empty                        ),
  .ibusif_ifctrl_inst_mad32_high         (ibusif_ifctrl_inst_mad32_high        ),
  .ibusif_ifctrl_inst_no_bypass          (ibusif_ifctrl_inst_no_bypass         ),
  .ibusif_xx_16bit_inst                  (ibusif_xx_16bit_inst                 ),
  .ibusif_xx_trans_cmplt                 (ibusif_xx_trans_cmplt                ),
  .ibusif_xx_unalign_fetch               (ibusif_xx_unalign_fetch              ),
  .ifctrl_ibuf_bypass_vld                (ifctrl_ibuf_bypass_vld               ),
  .ifctrl_ibuf_inst_pipe_down            (ifctrl_ibuf_inst_pipe_down           ),
  .ifctrl_ibuf_pop_en                    (ifctrl_ibuf_pop_en                   ),
  .ifctrl_xx_ifcancel                    (ifctrl_xx_ifcancel                   ),
  .ifu_iu_ex_inst_vld                    (ifu_iu_ex_inst_vld                   ),
  .ifu_iu_inst_buf_inst_dbg_disable      (ifu_iu_inst_buf_inst_dbg_disable     ),
  .ifu_iu_inst_buf_inst_vld              (ifu_iu_inst_buf_inst_vld             ),
  .iu_ifu_ex_stall                       (iu_ifu_ex_stall                      ),
  .iu_ifu_inst_fetch                     (iu_ifu_inst_fetch                    ),
  .iu_ifu_inst_fetch_without_dbg_disable (iu_ifu_inst_fetch_without_dbg_disable),
  .iu_ifu_wb_stall                       (iu_ifu_wb_stall                      ),
  .iu_yy_xx_dbgon                        (iu_yy_xx_dbgon                       ),
  .iu_yy_xx_flush                        (iu_yy_xx_flush                       ),
  .split_ifctrl_hs_stall                 (split_ifctrl_hs_stall                ),
  .split_ifctrl_hs_stall_part            (split_ifctrl_hs_stall_part           )
);

// &Connect(.cpuclk (forever_cpuclk_gated_ifu)); @84

// &Instance("cr_ifu_randclk","x_randclk"); @86
cr_ifu_randclk  x_randclk (
  .randclk_ibuf_entry_data_mod_en_w16 (randclk_ibuf_entry_data_mod_en_w16),
  .randclk_ibuf_pop_mod_en_w3         (randclk_ibuf_pop_mod_en_w3        ),
  .randclk_ibuf_push_mod_en_w3        (randclk_ibuf_push_mod_en_w3       )
);


// &ModuleEnd; @88
endmodule



