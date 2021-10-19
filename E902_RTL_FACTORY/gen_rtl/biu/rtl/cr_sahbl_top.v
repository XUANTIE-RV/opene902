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
module cr_sahbl_top(
  ahblif_idle,
  biu_bmu_dbus_acc_err,
  biu_bmu_dbus_data,
  biu_bmu_dbus_data_vld,
  biu_bmu_dbus_grnt,
  biu_bmu_dbus_trans_cmplt,
  biu_bmu_ibus_acc_err,
  biu_bmu_ibus_data,
  biu_bmu_ibus_data_vld,
  biu_bmu_ibus_grnt,
  biu_bmu_ibus_trans_cmplt,
  biu_pad_haddr,
  biu_pad_hburst,
  biu_pad_hprot,
  biu_pad_hsize,
  biu_pad_htrans,
  biu_pad_hwdata,
  biu_pad_hwrite,
  bmu_biu_dbus_acc_deny,
  bmu_biu_dbus_addr,
  bmu_biu_dbus_chk_fail,
  bmu_biu_dbus_prot,
  bmu_biu_dbus_req,
  bmu_biu_dbus_req_without_cmplt,
  bmu_biu_dbus_size,
  bmu_biu_dbus_wdata,
  bmu_biu_dbus_write,
  bmu_biu_ibus_acc_deny,
  bmu_biu_ibus_addr,
  bmu_biu_ibus_hit,
  bmu_biu_ibus_prot,
  bmu_biu_ibus_req,
  bmu_biu_ibus_req_no_hit,
  bmu_biu_ibus_size,
  bmu_biu_ibus_vec_redirect,
  cpurst_b,
  dahblif_other_mask,
  forever_cpuclk,
  iahblif_other_mask,
  pad_biu_hrdata,
  pad_biu_hready,
  pad_biu_hresp,
  pad_cpu_halt_ff2,
  pad_yy_gate_clk_en_b,
  pwrm_cpu_bus_peak_power_limit_en,
  sahblif_iahblif_mask
);

// &Ports; @23
input           bmu_biu_dbus_acc_deny;           
input   [31:0]  bmu_biu_dbus_addr;               
input           bmu_biu_dbus_chk_fail;           
input   [3 :0]  bmu_biu_dbus_prot;               
input           bmu_biu_dbus_req;                
input           bmu_biu_dbus_req_without_cmplt;  
input   [1 :0]  bmu_biu_dbus_size;               
input   [31:0]  bmu_biu_dbus_wdata;              
input           bmu_biu_dbus_write;              
input           bmu_biu_ibus_acc_deny;           
input   [31:0]  bmu_biu_ibus_addr;               
input           bmu_biu_ibus_hit;                
input   [3 :0]  bmu_biu_ibus_prot;               
input           bmu_biu_ibus_req;                
input           bmu_biu_ibus_req_no_hit;         
input   [1 :0]  bmu_biu_ibus_size;               
input           bmu_biu_ibus_vec_redirect;       
input           cpurst_b;                        
input           dahblif_other_mask;              
input           forever_cpuclk;                  
input           iahblif_other_mask;              
input   [31:0]  pad_biu_hrdata;                  
input           pad_biu_hready;                  
input           pad_biu_hresp;                   
input           pad_cpu_halt_ff2;                
input           pad_yy_gate_clk_en_b;            
input           pwrm_cpu_bus_peak_power_limit_en; 
output          ahblif_idle;                     
output          biu_bmu_dbus_acc_err;            
output  [31:0]  biu_bmu_dbus_data;               
output          biu_bmu_dbus_data_vld;           
output          biu_bmu_dbus_grnt;               
output          biu_bmu_dbus_trans_cmplt;        
output          biu_bmu_ibus_acc_err;            
output  [31:0]  biu_bmu_ibus_data;               
output          biu_bmu_ibus_data_vld;           
output          biu_bmu_ibus_grnt;               
output          biu_bmu_ibus_trans_cmplt;        
output  [31:0]  biu_pad_haddr;                   
output  [2 :0]  biu_pad_hburst;                  
output  [3 :0]  biu_pad_hprot;                   
output  [2 :0]  biu_pad_hsize;                   
output  [1 :0]  biu_pad_htrans;                  
output  [31:0]  biu_pad_hwdata;                  
output          biu_pad_hwrite;                  
output          sahblif_iahblif_mask;            

// &Regs; @24

// &Wires; @25
wire            ahbl_clk_en;                     
wire            ahbl_gated_clk;                  
wire            ahblif_busy;                     
wire            ahblif_idle;                     
wire            ahblif_power_mask;               
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
wire            cpu_acc_err;                     
wire    [31:0]  cpu_addr;                        
wire            cpu_data_vld;                    
wire    [3 :0]  cpu_prot;                        
wire    [31:0]  cpu_rdata;                       
wire            cpu_req;                         
wire            cpu_req_for_grnt;                
wire            cpu_req_for_peak_power;          
wire            cpu_req_grnt;                    
wire            cpu_req_power_masked;            
wire            cpu_sec;                         
wire    [1 :0]  cpu_size;                        
wire            cpu_trans_cmplt;                 
wire            cpu_vec_redirect;                
wire    [31:0]  cpu_wdata;                       
wire            cpu_wdata_sel;                   
wire            cpu_write;                       
wire            cpurst_b;                        
wire            dahblif_other_mask;              
wire            dbus_mask;                       
wire            forever_cpuclk;                  
wire            iahblif_other_mask;              
wire            ibus_not_granted;                
wire    [31:0]  pad_biu_hrdata;                  
wire            pad_biu_hready;                  
wire            pad_biu_hresp;                   
wire            pad_cpu_halt_ff2;                
wire            pad_yy_gate_clk_en_b;            
wire            pwrm_cpu_bus_peak_power_limit_en; 
wire            sahblif_iahblif_mask;            


//==========================================================
//  Instance Gated Cell for Most Common Use
//==========================================================
// &Instance("gated_clk_cell", "x_gated_ahbl_cpuclk_cell"); @30
gated_clk_cell  x_gated_ahbl_cpuclk_cell (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (ahbl_gated_clk      ),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (dbus_mask           ),
  .module_en            (ahbl_clk_en         ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in     (forever_cpuclk), @31
//          .global_en  (1'b1          ), @32
//          .module_en  (ahbl_clk_en   ), @33
//          .local_en   (dbus_mask     ), @34
//          .external_en(1'b0          ), @35
//          .clk_out    (ahbl_gated_clk)); @36

//==========================================================
//  Instance Request Arbiter module 
//==========================================================
// &Instance("cr_ahbl_req_arb_fo"); @42
// &Connect(.cpu_req_bus_sel (cpu_req_bus_grnt)); @43
// &Force("nonport", "cpu_req_bus_ff"); @44
// &Force("nonport", "cpu_req_for_peak_power"); @45
// &Force("input", "bmu_biu_ibus_req_no_hit"); @46
// &Force("nonport", "uncmplt_mask"); @52
// &Instance("cr_ahbl_req_arb"); @56
cr_ahbl_req_arb  x_cr_ahbl_req_arb (
  .ahbl_bmu_dbus_acc_err                   (biu_bmu_dbus_acc_err                   ),
  .ahbl_bmu_dbus_data                      (biu_bmu_dbus_data                      ),
  .ahbl_bmu_dbus_data_vld                  (biu_bmu_dbus_data_vld                  ),
  .ahbl_bmu_dbus_grnt                      (biu_bmu_dbus_grnt                      ),
  .ahbl_bmu_dbus_trans_cmplt               (biu_bmu_dbus_trans_cmplt               ),
  .ahbl_bmu_ibus_acc_err                   (biu_bmu_ibus_acc_err                   ),
  .ahbl_bmu_ibus_data                      (biu_bmu_ibus_data                      ),
  .ahbl_bmu_ibus_data_vld                  (biu_bmu_ibus_data_vld                  ),
  .ahbl_bmu_ibus_grnt                      (biu_bmu_ibus_grnt                      ),
  .ahbl_bmu_ibus_trans_cmplt               (biu_bmu_ibus_trans_cmplt               ),
  .ahbl_gated_clk                          (ahbl_gated_clk                         ),
  .bmu_ahbl_dbus_acc_deny                  (bmu_biu_dbus_acc_deny                  ),
  .bmu_ahbl_dbus_addr                      (bmu_biu_dbus_addr                      ),
  .bmu_ahbl_dbus_chk_fail                  (bmu_biu_dbus_chk_fail                  ),
  .bmu_ahbl_dbus_prot                      (bmu_biu_dbus_prot                      ),
  .bmu_ahbl_dbus_req                       (bmu_biu_dbus_req                       ),
  .bmu_ahbl_dbus_req_without_cmplt         (bmu_biu_dbus_req_without_cmplt         ),
  .bmu_ahbl_dbus_req_without_deny_chk_fail (bmu_biu_dbus_req                       ),
  .bmu_ahbl_dbus_size                      (bmu_biu_dbus_size                      ),
  .bmu_ahbl_dbus_write                     (bmu_biu_dbus_write                     ),
  .bmu_ahbl_ibus_acc_deny                  (bmu_biu_ibus_acc_deny                  ),
  .bmu_ahbl_ibus_addr                      (bmu_biu_ibus_addr                      ),
  .bmu_ahbl_ibus_hit                       (bmu_biu_ibus_hit                       ),
  .bmu_ahbl_ibus_prot                      (bmu_biu_ibus_prot                      ),
  .bmu_ahbl_ibus_req                       (bmu_biu_ibus_req                       ),
  .bmu_ahbl_ibus_req_no_hit                (bmu_biu_ibus_req_no_hit                ),
  .bmu_ahbl_ibus_size                      (bmu_biu_ibus_size                      ),
  .bmu_ahbl_ibus_vec_redirect              (bmu_biu_ibus_vec_redirect              ),
  .bmu_ahbl_ibus_write                     (1'b0                                   ),
  .bmu_ahbl_wdata                          (bmu_biu_dbus_wdata                     ),
  .cpu_acc_err                             (cpu_acc_err                            ),
  .cpu_addr                                (cpu_addr                               ),
  .cpu_data_vld                            (cpu_data_vld                           ),
  .cpu_prot                                (cpu_prot                               ),
  .cpu_rdata                               (cpu_rdata                              ),
  .cpu_req                                 (cpu_req                                ),
  .cpu_req_for_grnt                        (cpu_req_for_grnt                       ),
  .cpu_req_for_peak_power                  (cpu_req_for_peak_power                 ),
  .cpu_req_grnt                            (cpu_req_grnt                           ),
  .cpu_sec                                 (cpu_sec                                ),
  .cpu_size                                (cpu_size                               ),
  .cpu_trans_cmplt                         (cpu_trans_cmplt                        ),
  .cpu_vec_redirect                        (cpu_vec_redirect                       ),
  .cpu_wdata                               (cpu_wdata                              ),
  .cpu_write                               (cpu_write                              ),
  .cpurst_b                                (cpurst_b                               ),
  .ibus_not_granted                        (ibus_not_granted                       )
);

assign dbus_mask = ibus_not_granted;
// &Connect( .ahbl_bmu_bus_check_fail   (biu_bmu_bus_check_fail   ), @61
//           .ahbl_bmu_dbus_acc_err     (biu_bmu_dbus_acc_err     ), @62
//           .ahbl_bmu_dbus_data        (biu_bmu_dbus_data        ), @63
//           .ahbl_bmu_dbus_data_vld    (biu_bmu_dbus_data_vld    ), @64
//           .ahbl_bmu_dbus_grnt        (biu_bmu_dbus_grnt        ), @65
//           .ahbl_bmu_dbus_trans_cmplt (biu_bmu_dbus_trans_cmplt ), @66
//           .ahbl_bmu_ibus_acc_err     (biu_bmu_ibus_acc_err     ), @67
//           .ahbl_bmu_ibus_data        (biu_bmu_ibus_data        ), @68
//           .ahbl_bmu_ibus_data_vld    (biu_bmu_ibus_data_vld    ), @69
//           .ahbl_bmu_ibus_grnt        (biu_bmu_ibus_grnt        ), @70
//           .ahbl_bmu_ibus_trans_cmplt (biu_bmu_ibus_trans_cmplt ), @71
//           .bmu_ahbl_dbus_acc_deny    (bmu_biu_dbus_acc_deny    ), @72
//           .bmu_ahbl_dbus_chk_fail    (bmu_biu_dbus_chk_fail    ), @73
//           .bmu_ahbl_dbus_addr        (bmu_biu_dbus_addr        ), @74
//           .bmu_ahbl_dbus_prot        (bmu_biu_dbus_prot        ), @75
//           .bmu_ahbl_dbus_req         (bmu_biu_dbus_req         ), @76
//           .bmu_ahbl_dbus_req_without_deny_chk_fail(bmu_biu_dbus_req), @77
//           .bmu_ahbl_dbus_req_without_cmplt (bmu_biu_dbus_req_without_cmplt), @78
//           .bmu_ahbl_dbus_size        (bmu_biu_dbus_size        ), @79
//           .bmu_ahbl_wdata            (bmu_biu_dbus_wdata       ), @80
//           .bmu_ahbl_dbus_write       (bmu_biu_dbus_write       ), @81
//           .bmu_ahbl_ibus_acc_deny    (bmu_biu_ibus_acc_deny    ), @82
//           .bmu_ahbl_ibus_addr        (bmu_biu_ibus_addr        ), @83
//           .bmu_ahbl_ibus_prot        (bmu_biu_ibus_prot        ), @84
//           .bmu_ahbl_ibus_req         (bmu_biu_ibus_req         ), @85
//           .bmu_ahbl_ibus_req_no_hit  (bmu_biu_ibus_req_no_hit  ), @86
//           .bmu_ahbl_ibus_size        (bmu_biu_ibus_size        ), @87
//           .bmu_ahbl_ibus_vec_redirect (bmu_biu_ibus_vec_redirect), @88
//           .bmu_ahbl_ibus_write       (1'b0                     )); @89
// &Connect( .ahbl_bmu_dbus_data_pol    (biu_bmu_dbus_data_pol    ), @91
//           .ahbl_bmu_ibus_data_pol    (biu_bmu_ibus_data_pol    ), @92
//           .bmu_ahbl_wdata_pol        (bmu_biu_dbus_wdata_pol   )); @93
// &Connect( .bmu_ahbl_had_addr         (bmu_biu_had_addr         ),   @96
//           .bmu_ahbl_had_prot         (bmu_biu_had_prot         ),   @97
//           .bmu_ahbl_had_req          (bmu_biu_had_req          ),   @98
//           .bmu_ahbl_had_req_without_cmplt (bmu_biu_had_req_without_cmplt), @99
//           .bmu_ahbl_had_size         (bmu_biu_had_size         ),   @100
//           .bmu_ahbl_had_wdata        (bmu_biu_had_wdata        ),   @101
//           .bmu_ahbl_had_write        (bmu_biu_had_write        ),   @102
//           .ahbl_bmu_had_acc_err      (biu_bmu_had_acc_err      ),   @103
//           .ahbl_bmu_had_data         (biu_bmu_had_data         ),   @104
//           .ahbl_bmu_had_data_vld     (biu_bmu_had_data_vld     ),   @105
//           .ahbl_bmu_had_grnt         (biu_bmu_had_grnt         ),   @106
//           .ahbl_bmu_had_trans_cmplt  (biu_bmu_had_trans_cmplt  ));  @107
// &Force("bus", "bmu_biu_ibus_source_pc", 31, 0); @110
// &Force("bus", "bmu_biu_dbus_source_pc", 31, 0); @111
// &Connect( .bmu_ahbl_ibus_source_pc   (bmu_biu_ibus_source_pc[29:8]), @112
//           .bmu_ahbl_ibus_load        (1'b0                        ), @113
//           .bmu_ahbl_ibus_store       (1'b0                        ), @114
//           .bmu_ahbl_ibus_inst_fetch_chk (bmu_biu_ibus_inst_fetch_chk )); @115
// &Connect( .bmu_ahbl_dbus_source_pc   (bmu_biu_dbus_source_pc[29:8]), @116
//           .bmu_ahbl_dbus_load        (bmu_biu_dbus_load        ), @117
//           .bmu_ahbl_dbus_store       (bmu_biu_dbus_store       ), @118
//           .bmu_ahbl_dbus_inst_fetch_chk (bmu_biu_dbus_inst_fetch_chk )); @119
// &Connect( .ahbl_bmu_ibus_inst_dbg_disable (biu_bmu_ibus_inst_dbg_disable )); @124
// &Connect( .bmu_ahbl_ibus_hit (bmu_biu_ibus_hit)); @126
// &Force("nonport", "cpu_sec"); @127
// &Force("nonport", "ahbl_bmu_ibus_sec"); @128
// &Force("nonport", "ahb_ahbif_hsec"); @131
// &Force("nonport", "ahbl_ahbLif_hsec"); @135
// &Connect( .ahbl_bmu_bus_check_fail   (ahbl_cache_bus_check_fail), @139
//           .ahbl_bmu_ibus_acc_err     (ahbl_cache_lf_acc_err    ), @140
//           .ahbl_bmu_ibus_sec         (ahbl_cache_lf_sec        ), @141
//           .ahbl_bmu_ibus_data        (ahbl_cache_lf_data       ), @142
//           .ahbl_bmu_ibus_data_vld    (ahbl_cache_lf_data_vld   ), @143
//           .ahbl_bmu_ibus_grnt        (ahbl_cache_lf_grnt       ), @144
//           .ahbl_bmu_ibus_trans_cmplt (ahbl_cache_lf_trans_cmplt), @145
//           .ahbl_bmu_dbus_acc_err     (ahbl_cache_uc_acc_err    ), @146
//           .ahbl_bmu_dbus_data        (ahbl_cache_uc_data       ), @147
//           .ahbl_bmu_dbus_data_vld    (ahbl_cache_uc_data_vld   ), @148
//           .ahbl_bmu_dbus_trans_cmplt (ahbl_cache_uc_trans_cmplt), @149
//           .ahbl_bmu_dbus_grnt        (ahbl_cache_uc_grnt       ), @150
//           .bmu_ahbl_ibus_acc_deny    (1'b0                     ), @151
//           .bmu_ahbl_ibus_addr        (cache_ahbl_lf_addr       ), @152
//           .bmu_ahbl_ibus_prot        (cache_ahbl_lf_prot       ), @153
//           .bmu_ahbl_ibus_req         (cache_ahbl_lf_req        ), @154
//           .bmu_ahbl_ibus_req_no_hit  (cache_ahbl_lf_req        ), @155
//           .bmu_ahbl_ibus_size        (cache_ahbl_lf_size       ), @156
//           .bmu_ahbl_ibus_write       (1'b0                     ), @157
//           .bmu_ahbl_wdata            (cache_ahbl_uc_wdata      ), @158
//           .bmu_ahbl_dbus_acc_deny    (1'b0                     ), @159
//           .bmu_ahbl_dbus_chk_fail    (1'b0                     ), @160
//           .bmu_ahbl_dbus_addr        (cache_ahbl_uc_addr       ), @161
//           .bmu_ahbl_dbus_prot        (cache_ahbl_uc_prot       ), @162
//           .bmu_ahbl_dbus_req         (cache_ahbl_uc_req        ), @163
//           .bmu_ahbl_dbus_req_without_deny_chk_fail(cache_ahbl_uc_req_without_cmplt), @164
//           .bmu_ahbl_dbus_req_without_cmplt (cache_ahbl_uc_req_without_cmplt), @165
//           .bmu_ahbl_dbus_size        (cache_ahbl_uc_size       ), @166
//           .bmu_ahbl_ibus_vec_redirect (cache_ahbl_uc_vec_redirect), @167
//           .bmu_ahbl_dbus_write       (cache_ahbl_uc_write      )); @168
// &Connect( .ahbl_bmu_ibus_data_pol    (ahbl_cache_lf_data_pol   ), @170
//           .ahbl_bmu_dbus_data_pol    (ahbl_cache_uc_data_pol   ), @171
//           .bmu_ahbl_wdata_pol        (cache_ahbl_uc_wdata_pol  )); @172
// &Connect( .bmu_ahbl_dbus_source_pc   (cache_ahbl_uc_source_pc  ), @175
//           .bmu_ahbl_dbus_load        (cache_ahbl_uc_load       ), @176
//           .bmu_ahbl_dbus_store       (cache_ahbl_uc_store      ), @177
//           .bmu_ahbl_dbus_inst_fetch_chk (cache_ahbl_uc_inst_fetch_chk)); @178
// &Connect( .bmu_ahbl_ibus_source_pc   (cache_ahbl_lf_source_pc  ), @179
//           .bmu_ahbl_ibus_load        (1'b0                     ), @180
//           .bmu_ahbl_ibus_store       (1'b0                     ), @181
//           .bmu_ahbl_ibus_inst_fetch_chk (cache_ahbl_lf_inst_fetch_chk)); @182
// &Connect( .ahbl_bmu_ibus_inst_dbg_disable (ahbl_cache_bus_inst_dbg_disable )); @185
// &Connect( .bmu_ahbl_ibus_hit (1'b1)); @187
// &Connect( .ahbl_bmu_bus_check_fail   (biu_bmu_bus_check_fail   ), @190
//           .ahbl_bmu_dbus_acc_err     (biu_bmu_dbus_acc_err     ), @191
//           .ahbl_bmu_dbus_data        (biu_bmu_dbus_data        ), @192
//           .ahbl_bmu_dbus_data_vld    (biu_bmu_dbus_data_vld    ), @193
//           .ahbl_bmu_dbus_grnt        (biu_bmu_dbus_grnt        ), @194
//           .ahbl_bmu_dbus_trans_cmplt (biu_bmu_dbus_trans_cmplt ), @195
//           .ahbl_bmu_ibus_acc_err     (biu_bmu_ibus_acc_err     ), @196
//           .ahbl_bmu_ibus_data        (biu_bmu_ibus_data        ), @197
//           .ahbl_bmu_ibus_data_vld    (biu_bmu_ibus_data_vld    ), @198
//           .ahbl_bmu_ibus_grnt        (biu_bmu_ibus_grnt        ), @199
//           .ahbl_bmu_ibus_trans_cmplt (biu_bmu_ibus_trans_cmplt ), @200
//           .bmu_ahbl_dbus_acc_deny    (bmu_biu_dbus_acc_deny    ), @201
//           .bmu_ahbl_dbus_chk_fail    (bmu_biu_dbus_chk_fail    ), @202
//           .bmu_ahbl_dbus_addr        (bmu_biu_dbus_addr        ), @203
//           .bmu_ahbl_dbus_prot        (bmu_biu_dbus_prot        ), @204
//           .bmu_ahbl_dbus_req         (bmu_biu_dbus_req         ), @205
//           .bmu_ahbl_dbus_req_without_deny_chk_fail(bmu_biu_dbus_req), @206
//           .bmu_ahbl_dbus_req_without_cmplt (bmu_biu_dbus_req_without_cmplt), @207
//           .bmu_ahbl_dbus_size        (bmu_biu_dbus_size        ), @208
//           .bmu_ahbl_wdata            (bmu_biu_dbus_wdata       ), @209
//           .bmu_ahbl_dbus_write       (bmu_biu_dbus_write       ), @210
//           .bmu_ahbl_ibus_acc_deny    (bmu_biu_ibus_acc_deny    ), @211
//           .bmu_ahbl_ibus_addr        (bmu_biu_ibus_addr        ), @212
//           .bmu_ahbl_ibus_prot        (bmu_biu_ibus_prot        ), @213
//           .bmu_ahbl_ibus_req         (bmu_biu_ibus_req         ), @214
//           .bmu_ahbl_ibus_req_no_hit  (bmu_biu_ibus_req_no_hit  ), @215
//           .bmu_ahbl_ibus_size        (bmu_biu_ibus_size        ), @216
//           .bmu_ahbl_ibus_vec_redirect (bmu_biu_ibus_vec_redirect), @217
//           .bmu_ahbl_ibus_write       (1'b0                     )); @218
// &Connect( .ahbl_bmu_dbus_data_pol    (biu_bmu_dbus_data_pol    ), @220
//           .ahbl_bmu_ibus_data_pol    (biu_bmu_ibus_data_pol    ), @221
//           .bmu_ahbl_wdata_pol        (bmu_biu_dbus_wdata_pol   )); @222
// &Connect( .bmu_ahbl_had_addr         (bmu_biu_had_addr         ), @225
//           .bmu_ahbl_had_prot         (bmu_biu_had_prot         ), @226
//           .bmu_ahbl_had_req          (bmu_biu_had_req          ), @227
//           .bmu_ahbl_had_req_without_cmplt (bmu_biu_had_req_without_cmplt), @228
//           .bmu_ahbl_had_size         (bmu_biu_had_size         ), @229
//           .bmu_ahbl_had_wdata        (bmu_biu_had_wdata        ), @230
//           .bmu_ahbl_had_write        (bmu_biu_had_write        ), @231
//           .ahbl_bmu_had_acc_err      (biu_bmu_had_acc_err      ), @232
//           .ahbl_bmu_had_data         (biu_bmu_had_data         ), @233
//           .ahbl_bmu_had_data_vld     (biu_bmu_had_data_vld     ), @234
//           .ahbl_bmu_had_grnt         (biu_bmu_had_grnt         ), @235
//           .ahbl_bmu_had_trans_cmplt  (biu_bmu_had_trans_cmplt  )); @236
// &Force("bus", "bmu_biu_ibus_source_pc", 31, 0); @239
// &Force("bus", "bmu_biu_dbus_source_pc", 31, 0); @240
// &Connect( .bmu_ahbl_ibus_source_pc   (bmu_biu_ibus_source_pc[29:8]), @241
//           .bmu_ahbl_ibus_load        (1'b0                        ), @242
//           .bmu_ahbl_ibus_store       (1'b0                        ), @243
//           .bmu_ahbl_ibus_inst_fetch_chk (bmu_biu_ibus_inst_fetch_chk )); @244
// &Connect( .bmu_ahbl_dbus_source_pc   (bmu_biu_dbus_source_pc[29:8]), @245
//           .bmu_ahbl_dbus_load        (bmu_biu_dbus_load        ), @246
//           .bmu_ahbl_dbus_store       (bmu_biu_dbus_store       ), @247
//           .bmu_ahbl_dbus_inst_fetch_chk (bmu_biu_dbus_inst_fetch_chk )); @248
// &Connect( .ahbl_bmu_ibus_inst_dbg_disable (biu_bmu_ibus_inst_dbg_disable )); @253
// &Connect( .bmu_ahbl_ibus_hit (bmu_biu_ibus_hit)); @255

//==========================================================
//  Instance Bus Interface module
//  Width Adjust Module is needed for 16-bits BUS 
//==========================================================
// &Instance("cr_ahbl_wid_adj_fo"); @264
// &Instance("cr_ahbl_if_fo_hw"); @265
// &Connect(.cpu_addr        (cpu_addr_raw       ), @266
//          .cpu_prot        (cpu_prot_raw       ), @267
//          .cpu_req         (cpu_req_raw        ), @268
//          .cpu_size        (cpu_size_raw       ), @269
//          .cpu_wdata       (cpu_wdata_raw      ), @270
//          .cpu_write       (cpu_write_raw      ), @271
//          .cpu_acc_err     (cpu_acc_err_raw    ), @272
//          .cpu_data_vld    (cpu_data_vld_raw   ), @273
//          .cpu_rdata       (cpu_rdata_raw      ), @274
//          .cpu_req_grnt    (cpu_req_grnt_raw   ), @275
//          .cpu_trans_cmplt (cpu_trans_cmplt_raw) @276
// ); @277
// &Connect(.ahbLif_ahbl_haddr      (biu_pad_haddr         ), @278
//          .ahbLif_ahbl_hburst     (biu_pad_hburst        ), @279
//          .ahbLif_ahbl_hprot      (biu_pad_hprot         ), @280
//          .ahbLif_ahbl_hsize      (biu_pad_hsize         ), @281
//          .ahbLif_ahbl_htrans     (biu_pad_htrans        ), @282
//          .ahbLif_ahbl_hwdata     (biu_pad_hwdata        ), @283
//          .ahbLif_ahbl_hwrite     (biu_pad_hwrite        ), @284
//          .ahbl_ahbLif_hrdata     (pad_biu_hrdata        ), @285
//          .ahbl_ahbLif_hready     (pad_biu_hready        ), @286
//          .ahbl_ahbLif_hresp      (pad_biu_hresp         )); @287
// &Connect(.ahbLif_ahbl_haddr_pol  (biu_pad_haddr_pol     ), @289
//          .ahbLif_ahbl_hwdata_pol (biu_pad_hwdata_pol    ), @290
//          .ahbl_ahbLif_hrdata_pol (pad_biu_hrdata_pol    )); @291
// &Connect(.ahbLif_ahbl_hwdata_par (biu_pad_hwdata_par    ), @294
//          .ahbl_ahbLif_hrdata_par (pad_biu_hrdata_par    )); @295
// &Connect(.ahbl_ahbLif_inst_dbg_disable (pad_biu_inst_dbg_disable )); @298
// &Instance("cr_ahbl_wid_adj"); @301
// &Instance("cr_ahbl_if_hw"); @302
// &Connect(.cpu_addr        (cpu_addr_raw       ), @303
//          .cpu_prot        (cpu_prot_raw       ), @304
//          .cpu_req         (cpu_req_raw        ), @305
//          .cpu_size        (cpu_size_raw       ), @306
//          .cpu_wdata       (cpu_wdata_raw      ), @307
//          .cpu_write       (cpu_write_raw      ), @308
//          .cpu_acc_err     (cpu_acc_err_raw    ), @309
//          .cpu_data_vld    (cpu_data_vld_raw   ), @310
//          .cpu_rdata       (cpu_rdata_raw      ), @311
//          .cpu_req_grnt    (cpu_req_grnt_raw   ), @312
//          .cpu_trans_cmplt (cpu_trans_cmplt_raw) @313
// ); @314
// &Connect(.ahbLif_ahbl_haddr      (biu_pad_haddr         ), @315
//          .ahbLif_ahbl_hburst     (biu_pad_hburst        ), @316
//          .ahbLif_ahbl_hprot      (biu_pad_hprot         ), @317
//          .ahbLif_ahbl_hsize      (biu_pad_hsize         ), @318
//          .ahbLif_ahbl_htrans     (biu_pad_htrans        ), @319
//          .ahbLif_ahbl_hwdata     (biu_pad_hwdata        ), @320
//          .ahbLif_ahbl_hwrite     (biu_pad_hwrite        ), @321
//          .ahbl_ahbLif_hrdata     (pad_biu_hrdata        ), @322
//          .ahbl_ahbLif_hready     (pad_biu_hready        ), @323
//          .ahbl_ahbLif_hresp      (pad_biu_hresp         )); @324
// &Connect(.ahbLif_ahbl_haddr_pol  (biu_pad_haddr_pol     ), @326
//          .ahbLif_ahbl_hwdata_pol (biu_pad_hwdata_pol    ), @327
//          .ahbl_ahbLif_hrdata_pol (pad_biu_hrdata_pol    )); @328
// &Connect(.ahbLif_ahbl_hwdata_par (biu_pad_hwdata_par    ), @331
//          .ahbl_ahbLif_hrdata_par (pad_biu_hrdata_par    )); @332
// &Connect(.ahbl_ahbLif_inst_dbg_disable (pad_biu_inst_dbg_disable )); @335

// &Instance("cr_ahb_if_fo", "x_cr_ahbl_if_fo"); @342
// &Force("input", "pwrm_cpu_bus_peak_power_limit_en"); @343
// &Force("input", "iahblif_other_mask"); @344
// &Force("input", "dahblif_other_mask"); @345
// &Instance("cr_ahb_if", "x_cr_ahbl_if"); @353
// &Connect(.ahbif_busy           (ahblif_busy           )); @354
// &Force("nonport", "cpu_req_for_peak_power"); @358
// &Force("nonport", "cpu_wdata_sel"); @360
// &Connect(.cpu_wr_data            (cpu_wdata             )); @361
// &Force("input", "pwrm_cpu_bus_peak_power_limit_en"); @364
// &Force("nonport", "cpu_req_for_peak_power"); @365
// &Force("nonport", "ahblif_busy"); @366
// &Connect(.ahb_gated_clk        (ahbl_gated_clk        )); @376
// &Connect(.ahb_clk_en           (ahbl_clk_en           )); @377
// &Connect(.ahbif_power_mask     (ahblif_power_mask     )); @378
// &Connect(.ahbif_ahb_haddr      (biu_ebmu_haddr         ), @379
//          .ahbif_ahb_hburst     (biu_ebmu_hburst        ), @380
//          .ahbif_ahb_hprot      (biu_ebmu_hprot         ), @381
//          .ahbif_ahb_hsize      (biu_ebmu_hsize         ), @382
//          .ahbif_ahb_htrans     (biu_ebmu_htrans        ), @383
//          .ahbif_ahb_hbusreq    (biu_ebmu_hbusreq       ), @384
//          .ahbif_ahb_hwdata     (biu_ebmu_hwdata        ), @385
//          .ahbif_ahb_hwrite     (biu_ebmu_hwrite        ), @386
//          .ahbif_wfd            (biu_ebmu_wfd        ), @387
//          .ahb_ahbif_hrdata     (ebmu_biu_hrdata        ), @388
//          .ahb_ahbif_hready     (ebmu_biu_hready        ), @389
//          .ahb_ahbif_hgrant     (ebmu_biu_hgrant        ), @390
//          .ahb_ahbif_hresp      (ebmu_biu_hresp         )); @391
// &Connect(.ahbif_ahb_haddr_pol  (biu_ebmu_haddr_pol     ), @393
//          .ahbif_ahb_hwdata_pol (biu_ebmu_hwdata_pol    ), @394
//          .ahb_ahbif_hrdata_pol (ebmu_biu_hrdata_pol    )); @395
// &Connect(.ahbif_ahb_hwdata_par (biu_ebmu_hwdata_par    ), @398
//          .ahb_ahbif_hrdata_par (ebmu_biu_hrdata_par    )); @399
// &Connect(.ahb_ahbif_inst_dbg_disable (ebmu_biu_inst_dbg_disable )); @402
// &Connect(.ahbif_ahb_source_pc   (biu_ebmu_source_pc    ), @405
//          .ahbif_ahb_load        (biu_ebmu_load         ), @406
//          .ahbif_ahb_store       (biu_ebmu_store        ), @407
//          .ahbif_ahb_inst_fetch_chk (biu_ebmu_inst_fetch_chk  )); @408
// &Connect(.ahbif_ahb_vec_redrct (biu_ebmu_vec_redrct)); @410
// &Connect(.uncmplt_mask (cache_uncmplt_mask)); @417
// &Force("nonport", "cpu_req_for_grnt"); @423
// &Instance("cr_ahbl_if_fo"); @426
// &Force("input", "pwrm_cpu_bus_peak_power_limit_en"); @427
// &Force("input", "iahblif_other_mask"); @428
// &Force("input", "dahblif_other_mask"); @429
// &Instance("cr_ahbl_if"); @437
cr_ahbl_if  x_cr_ahbl_if (
  .ahbLif_ahbl_haddr    (biu_pad_haddr       ),
  .ahbLif_ahbl_hburst   (biu_pad_hburst      ),
  .ahbLif_ahbl_hprot    (biu_pad_hprot       ),
  .ahbLif_ahbl_hsize    (biu_pad_hsize       ),
  .ahbLif_ahbl_htrans   (biu_pad_htrans      ),
  .ahbLif_ahbl_hwdata   (biu_pad_hwdata      ),
  .ahbLif_ahbl_hwrite   (biu_pad_hwrite      ),
  .ahbl_ahbLif_hrdata   (pad_biu_hrdata      ),
  .ahbl_ahbLif_hready   (pad_biu_hready      ),
  .ahbl_ahbLif_hresp    (pad_biu_hresp       ),
  .ahbl_clk_en          (ahbl_clk_en         ),
  .ahbl_gated_clk       (ahbl_gated_clk      ),
  .ahblif_busy          (ahblif_busy         ),
  .ahblif_idle          (ahblif_idle         ),
  .ahblif_power_mask    (ahblif_power_mask   ),
  .cpu_acc_err          (cpu_acc_err         ),
  .cpu_addr             (cpu_addr            ),
  .cpu_data_vld         (cpu_data_vld        ),
  .cpu_prot             (cpu_prot            ),
  .cpu_rdata            (cpu_rdata           ),
  .cpu_req              (cpu_req             ),
  .cpu_req_grnt         (cpu_req_grnt        ),
  .cpu_req_power_masked (cpu_req_power_masked),
  .cpu_sec              (cpu_sec             ),
  .cpu_size             (cpu_size            ),
  .cpu_trans_cmplt      (cpu_trans_cmplt     ),
  .cpu_vec_redirect     (cpu_vec_redirect    ),
  .cpu_wdata_sel        (cpu_wdata_sel       ),
  .cpu_wr_data          (cpu_wdata           ),
  .cpu_write            (cpu_write           ),
  .cpurst_b             (cpurst_b            ),
  .pad_cpu_halt_ff2     (pad_cpu_halt_ff2    )
);

// &Force("nonport", "cpu_req_for_peak_power"); @441
// &Force("nonport", "cpu_wdata_sel"); @443
// &Connect(.cpu_wr_data            (cpu_wdata             )); @444
// &Force("input", "pwrm_cpu_bus_peak_power_limit_en"); @447
// &Force("nonport", "cpu_req_for_peak_power"); @448
// &Force("nonport", "ahblif_busy"); @449
assign sahblif_iahblif_mask = (ahblif_busy || cpu_req_for_peak_power) && 
                               pwrm_cpu_bus_peak_power_limit_en;
assign ahblif_power_mask  = iahblif_other_mask || dahblif_other_mask;
assign cpu_req_power_masked = cpu_req && !ahblif_power_mask;
// &Connect(.ahbLif_ahbl_haddr      (biu_pad_haddr         ), @459
//          .ahbLif_ahbl_hburst     (biu_pad_hburst        ), @460
//          .ahbLif_ahbl_hprot      (biu_pad_hprot         ), @461
//          .ahbLif_ahbl_hsize      (biu_pad_hsize         ), @462
//          .ahbLif_ahbl_htrans     (biu_pad_htrans        ), @463
//          .ahbLif_ahbl_hwdata     (biu_pad_hwdata        ), @464
//          .ahbLif_ahbl_hwrite     (biu_pad_hwrite        ), @465
//          .ahbl_ahbLif_hrdata     (pad_biu_hrdata        ), @466
//          .ahbl_ahbLif_hready     (pad_biu_hready        ), @467
//          .ahbl_ahbLif_hresp      (pad_biu_hresp         )); @468
// &Connect(.ahbLif_ahbl_haddr_pol  (biu_pad_haddr_pol     ), @470
//          .ahbLif_ahbl_hwdata_pol (biu_pad_hwdata_pol    ), @471
//          .ahbl_ahbLif_hrdata_pol (pad_biu_hrdata_pol    )); @472
// &Connect(.ahbLif_ahbl_hwdata_par (biu_pad_hwdata_par    ), @475
//          .ahbl_ahbLif_hrdata_par (pad_biu_hrdata_par    )); @476
// &Connect(.ahbl_ahbLif_inst_dbg_disable (pad_biu_inst_dbg_disable )); @479
// &Connect(.ahbLif_ahbl_source_pc   (biu_pad_source_pc    ), @482
//          .ahbLif_ahbl_load        (biu_pad_load         ), @483
//          .ahbLif_ahbl_store       (biu_pad_store        ), @484
//          .ahbLif_ahbl_inst_fetch_chk (biu_pad_inst_fetch_chk  )); @485
// &Connect(.ahbLif_ahbl_vec_redrct (biu_pad_vec_redrct)); @487
// &Connect(.uncmplt_mask (cache_uncmplt_mask)); @495
// &Instance("cr_ahb_if_fo", "x_cr_ahbl_if_fo"); @503
// &Force("input", "pwrm_cpu_bus_peak_power_limit_en"); @504
// &Force("input", "iahblif_other_mask"); @505
// &Force("input", "dahblif_other_mask"); @506
// &Instance("cr_ahb_if", "x_cr_ahbl_if"); @514
// &Connect(.ahbif_busy           (ahblif_busy           )); @515
// &Force("nonport", "cpu_req_for_peak_power"); @519
// &Force("nonport", "cpu_wdata_sel"); @521
// &Connect(.cpu_wr_data            (cpu_wdata             )); @522
// &Force("input", "pwrm_cpu_bus_peak_power_limit_en"); @525
// &Force("nonport", "cpu_req_for_peak_power"); @526
// &Force("nonport", "ahblif_busy"); @527
// &Force("nonport", "ahbif_wfd"); @537
// &Connect(.ahb_gated_clk        (ahbl_gated_clk        )); @538
// &Connect(.ahb_clk_en           (ahbl_clk_en           )); @539
// &Connect(.ahbif_power_mask     (ahblif_power_mask     )); @540
// &Connect(.ahbif_ahb_haddr      (biu_pad_haddr         ), @541
//          .ahbif_ahb_hburst     (biu_pad_hburst        ), @542
//          .ahbif_ahb_hprot      (biu_pad_hprot         ), @543
//          .ahbif_ahb_hsize      (biu_pad_hsize         ), @544
//          .ahbif_ahb_htrans     (biu_pad_htrans        ), @545
//          .ahbif_ahb_hbusreq    (biu_pad_hbusreq       ), @546
//          .ahbif_ahb_hwdata     (biu_pad_hwdata        ), @547
//          .ahbif_ahb_hwrite     (biu_pad_hwrite        ), @548
//          .ahb_ahbif_hrdata     (pad_biu_hrdata        ), @549
//          .ahb_ahbif_hready     (pad_biu_hready        ), @550
//          .ahb_ahbif_hgrant     (pad_biu_hgrant        ), @551
//          .ahb_ahbif_hresp      (pad_biu_hresp         )); @552
// &Connect(.ahbif_ahb_haddr_pol  (biu_pad_haddr_pol     ), @554
//          .ahbif_ahb_hwdata_pol (biu_pad_hwdata_pol    ), @555
//          .ahb_ahbif_hrdata_pol (pad_biu_hrdata_pol    )); @556
// &Connect(.ahbif_ahb_hwdata_par (biu_pad_hwdata_par    ), @559
//          .ahb_ahbif_hrdata_par (pad_biu_hrdata_par    )); @560
// &Connect(.ahb_ahbif_inst_dbg_disable (pad_biu_inst_dbg_disable )); @563
// &Connect(.ahbif_ahb_source_pc   (biu_pad_source_pc    ), @566
//          .ahbif_ahb_load        (biu_pad_load         ), @567
//          .ahbif_ahb_store       (biu_pad_store        ), @568
//          .ahbif_ahb_inst_fetch_chk (biu_pad_inst_fetch_chk  )); @569
// &Connect(.ahbif_ahb_vec_redrct (biu_pad_vec_redrct)); @571
// &Connect(.uncmplt_mask (cache_uncmplt_mask)); @579

// &ModuleEnd; @587
endmodule


