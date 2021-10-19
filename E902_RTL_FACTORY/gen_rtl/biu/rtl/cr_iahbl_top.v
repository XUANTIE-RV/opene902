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
module cr_iahbl_top(
  ahblif_idle,
  bmu_iahbl_dbus_acc_deny,
  bmu_iahbl_dbus_addr,
  bmu_iahbl_dbus_chk_fail,
  bmu_iahbl_dbus_prot,
  bmu_iahbl_dbus_req,
  bmu_iahbl_dbus_req_without_cmplt,
  bmu_iahbl_dbus_size,
  bmu_iahbl_dbus_wdata,
  bmu_iahbl_dbus_write,
  bmu_iahbl_ibus_acc_deny,
  bmu_iahbl_ibus_addr,
  bmu_iahbl_ibus_hit,
  bmu_iahbl_ibus_prot,
  bmu_iahbl_ibus_req,
  bmu_iahbl_ibus_req_no_hit,
  bmu_iahbl_ibus_size,
  bmu_iahbl_ibus_vec_redirect,
  cpurst_b,
  dahblif_other_mask,
  forever_cpuclk,
  iahbl_bmu_dbus_acc_err,
  iahbl_bmu_dbus_data,
  iahbl_bmu_dbus_data_vld,
  iahbl_bmu_dbus_grnt,
  iahbl_bmu_dbus_trans_cmplt,
  iahbl_bmu_ibus_acc_err,
  iahbl_bmu_ibus_data,
  iahbl_bmu_ibus_data_vld,
  iahbl_bmu_ibus_grnt,
  iahbl_bmu_ibus_trans_cmplt,
  iahbl_pad_haddr,
  iahbl_pad_hburst,
  iahbl_pad_hprot,
  iahbl_pad_hsize,
  iahbl_pad_htrans,
  iahbl_pad_hwdata,
  iahbl_pad_hwrite,
  iahblif_other_mask,
  pad_cpu_halt_ff2,
  pad_iahbl_hrdata,
  pad_iahbl_hready,
  pad_iahbl_hresp,
  pad_yy_gate_clk_en_b,
  pwrm_cpu_bus_peak_power_limit_en,
  sahblif_iahblif_mask
);

// &Ports; @23
input           bmu_iahbl_dbus_acc_deny;         
input   [31:0]  bmu_iahbl_dbus_addr;             
input           bmu_iahbl_dbus_chk_fail;         
input   [3 :0]  bmu_iahbl_dbus_prot;             
input           bmu_iahbl_dbus_req;              
input           bmu_iahbl_dbus_req_without_cmplt; 
input   [1 :0]  bmu_iahbl_dbus_size;             
input   [31:0]  bmu_iahbl_dbus_wdata;            
input           bmu_iahbl_dbus_write;            
input           bmu_iahbl_ibus_acc_deny;         
input   [31:0]  bmu_iahbl_ibus_addr;             
input           bmu_iahbl_ibus_hit;              
input   [3 :0]  bmu_iahbl_ibus_prot;             
input           bmu_iahbl_ibus_req;              
input           bmu_iahbl_ibus_req_no_hit;       
input   [1 :0]  bmu_iahbl_ibus_size;             
input           bmu_iahbl_ibus_vec_redirect;     
input           cpurst_b;                        
input           dahblif_other_mask;              
input           forever_cpuclk;                  
input           pad_cpu_halt_ff2;                
input   [31:0]  pad_iahbl_hrdata;                
input           pad_iahbl_hready;                
input           pad_iahbl_hresp;                 
input           pad_yy_gate_clk_en_b;            
input           pwrm_cpu_bus_peak_power_limit_en; 
input           sahblif_iahblif_mask;            
output          ahblif_idle;                     
output          iahbl_bmu_dbus_acc_err;          
output  [31:0]  iahbl_bmu_dbus_data;             
output          iahbl_bmu_dbus_data_vld;         
output          iahbl_bmu_dbus_grnt;             
output          iahbl_bmu_dbus_trans_cmplt;      
output          iahbl_bmu_ibus_acc_err;          
output  [31:0]  iahbl_bmu_ibus_data;             
output          iahbl_bmu_ibus_data_vld;         
output          iahbl_bmu_ibus_grnt;             
output          iahbl_bmu_ibus_trans_cmplt;      
output  [31:0]  iahbl_pad_haddr;                 
output  [2 :0]  iahbl_pad_hburst;                
output  [3 :0]  iahbl_pad_hprot;                 
output  [2 :0]  iahbl_pad_hsize;                 
output  [1 :0]  iahbl_pad_htrans;                
output  [31:0]  iahbl_pad_hwdata;                
output          iahbl_pad_hwrite;                
output          iahblif_other_mask;              

// &Regs; @24

// &Wires; @25
wire            ahbl_clk_en;                     
wire            ahbl_gated_clk;                  
wire            ahblif_busy;                     
wire            ahblif_idle;                     
wire            ahblif_power_mask;               
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
wire    [31:0]  cpu_wr_data;                     
wire            cpu_write;                       
wire            cpurst_b;                        
wire            dahblif_other_mask;              
wire            dbus_mask;                       
wire            forever_cpuclk;                  
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
wire            ibus_not_granted;                
wire            pad_cpu_halt_ff2;                
wire    [31:0]  pad_iahbl_hrdata;                
wire            pad_iahbl_hready;                
wire            pad_iahbl_hresp;                 
wire            pad_yy_gate_clk_en_b;            
wire            pwrm_cpu_bus_peak_power_limit_en; 
wire            sahblif_iahblif_mask;            


//assign pad_iahbl_hsec = 1'b0;

 //==========================================================
 //  Instance Gated Cell for Most Common Use
 //==========================================================
//  &Instance("gated_clk_cell", "x_gated_ahbl_cpuclk_cell"); @41
gated_clk_cell  x_gated_ahbl_cpuclk_cell (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (ahbl_gated_clk      ),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (dbus_mask           ),
  .module_en            (ahbl_clk_en         ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

//  &Connect(.clk_in     (forever_cpuclk), @42
//           .global_en  (1'b1          ), @43
//           .module_en  (ahbl_clk_en   ), @44
//           .local_en   (dbus_mask     ), @45
//           .external_en(1'b0          ), @46
//           .clk_out    (ahbl_gated_clk)); @47
 
//==========================================================
//  Instance Request Arbiter module 
//==========================================================
// &Instance("cr_ahbl_req_arb_fo_cache"); @54
// &Instance("cr_ahbl_req_arb_fo"); @56
// &Connect(.cpu_req_bus_sel (cpu_req_bus_grnt)); @58
// &Force("nonport", "cpu_req_bus_ff"); @59
// &Force("input", "bmu_iahbl_ibus_req_no_hit"); @60
// &Force("nonport", "uncmplt_mask"); @64
// &Instance("cr_ahbl_req_arb_cache"); @68
// &Instance("cr_ahbl_req_arb"); @70
cr_ahbl_req_arb  x_cr_ahbl_req_arb (
  .ahbl_bmu_dbus_acc_err                   (iahbl_bmu_dbus_acc_err                 ),
  .ahbl_bmu_dbus_data                      (iahbl_bmu_dbus_data                    ),
  .ahbl_bmu_dbus_data_vld                  (iahbl_bmu_dbus_data_vld                ),
  .ahbl_bmu_dbus_grnt                      (iahbl_bmu_dbus_grnt                    ),
  .ahbl_bmu_dbus_trans_cmplt               (iahbl_bmu_dbus_trans_cmplt             ),
  .ahbl_bmu_ibus_acc_err                   (iahbl_bmu_ibus_acc_err                 ),
  .ahbl_bmu_ibus_data                      (iahbl_bmu_ibus_data                    ),
  .ahbl_bmu_ibus_data_vld                  (iahbl_bmu_ibus_data_vld                ),
  .ahbl_bmu_ibus_grnt                      (iahbl_bmu_ibus_grnt                    ),
  .ahbl_bmu_ibus_trans_cmplt               (iahbl_bmu_ibus_trans_cmplt             ),
  .ahbl_gated_clk                          (ahbl_gated_clk                         ),
  .bmu_ahbl_dbus_acc_deny                  (bmu_iahbl_dbus_acc_deny                ),
  .bmu_ahbl_dbus_addr                      (bmu_iahbl_dbus_addr                    ),
  .bmu_ahbl_dbus_chk_fail                  (bmu_iahbl_dbus_chk_fail                ),
  .bmu_ahbl_dbus_prot                      (bmu_iahbl_dbus_prot                    ),
  .bmu_ahbl_dbus_req                       (bmu_iahbl_dbus_req                     ),
  .bmu_ahbl_dbus_req_without_cmplt         (bmu_iahbl_dbus_req_without_cmplt       ),
  .bmu_ahbl_dbus_req_without_deny_chk_fail (bmu_iahbl_dbus_req                     ),
  .bmu_ahbl_dbus_size                      (bmu_iahbl_dbus_size                    ),
  .bmu_ahbl_dbus_write                     (bmu_iahbl_dbus_write                   ),
  .bmu_ahbl_ibus_acc_deny                  (bmu_iahbl_ibus_acc_deny                ),
  .bmu_ahbl_ibus_addr                      (bmu_iahbl_ibus_addr                    ),
  .bmu_ahbl_ibus_hit                       (bmu_iahbl_ibus_hit                     ),
  .bmu_ahbl_ibus_prot                      (bmu_iahbl_ibus_prot                    ),
  .bmu_ahbl_ibus_req                       (bmu_iahbl_ibus_req                     ),
  .bmu_ahbl_ibus_req_no_hit                (bmu_iahbl_ibus_req_no_hit              ),
  .bmu_ahbl_ibus_size                      (bmu_iahbl_ibus_size                    ),
  .bmu_ahbl_ibus_vec_redirect              (bmu_iahbl_ibus_vec_redirect            ),
  .bmu_ahbl_ibus_write                     (1'b0                                   ),
  .bmu_ahbl_wdata                          (bmu_iahbl_dbus_wdata                   ),
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
// &Force("nonport", "cpu_req_for_peak_power"); @74
// &Connect( .ahbl_bmu_bus_check_fail   (ahbl_cache_bus_check_fail), @76
//           .ahbl_bmu_ibus_acc_err     (ahbl_cache_lf_acc_err    ), @77
//           .ahbl_bmu_ibus_sec         (ahbl_cache_lf_sec        ), @78
//           .ahbl_bmu_ibus_data        (ahbl_cache_lf_data       ), @79
//           .ahbl_bmu_ibus_data_vld    (ahbl_cache_lf_data_vld   ), @80
//           .ahbl_bmu_ibus_grnt        (ahbl_cache_lf_grnt       ), @81
//           .ahbl_bmu_ibus_trans_cmplt (ahbl_cache_lf_trans_cmplt), @82
//           .ahbl_bmu_dbus_acc_err     (ahbl_cache_uc_acc_err    ), @83
//           .ahbl_bmu_dbus_data        (ahbl_cache_uc_data       ), @84
//           .ahbl_bmu_dbus_data_vld    (ahbl_cache_uc_data_vld   ), @85
//           .ahbl_bmu_dbus_trans_cmplt (ahbl_cache_uc_trans_cmplt), @86
//           .ahbl_bmu_dbus_grnt        (ahbl_cache_uc_grnt       ), @87
//           .bmu_ahbl_ibus_acc_deny    (1'b0                     ), @88
//           .bmu_ahbl_ibus_addr        (cache_ahbl_lf_addr       ), @89
//           .bmu_ahbl_ibus_prot        (cache_ahbl_lf_prot       ), @90
//           .bmu_ahbl_ibus_req         (cache_ahbl_lf_req        ), @91
//           .bmu_ahbl_ibus_req_no_hit  (cache_ahbl_lf_req        ), @92
//           .bmu_ahbl_ibus_size        (cache_ahbl_lf_size       ), @93
//           .bmu_ahbl_ibus_write       (1'b0                     ), @94
//           .bmu_ahbl_wdata            (cache_ahbl_uc_wdata      ), @95
//           .bmu_ahbl_dbus_acc_deny    (1'b0                     ), @96
//           .bmu_ahbl_dbus_chk_fail    (1'b0                     ), @97
//           .bmu_ahbl_dbus_addr        (cache_ahbl_uc_addr       ), @98
//           .bmu_ahbl_dbus_prot        (cache_ahbl_uc_prot       ), @99
//           .bmu_ahbl_dbus_req         (cache_ahbl_uc_req        ), @100
//           .bmu_ahbl_dbus_req_without_deny_chk_fail(cache_ahbl_uc_req_without_cmplt), @101
//           .bmu_ahbl_dbus_req_without_cmplt (cache_ahbl_uc_req_without_cmplt), @102
//           .bmu_ahbl_dbus_size        (cache_ahbl_uc_size       ), @103
//           .bmu_ahbl_ibus_vec_redirect (cache_ahbl_uc_vec_redirect), @104
//           .bmu_ahbl_dbus_write       (cache_ahbl_uc_write      )); @105
// &Connect( .ahbl_bmu_ibus_data_pol    (ahbl_cache_lf_data_pol   ), @107
//           .ahbl_bmu_dbus_data_pol    (ahbl_cache_uc_data_pol   ), @108
//           .bmu_ahbl_wdata_pol        (cache_ahbl_uc_wdata_pol  )); @109
// &Connect( .bmu_ahbl_dbus_source_pc   (cache_ahbl_uc_source_pc  ), @112
//           .bmu_ahbl_dbus_load        (cache_ahbl_uc_load       ), @113
//           .bmu_ahbl_dbus_store       (cache_ahbl_uc_store      ), @114
//           .bmu_ahbl_dbus_inst_fetch_chk (cache_ahbl_uc_inst_fetch_chk)); @115
// &Connect( .bmu_ahbl_ibus_source_pc   (cache_ahbl_lf_source_pc  ), @116
//           .bmu_ahbl_ibus_load        (1'b0                     ), @117
//           .bmu_ahbl_ibus_store       (1'b0                     ), @118
//           .bmu_ahbl_ibus_inst_fetch_chk (cache_ahbl_lf_inst_fetch_chk)); @119
// &Connect( .ahbl_bmu_ibus_inst_dbg_disable (ahbl_cache_bus_inst_dbg_disable )); @122
// &Connect( .bmu_ahbl_ibus_hit (cache_ahbl_lf_req)); @124
// &Connect( .ahbl_bmu_bus_check_fail   (iahbl_bmu_bus_check_fail   ), @126
//           .ahbl_bmu_dbus_acc_err     (iahbl_bmu_dbus_acc_err     ), @127
//           .ahbl_bmu_dbus_data        (iahbl_bmu_dbus_data        ), @128
//           .ahbl_bmu_dbus_data_vld    (iahbl_bmu_dbus_data_vld    ), @129
//           .ahbl_bmu_dbus_grnt        (iahbl_bmu_dbus_grnt        ), @130
//           .ahbl_bmu_dbus_trans_cmplt (iahbl_bmu_dbus_trans_cmplt ), @131
//           .ahbl_bmu_ibus_acc_err     (iahbl_bmu_ibus_acc_err     ), @132
//           .ahbl_bmu_ibus_data        (iahbl_bmu_ibus_data        ), @133
//           .ahbl_bmu_ibus_data_vld    (iahbl_bmu_ibus_data_vld    ), @134
//           .ahbl_bmu_ibus_grnt        (iahbl_bmu_ibus_grnt        ), @135
//           .ahbl_bmu_ibus_trans_cmplt (iahbl_bmu_ibus_trans_cmplt ), @136
//           .bmu_ahbl_dbus_acc_deny    (bmu_iahbl_dbus_acc_deny    ), @137
//           .bmu_ahbl_dbus_chk_fail    (bmu_iahbl_dbus_chk_fail    ), @138
//           .bmu_ahbl_dbus_addr        (bmu_iahbl_dbus_addr        ), @139
//           .bmu_ahbl_dbus_prot        (bmu_iahbl_dbus_prot        ), @140
//           .bmu_ahbl_dbus_req         (bmu_iahbl_dbus_req         ), @141
//           .bmu_ahbl_dbus_req_without_deny_chk_fail(bmu_iahbl_dbus_req), @142
//           .bmu_ahbl_dbus_req_without_cmplt (bmu_iahbl_dbus_req_without_cmplt), @143
//           .bmu_ahbl_dbus_size        (bmu_iahbl_dbus_size        ), @144
//           .bmu_ahbl_wdata            (bmu_iahbl_dbus_wdata       ), @145
//           .bmu_ahbl_dbus_write       (bmu_iahbl_dbus_write       ), @146
//           .bmu_ahbl_ibus_acc_deny    (bmu_iahbl_ibus_acc_deny    ), @147
//           .bmu_ahbl_ibus_addr        (bmu_iahbl_ibus_addr        ), @148
//           .bmu_ahbl_ibus_prot        (bmu_iahbl_ibus_prot        ), @149
//           .bmu_ahbl_ibus_req         (bmu_iahbl_ibus_req         ), @150
//           .bmu_ahbl_ibus_req_no_hit  (bmu_iahbl_ibus_req_no_hit  ), @151
//           .bmu_ahbl_ibus_size        (bmu_iahbl_ibus_size        ), @152
//           .bmu_ahbl_ibus_vec_redirect (bmu_iahbl_ibus_vec_redirect), @153
//           .bmu_ahbl_ibus_write       (1'b0                       )); @154
// &Connect( .ahbl_bmu_dbus_data_pol    (iahbl_bmu_dbus_data_pol    ), @156
//           .ahbl_bmu_ibus_data_pol    (iahbl_bmu_ibus_data_pol    ), @157
//           .bmu_ahbl_wdata_pol        (bmu_iahbl_dbus_wdata_pol   )); @158
// &Connect( .ahbl_bmu_had_acc_err      (iahbl_bmu_had_acc_err      ), @161
//           .ahbl_bmu_had_data         (iahbl_bmu_had_data         ), @162
//           .ahbl_bmu_had_data_vld     (iahbl_bmu_had_data_vld     ), @163
//           .ahbl_bmu_had_grnt         (iahbl_bmu_had_grnt         ), @164
//           .ahbl_bmu_had_trans_cmplt  (iahbl_bmu_had_trans_cmplt  ), @165
//           .bmu_ahbl_had_addr         (bmu_iahbl_had_addr         ), @166
//           .bmu_ahbl_had_prot         (bmu_iahbl_had_prot         ), @167
//           .bmu_ahbl_had_req          (bmu_iahbl_had_req          ), @168
//           .bmu_ahbl_had_req_without_cmplt   (bmu_iahbl_had_req_without_cmplt), @169
//           .bmu_ahbl_had_size         (bmu_iahbl_had_size         ), @170
//           .bmu_ahbl_had_wdata        (bmu_iahbl_had_wdata        ), @171
//           .bmu_ahbl_had_write        (bmu_iahbl_had_write        )); @172
// &Force("bus", "bmu_iahbl_ibus_source_pc", 31, 0); @175
// &Force("bus", "bmu_iahbl_dbus_source_pc", 31, 0); @176
// &Connect( .bmu_ahbl_ibus_source_pc   (bmu_iahbl_ibus_source_pc[29:8]), @177
//           .bmu_ahbl_ibus_load        (1'b0                       ), @178
//           .bmu_ahbl_ibus_store       (1'b0                       ), @179
//           .bmu_ahbl_ibus_inst_fetch_chk (bmu_iahbl_ibus_inst_fetch_chk )); @180
// &Connect( .bmu_ahbl_dbus_source_pc   (bmu_iahbl_dbus_source_pc[29:8]), @181
//           .bmu_ahbl_dbus_load        (bmu_iahbl_dbus_load        ), @182
//           .bmu_ahbl_dbus_store       (bmu_iahbl_dbus_store       ), @183
//           .bmu_ahbl_dbus_inst_fetch_chk (bmu_iahbl_dbus_inst_fetch_chk )); @184
// &Connect( .ahbl_bmu_ibus_inst_dbg_disable (iahbl_bmu_ibus_inst_dbg_disable )); @189
// &Connect( .bmu_ahbl_ibus_hit (bmu_iahbl_ibus_hit)); @191

//==========================================================
//  Instance Bus Interface module
//  Width Adjust Module is needed for 16-bits BUS 
//==========================================================
// &Instance("cr_ahbl_wid_adj_fo"); @200
// &Connect(.clk_en          (iahbl_clk_en       )); @201
// &Instance("cr_ahbl_if_fo_hw"); @202
// &Connect(.cpu_addr        (cpu_addr_raw       ), @203
//          .cpu_prot        (cpu_prot_raw       ), @204
//          .cpu_req         (cpu_req_raw        ), @205
//          .cpu_size        (cpu_size_raw       ), @206
//          .cpu_wdata       (cpu_wdata_raw      ), @207
//          .cpu_write       (cpu_write_raw      ), @208
//          .cpu_acc_err     (cpu_acc_err_raw    ), @209
//          .cpu_data_vld    (cpu_data_vld_raw   ), @210
//          .cpu_rdata       (cpu_rdata_raw      ), @211
//          .cpu_req_grnt    (cpu_req_grnt_raw   ), @212
//          .cpu_trans_cmplt (cpu_trans_cmplt_raw) @213
// ); @214
// &Connect(.ahbLif_ahbl_haddr      (iahbl_pad_haddr         ), @215
//          .ahbLif_ahbl_hburst     (iahbl_pad_hburst        ), @216
//          .ahbLif_ahbl_hprot      (iahbl_pad_hprot         ), @217
//          .ahbLif_ahbl_hsize      (iahbl_pad_hsize         ), @218
//          .ahbLif_ahbl_htrans     (iahbl_pad_htrans        ), @219
//          .ahbLif_ahbl_hwdata     (iahbl_pad_hwdata        ), @220
//          .ahbLif_ahbl_hwrite     (iahbl_pad_hwrite        ), @221
//          .ahbl_ahbLif_hrdata     (pad_iahbl_hrdata        ), @222
//          .ahbl_ahbLif_hready     (pad_iahbl_hready        ), @223
//          .ahbl_ahbLif_hsec       (pad_iahbl_hsec          ), @224
//          .ahbl_ahbLif_hresp      (pad_iahbl_hresp         )); @225
// &Connect(.clk_en                 (iahbl_clk_en            )); @226
// &Connect(.ahbLif_ahbl_haddr_pol  (iahbl_pad_haddr_pol     ), @228
//          .ahbLif_ahbl_hwdata_pol (iahbl_pad_hwdata_pol    ), @229
//          .ahbl_ahbLif_hrdata_pol (pad_iahbl_hrdata_pol    )); @230
// &Connect(.ahbLif_ahbl_hwdata_par (iahbl_pad_hwdata_par    ), @233
//          .ahbl_ahbLif_hrdata_par (pad_iahbl_hrdata_par    )); @234
// &Connect(.ahbl_ahbLif_inst_dbg_disable (pad_iahbl_inst_dbg_disable )); @237
// &Instance("cr_ahbl_wid_adj"); @240
// &Instance("cr_ahbl_if_hw"); @241
// &Connect(.cpu_addr        (cpu_addr_raw       ), @242
//          .cpu_prot        (cpu_prot_raw       ), @243
//          .cpu_req         (cpu_req_raw        ), @244
//          .cpu_size        (cpu_size_raw       ), @245
//          .cpu_wdata       (cpu_wdata_raw      ), @246
//          .cpu_write       (cpu_write_raw      ), @247
//          .cpu_acc_err     (cpu_acc_err_raw    ), @248
//          .cpu_data_vld    (cpu_data_vld_raw   ), @249
//          .cpu_rdata       (cpu_rdata_raw      ), @250
//          .cpu_req_grnt    (cpu_req_grnt_raw   ), @251
//          .cpu_trans_cmplt (cpu_trans_cmplt_raw) @252
// ); @253
// &Connect(.ahbLif_ahbl_haddr      (iahbl_pad_haddr         ), @254
//          .ahbLif_ahbl_hburst     (iahbl_pad_hburst        ), @255
//          .ahbLif_ahbl_hprot      (iahbl_pad_hprot         ), @256
//          .ahbLif_ahbl_hsize      (iahbl_pad_hsize         ), @257
//          .ahbLif_ahbl_htrans     (iahbl_pad_htrans        ), @258
//          .ahbLif_ahbl_hwdata     (iahbl_pad_hwdata        ), @259
//          .ahbLif_ahbl_hwrite     (iahbl_pad_hwrite        ), @260
//          .ahbl_ahbLif_hrdata     (pad_iahbl_hrdata        ), @261
//          .ahbl_ahbLif_hready     (pad_iahbl_hready        ), @262
//          .ahbl_ahbLif_hsec       (pad_iahbl_hsec          ), @263
//          .ahbl_ahbLif_hresp      (pad_iahbl_hresp         )); @264
// &Connect(.ahbLif_ahbl_haddr_pol  (iahbl_pad_haddr_pol     ), @266
//          .ahbLif_ahbl_hwdata_pol (iahbl_pad_hwdata_pol    ), @267
//          .ahbl_ahbLif_hrdata_pol (pad_iahbl_hrdata_pol    )); @268
// &Connect(.ahbLif_ahbl_hwdata_par (iahbl_pad_hwdata_par    ), @271
//          .ahbl_ahbLif_hrdata_par (pad_iahbl_hrdata_par    )); @272
// &Connect(.ahbl_ahbLif_inst_dbg_disable (pad_iahbl_inst_dbg_disable )); @275

// &Instance("cr_ahb_if_fo"); @282
// &Connect(.clk_en                 (iahbl_clk_en            )); @283
// &Connect(.uncmplt_mask (cache_uncmplt_mask)); @287
// &Force("input", "sahblif_iahblif_mask"); @290
// &Instance("cr_ahb_if"); @292
// &Connect(.ahb_gated_clk        (ahbl_gated_clk        )); @298
// &Connect(.ahb_clk_en           (ahbl_clk_en           )); @299
// &Connect(.ahbif_busy           (ahblif_busy           )); @300
// &Connect(.ahbif_power_mask     (ahblif_power_mask     )); @301
// &Connect(.ahbif_ahb_haddr      (iahb_ebmu_haddr         ), @302
//          .ahbif_ahb_hburst     (iahb_ebmu_hburst        ), @303
//          .ahbif_ahb_hprot      (iahb_ebmu_hprot         ), @304
//          .ahbif_ahb_hsize      (iahb_ebmu_hsize         ), @305
//          .ahbif_ahb_htrans     (iahb_ebmu_htrans        ), @306
//          .ahbif_ahb_hbusreq    (iahb_ebmu_hbusreq       ), @307
//          .ahbif_ahb_hwdata     (iahb_ebmu_hwdata        ), @308
//          .ahbif_ahb_hwrite     (iahb_ebmu_hwrite        ), @309
//          .ahbif_wfd            (iahb_ebmu_wfd        ), @310
//          .ahb_ahbif_hrdata     (ebmu_iahb_hrdata        ), @311
//          .ahb_ahbif_hready     (ebmu_iahb_hready        ), @312
//          .ahb_ahbif_hgrant     (ebmu_iahb_hgrant        ), @313
//          .ahb_ahbif_hresp      (ebmu_iahb_hresp         )); @314
// &Connect(.ahbif_ahb_haddr_pol  (iahb_ebmu_haddr_pol     ), @316
//          .ahbif_ahb_hwdata_pol (iahb_ebmu_hwdata_pol    ), @317
//          .ahb_ahbif_hrdata_pol (ebmu_iahb_hrdata_pol    )); @318
// &Connect(.ahbif_ahb_hwdata_par (iahb_ebmu_hwdata_par    ), @321
//          .ahb_ahbif_hrdata_par (ebmu_iahb_hrdata_par    )); @322
// &Connect(.ahb_ahbif_inst_dbg_disable (ebmu_iahb_inst_dbg_disable )); @325
// &Connect(.ahbif_ahb_source_pc   (iahb_ebmu_source_pc    ), @328
//          .ahbif_ahb_load        (iahb_ebmu_load         ), @329
//          .ahbif_ahb_store       (iahb_ebmu_store        ), @330
//          .ahbif_ahb_inst_fetch_chk (iahb_ebmu_inst_fetch_chk  )); @331
// &Connect(.ahbif_ahb_vec_redrct (iahb_ebmu_vec_redrct)); @333
// &Force("nonport", "cpu_req_for_grnt"); @335
// &Instance("cr_ahbl_if_fo"); @338
// &Connect(.clk_en                 (iahbl_clk_en            )); @339
// &Connect(.uncmplt_mask (cache_uncmplt_mask)); @343
// &Force("input", "sahblif_iahblif_mask"); @346
// &Instance("cr_ahbl_if"); @348
cr_ahbl_if  x_cr_ahbl_if (
  .ahbLif_ahbl_haddr    (iahbl_pad_haddr     ),
  .ahbLif_ahbl_hburst   (iahbl_pad_hburst    ),
  .ahbLif_ahbl_hprot    (iahbl_pad_hprot     ),
  .ahbLif_ahbl_hsize    (iahbl_pad_hsize     ),
  .ahbLif_ahbl_htrans   (iahbl_pad_htrans    ),
  .ahbLif_ahbl_hwdata   (iahbl_pad_hwdata    ),
  .ahbLif_ahbl_hwrite   (iahbl_pad_hwrite    ),
  .ahbl_ahbLif_hrdata   (pad_iahbl_hrdata    ),
  .ahbl_ahbLif_hready   (pad_iahbl_hready    ),
  .ahbl_ahbLif_hresp    (pad_iahbl_hresp     ),
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
  .cpu_wr_data          (cpu_wr_data         ),
  .cpu_write            (cpu_write           ),
  .cpurst_b             (cpurst_b            ),
  .pad_cpu_halt_ff2     (pad_cpu_halt_ff2    )
);

assign cpu_wr_data[31:0] = {32{cpu_wdata_sel}} & cpu_wdata[31:0];
assign iahblif_other_mask = ahblif_busy && pwrm_cpu_bus_peak_power_limit_en;
assign ahblif_power_mask  = sahblif_iahblif_mask || dahblif_other_mask;
assign cpu_req_power_masked = cpu_req && !ahblif_power_mask;
// &Connect(.ahbLif_ahbl_haddr      (iahbl_pad_haddr         ), @354
//          .ahbLif_ahbl_hburst     (iahbl_pad_hburst        ), @355
//          .ahbLif_ahbl_hprot      (iahbl_pad_hprot         ), @356
//          .ahbLif_ahbl_hsize      (iahbl_pad_hsize         ), @357
//          .ahbLif_ahbl_htrans     (iahbl_pad_htrans        ), @358
//          .ahbLif_ahbl_hwdata     (iahbl_pad_hwdata        ), @359
//          .ahbLif_ahbl_hwrite     (iahbl_pad_hwrite        ), @360
//          .ahbl_ahbLif_hrdata     (pad_iahbl_hrdata        ), @361
//          .ahbl_ahbLif_hready     (pad_iahbl_hready        ), @362
//          .ahbl_ahbLif_hsec       (pad_iahbl_hsec          ), @363
//          .ahbl_ahbLif_hresp      (pad_iahbl_hresp         )); @364
// &Connect(.ahbLif_ahbl_haddr_pol  (iahbl_pad_haddr_pol     ), @366
//          .ahbLif_ahbl_hwdata_pol (iahbl_pad_hwdata_pol    ), @367
//          .ahbl_ahbLif_hrdata_pol (pad_iahbl_hrdata_pol    )); @368
// &Connect(.ahbLif_ahbl_hwdata_par (iahbl_pad_hwdata_par    ), @371
//          .ahbl_ahbLif_hrdata_par (pad_iahbl_hrdata_par    )); @372
// &Connect(.ahbl_ahbLif_inst_dbg_disable (pad_iahbl_inst_dbg_disable )); @375
// &Connect(.ahbLif_ahbl_source_pc   (iahbl_pad_source_pc    ), @378
//          .ahbLif_ahbl_load        (iahbl_pad_load         ), @379
//          .ahbLif_ahbl_store       (iahbl_pad_store        ), @380
//          .ahbLif_ahbl_inst_fetch_chk (iahbl_pad_inst_fetch_chk  )); @381
// &Connect(.ahbLif_ahbl_vec_redrct (iahbl_pad_vec_redrct)); @383

// &ModuleEnd; @387
endmodule


