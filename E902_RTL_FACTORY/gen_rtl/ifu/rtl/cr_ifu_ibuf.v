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
module cr_ifu_ibuf(
  cp0_yy_clk_en,
  cpuclk,
  cpurst_b,
  forever_cpuclk,
  had_ifu_ir,
  had_ifu_ir_vld,
  ibuf_ibusif_inst_fetch,
  ibuf_ifctrl_inst32_low,
  ibuf_ifctrl_inst_vld,
  ibuf_ifctrl_pop0_mad32_low,
  ibuf_ifdp_inst_dbg_disable,
  ibuf_top_clk_en,
  ibuf_xx_empty,
  ibusif_ibuf_no_trans,
  ibusif_xx_16bit_inst,
  ibusif_xx_acc_err,
  ibusif_xx_data,
  ibusif_xx_ibus_idle,
  ibusif_xx_trans_cmplt,
  ibusif_xx_unalign_fetch,
  ifctrl_ibuf_bypass_vld,
  ifctrl_ibuf_inst_pipe_down,
  ifctrl_ibuf_pop_en,
  ifctrl_xx_ifcancel,
  ifu_had_fetch_expt_vld,
  ifu_iu_ex_expt_cur,
  ifu_iu_ex_expt_vld,
  ifu_iu_ex_inst,
  ifu_misc_clk,
  iu_ifu_ex_stall_noinput,
  iu_ifu_ex_vld,
  iu_ifu_inst_fetch,
  iu_ifu_lsu_inst,
  iu_ifu_wb_ldst,
  iu_ifu_wb_stall,
  iu_yy_xx_dbgon,
  pad_yy_gate_clk_en_b,
  randclk_ibuf_entry_data_mod_en_w16,
  randclk_ibuf_pop_mod_en_w3,
  randclk_ibuf_push_mod_en_w3
);

// &Ports; @24
input           cp0_yy_clk_en;                     
input           cpuclk;                            
input           cpurst_b;                          
input           forever_cpuclk;                    
input   [31:0]  had_ifu_ir;                        
input           had_ifu_ir_vld;                    
input           ibusif_ibuf_no_trans;              
input           ibusif_xx_16bit_inst;              
input           ibusif_xx_acc_err;                 
input   [31:0]  ibusif_xx_data;                    
input           ibusif_xx_ibus_idle;               
input           ibusif_xx_trans_cmplt;             
input           ibusif_xx_unalign_fetch;           
input           ifctrl_ibuf_bypass_vld;            
input           ifctrl_ibuf_inst_pipe_down;        
input           ifctrl_ibuf_pop_en;                
input           ifctrl_xx_ifcancel;                
input           ifu_misc_clk;                      
input           iu_ifu_ex_stall_noinput;           
input           iu_ifu_ex_vld;                     
input           iu_ifu_inst_fetch;                 
input           iu_ifu_lsu_inst;                   
input           iu_ifu_wb_ldst;                    
input           iu_ifu_wb_stall;                   
input           iu_yy_xx_dbgon;                    
input           pad_yy_gate_clk_en_b;              
input   [3 :0]  randclk_ibuf_entry_data_mod_en_w16; 
input           randclk_ibuf_pop_mod_en_w3;        
input           randclk_ibuf_push_mod_en_w3;       
output          ibuf_ibusif_inst_fetch;            
output          ibuf_ifctrl_inst32_low;            
output          ibuf_ifctrl_inst_vld;              
output          ibuf_ifctrl_pop0_mad32_low;        
output          ibuf_ifdp_inst_dbg_disable;        
output          ibuf_top_clk_en;                   
output          ibuf_xx_empty;                     
output          ifu_had_fetch_expt_vld;            
output          ifu_iu_ex_expt_cur;                
output          ifu_iu_ex_expt_vld;                
output  [31:0]  ifu_iu_ex_inst;                    

// &Regs; @25
reg     [5 :0]  pop0;                              
reg             pop0_acc_err;                      
reg     [15:0]  pop0_inst;                         
reg     [5 :0]  pop0_shift;                        
reg     [15:0]  pop0_shift_inst;                   
reg             pop0_shift_vld;                    
reg             pop0_vld;                          
reg             pop1_acc_err;                      
reg     [15:0]  pop1_inst;                         
reg             pop1_shift_vld;                    
reg             pop1_vld;                          
reg     [5 :0]  push0;                             
reg     [5 :0]  push0_shift;                       

// &Wires; @26
wire            acc_err_upd_en;                    
wire            align_fetch_bypass_32bit;          
wire            cp0_yy_clk_en;                     
wire            cpuclk;                            
wire            cpurst_b;                          
wire            entry0_acc_err;                    
wire            entry0_create0_en;                 
wire            entry0_create1_en;                 
wire    [16:0]  entry0_inst;                       
wire            entry0_part_flush;                 
wire            entry0_randclk_data_mod_en_w16;    
wire            entry0_retire0_en;                 
wire            entry0_retire1_en;                 
wire            entry0_vld;                        
wire            entry1_acc_err;                    
wire            entry1_create0_en;                 
wire            entry1_create1_en;                 
wire    [16:0]  entry1_inst;                       
wire            entry1_part_flush;                 
wire            entry1_randclk_data_mod_en_w16;    
wire            entry1_retire0_en;                 
wire            entry1_retire1_en;                 
wire            entry1_vld;                        
wire            entry2_acc_err;                    
wire            entry2_create0_en;                 
wire            entry2_create1_en;                 
wire    [16:0]  entry2_inst;                       
wire            entry2_part_flush;                 
wire            entry2_randclk_data_mod_en_w16;    
wire            entry2_retire0_en;                 
wire            entry2_retire1_en;                 
wire            entry2_vld;                        
wire            entry3_acc_err;                    
wire            entry3_create0_en;                 
wire            entry3_create1_en;                 
wire    [16:0]  entry3_inst;                       
wire            entry3_part_flush;                 
wire            entry3_randclk_data_mod_en_w16;    
wire            entry3_retire0_en;                 
wire            entry3_retire1_en;                 
wire            entry3_vld;                        
wire            entry4_acc_err;                    
wire            entry4_create0_en;                 
wire            entry4_create1_en;                 
wire    [16:0]  entry4_inst;                       
wire            entry4_part_flush;                 
wire            entry4_randclk_data_mod_en_w16;    
wire            entry4_retire0_en;                 
wire            entry4_retire1_en;                 
wire            entry4_vld;                        
wire            entry5_acc_err;                    
wire            entry5_create0_en;                 
wire            entry5_create1_en;                 
wire    [16:0]  entry5_inst;                       
wire            entry5_part_flush;                 
wire            entry5_randclk_data_mod_en_w16;    
wire            entry5_retire0_en;                 
wire            entry5_retire1_en;                 
wire            entry5_vld;                        
wire    [5 :0]  flush_4_entry_ptr;                 
wire    [5 :0]  flush_5_entry_ptr;                 
wire            forever_cpuclk;                    
wire            had_create0_en;                    
wire            had_create1_en;                    
wire    [31:0]  had_ifu_ir;                        
wire            had_ifu_ir_vld;                    
wire            ibuf_acc_err;                      
wire            ibuf_create0_en;                   
wire            ibuf_create1_en;                   
wire            ibuf_empty;                        
wire            ibuf_fetch_empty;                  
wire            ibuf_fetch_full;                   
wire            ibuf_fetch_more_than_two;          
wire            ibuf_fetch_one;                    
wire            ibuf_five_avalbe;                  
wire            ibuf_flush;                        
wire            ibuf_four_avalbe;                  
wire            ibuf_full;                         
wire            ibuf_ibusif_inst_fetch;            
wire            ibuf_ifctrl_inst32_low;            
wire            ibuf_ifctrl_inst_vld;              
wire            ibuf_ifctrl_pop0_mad32_low;        
wire            ibuf_ifdp_inst_dbg_disable;        
wire            ibuf_inst16;                       
wire            ibuf_inst32;                       
wire            ibuf_inst_32_vld;                  
wire            ibuf_inst_fetch;                   
wire            ibuf_no_inst;                      
wire            ibuf_no_inst_during_pipe_down;     
wire            ibuf_one_avalbe;                   
wire    [5 :0]  ibuf_part_flush_ptr;               
wire            ibuf_pop0_mad32_low;               
wire            ibuf_pop0_sys32_low;               
wire            ibuf_pop_upd_clk;                  
wire            ibuf_pop_upd_en;                   
wire            ibuf_push_upd_clk;                 
wire            ibuf_push_upd_en;                  
wire            ibuf_retire0_en;                   
wire            ibuf_retire0_en_vld;               
wire            ibuf_retire1_en;                   
wire            ibuf_three_avalbe;                 
wire            ibuf_top_clk_en;                   
wire            ibuf_two_avalbe;                   
wire    [2 :0]  ibuf_vld_num;                      
wire            ibuf_xx_empty;                     
wire            ibus_create0_en;                   
wire            ibus_create1_en;                   
wire            ibusif_ibuf_no_trans;              
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
wire            ifu_had_fetch_expt_vld;            
wire            ifu_iu_ex_expt_cur;                
wire            ifu_iu_ex_expt_vld;                
wire    [31:0]  ifu_iu_ex_inst;                    
wire            ifu_misc_clk;                      
wire            iu_ifu_ex_stall_noinput;           
wire            iu_ifu_ex_vld;                     
wire            iu_ifu_inst_fetch;                 
wire            iu_ifu_lsu_inst;                   
wire            iu_ifu_wb_ldst;                    
wire            iu_ifu_wb_stall;                   
wire            iu_yy_xx_dbgon;                    
wire            pad_yy_gate_clk_en_b;              
wire            pop0_inst_32;                      
wire            pop0_shift_lsu_inst;               
wire            pop0_shift_mad_low;                
wire            pop0_shift_sys_low;                
wire    [5 :0]  pop1;                              
wire    [5 :0]  pop1_shift;                        
wire    [5 :0]  push1;                             
wire    [3 :0]  randclk_ibuf_entry_data_mod_en_w16; 
wire            randclk_ibuf_pop_mod_en_w3;        
wire            randclk_ibuf_push_mod_en_w3;       
wire            unalign_fetch_bypass_16bit;        



parameter IDLE     = 2'b00,
          POP1_EN  = 2'b01,
          POP2_EN  = 2'b10,
          FLUSH    = 2'b11;

//==============================================================================
//                            Gated Clock
//==============================================================================
// &Instance("gated_clk_cell", "x_ibuf_push_upd_clkhdr"); @37
gated_clk_cell  x_ibuf_push_upd_clkhdr (
  .clk_in                      (forever_cpuclk             ),
  .clk_out                     (ibuf_push_upd_clk          ),
  .external_en                 (1'b0                       ),
  .global_en                   (cp0_yy_clk_en              ),
  .local_en                    (ibuf_push_upd_en           ),
  .module_en                   (randclk_ibuf_push_mod_en_w3),
  .pad_yy_gate_clk_en_b        (pad_yy_gate_clk_en_b       )
);

// &Connect(.clk_in(forever_cpuclk), @38
//          .external_en(1'b0), @39
//          .global_en(cp0_yy_clk_en), @40
//          .module_en(randclk_ibuf_push_mod_en_w3), @41
//          .local_en(ibuf_push_upd_en), @42
//          .clk_out(ibuf_push_upd_clk) @43
//         ); @44
assign ibuf_push_upd_en = ibuf_flush || ibuf_create0_en || iu_ifu_inst_fetch;

// &Instance("gated_clk_cell", "x_ibuf_pop_upd_clkhdr"); @47
gated_clk_cell  x_ibuf_pop_upd_clkhdr (
  .clk_in                     (forever_cpuclk            ),
  .clk_out                    (ibuf_pop_upd_clk          ),
  .external_en                (1'b0                      ),
  .global_en                  (cp0_yy_clk_en             ),
  .local_en                   (ibuf_pop_upd_en           ),
  .module_en                  (randclk_ibuf_pop_mod_en_w3),
  .pad_yy_gate_clk_en_b       (pad_yy_gate_clk_en_b      )
);

// &Connect(.clk_in(forever_cpuclk), @48
//          .external_en(1'b0), @49
//          .global_en(cp0_yy_clk_en), @50
//          .module_en(randclk_ibuf_pop_mod_en_w3), @51
//          .local_en(ibuf_pop_upd_en), @52
//          .clk_out(ibuf_pop_upd_clk) @53
//         ); @54
assign ibuf_pop_upd_en = ibuf_retire0_en_vld && !ibuf_flush;

assign acc_err_upd_en = iu_yy_xx_dbgon
                     || ibusif_xx_trans_cmplt
                          && (ibusif_xx_acc_err ||
                              entry0_acc_err    ||
                              entry1_acc_err    ||
                              entry2_acc_err    || 
                              entry3_acc_err    || 
                              entry4_acc_err    || 
                              entry5_acc_err    
                             );

assign ibuf_top_clk_en = acc_err_upd_en;

parameter ENTRY_NUM = 6;

////////////////////////////////////////////////////////////////////////////////
//                              Data Path                                     //
////////////////////////////////////////////////////////////////////////////////
//==============================================================================
// Instance the entries
//==============================================================================
// &Instance("cr_ifu_ibuf_entry", "x_ibuf_entry_0"); @94
cr_ifu_ibuf_entry  x_ibuf_entry_0 (
  .cp0_yy_clk_en                  (cp0_yy_clk_en                 ),
  .cpuclk                         (cpuclk                        ),
  .cpurst_b                       (cpurst_b                      ),
  .entry_acc_err                  (entry0_acc_err                ),
  .entry_create0_en               (entry0_create0_en             ),
  .entry_create1_en               (entry0_create1_en             ),
  .entry_inst                     (entry0_inst                   ),
  .entry_part_flush               (entry0_part_flush             ),
  .entry_randclk_data_mod_en_w16  (entry0_randclk_data_mod_en_w16),
  .entry_retire0_en               (entry0_retire0_en             ),
  .entry_retire1_en               (entry0_retire1_en             ),
  .entry_vld                      (entry0_vld                    ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .had_ifu_ir                     (had_ifu_ir                    ),
  .ibuf_flush                     (ibuf_flush                    ),
  .ibuf_no_inst_during_pipe_down  (ibuf_no_inst_during_pipe_down ),
  .ibusif_xx_acc_err              (ibusif_xx_acc_err             ),
  .ibusif_xx_data                 (ibusif_xx_data                ),
  .ifu_misc_clk                   (ifu_misc_clk                  ),
  .iu_yy_xx_dbgon                 (iu_yy_xx_dbgon                ),
  .pad_yy_gate_clk_en_b           (pad_yy_gate_clk_en_b          )
);

// &Connect(.entry_create0_en             (entry0_create0_en), @95
//          .entry_create1_en             (entry0_create1_en), @96
//          .entry_randclk_data_mod_en_w16(entry0_randclk_data_mod_en_w16), @97
//          .entry_retire0_en             (entry0_retire0_en), @98
//          .entry_retire1_en             (entry0_retire1_en), @99
//          .entry_acc_err                (entry0_acc_err), @100
//          .entry_inst                   (entry0_inst), @101
//          .entry_part_flush             (entry0_part_flush), @102
//          .entry_vld                    (entry0_vld) @103
//         ); @104
// &Connect(.entry_inst_dbg_disable            (entry0_inst_dbg_disable)); @106

// &Instance("cr_ifu_ibuf_entry", "x_ibuf_entry_1"); @109
cr_ifu_ibuf_entry  x_ibuf_entry_1 (
  .cp0_yy_clk_en                  (cp0_yy_clk_en                 ),
  .cpuclk                         (cpuclk                        ),
  .cpurst_b                       (cpurst_b                      ),
  .entry_acc_err                  (entry1_acc_err                ),
  .entry_create0_en               (entry1_create0_en             ),
  .entry_create1_en               (entry1_create1_en             ),
  .entry_inst                     (entry1_inst                   ),
  .entry_part_flush               (entry1_part_flush             ),
  .entry_randclk_data_mod_en_w16  (entry1_randclk_data_mod_en_w16),
  .entry_retire0_en               (entry1_retire0_en             ),
  .entry_retire1_en               (entry1_retire1_en             ),
  .entry_vld                      (entry1_vld                    ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .had_ifu_ir                     (had_ifu_ir                    ),
  .ibuf_flush                     (ibuf_flush                    ),
  .ibuf_no_inst_during_pipe_down  (ibuf_no_inst_during_pipe_down ),
  .ibusif_xx_acc_err              (ibusif_xx_acc_err             ),
  .ibusif_xx_data                 (ibusif_xx_data                ),
  .ifu_misc_clk                   (ifu_misc_clk                  ),
  .iu_yy_xx_dbgon                 (iu_yy_xx_dbgon                ),
  .pad_yy_gate_clk_en_b           (pad_yy_gate_clk_en_b          )
);

// &Connect(.entry_create0_en             (entry1_create0_en), @110
//          .entry_create1_en             (entry1_create1_en), @111
//          .entry_randclk_data_mod_en_w16(entry1_randclk_data_mod_en_w16), @112
//          .entry_retire0_en             (entry1_retire0_en), @113
//          .entry_retire1_en             (entry1_retire1_en), @114
//          .entry_acc_err                (entry1_acc_err), @115
//          .entry_inst                   (entry1_inst), @116
//          .entry_part_flush             (entry1_part_flush), @117
//          .entry_vld                    (entry1_vld) @118
//         ); @119
// &Connect(.entry_inst_dbg_disable            (entry1_inst_dbg_disable)); @121

// &Instance("cr_ifu_ibuf_entry", "x_ibuf_entry_2"); @124
cr_ifu_ibuf_entry  x_ibuf_entry_2 (
  .cp0_yy_clk_en                  (cp0_yy_clk_en                 ),
  .cpuclk                         (cpuclk                        ),
  .cpurst_b                       (cpurst_b                      ),
  .entry_acc_err                  (entry2_acc_err                ),
  .entry_create0_en               (entry2_create0_en             ),
  .entry_create1_en               (entry2_create1_en             ),
  .entry_inst                     (entry2_inst                   ),
  .entry_part_flush               (entry2_part_flush             ),
  .entry_randclk_data_mod_en_w16  (entry2_randclk_data_mod_en_w16),
  .entry_retire0_en               (entry2_retire0_en             ),
  .entry_retire1_en               (entry2_retire1_en             ),
  .entry_vld                      (entry2_vld                    ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .had_ifu_ir                     (had_ifu_ir                    ),
  .ibuf_flush                     (ibuf_flush                    ),
  .ibuf_no_inst_during_pipe_down  (ibuf_no_inst_during_pipe_down ),
  .ibusif_xx_acc_err              (ibusif_xx_acc_err             ),
  .ibusif_xx_data                 (ibusif_xx_data                ),
  .ifu_misc_clk                   (ifu_misc_clk                  ),
  .iu_yy_xx_dbgon                 (iu_yy_xx_dbgon                ),
  .pad_yy_gate_clk_en_b           (pad_yy_gate_clk_en_b          )
);

// &Connect(.entry_create0_en             (entry2_create0_en), @125
//          .entry_create1_en             (entry2_create1_en), @126
//          .entry_randclk_data_mod_en_w16(entry2_randclk_data_mod_en_w16), @127
//          .entry_retire0_en             (entry2_retire0_en), @128
//          .entry_retire1_en             (entry2_retire1_en), @129
//          .entry_acc_err                (entry2_acc_err), @130
//          .entry_inst                   (entry2_inst), @131
//          .entry_part_flush             (entry2_part_flush), @132
//          .entry_vld                    (entry2_vld) @133
//         ); @134
// &Connect(.entry_inst_dbg_disable            (entry2_inst_dbg_disable)); @136

// &Instance("cr_ifu_ibuf_entry", "x_ibuf_entry_3"); @139
cr_ifu_ibuf_entry  x_ibuf_entry_3 (
  .cp0_yy_clk_en                  (cp0_yy_clk_en                 ),
  .cpuclk                         (cpuclk                        ),
  .cpurst_b                       (cpurst_b                      ),
  .entry_acc_err                  (entry3_acc_err                ),
  .entry_create0_en               (entry3_create0_en             ),
  .entry_create1_en               (entry3_create1_en             ),
  .entry_inst                     (entry3_inst                   ),
  .entry_part_flush               (entry3_part_flush             ),
  .entry_randclk_data_mod_en_w16  (entry3_randclk_data_mod_en_w16),
  .entry_retire0_en               (entry3_retire0_en             ),
  .entry_retire1_en               (entry3_retire1_en             ),
  .entry_vld                      (entry3_vld                    ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .had_ifu_ir                     (had_ifu_ir                    ),
  .ibuf_flush                     (ibuf_flush                    ),
  .ibuf_no_inst_during_pipe_down  (ibuf_no_inst_during_pipe_down ),
  .ibusif_xx_acc_err              (ibusif_xx_acc_err             ),
  .ibusif_xx_data                 (ibusif_xx_data                ),
  .ifu_misc_clk                   (ifu_misc_clk                  ),
  .iu_yy_xx_dbgon                 (iu_yy_xx_dbgon                ),
  .pad_yy_gate_clk_en_b           (pad_yy_gate_clk_en_b          )
);

// &Connect(.entry_create0_en             (entry3_create0_en), @140
//          .entry_create1_en             (entry3_create1_en), @141
//          .entry_randclk_data_mod_en_w16(entry3_randclk_data_mod_en_w16), @142
//          .entry_retire0_en             (entry3_retire0_en), @143
//          .entry_retire1_en             (entry3_retire1_en), @144
//          .entry_acc_err                (entry3_acc_err), @145
//          .entry_inst                   (entry3_inst), @146
//          .entry_part_flush             (entry3_part_flush), @147
//          .entry_vld                    (entry3_vld) @148
//         ); @149
// &Connect(.entry_inst_dbg_disable            (entry3_inst_dbg_disable)); @151

// &Instance("cr_ifu_ibuf_entry", "x_ibuf_entry_4"); @154
cr_ifu_ibuf_entry  x_ibuf_entry_4 (
  .cp0_yy_clk_en                  (cp0_yy_clk_en                 ),
  .cpuclk                         (cpuclk                        ),
  .cpurst_b                       (cpurst_b                      ),
  .entry_acc_err                  (entry4_acc_err                ),
  .entry_create0_en               (entry4_create0_en             ),
  .entry_create1_en               (entry4_create1_en             ),
  .entry_inst                     (entry4_inst                   ),
  .entry_part_flush               (entry4_part_flush             ),
  .entry_randclk_data_mod_en_w16  (entry4_randclk_data_mod_en_w16),
  .entry_retire0_en               (entry4_retire0_en             ),
  .entry_retire1_en               (entry4_retire1_en             ),
  .entry_vld                      (entry4_vld                    ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .had_ifu_ir                     (had_ifu_ir                    ),
  .ibuf_flush                     (ibuf_flush                    ),
  .ibuf_no_inst_during_pipe_down  (ibuf_no_inst_during_pipe_down ),
  .ibusif_xx_acc_err              (ibusif_xx_acc_err             ),
  .ibusif_xx_data                 (ibusif_xx_data                ),
  .ifu_misc_clk                   (ifu_misc_clk                  ),
  .iu_yy_xx_dbgon                 (iu_yy_xx_dbgon                ),
  .pad_yy_gate_clk_en_b           (pad_yy_gate_clk_en_b          )
);

// &Connect(.entry_create0_en             (entry4_create0_en), @155
//          .entry_create1_en             (entry4_create1_en), @156
//          .entry_randclk_data_mod_en_w16(entry4_randclk_data_mod_en_w16), @157
//          .entry_retire0_en             (entry4_retire0_en), @158
//          .entry_retire1_en             (entry4_retire1_en), @159
//          .entry_acc_err                (entry4_acc_err), @160
//          .entry_inst                   (entry4_inst), @161
//          .entry_part_flush             (entry4_part_flush), @162
//          .entry_vld                    (entry4_vld) @163
//         ); @164
// &Instance("cr_ifu_ibuf_entry", "x_ibuf_entry_5"); @165
cr_ifu_ibuf_entry  x_ibuf_entry_5 (
  .cp0_yy_clk_en                  (cp0_yy_clk_en                 ),
  .cpuclk                         (cpuclk                        ),
  .cpurst_b                       (cpurst_b                      ),
  .entry_acc_err                  (entry5_acc_err                ),
  .entry_create0_en               (entry5_create0_en             ),
  .entry_create1_en               (entry5_create1_en             ),
  .entry_inst                     (entry5_inst                   ),
  .entry_part_flush               (entry5_part_flush             ),
  .entry_randclk_data_mod_en_w16  (entry5_randclk_data_mod_en_w16),
  .entry_retire0_en               (entry5_retire0_en             ),
  .entry_retire1_en               (entry5_retire1_en             ),
  .entry_vld                      (entry5_vld                    ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .had_ifu_ir                     (had_ifu_ir                    ),
  .ibuf_flush                     (ibuf_flush                    ),
  .ibuf_no_inst_during_pipe_down  (ibuf_no_inst_during_pipe_down ),
  .ibusif_xx_acc_err              (ibusif_xx_acc_err             ),
  .ibusif_xx_data                 (ibusif_xx_data                ),
  .ifu_misc_clk                   (ifu_misc_clk                  ),
  .iu_yy_xx_dbgon                 (iu_yy_xx_dbgon                ),
  .pad_yy_gate_clk_en_b           (pad_yy_gate_clk_en_b          )
);

// &Connect(.entry_create0_en             (entry5_create0_en), @166
//          .entry_create1_en             (entry5_create1_en), @167
//          .entry_randclk_data_mod_en_w16(entry5_randclk_data_mod_en_w16), @168
//          .entry_retire0_en             (entry5_retire0_en), @169
//          .entry_retire1_en             (entry5_retire1_en), @170
//          .entry_acc_err                (entry5_acc_err), @171
//          .entry_inst                   (entry5_inst), @172
//          .entry_part_flush             (entry5_part_flush), @173
//          .entry_vld                    (entry5_vld) @174
//         ); @175
//==============================================================================
//                  entry gate clock module enable signal
//==============================================================================
assign entry0_randclk_data_mod_en_w16 = randclk_ibuf_entry_data_mod_en_w16[0];
assign entry1_randclk_data_mod_en_w16 = randclk_ibuf_entry_data_mod_en_w16[1];
assign entry2_randclk_data_mod_en_w16 = randclk_ibuf_entry_data_mod_en_w16[2];
assign entry3_randclk_data_mod_en_w16 = randclk_ibuf_entry_data_mod_en_w16[3];
assign entry4_randclk_data_mod_en_w16 = randclk_ibuf_entry_data_mod_en_w16[3];
assign entry5_randclk_data_mod_en_w16 = randclk_ibuf_entry_data_mod_en_w16[3];

//==============================================================================
//                  Extract Information from Prefetch Buffer
//==============================================================================
//The infornation which is index by pop0 pointer
// &CombBeg; @190
always @( entry3_acc_err
       or entry1_vld
       or entry1_acc_err
       or entry2_inst[15:0]
       or entry5_inst[15:0]
       or entry4_acc_err
       or entry0_acc_err
       or entry5_acc_err
       or entry5_vld
       or entry4_inst[15:0]
       or entry0_vld
       or entry2_vld
       or entry1_inst[15:0]
       or entry3_vld
       or entry2_acc_err
       or entry4_vld
       or entry3_inst[15:0]
       or pop0[5:0]
       or entry0_inst[15:0])
begin
  case(pop0[ENTRY_NUM-1:0])
  6'b0001:
  begin
    pop0_vld          = entry0_vld;
    pop0_inst[15:0]   = entry0_inst[15:0];
    pop0_acc_err      = entry0_acc_err;
  end
  6'b0010:
  begin
    pop0_vld          = entry1_vld;
    pop0_inst[15:0]   = entry1_inst[15:0];
    pop0_acc_err      = entry1_acc_err;
  end
  6'b0100:
  begin
    pop0_vld          = entry2_vld;
    pop0_inst[15:0]   = entry2_inst[15:0];
    pop0_acc_err      = entry2_acc_err;
  end
  6'b1000:
  begin
    pop0_vld          = entry3_vld;
    pop0_inst[15:0]   = entry3_inst[15:0];
    pop0_acc_err      = entry3_acc_err;
  end
  6'b10000:
  begin
    pop0_vld          = entry4_vld;
    pop0_inst[15:0]   = entry4_inst[15:0];
    pop0_acc_err      = entry4_acc_err;
  end
  6'b100000:
  begin
    pop0_vld          = entry5_vld;
    pop0_inst[15:0]   = entry5_inst[15:0];
    pop0_acc_err      = entry5_acc_err;
  end
  default:
  begin
    pop0_vld          = 1'bx;
    pop0_inst[15:0]   = 16'bx;
    pop0_acc_err      = 1'bx;
  end
  endcase
// &CombEnd; @235
end

//The information which is index by pop1 pointer
// &CombBeg; @238
always @( entry3_acc_err
       or entry1_vld
       or entry1_acc_err
       or entry2_inst[15:0]
       or entry5_inst[15:0]
       or entry4_acc_err
       or entry0_acc_err
       or entry5_vld
       or entry5_acc_err
       or entry4_inst[15:0]
       or entry2_vld
       or entry0_vld
       or entry1_inst[15:0]
       or entry3_vld
       or entry4_vld
       or entry2_acc_err
       or entry3_inst[15:0]
       or pop1[5:0]
       or entry0_inst[15:0])
begin
  case(pop1[ENTRY_NUM-1:0])
  6'b0001:
  begin
    pop1_vld          = entry0_vld;
    pop1_inst[15:0]   = entry0_inst[15:0];
    pop1_acc_err      = entry0_acc_err;
  end
  6'b0010:
  begin
    pop1_vld          = entry1_vld;
    pop1_inst[15:0]   = entry1_inst[15:0];
    pop1_acc_err      = entry1_acc_err;
  end
  6'b0100:
  begin
    pop1_vld          = entry2_vld;
    pop1_inst[15:0]   = entry2_inst[15:0];
    pop1_acc_err      = entry2_acc_err;
  end
  6'b1000:
  begin
   pop1_vld          = entry3_vld;
   pop1_inst[15:0]   = entry3_inst[15:0];
   pop1_acc_err      = entry3_acc_err;
  end
  6'b10000:
  begin
   pop1_vld          = entry4_vld;
   pop1_inst[15:0]   = entry4_inst[15:0];
   pop1_acc_err      = entry4_acc_err;
  end
  6'b100000:
  begin
   pop1_vld          = entry5_vld;
   pop1_inst[15:0]   = entry5_inst[15:0];
   pop1_acc_err      = entry5_acc_err;
  end
  default:
  begin
    pop1_vld          = 1'bx;
    pop1_inst[15:0]   = 16'bx;
    pop1_acc_err      = 1'bx;
  end
  endcase
// &CombEnd; @283
end

// &CombBeg; @286
// &CombEnd; @309
// &CombBeg; @311
// &CombEnd; @334

////////////////////////////////////////////////////////////////////////////////
//                              Control Logic                                 //
////////////////////////////////////////////////////////////////////////////////
//==============================================================================
//                  Create Information into Prefetch Buffer
//==============================================================================
//the instruction created into inst buf may come from IBUS or HAD
//the create0 signal
assign align_fetch_bypass_32bit   = ibuf_empty && !ibusif_xx_16bit_inst;
assign unalign_fetch_bypass_16bit = ibusif_xx_unalign_fetch;

//either create 16 bit or 32 bit into inst buf, the create0 is always asserted
//when bypass happens, except whole word is bypassed or 16bit inst is bypassed
//in unalign mode, the create0 is enabled
//assign ibus_create0_en = ibusif_xx_trans_cmplt &&
//                         (!ifctrl_ibuf_bypass_vld ||
//                          !(align_fetch_bypass_32bit ||
//                            unalign_fetch_bypass_16bit
//                           )
//                         );
assign ibus_create0_en = ibusif_xx_trans_cmplt && !(ifctrl_ibuf_bypass_vld && 
                                                   (align_fetch_bypass_32bit 
                                               || unalign_fetch_bypass_16bit));
assign had_create0_en = iu_yy_xx_dbgon && had_ifu_ir_vld;

assign ibuf_create0_en = ibus_create0_en || had_create0_en;

//the create1 signal
//only create 32 bit into inst buf, the create1 signal will be asserted
assign ibus_create1_en = ibusif_xx_trans_cmplt &&
                         !ifctrl_ibuf_bypass_vld &&
                         !ibusif_xx_unalign_fetch;
// &Force("bus", "had_ifu_ir", 31, 0); @369
assign had_create1_en = had_create0_en && had_ifu_ir[1:0] == 2'b11;

assign ibuf_create1_en = ibus_create1_en || had_create1_en;

//==========================================================
//         Generate Entry Create Signal for Each Entry 
//==========================================================
//push0
always @(posedge ibuf_push_upd_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    push0[ENTRY_NUM-1:0] <= {{(ENTRY_NUM-1){1'b0}}, 1'b1};
  else if(iu_ifu_inst_fetch && iu_ifu_wb_stall)
    push0[ENTRY_NUM-1:0] <= pop0_shift[ENTRY_NUM-1:0];
  else if(ibuf_flush)
    push0[ENTRY_NUM-1:0] <= pop0[ENTRY_NUM-1:0];
  else if(ibuf_create0_en)
    push0[ENTRY_NUM-1:0] <= push0_shift[ENTRY_NUM-1:0];
end

// &CombBeg; @390
always @( push0[5:0]
       or ibuf_create1_en)
begin
  if(ibuf_create1_en)
    push0_shift[ENTRY_NUM-1:0] = {push0[ENTRY_NUM-3:0],
                                  push0[ENTRY_NUM-1:ENTRY_NUM-2]};
  else
    push0_shift[ENTRY_NUM-1:0] = {push0[ENTRY_NUM-2:0],
                                  push0[ENTRY_NUM-1]};
// &CombEnd; @397
end

//create0
assign {entry5_create0_en,
        entry4_create0_en,
        entry3_create0_en,
        entry2_create0_en,
        entry1_create0_en,
        entry0_create0_en} = push0[ENTRY_NUM-1:0] &
                             {ENTRY_NUM{ibuf_create0_en}};

//push1
assign push1[ENTRY_NUM-1:0] = {push0[ENTRY_NUM-2:0],
                               push0[ENTRY_NUM-1]};

//create1
assign {entry5_create1_en,
        entry4_create1_en,
        entry3_create1_en,
        entry2_create1_en,
        entry1_create1_en,
        entry0_create1_en} = push1[ENTRY_NUM-1:0] &
                             {ENTRY_NUM{ibuf_create1_en}};


//==============================================================================
//                  Retire Information out of Instruction Buffer
//==============================================================================
//The instruction will be retired in inst buf when it can be piped down
//to EX stage, when the instrcution is SPLIT inst, it will be retire when the 
//last sub-inst can be piped down.
assign ibuf_retire0_en = pop0_vld && ifctrl_ibuf_pop_en;

assign ibuf_retire1_en = ibuf_inst32 && ifctrl_ibuf_pop_en;

//==========================================================
//         Generate Entry retire Signal for Each Entry 
//==========================================================
assign ibuf_retire0_en_vld = ibuf_retire0_en;
assign ibuf_inst_32_vld = ibuf_inst32;

//pop0
always @(posedge ibuf_pop_upd_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pop0[ENTRY_NUM-1:0] <= {{(ENTRY_NUM-1){1'b0}}, 1'b1};
  else if(ibuf_flush)
    pop0[ENTRY_NUM-1:0] <= pop0[ENTRY_NUM-1:0];
  else if(ibuf_retire0_en_vld)
    pop0[ENTRY_NUM-1:0] <= pop0_shift[ENTRY_NUM-1:0];
end

// &CombBeg; @449
always @( pop0[5:0]
       or ibuf_inst_32_vld)
begin
  if(ibuf_inst_32_vld)
    pop0_shift[ENTRY_NUM-1:0] = {pop0[ENTRY_NUM-3:0],
                                 pop0[ENTRY_NUM-1:ENTRY_NUM-2]};
  else
    pop0_shift[ENTRY_NUM-1:0] = {pop0[ENTRY_NUM-2:0],
                                 pop0[ENTRY_NUM-1]};
// &CombEnd; @456
end

//retire0
assign {entry5_retire0_en,
        entry4_retire0_en,
        entry3_retire0_en,
        entry2_retire0_en,
        entry1_retire0_en,
        entry0_retire0_en} = pop0[ENTRY_NUM-1:0] & {ENTRY_NUM{ibuf_retire0_en}};

//pop1
assign pop1[ENTRY_NUM-1:0] = {pop0[ENTRY_NUM-2:0],
                              pop0[ENTRY_NUM-1]};

//retire1
assign {entry5_retire1_en,
        entry4_retire1_en,
        entry3_retire1_en,
        entry2_retire1_en,
        entry1_retire1_en,
        entry0_retire1_en} = pop1[ENTRY_NUM-1:0] &
                             {ENTRY_NUM{ibuf_retire1_en}};

//flush 4-5 entries when if change flow but iu stall
assign flush_4_entry_ptr[ENTRY_NUM-1:0] = ~(pop0[ENTRY_NUM-1:0] | pop1[ENTRY_NUM-1:0]);
assign flush_5_entry_ptr[ENTRY_NUM-1:0] = ~pop0[ENTRY_NUM-1:0];
assign ibuf_part_flush_ptr[ENTRY_NUM-1:0] = ibuf_inst32
                                             ? flush_4_entry_ptr[ENTRY_NUM-1:0]
                                             : flush_5_entry_ptr[ENTRY_NUM-1:0];
assign {entry5_part_flush,
        entry4_part_flush,
        entry3_part_flush,
        entry2_part_flush,
        entry1_part_flush,
        entry0_part_flush} = ibuf_part_flush_ptr[ENTRY_NUM-1:0] &
                             {ENTRY_NUM{iu_ifu_inst_fetch && iu_ifu_wb_stall}};

//==============================================================================
//              Some Control Signal
//==============================================================================
//The oldest instruction in ibuffer is a 32-bit inst
assign pop0_inst_32 = pop0_inst[1:0] == 2'b11;
assign ibuf_inst32 = pop0_vld && pop1_vld && pop0_inst_32;

//The oldest instruction in ibuffer is a 16-bit inst
assign ibuf_inst16 = pop0_vld && !pop0_inst_32;

//Thre inst buffer will be flushed when:
//1.flow change happens
//2.IU send the exception valid signal to IFU
assign ibuf_flush = ifctrl_xx_ifcancel;

//==========================================================
//              The inst buffer status signal
//==========================================================
assign ibuf_vld_num[2:0] = {2'b0, entry0_vld} + {2'b0, entry1_vld}
                         + {2'b0, entry2_vld} + {2'b0, entry3_vld}
                         + {2'b0, entry4_vld} + {2'b0, entry5_vld};

// only 1 entry avalable
assign ibuf_one_avalbe   = (ibuf_vld_num[2:0] == 3'b101); 
assign ibuf_full         = (ibuf_vld_num[2:0] == 3'b110); 
//assign ibuf_full = entry0_vld && entry1_vld && entry2_vld && entry3_vld; 
assign ibuf_no_inst_during_pipe_down = ifctrl_ibuf_inst_pipe_down && ibuf_no_inst && 1'b0;

// 2 entry avalable
assign ibuf_two_avalbe   = ibuf_vld_num[2:0] == 3'b100; 
assign ibuf_three_avalbe = ibuf_vld_num[2:0] == 3'b011;       
assign ibuf_four_avalbe  = ibuf_vld_num[2:0] == 3'b010;       
assign ibuf_five_avalbe  = ibuf_vld_num[2:0] == 3'b001;       

//ibuf full

//ibuf empty
//assign ibuf_empty = !(entry0_vld || entry1_vld || entry2_vld || entry3_vld);
assign ibuf_empty = ibuf_vld_num[2:0] == 3'b000;
//assign ibuf_empty = !pop0_vld;

assign ibuf_no_inst = !ibuf_inst32 && !ibuf_inst16;

assign ibuf_acc_err = (ibuf_inst32 && (pop0_acc_err || pop1_acc_err)) ||
                      (ibuf_inst16 && pop0_acc_err);

//==========================================================
//             The inst fetch request from ibuffer 
//==========================================================
//the inst fetch request is devided into 2 conditions:
//0.the buffer is empty
assign ibuf_fetch_empty = ibuf_empty;

// test 
// &CombBeg; @548
always @( entry1_vld
       or pop0_shift[5:0]
       or entry2_inst[15:0]
       or entry5_inst[15:0]
       or entry5_vld
       or entry4_inst[15:0]
       or entry0_vld
       or entry2_vld
       or entry1_inst[15:0]
       or entry3_vld
       or entry4_vld
       or entry3_inst[15:0]
       or entry0_inst[15:0])
begin
  case(pop0_shift[ENTRY_NUM-1:0])
  6'b0001:
  begin
    pop0_shift_vld          = entry0_vld;
    pop0_shift_inst[15:0]   = entry0_inst[15:0];
  end
  6'b0010:
  begin
    pop0_shift_vld          = entry1_vld;
    pop0_shift_inst[15:0]   = entry1_inst[15:0];
  end
  6'b0100:
  begin
    pop0_shift_vld          = entry2_vld;
    pop0_shift_inst[15:0]   = entry2_inst[15:0];
  end
  6'b1000:
  begin
    pop0_shift_vld          = entry3_vld;
    pop0_shift_inst[15:0]   = entry3_inst[15:0];
  end
  6'b10000:
  begin
    pop0_shift_vld          = entry4_vld;
    pop0_shift_inst[15:0]   = entry4_inst[15:0];
  end
  6'b100000:
  begin
    pop0_shift_vld          = entry5_vld;
    pop0_shift_inst[15:0]   = entry5_inst[15:0];
  end
  default:
  begin
    pop0_shift_vld          = 1'bx;
    pop0_shift_inst[15:0]   = 16'bx;
  end
  endcase
// &CombEnd; @586
end

assign pop1_shift[ENTRY_NUM-1:0] = {pop0_shift[ENTRY_NUM-2:0], pop0_shift[ENTRY_NUM-1]};
//The information which is index by pop1 pointer
// &CombBeg; @590
always @( entry1_vld
       or pop1_shift[5:0]
       or entry5_vld
       or entry0_vld
       or entry2_vld
       or entry3_vld
       or entry4_vld)
begin
  case(pop1_shift[ENTRY_NUM-1:0])
  6'b0001:
  begin
    pop1_shift_vld          = entry0_vld;
  end
  6'b0010:
  begin
    pop1_shift_vld          = entry1_vld;
  end
  6'b0100:
  begin
    pop1_shift_vld          = entry2_vld;
  end
  6'b1000:
  begin
   pop1_shift_vld          = entry3_vld;
  end
  6'b10000:
  begin
   pop1_shift_vld          = entry4_vld;
  end
  6'b100000:
  begin
   pop1_shift_vld          = entry5_vld;
  end
  default:
  begin
    pop1_shift_vld          = 1'bx;
  end
  endcase
// &CombEnd; @621
end

// &Force("input", "iu_ifu_lsu_inst"); @624
assign pop0_shift_mad_low = pop0_shift_vld && pop0_shift_inst[6:0] == 7'b0110011;
assign pop0_shift_sys_low = pop0_shift_vld && 
                           (pop0_shift_inst[6:0] == 7'b1110011
                         || pop0_shift_inst[6:0] == 7'b0001111  
                         || pop0_shift_inst[6:0] == 7'b0001011);
assign pop0_shift_lsu_inst = pop0_shift_vld && 
                            (pop0_shift_inst[6:0] == 7'b0100011
                          || pop0_shift_inst[6:0] == 7'b0000011
                          || {pop0_shift_inst[14:13],pop0_shift_inst[0]} == 3'b100);
assign ibuf_fetch_more_than_two = ibuf_two_avalbe && ibusif_ibuf_no_trans
                               || ibuf_two_avalbe && ibusif_xx_ibus_idle &&
                                 !iu_ifu_wb_ldst && !iu_ifu_ex_stall_noinput &&
                                 //!(iu_ifu_lsu_inst && ibuf_inst16)
                                 !(pop0_shift_lsu_inst && ibuf_inst16) &&
                                 !(pop0_shift_mad_low && ibuf_inst16) && //mad32
                                 !(pop0_shift_sys_low && ibuf_inst16) // mad32
                               || ibuf_three_avalbe && ibusif_ibuf_no_trans
                               || ibuf_three_avalbe && ibusif_xx_ibus_idle &&
                                 !ibuf_pop0_mad32_low &&
                                 !ibuf_pop0_sys32_low &&
                                 !(iu_ifu_lsu_inst && iu_ifu_ex_stall_noinput) &&
                                (!iu_ifu_wb_ldst && !iu_ifu_ex_stall_noinput
                                 );

//2.onlu 1 entry avalable
assign ibuf_fetch_one           = ibuf_one_avalbe && ibusif_ibuf_no_trans &&
                                (!iu_ifu_wb_ldst && !iu_ifu_ex_stall_noinput
                                   || !iu_ifu_ex_vld) 
                               || ibuf_one_avalbe && ibusif_xx_ibus_idle &&
                                  (ibuf_inst32 || pop0_shift_vld 
                                  && pop0_shift_inst[1:0] == 2'b11) &&
                                 !iu_ifu_lsu_inst &&
                                 !pop0_shift_sys_low && 
                                 !pop0_shift_lsu_inst &&
                                 !pop0_shift_mad_low && // mad32
                                (!iu_ifu_wb_ldst && !iu_ifu_ex_stall_noinput
                                 );

//3.ibuf is full
assign ibuf_fetch_full           = ibuf_full && ibusif_ibuf_no_trans &&
                                  (ibuf_inst32 || pop0_shift_vld 
                                  && pop0_shift_inst[1:0] == 2'b11) &&
                                 !iu_ifu_lsu_inst &&
                                 !pop0_shift_sys_low &&
                                 !pop0_shift_lsu_inst &&
                                 !pop0_shift_mad_low && // mad32
                                 !iu_ifu_wb_ldst && !iu_ifu_ex_stall_noinput;
// &Force("nonport", "pop0_shift_vld"); @673
// &Force("nonport", "pop0_shift_inst"); @674
// &Force("nonport", "ibuf_full"); @675
// &Force("input", "iu_ifu_ex_vld"); @676
// &Force("input", "iu_ifu_wb_ldst"); @677
assign ibuf_inst_fetch = ibuf_fetch_empty ||
                         ibuf_five_avalbe ||
                         ibuf_four_avalbe ||
                         ibuf_fetch_one ||
                         ibuf_fetch_full ||
                         ibuf_fetch_more_than_two;

//==========================================================
//                Predecode
//==========================================================
//when the pop0 inst is mls32 or mad32-high(when SLOW MULT)
//and pop1 not valid, bypass can not happen
assign ibuf_pop0_mad32_low = pop0_inst[6:2] == 5'b01100;
assign ibuf_pop0_sys32_low = pop0_inst[6:2] == 5'b11100;

////////////////////////////////////////////////////////////////////////////////
//                              Interface                                     //
////////////////////////////////////////////////////////////////////////////////
//==========================================================
//                Globle Signal
//==========================================================
//assign ibuf_xx_pop0_vld = pop0_shift_vld;
//assign ibuf_xx_pop1_vld = pop1_shift_vld;
assign ibuf_xx_empty = iu_ifu_ex_vld ? !pop0_shift_vld : ibuf_empty;
//assign ibuf_xx_pop0_vld = pop0_vld;
//assign ibuf_xx_pop1_vld = pop1_vld;

//==========================================================
//                  Interface to I-BUS Interface 
//==========================================================
assign ibuf_ibusif_inst_fetch = ibuf_inst_fetch;

//==========================================================
//                  Interface to If Stage Control Logic 
//==========================================================
assign ibuf_ifctrl_inst_vld   = pop0_shift_vld && pop1_shift_vld && pop0_shift_inst[1:0] == 2'b11
                             || pop0_shift_vld && pop0_shift_inst[1:0] != 2'b11;
assign ibuf_ifctrl_inst32_low = iu_ifu_ex_vld ? pop0_shift_vld && !pop1_shift_vld && pop0_shift_inst[1:0] == 2'b11 :
                                pop0_vld && !pop1_vld && !ibuf_inst16;
assign ibuf_ifctrl_pop0_mad32_low = ibuf_pop0_mad32_low;

//==========================================================
//               Interface to Ex Stage 
//==========================================================
assign ifu_iu_ex_inst[31:0] = {pop1_inst[15:0], pop0_inst[15:0]};
assign ifu_iu_ex_expt_vld = ibuf_acc_err;
assign ifu_iu_ex_expt_cur = pop0_acc_err;

assign ifu_had_fetch_expt_vld = ibuf_acc_err;
assign ibuf_ifdp_inst_dbg_disable = 1'b0;

// &ModuleEnd; @822
endmodule


