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
module cr_tcipif_top(
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
  cp0_yy_be_v2,
  cp0_yy_priv_mode,
  cpu_clic_curid,
  cpu_clic_int_exit,
  cpurst_b,
  forever_cpuclk,
  had_tcipif_cmplt,
  had_tcipif_rdata,
  iu_yy_xx_dbgon,
  pad_clic_int_vld,
  pad_yy_gate_clk_en_b,
  pwrm_cpu_bus_peak_power_limit_en,
  sysio_clint_me_int,
  sysio_clint_mtime,
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
  tcipif_bmu_ibus_trans_cmplt,
  tcipif_had_addr,
  tcipif_had_sel,
  tcipif_had_wdata,
  tcipif_had_write
);

// &Ports; @23
input           bmu_tcipif_dbus_acc_deny;        
input   [31:0]  bmu_tcipif_dbus_addr;            
input           bmu_tcipif_dbus_chk_fail;        
input           bmu_tcipif_dbus_req;             
input   [1 :0]  bmu_tcipif_dbus_size;            
input           bmu_tcipif_dbus_supv_mode;       
input   [31:0]  bmu_tcipif_dbus_wdata;           
input           bmu_tcipif_dbus_write;           
input           bmu_tcipif_ibus_acc_deny;        
input   [31:0]  bmu_tcipif_ibus_addr;            
input           bmu_tcipif_ibus_req;             
input           bmu_tcipif_ibus_write;           
input           cp0_yy_be_v2;                    
input   [1 :0]  cp0_yy_priv_mode;                
input   [11:0]  cpu_clic_curid;                  
input           cpu_clic_int_exit;               
input           cpurst_b;                        
input           forever_cpuclk;                  
input           had_tcipif_cmplt;                
input   [31:0]  had_tcipif_rdata;                
input           iu_yy_xx_dbgon;                  
input   [63:0]  pad_clic_int_vld;                
input           pad_yy_gate_clk_en_b;            
input           sysio_clint_me_int;              
input   [63:0]  sysio_clint_mtime;               
output          clic_cpu_int_hv;                 
output  [11:0]  clic_cpu_int_id;                 
output  [7 :0]  clic_cpu_int_il;                 
output  [1 :0]  clic_cpu_int_priv;               
output          clint_cpu_me_int;                
output          pwrm_cpu_bus_peak_power_limit_en; 
output  [31:0]  tcip_cp0_clic_base;              
output          tcipif_bmu_dbus_acc_err;         
output  [31:0]  tcipif_bmu_dbus_data;            
output          tcipif_bmu_dbus_data_vld;        
output          tcipif_bmu_dbus_grnt;            
output          tcipif_bmu_dbus_trans_cmplt;     
output          tcipif_bmu_ibus_acc_err;         
output  [31:0]  tcipif_bmu_ibus_data;            
output          tcipif_bmu_ibus_data_vld;        
output          tcipif_bmu_ibus_grnt;            
output          tcipif_bmu_ibus_trans_cmplt;     
output  [15:0]  tcipif_had_addr;                 
output          tcipif_had_sel;                  
output  [31:0]  tcipif_had_wdata;                
output          tcipif_had_write;                

// &Regs; @24

// &Wires; @25
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
wire            clic_cpu_int_hv;                 
wire    [11:0]  clic_cpu_int_id;                 
wire    [7 :0]  clic_cpu_int_il;                 
wire    [1 :0]  clic_cpu_int_priv;               
wire            clint_cpu_me_int;                
wire            clint_cpu_ms_int;                
wire            clint_cpu_mt_int;                
wire            clint_tcipif_cmplt;              
wire    [31:0]  clint_tcipif_rdata;              
wire            cp0_yy_be_v2;                    
wire    [1 :0]  cp0_yy_priv_mode;                
wire    [11:0]  cpu_clic_curid;                  
wire            cpu_clic_int_exit;               
wire            cpurst_b;                        
wire            forever_cpuclk;                  
wire            had_img_tcipif_cmplt;            
wire    [31:0]  had_img_tcipif_rdata;            
wire            had_tcipif_cmplt;                
wire    [31:0]  had_tcipif_rdata;                
wire            iu_yy_xx_dbgon;                  
wire    [63:0]  pad_clic_int_vld;                
wire            pad_yy_gate_clk_en_b;            
wire            pwrm_cpu_bus_peak_power_limit_en; 
wire            sysio_clint_me_int;              
wire    [63:0]  sysio_clint_mtime;               
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
wire            tcipif_clint_sel;                
wire    [15:0]  tcipif_had_addr;                 
wire            tcipif_had_img_sel;              
wire            tcipif_had_sel;                  
wire    [31:0]  tcipif_had_wdata;                
wire            tcipif_had_write;                
wire            tcipif_vic_sel;                  
wire    [1 :0]  tcipif_vic_size;                 
wire    [15:0]  tcipif_xx_dbus_addr;             
wire    [31:0]  tcipif_xx_dbus_wdata;            
wire            tcipif_xx_dbus_write;            
wire            vic_tcipif_cmplt;                
wire    [31:0]  vic_tcipif_rdata;                


//---------------------------------------------------------
// TCIPIF Connecting with BMU
//---------------------------------------------------------
// &Instance("cr_tcipif_behavior_bus","x_cr_tcipif_dbus"); @30
cr_tcipif_behavior_bus  x_cr_tcipif_dbus (
  .bmu_tcipif_dbus_acc_deny    (bmu_tcipif_dbus_acc_deny   ),
  .bmu_tcipif_dbus_addr        (bmu_tcipif_dbus_addr       ),
  .bmu_tcipif_dbus_chk_fail    (bmu_tcipif_dbus_chk_fail   ),
  .bmu_tcipif_dbus_req         (bmu_tcipif_dbus_req        ),
  .bmu_tcipif_dbus_size        (bmu_tcipif_dbus_size       ),
  .bmu_tcipif_dbus_supv_mode   (bmu_tcipif_dbus_supv_mode  ),
  .bmu_tcipif_dbus_wdata       (bmu_tcipif_dbus_wdata      ),
  .bmu_tcipif_dbus_write       (bmu_tcipif_dbus_write      ),
  .clint_tcipif_cmplt          (clint_tcipif_cmplt         ),
  .clint_tcipif_rdata          (clint_tcipif_rdata         ),
  .cp0_yy_be_v2                (cp0_yy_be_v2               ),
  .cpurst_b                    (cpurst_b                   ),
  .forever_cpuclk              (forever_cpuclk             ),
  .had_img_tcipif_cmplt        (had_img_tcipif_cmplt       ),
  .had_img_tcipif_rdata        (had_img_tcipif_rdata       ),
  .iu_yy_xx_dbgon              (iu_yy_xx_dbgon             ),
  .pad_yy_gate_clk_en_b        (pad_yy_gate_clk_en_b       ),
  .tcip_cp0_clic_base          (tcip_cp0_clic_base         ),
  .tcipif_bmu_dbus_acc_err     (tcipif_bmu_dbus_acc_err    ),
  .tcipif_bmu_dbus_data        (tcipif_bmu_dbus_data       ),
  .tcipif_bmu_dbus_data_vld    (tcipif_bmu_dbus_data_vld   ),
  .tcipif_bmu_dbus_grnt        (tcipif_bmu_dbus_grnt       ),
  .tcipif_bmu_dbus_trans_cmplt (tcipif_bmu_dbus_trans_cmplt),
  .tcipif_clint_sel            (tcipif_clint_sel           ),
  .tcipif_had_img_sel          (tcipif_had_img_sel         ),
  .tcipif_vic_sel              (tcipif_vic_sel             ),
  .tcipif_vic_size             (tcipif_vic_size            ),
  .tcipif_xx_dbus_addr         (tcipif_xx_dbus_addr        ),
  .tcipif_xx_dbus_wdata        (tcipif_xx_dbus_wdata       ),
  .tcipif_xx_dbus_write        (tcipif_xx_dbus_write       ),
  .vic_tcipif_cmplt            (vic_tcipif_cmplt           ),
  .vic_tcipif_rdata            (vic_tcipif_rdata           )
);

// &Instance("cr_tcipif_dummy_bus","x_cr_tcipif_ibus"); @31
cr_tcipif_dummy_bus  x_cr_tcipif_ibus (
  .bmu_tcipif_ibus_acc_deny    (bmu_tcipif_ibus_acc_deny   ),
  .bmu_tcipif_ibus_addr        (bmu_tcipif_ibus_addr       ),
  .bmu_tcipif_ibus_req         (bmu_tcipif_ibus_req        ),
  .bmu_tcipif_ibus_write       (bmu_tcipif_ibus_write      ),
  .cpurst_b                    (cpurst_b                   ),
  .forever_cpuclk              (forever_cpuclk             ),
  .pad_yy_gate_clk_en_b        (pad_yy_gate_clk_en_b       ),
  .tcipif_bmu_ibus_acc_err     (tcipif_bmu_ibus_acc_err    ),
  .tcipif_bmu_ibus_data        (tcipif_bmu_ibus_data       ),
  .tcipif_bmu_ibus_data_vld    (tcipif_bmu_ibus_data_vld   ),
  .tcipif_bmu_ibus_grnt        (tcipif_bmu_ibus_grnt       ),
  .tcipif_bmu_ibus_trans_cmplt (tcipif_bmu_ibus_trans_cmplt)
);


//---------------------------------------------------------
// TCIPIF Connecting with Off-core IP
//---------------------------------------------------------
//--------------------------------------
//  Instance  interrupt controller module
//--------------------------------------
// &Instance("cr_clic_top"); @40
cr_clic_top  x_cr_clic_top (
  .clic_cpu_int_hv      (clic_cpu_int_hv     ),
  .clic_cpu_int_id      (clic_cpu_int_id     ),
  .clic_cpu_int_il      (clic_cpu_int_il     ),
  .clic_cpu_int_priv    (clic_cpu_int_priv   ),
  .clic_tcipif_cmplt    (vic_tcipif_cmplt    ),
  .clic_tcipif_rdata    (vic_tcipif_rdata    ),
  .clint_cpu_me_int     (clint_cpu_me_int    ),
  .clint_cpu_ms_int     (clint_cpu_ms_int    ),
  .clint_cpu_mt_int     (clint_cpu_mt_int    ),
  .cpu_clic_curid       (cpu_clic_curid      ),
  .cpu_clic_int_exit    (cpu_clic_int_exit   ),
  .cpu_clic_mode        (cp0_yy_priv_mode    ),
  .cpurst_b             (cpurst_b            ),
  .forever_cpuclk       (forever_cpuclk      ),
  .pad_clic_int_vld     (pad_clic_int_vld    ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b),
  .tcipif_clic_addr     (tcipif_xx_dbus_addr ),
  .tcipif_clic_sel      (tcipif_vic_sel      ),
  .tcipif_clic_size     (tcipif_vic_size     ),
  .tcipif_clic_wdata    (tcipif_xx_dbus_wdata),
  .tcipif_clic_write    (tcipif_xx_dbus_write)
);

// &Connect( @41
//          .tcipif_clic_addr     (tcipif_xx_dbus_addr  ), @42
//          .tcipif_clic_wdata    (tcipif_xx_dbus_wdata ), @43
//          .tcipif_clic_write    (tcipif_xx_dbus_write ), @44
//          .clic_pad_int_hv      (clic_cpu_int_hv       ), @45
//          .clic_pad_int_id      (clic_cpu_int_id     ), @46
//          .clic_pad_int_il      (clic_cpu_int_il       ), @47
//          .clic_pad_int_priv    (clic_cpu_int_priv       ), @48
//          .tcipif_clic_sel        (tcipif_vic_sel       ), @49
//          .tcipif_clic_size        (tcipif_vic_size       ), @50
//          .clic_tcipif_cmplt        (vic_tcipif_cmplt       ), @51
//          .clic_tcipif_rdata        (vic_tcipif_rdata       ), @52
//          .cpu_clic_mode          (cp0_yy_priv_mode       ), @53
//        ); @54
       
//  &Connect( @57
//     .clic_pad_int_sec    (clic_cpu_int_sec), @58
//   ); @59
//&Instance("cr_intc_top");
// //&Connect( @62
// //         .tcipif_vic_addr     (tcipif_xx_dbus_addr  ), @63
// //         .tcipif_vic_wdata    (tcipif_xx_dbus_wdata ), @64
// //         .tcipif_vic_write    (tcipif_xx_dbus_write ), @65
// //         .pad_vic_int_ack     (cpu_intc_int_ack     ), @66
// //         .pad_vic_intraw_ack  (cpu_intc_intraw_ack  ), @67
// //         .pad_vic_int_exit    (cpu_intc_int_exit    ), @68
// //         .pad_vic_int_vec     (cpu_intc_int_vec     ), @69
// //         .pad_vic_ack_vec     (cpu_intc_ack_vec     ), @70
// //         .vic_pad_int_b       (intc_cpu_int_b       ), @71
// //         .vic_pad_int_sec     (intc_cpu_int_sec     ), @72
// //         .vic_pad_int_vec_b   (intc_cpu_vec_b       ), @73
// //         .vic_pad_intraw_b    (intc_cpu_intraw_b    ), @74
// //        ); @75
// //&Connect( @77
// //         .pad_vic_int_pulse_0 (pad_vic_int_cfg      ), @78
// //         .pad_vic_int_src_0   (pad_vic_int_vld      ), @79
// //        ); @80
// //&Connect( @83
// //         .pad_vic_int_pulse_0 (pad_vic_int_cfg[0]   ), @84
// //         .pad_vic_int_pulse_1 (pad_vic_int_cfg[1]   ), @85
// //         .pad_vic_int_src_0   (pad_vic_int_vld[0]   ), @86
// //         .pad_vic_int_src_1   (pad_vic_int_vld[1]   ), @87
// //        ); @88
// //&Connect( @91
// //         .pad_vic_int_pulse_0 (pad_vic_int_cfg[0]   ), @92
// //         .pad_vic_int_pulse_1 (pad_vic_int_cfg[1]   ), @93
// //         .pad_vic_int_pulse_2 (pad_vic_int_cfg[2]   ), @94
// //         .pad_vic_int_pulse_3 (pad_vic_int_cfg[3]   ), @95
// //         .pad_vic_int_src_0   (pad_vic_int_vld[0]   ), @96
// //         .pad_vic_int_src_1   (pad_vic_int_vld[1]   ), @97
// //         .pad_vic_int_src_2   (pad_vic_int_vld[2]   ), @98
// //         .pad_vic_int_src_3   (pad_vic_int_vld[3]   ), @99
// //        ); @100
// //&Connect( @103
// //         .pad_vic_int_pulse_0 (pad_vic_int_cfg[0]   ), @104
// //         .pad_vic_int_pulse_1 (pad_vic_int_cfg[1]   ), @105
// //         .pad_vic_int_pulse_2 (pad_vic_int_cfg[2]   ), @106
// //         .pad_vic_int_pulse_3 (pad_vic_int_cfg[3]   ), @107
// //         .pad_vic_int_pulse_4 (pad_vic_int_cfg[4]   ), @108
// //         .pad_vic_int_pulse_5 (pad_vic_int_cfg[5]   ), @109
// //         .pad_vic_int_pulse_6 (pad_vic_int_cfg[6]   ), @110
// //         .pad_vic_int_pulse_7 (pad_vic_int_cfg[7]   ), @111
// //         .pad_vic_int_src_0   (pad_vic_int_vld[0]   ), @112
// //         .pad_vic_int_src_1   (pad_vic_int_vld[1]   ), @113
// //         .pad_vic_int_src_2   (pad_vic_int_vld[2]   ), @114
// //         .pad_vic_int_src_3   (pad_vic_int_vld[3]   ), @115
// //         .pad_vic_int_src_4   (pad_vic_int_vld[4]   ), @116
// //         .pad_vic_int_src_5   (pad_vic_int_vld[5]   ), @117
// //         .pad_vic_int_src_6   (pad_vic_int_vld[6]   ), @118
// //         .pad_vic_int_src_7   (pad_vic_int_vld[7]   ), @119
// //        ); @120
// //&Connect( @123
// //         .pad_vic_int_pulse_8 (pad_vic_int_cfg[8]   ), @124
// //         .pad_vic_int_pulse_9 (pad_vic_int_cfg[9]   ), @125
// //         .pad_vic_int_pulse_10(pad_vic_int_cfg[10]  ), @126
// //         .pad_vic_int_pulse_11(pad_vic_int_cfg[11]  ), @127
// //         .pad_vic_int_pulse_12(pad_vic_int_cfg[12]  ), @128
// //         .pad_vic_int_pulse_13(pad_vic_int_cfg[13]  ), @129
// //         .pad_vic_int_pulse_14(pad_vic_int_cfg[14]  ), @130
// //         .pad_vic_int_pulse_15(pad_vic_int_cfg[15]  ), @131
// //         .pad_vic_int_src_8   (pad_vic_int_vld[8]   ), @132
// //         .pad_vic_int_src_9   (pad_vic_int_vld[9]   ), @133
// //         .pad_vic_int_src_10  (pad_vic_int_vld[10]  ), @134
// //         .pad_vic_int_src_11  (pad_vic_int_vld[11]  ), @135
// //         .pad_vic_int_src_12  (pad_vic_int_vld[12]  ), @136
// //         .pad_vic_int_src_13  (pad_vic_int_vld[13]  ), @137
// //         .pad_vic_int_src_14  (pad_vic_int_vld[14]  ), @138
// //         .pad_vic_int_src_15  (pad_vic_int_vld[15]  ), @139
// //        ); @140
// //&Connect( @143
// //         .pad_vic_int_pulse_16(pad_vic_int_cfg[16]  ), @144
// //         .pad_vic_int_pulse_17(pad_vic_int_cfg[17]  ), @145
// //         .pad_vic_int_pulse_18(pad_vic_int_cfg[18]  ), @146
// //         .pad_vic_int_pulse_19(pad_vic_int_cfg[19]  ), @147
// //         .pad_vic_int_pulse_20(pad_vic_int_cfg[20]  ), @148
// //         .pad_vic_int_pulse_21(pad_vic_int_cfg[21]  ), @149
// //         .pad_vic_int_pulse_22(pad_vic_int_cfg[22]  ), @150
// //         .pad_vic_int_pulse_23(pad_vic_int_cfg[23]  ), @151
// //         .pad_vic_int_src_16  (pad_vic_int_vld[16]  ), @152
// //         .pad_vic_int_src_17  (pad_vic_int_vld[17]  ), @153
// //         .pad_vic_int_src_18  (pad_vic_int_vld[18]  ), @154
// //         .pad_vic_int_src_19  (pad_vic_int_vld[19]  ), @155
// //         .pad_vic_int_src_20  (pad_vic_int_vld[20]  ), @156
// //         .pad_vic_int_src_21  (pad_vic_int_vld[21]  ), @157
// //         .pad_vic_int_src_22  (pad_vic_int_vld[22]  ), @158
// //         .pad_vic_int_src_23  (pad_vic_int_vld[23]  ), @159
// //        ); @160
// //&Connect( @163
// //         .pad_vic_int_pulse_24(pad_vic_int_cfg[24]  ), @164
// //         .pad_vic_int_pulse_25(pad_vic_int_cfg[25]  ), @165
// //         .pad_vic_int_pulse_26(pad_vic_int_cfg[26]  ), @166
// //         .pad_vic_int_pulse_27(pad_vic_int_cfg[27]  ), @167
// //         .pad_vic_int_pulse_28(pad_vic_int_cfg[28]  ), @168
// //         .pad_vic_int_pulse_29(pad_vic_int_cfg[29]  ), @169
// //         .pad_vic_int_pulse_30(pad_vic_int_cfg[30]  ), @170
// //         .pad_vic_int_pulse_31(pad_vic_int_cfg[31]  ), @171
// //         .pad_vic_int_src_24  (pad_vic_int_vld[24]  ), @172
// //         .pad_vic_int_src_25  (pad_vic_int_vld[25]  ), @173
// //         .pad_vic_int_src_26  (pad_vic_int_vld[26]  ), @174
// //         .pad_vic_int_src_27  (pad_vic_int_vld[27]  ), @175
// //         .pad_vic_int_src_28  (pad_vic_int_vld[28]  ), @176
// //         .pad_vic_int_src_29  (pad_vic_int_vld[29]  ), @177
// //         .pad_vic_int_src_30  (pad_vic_int_vld[30]  ), @178
// //         .pad_vic_int_src_31  (pad_vic_int_vld[31]  ), @179
// //        ); @180
// &Instance("cr_clic_top_dummy"); @185
// &Connect(.cpuclk    (forever_cpuclk_nogated)); @186
// &Connect(.cpurst_b  (cpurst_b)); @187


// &Instance("cr_seu_top"); @204

// &Instance("cr_seu_bist_top"); @211

// &Instance("cr_pwrm_top"); @218
// &Connect( @219
//          .tcipif_pwrm_addr  (tcipif_xx_dbus_addr ), @220
//          .tcipif_pwrm_wdata (tcipif_xx_dbus_wdata), @221
//          .tcipif_pwrm_write (tcipif_xx_dbus_write) @222
//         ); @223
// &Instance("cr_pwrm_top_dummy"); @225
cr_pwrm_top_dummy  x_cr_pwrm_top_dummy (
  .pwrm_cpu_bus_peak_power_limit_en (pwrm_cpu_bus_peak_power_limit_en)
);


// // &Connect( @233
// //          .cpurst_b                  (cpurst_b               ), @234
// //          .forever_cpuclk            (forever_cpuclk         ), @235
// //          .forever_cpuclk_nogated    (forever_cpuclk_nogated ), @236
// //          .tcipif_coretim_addr       (tcipif_xx_dbus_addr    ), @237
// //          .tcipif_coretim_wdata      (tcipif_xx_dbus_wdata   ), @238
// //          .tcipif_coretim_write      (tcipif_xx_dbus_write   ), @239
// //          .ctim_pad_int_vld          (ctim_pad_int_vld       ), @240
// //          .pad_ctim_refclk           (pad_ctim_refclk        ), @241
// //          .core_dbgon                (iu_yy_xx_dbgon         ), @242
// //          .pad_ctim_calib            (pad_ctim_calib         ), @243
// //         ); @244
// &Instance("cr_coretim_top_dummy"); @245
// &Instance("cr_coretim_top_dummy"); @247
cr_coretim_top_dummy  x_cr_coretim_top_dummy (
  .iu_yy_xx_dbgon (iu_yy_xx_dbgon)
);




//to HAD
assign tcipif_had_sel             = tcipif_had_img_sel;
assign tcipif_had_addr[15:0]      = tcipif_xx_dbus_addr[15:0];
assign tcipif_had_write           = tcipif_xx_dbus_write;
assign tcipif_had_wdata[31:0]     = tcipif_xx_dbus_wdata[31:0];
//from HAD
assign had_img_tcipif_cmplt       = had_tcipif_cmplt;
assign had_img_tcipif_rdata[31:0] = had_tcipif_rdata[31:0];
// &Force("output","tcipif_xx_dbus_sec"); @268

// &Instance("cr_cmmu_top"); @276

//==========================================================
//  Instance CLINT module
//==========================================================
// &Instance("cr_clint_top"); @282
cr_clint_top  x_cr_clint_top (
  .clint_cpu_me_int     (clint_cpu_me_int    ),
  .clint_cpu_ms_int     (clint_cpu_ms_int    ),
  .clint_cpu_mt_int     (clint_cpu_mt_int    ),
  .clint_tcipif_cmplt   (clint_tcipif_cmplt  ),
  .clint_tcipif_rdata   (clint_tcipif_rdata  ),
  .cpu_clint_mode       (cp0_yy_priv_mode    ),
  .cpurst_b             (cpurst_b            ),
  .forever_cpuclk       (forever_cpuclk      ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b),
  .sysio_clint_me_int   (sysio_clint_me_int  ),
  .sysio_clint_mtime    (sysio_clint_mtime   ),
  .tcipif_clint_addr    (tcipif_xx_dbus_addr ),
  .tcipif_clint_sel     (tcipif_clint_sel    ),
  .tcipif_clint_wdata   (tcipif_xx_dbus_wdata),
  .tcipif_clint_write   (tcipif_xx_dbus_write)
);

// &Connect( @283
//          .tcipif_clint_addr       (tcipif_xx_dbus_addr    ), @284
//          .tcipif_clint_wdata      (tcipif_xx_dbus_wdata   ), @285
//          .tcipif_clint_write      (tcipif_xx_dbus_write   ), @286
//          .cpu_clint_mode          (cp0_yy_priv_mode       ), @287
//         ); @288

// &Force("output", "clint_cpu_me_int"); @290

// &ModuleEnd; @292
endmodule


