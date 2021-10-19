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
module cr_iu_oper_gpr(
  cp0_yy_clk_en,
  forever_cpuclk,
  hs_split_iu_nsinst_gpr_rst_b,
  inst_read_data0,
  inst_read_data1,
  inst_read_index0,
  inst_read_index1,
  inst_wen,
  inst_write_data,
  inst_write_index,
  iu_yy_xx_reg_rst_b,
  pad_yy_gate_clk_en_b,
  randclk_oper_gpr_mod_en_w32
);

// &Ports; @24
input           cp0_yy_clk_en;                   
input           forever_cpuclk;                  
input           hs_split_iu_nsinst_gpr_rst_b;    
input   [4 :0]  inst_read_index0;                
input   [4 :0]  inst_read_index1;                
input           inst_wen;                        
input   [31:0]  inst_write_data;                 
input   [4 :0]  inst_write_index;                
input           iu_yy_xx_reg_rst_b;              
input           pad_yy_gate_clk_en_b;            
input   [20:0]  randclk_oper_gpr_mod_en_w32;     
output  [31:0]  inst_read_data0;                 
output  [31:0]  inst_read_data1;                 

// &Regs; @25
reg     [31:0]  gpr_read_data0;                  
reg     [31:0]  gpr_read_data1;                  
reg     [31:0]  reg_sel;                         
reg     [31:0]  sp_read_data0;                   
reg     [31:0]  sp_read_data1;                   

// &Wires; @26
wire    [31:0]  alter_0_reg_dout;                
wire    [31:0]  alter_10_reg_dout;               
wire    [31:0]  alter_11_reg_dout;               
wire    [31:0]  alter_12_reg_dout;               
wire    [31:0]  alter_13_reg_dout;               
wire    [31:0]  alter_14_reg_dout;               
wire    [31:0]  alter_15_reg_dout;               
wire    [31:0]  alter_1_reg_dout;                
wire    [31:0]  alter_2_reg_dout;                
wire    [31:0]  alter_3_reg_dout;                
wire    [31:0]  alter_4_reg_dout;                
wire    [31:0]  alter_5_reg_dout;                
wire    [31:0]  alter_6_reg_dout;                
wire    [31:0]  alter_7_reg_dout;                
wire    [31:0]  alter_8_reg_dout;                
wire    [31:0]  alter_9_reg_dout;                
wire            alter_mode;                      
wire            cp0_yy_clk_en;                   
wire            forever_cpuclk;                  
wire            gpr_sync_rst_b;                  
wire            gpr_sync_rst_for_sp_b;           
wire            hs_split_iu_nsinst_gpr_rst_b;    
wire    [31:0]  inst_read_data0;                 
wire    [31:0]  inst_read_data1;                 
wire    [4 :0]  inst_read_index0;                
wire    [4 :0]  inst_read_index1;                
wire            inst_wen;                        
wire    [31:0]  inst_write_data;                 
wire    [4 :0]  inst_write_index;                
wire            iu_yy_xx_reg_rst_b;              
wire            machine_2_randclk_reg_mod_en_w32; 
wire    [31:0]  machine_2_reg_dout;              
wire            machine_2_write_en;              
wire            machine_write_en_2;              
wire            pad_cpu_gpr_rst_b;               
wire            pad_yy_gate_clk_en_b;            
wire    [20:0]  randclk_oper_gpr_mod_en_w32;     
wire            user_10_randclk_reg_mod_en_w32;  
wire    [31:0]  user_10_reg_dout;                
wire            user_10_write_en;                
wire            user_11_randclk_reg_mod_en_w32;  
wire    [31:0]  user_11_reg_dout;                
wire            user_11_write_en;                
wire            user_12_randclk_reg_mod_en_w32;  
wire    [31:0]  user_12_reg_dout;                
wire            user_12_write_en;                
wire            user_13_randclk_reg_mod_en_w32;  
wire    [31:0]  user_13_reg_dout;                
wire            user_13_write_en;                
wire            user_14_randclk_reg_mod_en_w32;  
wire    [31:0]  user_14_reg_dout;                
wire            user_14_write_en;                
wire            user_15_randclk_reg_mod_en_w32;  
wire    [31:0]  user_15_reg_dout;                
wire            user_15_write_en;                
wire            user_1_randclk_reg_mod_en_w32;   
wire    [31:0]  user_1_reg_dout;                 
wire            user_1_write_en;                 
wire            user_3_randclk_reg_mod_en_w32;   
wire    [31:0]  user_3_reg_dout;                 
wire            user_3_write_en;                 
wire            user_4_randclk_reg_mod_en_w32;   
wire    [31:0]  user_4_reg_dout;                 
wire            user_4_write_en;                 
wire            user_5_randclk_reg_mod_en_w32;   
wire    [31:0]  user_5_reg_dout;                 
wire            user_5_write_en;                 
wire            user_6_randclk_reg_mod_en_w32;   
wire    [31:0]  user_6_reg_dout;                 
wire            user_6_write_en;                 
wire            user_7_randclk_reg_mod_en_w32;   
wire    [31:0]  user_7_reg_dout;                 
wire            user_7_write_en;                 
wire            user_8_randclk_reg_mod_en_w32;   
wire    [31:0]  user_8_reg_dout;                 
wire            user_8_write_en;                 
wire            user_9_randclk_reg_mod_en_w32;   
wire    [31:0]  user_9_reg_dout;                 
wire            user_9_write_en;                 
wire    [31:0]  user_write_en;                   
wire            ussp_explicit_we;                
wire    [31:0]  write_data;                      
wire    [31:0]  write_data_for_sp;               
wire    [31:0]  write_port_data;                 


//==============================================================================
// Instance 16 registers for register file
//==============================================================================
// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_1"); @31
cr_iu_gated_clk_reg  x_cr_iu_gated_clk_reg_user_1 (
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .forever_cpuclk                (forever_cpuclk               ),
  .pad_yy_gate_clk_en_b          (pad_yy_gate_clk_en_b         ),
  .write_data                    (write_data                   ),
  .x_randclk_reg_mod_en_w32      (user_1_randclk_reg_mod_en_w32),
  .x_reg_dout                    (user_1_reg_dout              ),
  .x_write_en                    (user_1_write_en              )
);

// &Connect(.x_randclk_reg_mod_en_w32(user_1_randclk_reg_mod_en_w32), @32
//          .x_write_en              (user_1_write_en), @33
//          .x_reg_dout              (user_1_reg_dout) @34
//         ); @35
// &Connect(.x_reg_verify            (user_1_reg_verify)); @37
// &Connect(.x_reg_dout_pol          (user_1_reg_dout_pol)); @40

// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_2"); @44
// &Connect(.x_randclk_reg_mod_en_w32(user_2_randclk_reg_mod_en_w32), @45
//          .write_data              (write_data_for_sp[31:0]), @46
//          .x_write_en              (user_2_write_en), @47
//          .x_reg_dout              (user_2_reg_dout) @48
//         ); @49
// &Connect(.x_reg_verify            (user_2_reg_verify)); @51
// &Connect(.x_reg_dout_pol          (user_2_reg_dout_pol)); @54

// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_3"); @58
cr_iu_gated_clk_reg  x_cr_iu_gated_clk_reg_user_3 (
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .forever_cpuclk                (forever_cpuclk               ),
  .pad_yy_gate_clk_en_b          (pad_yy_gate_clk_en_b         ),
  .write_data                    (write_data                   ),
  .x_randclk_reg_mod_en_w32      (user_3_randclk_reg_mod_en_w32),
  .x_reg_dout                    (user_3_reg_dout              ),
  .x_write_en                    (user_3_write_en              )
);

// &Connect(.x_randclk_reg_mod_en_w32(user_3_randclk_reg_mod_en_w32), @59
//          .x_write_en              (user_3_write_en), @60
//          .x_reg_dout              (user_3_reg_dout) @61
//         ); @62
// &Connect(.x_reg_verify            (user_3_reg_verify)); @64
// &Connect(.x_reg_dout_pol          (user_3_reg_dout_pol)); @67


// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_4"); @71
cr_iu_gated_clk_reg  x_cr_iu_gated_clk_reg_user_4 (
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .forever_cpuclk                (forever_cpuclk               ),
  .pad_yy_gate_clk_en_b          (pad_yy_gate_clk_en_b         ),
  .write_data                    (write_data                   ),
  .x_randclk_reg_mod_en_w32      (user_4_randclk_reg_mod_en_w32),
  .x_reg_dout                    (user_4_reg_dout              ),
  .x_write_en                    (user_4_write_en              )
);

// &Connect(.x_randclk_reg_mod_en_w32(user_4_randclk_reg_mod_en_w32), @72
//          .x_write_en              (user_4_write_en), @73
//          .x_reg_dout              (user_4_reg_dout) @74
//         ); @75
// &Connect(.x_reg_verify            (user_4_reg_verify)); @77
// &Connect(.x_reg_dout_pol          (user_4_reg_dout_pol)); @80


// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_5"); @84
cr_iu_gated_clk_reg  x_cr_iu_gated_clk_reg_user_5 (
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .forever_cpuclk                (forever_cpuclk               ),
  .pad_yy_gate_clk_en_b          (pad_yy_gate_clk_en_b         ),
  .write_data                    (write_data                   ),
  .x_randclk_reg_mod_en_w32      (user_5_randclk_reg_mod_en_w32),
  .x_reg_dout                    (user_5_reg_dout              ),
  .x_write_en                    (user_5_write_en              )
);

// &Connect(.x_randclk_reg_mod_en_w32(user_5_randclk_reg_mod_en_w32), @85
//          .x_write_en              (user_5_write_en), @86
//          .x_reg_dout              (user_5_reg_dout) @87
//         ); @88
// &Connect(.x_reg_verify            (user_5_reg_verify)); @90
// &Connect(.x_reg_dout_pol          (user_5_reg_dout_pol)); @93


// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_6"); @97
cr_iu_gated_clk_reg  x_cr_iu_gated_clk_reg_user_6 (
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .forever_cpuclk                (forever_cpuclk               ),
  .pad_yy_gate_clk_en_b          (pad_yy_gate_clk_en_b         ),
  .write_data                    (write_data                   ),
  .x_randclk_reg_mod_en_w32      (user_6_randclk_reg_mod_en_w32),
  .x_reg_dout                    (user_6_reg_dout              ),
  .x_write_en                    (user_6_write_en              )
);

// &Connect(.x_randclk_reg_mod_en_w32(user_6_randclk_reg_mod_en_w32), @98
//          .x_write_en              (user_6_write_en), @99
//          .x_reg_dout              (user_6_reg_dout) @100
//         ); @101
// &Connect(.x_reg_verify            (user_6_reg_verify)); @103
// &Connect(.x_reg_dout_pol          (user_6_reg_dout_pol)); @106


// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_7"); @110
cr_iu_gated_clk_reg  x_cr_iu_gated_clk_reg_user_7 (
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .forever_cpuclk                (forever_cpuclk               ),
  .pad_yy_gate_clk_en_b          (pad_yy_gate_clk_en_b         ),
  .write_data                    (write_data                   ),
  .x_randclk_reg_mod_en_w32      (user_7_randclk_reg_mod_en_w32),
  .x_reg_dout                    (user_7_reg_dout              ),
  .x_write_en                    (user_7_write_en              )
);

// &Connect(.x_randclk_reg_mod_en_w32(user_7_randclk_reg_mod_en_w32), @111
//          .x_write_en              (user_7_write_en), @112
//          .x_reg_dout              (user_7_reg_dout) @113
//         ); @114
// &Connect(.x_reg_verify            (user_7_reg_verify)); @116
// &Connect(.x_reg_dout_pol          (user_7_reg_dout_pol)); @119


// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_8"); @123
cr_iu_gated_clk_reg  x_cr_iu_gated_clk_reg_user_8 (
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .forever_cpuclk                (forever_cpuclk               ),
  .pad_yy_gate_clk_en_b          (pad_yy_gate_clk_en_b         ),
  .write_data                    (write_data                   ),
  .x_randclk_reg_mod_en_w32      (user_8_randclk_reg_mod_en_w32),
  .x_reg_dout                    (user_8_reg_dout              ),
  .x_write_en                    (user_8_write_en              )
);

// &Connect(.x_randclk_reg_mod_en_w32(user_8_randclk_reg_mod_en_w32), @124
//          .x_write_en              (user_8_write_en), @125
//          .x_reg_dout              (user_8_reg_dout) @126
//         ); @127
// &Connect(.x_reg_verify            (user_8_reg_verify)); @129
// &Connect(.x_reg_dout_pol          (user_8_reg_dout_pol)); @132


// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_9"); @137
cr_iu_gated_clk_reg  x_cr_iu_gated_clk_reg_user_9 (
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .forever_cpuclk                (forever_cpuclk               ),
  .pad_yy_gate_clk_en_b          (pad_yy_gate_clk_en_b         ),
  .write_data                    (write_data                   ),
  .x_randclk_reg_mod_en_w32      (user_9_randclk_reg_mod_en_w32),
  .x_reg_dout                    (user_9_reg_dout              ),
  .x_write_en                    (user_9_write_en              )
);

// &Connect(.x_randclk_reg_mod_en_w32(user_9_randclk_reg_mod_en_w32), @138
//          .x_write_en              (user_9_write_en), @139
//          .x_reg_dout              (user_9_reg_dout) @140
//         ); @141
// &Connect(.x_reg_verify            (user_9_reg_verify)); @143
// &Connect(.x_reg_dout_pol          (user_9_reg_dout_pol)); @146


// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_10"); @150
cr_iu_gated_clk_reg  x_cr_iu_gated_clk_reg_user_10 (
  .cp0_yy_clk_en                  (cp0_yy_clk_en                 ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .pad_yy_gate_clk_en_b           (pad_yy_gate_clk_en_b          ),
  .write_data                     (write_data                    ),
  .x_randclk_reg_mod_en_w32       (user_10_randclk_reg_mod_en_w32),
  .x_reg_dout                     (user_10_reg_dout              ),
  .x_write_en                     (user_10_write_en              )
);

// &Connect(.x_randclk_reg_mod_en_w32(user_10_randclk_reg_mod_en_w32), @151
//          .x_write_en              (user_10_write_en), @152
//          .x_reg_dout              (user_10_reg_dout) @153
//         ); @154
// &Connect(.x_reg_verify            (user_10_reg_verify)); @156
// &Connect(.x_reg_dout_pol          (user_10_reg_dout_pol)); @159


// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_11"); @163
cr_iu_gated_clk_reg  x_cr_iu_gated_clk_reg_user_11 (
  .cp0_yy_clk_en                  (cp0_yy_clk_en                 ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .pad_yy_gate_clk_en_b           (pad_yy_gate_clk_en_b          ),
  .write_data                     (write_data                    ),
  .x_randclk_reg_mod_en_w32       (user_11_randclk_reg_mod_en_w32),
  .x_reg_dout                     (user_11_reg_dout              ),
  .x_write_en                     (user_11_write_en              )
);

// &Connect(.x_randclk_reg_mod_en_w32(user_11_randclk_reg_mod_en_w32), @164
//          .x_write_en              (user_11_write_en), @165
//          .x_reg_dout              (user_11_reg_dout) @166
//         ); @167
// &Connect(.x_reg_verify            (user_11_reg_verify)); @169
// &Connect(.x_reg_dout_pol          (user_11_reg_dout_pol)); @172


// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_12"); @176
cr_iu_gated_clk_reg  x_cr_iu_gated_clk_reg_user_12 (
  .cp0_yy_clk_en                  (cp0_yy_clk_en                 ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .pad_yy_gate_clk_en_b           (pad_yy_gate_clk_en_b          ),
  .write_data                     (write_data                    ),
  .x_randclk_reg_mod_en_w32       (user_12_randclk_reg_mod_en_w32),
  .x_reg_dout                     (user_12_reg_dout              ),
  .x_write_en                     (user_12_write_en              )
);

// &Connect(.x_randclk_reg_mod_en_w32(user_12_randclk_reg_mod_en_w32), @177
//          .x_write_en              (user_12_write_en), @178
//          .x_reg_dout              (user_12_reg_dout) @179
//         ); @180
// &Connect(.x_reg_verify            (user_12_reg_verify)); @182
// &Connect(.x_reg_dout_pol          (user_12_reg_dout_pol)); @185


// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_13"); @189
cr_iu_gated_clk_reg  x_cr_iu_gated_clk_reg_user_13 (
  .cp0_yy_clk_en                  (cp0_yy_clk_en                 ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .pad_yy_gate_clk_en_b           (pad_yy_gate_clk_en_b          ),
  .write_data                     (write_data                    ),
  .x_randclk_reg_mod_en_w32       (user_13_randclk_reg_mod_en_w32),
  .x_reg_dout                     (user_13_reg_dout              ),
  .x_write_en                     (user_13_write_en              )
);

// &Connect(.x_randclk_reg_mod_en_w32(user_13_randclk_reg_mod_en_w32), @190
//          .x_write_en              (user_13_write_en), @191
//          .x_reg_dout              (user_13_reg_dout) @192
//         ); @193
// &Connect(.x_reg_verify            (user_13_reg_verify)); @195
// &Connect(.x_reg_dout_pol          (user_13_reg_dout_pol)); @198


// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_14"); @203
cr_iu_gated_clk_reg  x_cr_iu_gated_clk_reg_user_14 (
  .cp0_yy_clk_en                  (cp0_yy_clk_en                 ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .pad_yy_gate_clk_en_b           (pad_yy_gate_clk_en_b          ),
  .write_data                     (write_data                    ),
  .x_randclk_reg_mod_en_w32       (user_14_randclk_reg_mod_en_w32),
  .x_reg_dout                     (user_14_reg_dout              ),
  .x_write_en                     (user_14_write_en              )
);

// &Connect(.x_randclk_reg_mod_en_w32(user_14_randclk_reg_mod_en_w32), @204
//          .x_write_en              (user_14_write_en), @205
//          .x_reg_dout              (user_14_reg_dout) @206
//         ); @207
// &Connect(.x_reg_verify            (user_14_reg_verify)); @209
// &Connect(.x_reg_dout_pol          (user_14_reg_dout_pol)); @212

// &Instance("cr_iu_gated_clk_reg", "x_cr_iu_gated_clk_reg_user_15"); @215
cr_iu_gated_clk_reg  x_cr_iu_gated_clk_reg_user_15 (
  .cp0_yy_clk_en                  (cp0_yy_clk_en                 ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .pad_yy_gate_clk_en_b           (pad_yy_gate_clk_en_b          ),
  .write_data                     (write_data                    ),
  .x_randclk_reg_mod_en_w32       (user_15_randclk_reg_mod_en_w32),
  .x_reg_dout                     (user_15_reg_dout              ),
  .x_write_en                     (user_15_write_en              )
);

// &Connect(.x_randclk_reg_mod_en_w32(user_15_randclk_reg_mod_en_w32), @216
//          .x_write_en              (user_15_write_en), @217
//          .x_reg_dout              (user_15_reg_dout) @218
//         ); @219
// &Connect(.x_reg_verify            (user_15_reg_verify)); @221
// &Connect(.x_reg_dout_pol          (user_15_reg_dout_pol)); @224

//==============================================================================
// Instance  registers for Privilege Mode register file
//==============================================================================
// &Instance("cr_iu_gated_clk_reg_timing", "x_cr_iu_gated_clk_reg_machine_2"); @230
cr_iu_gated_clk_reg_timing  x_cr_iu_gated_clk_reg_machine_2 (
  .cp0_yy_clk_en                    (cp0_yy_clk_en                   ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .pad_yy_gate_clk_en_b             (pad_yy_gate_clk_en_b            ),
  .write_data                       (write_data_for_sp[31:0]         ),
  .x_randclk_reg_mod_en_w32         (machine_2_randclk_reg_mod_en_w32),
  .x_reg_dout                       (machine_2_reg_dout              ),
  .x_write_en                       (machine_2_write_en              )
);

// &Connect(.write_data              (write_data_for_sp[31:0]), @231
//          .write_data_verify       (write_data_verify_for_sp[3:0]), @232
//          .write_data_pol          (write_data_pol_for_sp) @233
//         ); @234
// &Connect(.x_randclk_reg_mod_en_w32(machine_2_randclk_reg_mod_en_w32), @235
//          .x_write_en              (machine_2_write_en), @236
//          .x_reg_dout              (machine_2_reg_dout) @237
//         ); @238
// &Connect(.x_reg_verify            (machine_2_reg_verify)); @240
// &Connect(.x_reg_dout_pol          (machine_2_reg_dout_pol)); @244

//==============================================================================
// Instance  registers for Secure Privilege and User stack register file
//==============================================================================
// &Instance("cr_iu_gated_clk_reg_timing", "x_cr_iu_gated_clk_reg_sec_user_2"); @251
// &Connect(.write_data              (write_data_for_sp[31:0]), @252
//          .write_data_verify       (write_data_verify_for_sp[3:0]), @253
//          .write_data_pol          (write_data_pol_for_sp) @254
//         ); @255
// &Connect(.x_randclk_reg_mod_en_w32(susp_randclk_reg_mod_en_w32), @256
//          .x_write_en              (susp_write_en), @257
//          .x_reg_dout              (susp_reg_dout) @258
//         ); @259
// &Connect(.x_reg_verify            (susp_reg_verify)); @261
// &Connect(.x_reg_dout_pol          (susp_reg_dout_pol)); @265
// &Instance("cr_iu_gated_clk_reg_timing", "x_cr_iu_gated_clk_reg_sec_machine_2"); @268
// &Connect(.write_data              (write_data_for_sp[31:0]), @269
//          .write_data_verify       (write_data_verify_for_sp[3:0]), @270
//          .write_data_pol          (write_data_pol_for_sp) @271
//         ); @272
// &Connect(.x_randclk_reg_mod_en_w32(sssp_randclk_reg_mod_en_w32), @274
//          .x_write_en              (sssp_write_en), @275
//          .x_reg_dout              (sssp_reg_dout) @276
//         ); @277
// &Connect(.x_reg_verify            (sssp_reg_verify)); @279
// &Connect(.x_reg_dout_pol          (sssp_reg_dout_pol)); @283

//==============================================================================
// rename random clock module enable signal
//==============================================================================
// &Force("bus","randclk_oper_gpr_mod_en_w32",20,0); @291
//assign user_0_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[0];
assign user_1_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[1];
assign user_3_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[3];
assign user_4_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[4];
assign user_5_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[5];
assign user_6_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[6];
assign user_7_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[7];
assign user_8_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[8];
assign user_9_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[9];
assign user_10_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[10];
assign user_11_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[11];
assign user_12_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[12];
assign user_13_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[13];
assign user_14_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[14];
assign user_15_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[15];

assign machine_2_randclk_reg_mod_en_w32 = randclk_oper_gpr_mod_en_w32[16];
//==============================================================================
// implement of 1 write port GPR
//==============================================================================
//if not define, set rst_b 1
assign pad_cpu_gpr_rst_b = 1'b1;

assign gpr_sync_rst_b = pad_cpu_gpr_rst_b && iu_yy_xx_reg_rst_b
                        && hs_split_iu_nsinst_gpr_rst_b;
assign gpr_sync_rst_for_sp_b = pad_cpu_gpr_rst_b && iu_yy_xx_reg_rst_b;

//the general write port
assign write_port_data[31:0] = {32{gpr_sync_rst_b}}
                             & inst_write_data[31:0];
assign write_data[31:0] = write_port_data[31:0];

//==============================================================================
// implement of 1 write port GPR
//==============================================================================
//write port for gpr with general write buffer wen and CP0 wen
//1.user x2 when MACHINE_SP
//2.machine x2 when CSKY_TEE
//3.susp when CSKY_TEE

assign  write_data_for_sp[31:0] =  write_port_data[31:0];

//==========================================================
// implement of write port: write data and write enable
//==========================================================

// &CombBeg; @376
always @( inst_write_index[4:0])
begin
  reg_sel[31:0] = 32'b0;
  case(inst_write_index[4:0])
  5'h0 :  reg_sel[0]  = 1'b1;
  5'h1 :  reg_sel[1]  = 1'b1;
  5'h2 :  reg_sel[2]  = 1'b1;
  5'h3 :  reg_sel[3]  = 1'b1;
  5'h4 :  reg_sel[4]  = 1'b1;
  5'h5 :  reg_sel[5]  = 1'b1;
  5'h6 :  reg_sel[6]  = 1'b1;
  5'h7 :  reg_sel[7]  = 1'b1;
  5'h8 :  reg_sel[8]  = 1'b1;
  5'h9 :  reg_sel[9]  = 1'b1;
  5'ha :  reg_sel[10] = 1'b1;
  5'hb :  reg_sel[11] = 1'b1;
  5'hc :  reg_sel[12] = 1'b1;
  5'hd :  reg_sel[13] = 1'b1;
  5'he :  reg_sel[14] = 1'b1;
  5'hf :  reg_sel[15] = 1'b1;
  endcase
// &CombEnd; @398
end

//r31~r0, normal
assign user_write_en[31:3] = reg_sel[31:3] & {29{inst_wen}};
assign user_write_en[1:0]  = reg_sel[1:0] & {2{inst_wen}}; 

// &Force ("bus","cp0_iu_vec",7,0); @404

assign user_write_en[2] = 1'b0;

assign ussp_explicit_we   = reg_sel[2] && inst_wen
                         || !gpr_sync_rst_for_sp_b;
assign machine_write_en_2 = ussp_explicit_we;


assign user_1_write_en   = !gpr_sync_rst_b | user_write_en[1];
assign user_3_write_en   = !gpr_sync_rst_b | user_write_en[3];
assign user_4_write_en   = !gpr_sync_rst_b | user_write_en[4];
assign user_5_write_en   = !gpr_sync_rst_b | user_write_en[5];
assign user_6_write_en   = !gpr_sync_rst_b | user_write_en[6];
assign user_7_write_en   = !gpr_sync_rst_b | user_write_en[7];
assign user_8_write_en   = !gpr_sync_rst_b | user_write_en[8];
assign user_9_write_en   = !gpr_sync_rst_b | user_write_en[9];
assign user_10_write_en  = !gpr_sync_rst_b | user_write_en[10];
assign user_11_write_en  = !gpr_sync_rst_b | user_write_en[11];
assign user_12_write_en  = !gpr_sync_rst_b | user_write_en[12];
assign user_13_write_en  = !gpr_sync_rst_b | user_write_en[13];
assign user_14_write_en  = !gpr_sync_rst_b | user_write_en[14];
assign user_15_write_en  = !gpr_sync_rst_b | user_write_en[15];
assign machine_2_write_en = machine_write_en_2;



//==============================================================================
// As GPR has 2 read ports, the logic is responsible for generating 2 read ports
//==============================================================================
//read port of x1 for IFU forwarding
// //&Force("output","user_reg_1_dout"); @475
//assign user_reg_1_dout[31:0] = alter_mode ? alter_1_reg_dout[31:0]
//                                          : user_1_reg_dout[31:0];

//==============================================================================
//for code sytye of GPR read
//==============================================================================
// //&Force ("output","alter_mode"); @482

assign alter_mode = 1'b0;
assign alter_0_reg_dout[31:0] = 32'b0;
assign alter_1_reg_dout[31:0] = 32'b0;
assign alter_2_reg_dout[31:0] = 32'b0;
assign alter_3_reg_dout[31:0] = 32'b0;
assign alter_4_reg_dout[31:0] = 32'b0;
assign alter_5_reg_dout[31:0] = 32'b0;
assign alter_6_reg_dout[31:0] = 32'b0;
assign alter_7_reg_dout[31:0] = 32'b0;
assign alter_8_reg_dout[31:0] = 32'b0;
assign alter_9_reg_dout[31:0]  = 32'b0;
assign alter_10_reg_dout[31:0] = 32'b0;
assign alter_11_reg_dout[31:0] = 32'b0;
assign alter_12_reg_dout[31:0] = 32'b0;
assign alter_13_reg_dout[31:0] = 32'b0;
assign alter_14_reg_dout[31:0] = 32'b0;
assign alter_15_reg_dout[31:0] = 32'b0;

//==============================================================================
// Read Port 0
//==============================================================================
// &CombBeg; @509
always @( user_8_reg_dout[31:0]
       or alter_3_reg_dout[31:0]
       or alter_7_reg_dout[31:0]
       or alter_13_reg_dout[31:0]
       or inst_read_index0[4:0]
       or user_11_reg_dout[31:0]
       or user_10_reg_dout[31:0]
       or user_3_reg_dout[31:0]
       or user_9_reg_dout[31:0]
       or alter_15_reg_dout[31:0]
       or alter_1_reg_dout[31:0]
       or alter_6_reg_dout[31:0]
       or user_1_reg_dout[31:0]
       or sp_read_data0[31:0]
       or alter_5_reg_dout[31:0]
       or user_13_reg_dout[31:0]
       or alter_4_reg_dout[31:0]
       or alter_mode
       or user_4_reg_dout[31:0]
       or user_5_reg_dout[31:0]
       or user_15_reg_dout[31:0]
       or user_6_reg_dout[31:0]
       or alter_12_reg_dout[31:0]
       or alter_10_reg_dout[31:0]
       or alter_9_reg_dout[31:0]
       or alter_11_reg_dout[31:0]
       or user_14_reg_dout[31:0]
       or alter_0_reg_dout[31:0]
       or user_12_reg_dout[31:0]
       or user_7_reg_dout[31:0]
       or alter_8_reg_dout[31:0]
       or alter_14_reg_dout[31:0])
begin
  case(inst_read_index0[4:0])
  5'h0:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_0_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = 32'b0;
  5'h1:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_1_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = user_1_reg_dout[31:0];
  5'h2:
    gpr_read_data0[31:0] = sp_read_data0[31:0];
  5'h3:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_3_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = user_3_reg_dout[31:0];
  5'h4:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_4_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = user_4_reg_dout[31:0];
  5'h5:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_5_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = user_5_reg_dout[31:0];
  5'h6:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_6_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = user_6_reg_dout[31:0];
  5'h7:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_7_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = user_7_reg_dout[31:0];
  5'h8:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_8_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = user_8_reg_dout[31:0];
  5'h9:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_9_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = user_9_reg_dout[31:0];
  5'ha:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_10_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = user_10_reg_dout[31:0];
  5'hb:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_11_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = user_11_reg_dout[31:0];
  5'hc:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_12_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = user_12_reg_dout[31:0];
  5'hd:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_13_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = user_13_reg_dout[31:0];
  5'he:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_14_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = user_14_reg_dout[31:0];
  5'hf:
  if(alter_mode)
    gpr_read_data0[31:0] = alter_15_reg_dout[31:0];
  else
    gpr_read_data0[31:0] = user_15_reg_dout[31:0];
  default: gpr_read_data0[31:0] = 32'b0;
  endcase
// &CombEnd; @592
end

// &CombBeg; @594
always @( alter_2_reg_dout[31:0]
       or alter_mode
       or machine_2_reg_dout[31:0])
begin
  if(alter_mode)
    sp_read_data0[31:0] = alter_2_reg_dout[31:0];
  else
    sp_read_data0[31:0] = machine_2_reg_dout[31:0];

// &CombEnd; @627
end

assign inst_read_data0[31:0] = gpr_read_data0[31:0];

//==============================================================================
// Read Port 1
//==============================================================================
// &CombBeg; @634
always @( user_8_reg_dout[31:0]
       or alter_3_reg_dout[31:0]
       or sp_read_data1[31:0]
       or alter_7_reg_dout[31:0]
       or alter_13_reg_dout[31:0]
       or user_11_reg_dout[31:0]
       or user_10_reg_dout[31:0]
       or user_3_reg_dout[31:0]
       or user_9_reg_dout[31:0]
       or alter_15_reg_dout[31:0]
       or inst_read_index1[4:0]
       or alter_1_reg_dout[31:0]
       or alter_6_reg_dout[31:0]
       or user_1_reg_dout[31:0]
       or user_13_reg_dout[31:0]
       or alter_5_reg_dout[31:0]
       or alter_4_reg_dout[31:0]
       or alter_mode
       or user_4_reg_dout[31:0]
       or user_5_reg_dout[31:0]
       or user_15_reg_dout[31:0]
       or user_6_reg_dout[31:0]
       or alter_10_reg_dout[31:0]
       or alter_12_reg_dout[31:0]
       or alter_9_reg_dout[31:0]
       or alter_11_reg_dout[31:0]
       or alter_0_reg_dout[31:0]
       or user_14_reg_dout[31:0]
       or user_12_reg_dout[31:0]
       or user_7_reg_dout[31:0]
       or alter_8_reg_dout[31:0]
       or alter_14_reg_dout[31:0])
begin
  case(inst_read_index1[4:0])
  5'h0:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_0_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = 32'b0;
  5'h1:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_1_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = user_1_reg_dout[31:0];
  5'h2:
    gpr_read_data1[31:0] = sp_read_data1[31:0];
  5'h3:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_3_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = user_3_reg_dout[31:0];
  5'h4:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_4_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = user_4_reg_dout[31:0];
  5'h5:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_5_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = user_5_reg_dout[31:0];
  5'h6:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_6_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = user_6_reg_dout[31:0];
  5'h7:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_7_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = user_7_reg_dout[31:0];
  5'h8:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_8_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = user_8_reg_dout[31:0];
  5'h9:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_9_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = user_9_reg_dout[31:0];
  5'ha:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_10_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = user_10_reg_dout[31:0];
  5'hb:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_11_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = user_11_reg_dout[31:0];
  5'hc:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_12_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = user_12_reg_dout[31:0];
  5'hd:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_13_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = user_13_reg_dout[31:0];
  5'he:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_14_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = user_14_reg_dout[31:0];
  5'hf:
  if(alter_mode)
    gpr_read_data1[31:0] = alter_15_reg_dout[31:0];
  else
    gpr_read_data1[31:0] = user_15_reg_dout[31:0];
  default: gpr_read_data1[31:0] = 32'b0;
  endcase
// &CombEnd; @736
end
// &CombBeg; @740
always @( alter_2_reg_dout[31:0]
       or alter_mode
       or machine_2_reg_dout[31:0])
begin
  if(alter_mode)
    sp_read_data1[31:0] = alter_2_reg_dout[31:0];
  else
    sp_read_data1[31:0] = machine_2_reg_dout[31:0];
// &CombEnd; @772
end
// &Force("output","user_2_reg_dout"); @774
// &Force("output","machine_2_reg_dout"); @777
// &Force("output","susp_reg_dout"); @778

assign inst_read_data1[31:0] = gpr_read_data1[31:0];

// &ModuleEnd; @783
endmodule


