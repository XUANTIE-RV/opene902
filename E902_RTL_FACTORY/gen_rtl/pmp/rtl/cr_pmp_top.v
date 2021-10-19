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
module cr_pmp_top(
  cp0_pmp_csr_sel,
  cp0_pmp_csr_wen,
  cp0_pmp_mstatus_mpp,
  cp0_pmp_mstatus_mprv,
  cp0_pmp_updt_data,
  cp0_yy_clk_en,
  cp0_yy_machine_mode_aft_dbg,
  cpurst_b,
  forever_cpuclk,
  ifu_bmu_addr,
  ifu_bmu_prot,
  lsu_bmu_addr,
  lsu_bmu_write,
  pad_yy_gate_clk_en_b,
  pmp_bmu_dbus_acc_deny,
  pmp_bmu_ibus_acc_deny,
  pmp_cp0_data,
  pmp_ifu_acc_scu,
  pmp_lsu_acc_scu
);

// &Ports; @25
input   [11:0]  cp0_pmp_csr_sel;            
input           cp0_pmp_csr_wen;            
input   [1 :0]  cp0_pmp_mstatus_mpp;        
input           cp0_pmp_mstatus_mprv;       
input   [31:0]  cp0_pmp_updt_data;          
input           cp0_yy_clk_en;              
input           cp0_yy_machine_mode_aft_dbg; 
input           cpurst_b;                   
input           forever_cpuclk;             
input   [31:0]  ifu_bmu_addr;               
input   [3 :0]  ifu_bmu_prot;               
input   [31:0]  lsu_bmu_addr;               
input           lsu_bmu_write;              
input           pad_yy_gate_clk_en_b;       
output          pmp_bmu_dbus_acc_deny;      
output          pmp_bmu_ibus_acc_deny;      
output  [31:0]  pmp_cp0_data;               
output          pmp_ifu_acc_scu;            
output          pmp_lsu_acc_scu;            

// &Regs; @26

// &Wires; @27
wire    [11:0]  cp0_pmp_csr_sel;            
wire            cp0_pmp_csr_wen;            
wire    [1 :0]  cp0_pmp_mstatus_mpp;        
wire            cp0_pmp_mstatus_mprv;       
wire    [31:0]  cp0_pmp_updt_data;          
wire            cp0_yy_clk_en;              
wire            cp0_yy_machine_mode_aft_dbg; 
wire            cp0_yy_secu_mode_aft_dbg;   
wire            cpuclk;                     
wire            cpurst_b;                   
wire            forever_cpuclk;             
wire    [7 :0]  ifu_addr_ge_bottom;         
wire    [31:0]  ifu_bmu_addr;               
wire    [3 :0]  ifu_bmu_prot;               
wire    [7 :0]  lsu_addr_ge_bottom;         
wire    [31:0]  lsu_bmu_addr;               
wire            lsu_bmu_write;              
wire            pad_yy_gate_clk_en_b;       
wire            pmp_bmu_dbus_acc_deny;      
wire            pmp_bmu_ibus_acc_deny;      
wire    [31:0]  pmp_cp0_data;               
wire    [19:0]  pmp_csr_sel;                
wire    [19:0]  pmp_csr_wen;                
wire            pmp_ifu_acc_scu;            
wire    [7 :0]  pmp_ifu_hit;                
wire            pmp_lsu_acc_scu;            
wire    [7 :0]  pmp_lsu_hit;                
wire    [31:0]  pmpaddr0_value;             
wire    [31:0]  pmpaddr1_value;             
wire    [31:0]  pmpaddr2_value;             
wire    [31:0]  pmpaddr3_value;             
wire    [31:0]  pmpaddr4_value;             
wire    [31:0]  pmpaddr5_value;             
wire    [31:0]  pmpaddr6_value;             
wire    [31:0]  pmpaddr7_value;             
wire    [1 :0]  regs_comp_addr_mode0;       
wire    [1 :0]  regs_comp_addr_mode1;       
wire    [1 :0]  regs_comp_addr_mode2;       
wire    [1 :0]  regs_comp_addr_mode3;       
wire    [1 :0]  regs_comp_addr_mode4;       
wire    [1 :0]  regs_comp_addr_mode5;       
wire    [1 :0]  regs_comp_addr_mode6;       
wire    [1 :0]  regs_comp_addr_mode7;       
wire            regs_comp_excut0;           
wire            regs_comp_excut1;           
wire            regs_comp_excut2;           
wire            regs_comp_excut3;           
wire            regs_comp_excut4;           
wire            regs_comp_excut5;           
wire            regs_comp_excut6;           
wire            regs_comp_excut7;           
wire            regs_comp_lock0;            
wire            regs_comp_lock1;            
wire            regs_comp_lock2;            
wire            regs_comp_lock3;            
wire            regs_comp_lock4;            
wire            regs_comp_lock5;            
wire            regs_comp_lock6;            
wire            regs_comp_lock7;            
wire            regs_comp_read0;            
wire            regs_comp_read1;            
wire            regs_comp_read2;            
wire            regs_comp_read3;            
wire            regs_comp_read4;            
wire            regs_comp_read5;            
wire            regs_comp_read6;            
wire            regs_comp_read7;            
wire            regs_comp_write0;           
wire            regs_comp_write1;           
wire            regs_comp_write2;           
wire            regs_comp_write3;           
wire            regs_comp_write4;           
wire            regs_comp_write5;           
wire            regs_comp_write6;           
wire            regs_comp_write7;           
wire            wr_pmp_regs;                



parameter PMPCFG0   = 12'h3A0;
parameter PMPCFG1   = 12'h3A1;
parameter PMPCFG2   = 12'h3A2;
parameter PMPCFG3   = 12'h3A3;
parameter PMPADDR0  = 12'h3B0;
parameter PMPADDR1  = 12'h3B1;
parameter PMPADDR2  = 12'h3B2;
parameter PMPADDR3  = 12'h3B3;
parameter PMPADDR4  = 12'h3B4;
parameter PMPADDR5  = 12'h3B5;
parameter PMPADDR6  = 12'h3B6;
parameter PMPADDR7  = 12'h3B7;
parameter PMPADDR8  = 12'h3B8;
parameter PMPADDR9  = 12'h3B9;
parameter PMPADDR10 = 12'h3BA;
parameter PMPADDR11 = 12'h3BB;
parameter PMPADDR12 = 12'h3BC;
parameter PMPADDR13 = 12'h3BD;
parameter PMPADDR14 = 12'h3BE;
parameter PMPADDR15 = 12'h3BF;
parameter PMPTEECFG = 12'hBEF;

assign pmp_csr_sel[0]  = cp0_pmp_csr_sel[11:0] == PMPCFG0; 
assign pmp_csr_sel[1]  = cp0_pmp_csr_sel[11:0] == PMPCFG1; 
assign pmp_csr_sel[2]  = cp0_pmp_csr_sel[11:0] == PMPCFG2; 
assign pmp_csr_sel[3]  = cp0_pmp_csr_sel[11:0] == PMPCFG3; 
assign pmp_csr_sel[4]  = cp0_pmp_csr_sel[11:0] == PMPADDR0; 
assign pmp_csr_sel[5]  = cp0_pmp_csr_sel[11:0] == PMPADDR1; 
assign pmp_csr_sel[6]  = cp0_pmp_csr_sel[11:0] == PMPADDR2; 
assign pmp_csr_sel[7]  = cp0_pmp_csr_sel[11:0] == PMPADDR3; 
assign pmp_csr_sel[8]  = cp0_pmp_csr_sel[11:0] == PMPADDR4; 
assign pmp_csr_sel[9]  = cp0_pmp_csr_sel[11:0] == PMPADDR5; 
assign pmp_csr_sel[10] = cp0_pmp_csr_sel[11:0] == PMPADDR6; 
assign pmp_csr_sel[11] = cp0_pmp_csr_sel[11:0] == PMPADDR7; 
assign pmp_csr_sel[12] = cp0_pmp_csr_sel[11:0] == PMPADDR8; 
assign pmp_csr_sel[13] = cp0_pmp_csr_sel[11:0] == PMPADDR9; 
assign pmp_csr_sel[14] = cp0_pmp_csr_sel[11:0] == PMPADDR10; 
assign pmp_csr_sel[15] = cp0_pmp_csr_sel[11:0] == PMPADDR11; 
assign pmp_csr_sel[16] = cp0_pmp_csr_sel[11:0] == PMPADDR12; 
assign pmp_csr_sel[17] = cp0_pmp_csr_sel[11:0] == PMPADDR13; 
assign pmp_csr_sel[18] = cp0_pmp_csr_sel[11:0] == PMPADDR14; 
assign pmp_csr_sel[19] = cp0_pmp_csr_sel[11:0] == PMPADDR15;

assign pmp_csr_wen[19:0] = pmp_csr_sel[19:0] & {20{cp0_pmp_csr_wen}};

assign cp0_yy_secu_mode_aft_dbg = 1'b0;

assign wr_pmp_regs = |pmp_csr_wen[19:0];
// &Instance("gated_clk_cell", "x_pmp_gated_clk"); @91
gated_clk_cell  x_pmp_gated_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (cpuclk              ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (1'b0                ),
  .module_en            (wr_pmp_regs         ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect( @92
//          .clk_in      (forever_cpuclk), @93
//          .global_en   (cp0_yy_clk_en ), @94
//          .module_en   (wr_pmp_regs   ), @95
//          .local_en    (1'b0          ), @96
//          .external_en (1'b0          ), @97
//          .clk_out     (cpuclk        ), @98
//         ); @99

// &Instance("cr_pmp_enc"); @101
cr_pmp_enc  x_cr_pmp_enc (
  .cp0_pmp_mstatus_mpp         (cp0_pmp_mstatus_mpp        ),
  .cp0_pmp_mstatus_mprv        (cp0_pmp_mstatus_mprv       ),
  .cp0_yy_machine_mode_aft_dbg (cp0_yy_machine_mode_aft_dbg),
  .ifu_bmu_prot                (ifu_bmu_prot               ),
  .lsu_bmu_write               (lsu_bmu_write              ),
  .pmp_bmu_dbus_acc_deny       (pmp_bmu_dbus_acc_deny      ),
  .pmp_bmu_ibus_acc_deny       (pmp_bmu_ibus_acc_deny      ),
  .pmp_ifu_acc_scu             (pmp_ifu_acc_scu            ),
  .pmp_ifu_hit                 (pmp_ifu_hit                ),
  .pmp_lsu_acc_scu             (pmp_lsu_acc_scu            ),
  .pmp_lsu_hit                 (pmp_lsu_hit                ),
  .regs_comp_excut0            (regs_comp_excut0           ),
  .regs_comp_excut1            (regs_comp_excut1           ),
  .regs_comp_excut2            (regs_comp_excut2           ),
  .regs_comp_excut3            (regs_comp_excut3           ),
  .regs_comp_excut4            (regs_comp_excut4           ),
  .regs_comp_excut5            (regs_comp_excut5           ),
  .regs_comp_excut6            (regs_comp_excut6           ),
  .regs_comp_excut7            (regs_comp_excut7           ),
  .regs_comp_lock0             (regs_comp_lock0            ),
  .regs_comp_lock1             (regs_comp_lock1            ),
  .regs_comp_lock2             (regs_comp_lock2            ),
  .regs_comp_lock3             (regs_comp_lock3            ),
  .regs_comp_lock4             (regs_comp_lock4            ),
  .regs_comp_lock5             (regs_comp_lock5            ),
  .regs_comp_lock6             (regs_comp_lock6            ),
  .regs_comp_lock7             (regs_comp_lock7            ),
  .regs_comp_read0             (regs_comp_read0            ),
  .regs_comp_read1             (regs_comp_read1            ),
  .regs_comp_read2             (regs_comp_read2            ),
  .regs_comp_read3             (regs_comp_read3            ),
  .regs_comp_read4             (regs_comp_read4            ),
  .regs_comp_read5             (regs_comp_read5            ),
  .regs_comp_read6             (regs_comp_read6            ),
  .regs_comp_read7             (regs_comp_read7            ),
  .regs_comp_write0            (regs_comp_write0           ),
  .regs_comp_write1            (regs_comp_write1           ),
  .regs_comp_write2            (regs_comp_write2           ),
  .regs_comp_write3            (regs_comp_write3           ),
  .regs_comp_write4            (regs_comp_write4           ),
  .regs_comp_write5            (regs_comp_write5           ),
  .regs_comp_write6            (regs_comp_write6           ),
  .regs_comp_write7            (regs_comp_write7           )
);

// &Instance("cr_pmp_regs"); @102
cr_pmp_regs  x_cr_pmp_regs (
  .cp0_pmp_updt_data        (cp0_pmp_updt_data       ),
  .cp0_yy_secu_mode_aft_dbg (cp0_yy_secu_mode_aft_dbg),
  .cpuclk                   (cpuclk                  ),
  .cpurst_b                 (cpurst_b                ),
  .pmp_cp0_data             (pmp_cp0_data            ),
  .pmp_csr_sel              (pmp_csr_sel             ),
  .pmp_csr_wen              (pmp_csr_wen             ),
  .pmpaddr0_value           (pmpaddr0_value          ),
  .pmpaddr1_value           (pmpaddr1_value          ),
  .pmpaddr2_value           (pmpaddr2_value          ),
  .pmpaddr3_value           (pmpaddr3_value          ),
  .pmpaddr4_value           (pmpaddr4_value          ),
  .pmpaddr5_value           (pmpaddr5_value          ),
  .pmpaddr6_value           (pmpaddr6_value          ),
  .pmpaddr7_value           (pmpaddr7_value          ),
  .regs_comp_addr_mode0     (regs_comp_addr_mode0    ),
  .regs_comp_addr_mode1     (regs_comp_addr_mode1    ),
  .regs_comp_addr_mode2     (regs_comp_addr_mode2    ),
  .regs_comp_addr_mode3     (regs_comp_addr_mode3    ),
  .regs_comp_addr_mode4     (regs_comp_addr_mode4    ),
  .regs_comp_addr_mode5     (regs_comp_addr_mode5    ),
  .regs_comp_addr_mode6     (regs_comp_addr_mode6    ),
  .regs_comp_addr_mode7     (regs_comp_addr_mode7    ),
  .regs_comp_excut0         (regs_comp_excut0        ),
  .regs_comp_excut1         (regs_comp_excut1        ),
  .regs_comp_excut2         (regs_comp_excut2        ),
  .regs_comp_excut3         (regs_comp_excut3        ),
  .regs_comp_excut4         (regs_comp_excut4        ),
  .regs_comp_excut5         (regs_comp_excut5        ),
  .regs_comp_excut6         (regs_comp_excut6        ),
  .regs_comp_excut7         (regs_comp_excut7        ),
  .regs_comp_lock0          (regs_comp_lock0         ),
  .regs_comp_lock1          (regs_comp_lock1         ),
  .regs_comp_lock2          (regs_comp_lock2         ),
  .regs_comp_lock3          (regs_comp_lock3         ),
  .regs_comp_lock4          (regs_comp_lock4         ),
  .regs_comp_lock5          (regs_comp_lock5         ),
  .regs_comp_lock6          (regs_comp_lock6         ),
  .regs_comp_lock7          (regs_comp_lock7         ),
  .regs_comp_read0          (regs_comp_read0         ),
  .regs_comp_read1          (regs_comp_read1         ),
  .regs_comp_read2          (regs_comp_read2         ),
  .regs_comp_read3          (regs_comp_read3         ),
  .regs_comp_read4          (regs_comp_read4         ),
  .regs_comp_read5          (regs_comp_read5         ),
  .regs_comp_read6          (regs_comp_read6         ),
  .regs_comp_read7          (regs_comp_read7         ),
  .regs_comp_write0         (regs_comp_write0        ),
  .regs_comp_write1         (regs_comp_write1        ),
  .regs_comp_write2         (regs_comp_write2        ),
  .regs_comp_write3         (regs_comp_write3        ),
  .regs_comp_write4         (regs_comp_write4        ),
  .regs_comp_write5         (regs_comp_write5        ),
  .regs_comp_write6         (regs_comp_write6        ),
  .regs_comp_write7         (regs_comp_write7        )
);


// &Force("bus","ifu_bmu_addr",31,0); @104
// &Force("bus","lsu_bmu_addr",31,0); @105

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_0"); @108
cr_pmp_comp_hit  x_cr_pmp_comp_hit_0 (
  .addr_match_mode           (regs_comp_addr_mode0[1:0]),
  .ifu_acc_addr              (ifu_bmu_addr[31:0]       ),
  .ifu_addr_ge_bottom        (1'b1                     ),
  .ifu_addr_ge_pmpaddr       (ifu_addr_ge_bottom[0]    ),
  .lsu_acc_addr              (lsu_bmu_addr[31:0]       ),
  .lsu_addr_ge_bottom        (1'b1                     ),
  .lsu_addr_ge_pmpaddr       (lsu_addr_ge_bottom[0]    ),
  .pmp_ifu_hit               (pmp_ifu_hit[0]           ),
  .pmp_lsu_hit               (pmp_lsu_hit[0]           ),
  .pmpaddr                   (pmpaddr0_value[31:0]     )
);

// &Connect(.addr_match_mode     (regs_comp_addr_mode0[1:0]), @109
//          .pmpaddr             (pmpaddr0_value[31:0]     ), @110
//          .ifu_addr_ge_bottom  (1'b1                     ), @111
//          .lsu_addr_ge_bottom  (1'b1                     ), @112
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]       ), @113
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]       ),  @114
//          .pmp_ifu_hit         (pmp_ifu_hit[0]           ), @115
//          .pmp_lsu_hit         (pmp_lsu_hit[0]           ), @116
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[0]    ), @117
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[0]    ) @118
//         ); @119

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_1"); @123
cr_pmp_comp_hit  x_cr_pmp_comp_hit_1 (
  .addr_match_mode           (regs_comp_addr_mode1[1:0]),
  .ifu_acc_addr              (ifu_bmu_addr[31:0]       ),
  .ifu_addr_ge_bottom        (ifu_addr_ge_bottom[0]    ),
  .ifu_addr_ge_pmpaddr       (ifu_addr_ge_bottom[1]    ),
  .lsu_acc_addr              (lsu_bmu_addr[31:0]       ),
  .lsu_addr_ge_bottom        (lsu_addr_ge_bottom[0]    ),
  .lsu_addr_ge_pmpaddr       (lsu_addr_ge_bottom[1]    ),
  .pmp_ifu_hit               (pmp_ifu_hit[1]           ),
  .pmp_lsu_hit               (pmp_lsu_hit[1]           ),
  .pmpaddr                   (pmpaddr1_value[31:0]     )
);

// &Connect(.addr_match_mode     (regs_comp_addr_mode1[1:0]), @124
//          .pmpaddr             (pmpaddr1_value[31:0]     ), @125
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[0]    ), @126
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[0]    ), @127
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]       ), @128
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]       ),  @129
//          .pmp_ifu_hit         (pmp_ifu_hit[1]           ), @130
//          .pmp_lsu_hit         (pmp_lsu_hit[1]           ), @131
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[1]    ), @132
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[1]    ) @133
//         ); @134

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_2"); @138
cr_pmp_comp_hit  x_cr_pmp_comp_hit_2 (
  .addr_match_mode           (regs_comp_addr_mode2[1:0]),
  .ifu_acc_addr              (ifu_bmu_addr[31:0]       ),
  .ifu_addr_ge_bottom        (ifu_addr_ge_bottom[1]    ),
  .ifu_addr_ge_pmpaddr       (ifu_addr_ge_bottom[2]    ),
  .lsu_acc_addr              (lsu_bmu_addr[31:0]       ),
  .lsu_addr_ge_bottom        (lsu_addr_ge_bottom[1]    ),
  .lsu_addr_ge_pmpaddr       (lsu_addr_ge_bottom[2]    ),
  .pmp_ifu_hit               (pmp_ifu_hit[2]           ),
  .pmp_lsu_hit               (pmp_lsu_hit[2]           ),
  .pmpaddr                   (pmpaddr2_value[31:0]     )
);

// &Connect(.addr_match_mode     (regs_comp_addr_mode2[1:0]), @139
//          .pmpaddr             (pmpaddr2_value[31:0]     ), @140
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[1]    ), @141
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[1]    ), @142
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]       ), @143
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]       ),  @144
//          .pmp_ifu_hit         (pmp_ifu_hit[2]           ), @145
//          .pmp_lsu_hit         (pmp_lsu_hit[2]           ), @146
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[2]    ), @147
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[2]    ) @148
//         ); @149

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_3"); @153
cr_pmp_comp_hit  x_cr_pmp_comp_hit_3 (
  .addr_match_mode           (regs_comp_addr_mode3[1:0]),
  .ifu_acc_addr              (ifu_bmu_addr[31:0]       ),
  .ifu_addr_ge_bottom        (ifu_addr_ge_bottom[2]    ),
  .ifu_addr_ge_pmpaddr       (ifu_addr_ge_bottom[3]    ),
  .lsu_acc_addr              (lsu_bmu_addr[31:0]       ),
  .lsu_addr_ge_bottom        (lsu_addr_ge_bottom[2]    ),
  .lsu_addr_ge_pmpaddr       (lsu_addr_ge_bottom[3]    ),
  .pmp_ifu_hit               (pmp_ifu_hit[3]           ),
  .pmp_lsu_hit               (pmp_lsu_hit[3]           ),
  .pmpaddr                   (pmpaddr3_value[31:0]     )
);

// &Connect(.addr_match_mode     (regs_comp_addr_mode3[1:0]), @154
//          .pmpaddr             (pmpaddr3_value[31:0]     ), @155
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[2]    ), @156
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[2]    ), @157
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]       ), @158
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]       ),  @159
//          .pmp_ifu_hit         (pmp_ifu_hit[3]           ), @160
//          .pmp_lsu_hit         (pmp_lsu_hit[3]           ), @161
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[3]    ), @162
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[3]    ) @163
//         ); @164

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_4"); @168
cr_pmp_comp_hit  x_cr_pmp_comp_hit_4 (
  .addr_match_mode           (regs_comp_addr_mode4[1:0]),
  .ifu_acc_addr              (ifu_bmu_addr[31:0]       ),
  .ifu_addr_ge_bottom        (ifu_addr_ge_bottom[3]    ),
  .ifu_addr_ge_pmpaddr       (ifu_addr_ge_bottom[4]    ),
  .lsu_acc_addr              (lsu_bmu_addr[31:0]       ),
  .lsu_addr_ge_bottom        (lsu_addr_ge_bottom[3]    ),
  .lsu_addr_ge_pmpaddr       (lsu_addr_ge_bottom[4]    ),
  .pmp_ifu_hit               (pmp_ifu_hit[4]           ),
  .pmp_lsu_hit               (pmp_lsu_hit[4]           ),
  .pmpaddr                   (pmpaddr4_value[31:0]     )
);

// &Connect(.addr_match_mode     (regs_comp_addr_mode4[1:0]), @169
//          .pmpaddr             (pmpaddr4_value[31:0]     ), @170
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[3]    ), @171
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[3]    ), @172
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]       ), @173
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]       ),  @174
//          .pmp_ifu_hit         (pmp_ifu_hit[4]           ), @175
//          .pmp_lsu_hit         (pmp_lsu_hit[4]           ), @176
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[4]    ), @177
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[4]    ) @178
//         ); @179

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_5"); @183
cr_pmp_comp_hit  x_cr_pmp_comp_hit_5 (
  .addr_match_mode           (regs_comp_addr_mode5[1:0]),
  .ifu_acc_addr              (ifu_bmu_addr[31:0]       ),
  .ifu_addr_ge_bottom        (ifu_addr_ge_bottom[4]    ),
  .ifu_addr_ge_pmpaddr       (ifu_addr_ge_bottom[5]    ),
  .lsu_acc_addr              (lsu_bmu_addr[31:0]       ),
  .lsu_addr_ge_bottom        (lsu_addr_ge_bottom[4]    ),
  .lsu_addr_ge_pmpaddr       (lsu_addr_ge_bottom[5]    ),
  .pmp_ifu_hit               (pmp_ifu_hit[5]           ),
  .pmp_lsu_hit               (pmp_lsu_hit[5]           ),
  .pmpaddr                   (pmpaddr5_value[31:0]     )
);

// &Connect(.addr_match_mode     (regs_comp_addr_mode5[1:0]), @184
//          .pmpaddr             (pmpaddr5_value[31:0]     ), @185
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[4]    ), @186
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[4]    ), @187
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]       ), @188
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]       ),  @189
//          .pmp_ifu_hit         (pmp_ifu_hit[5]           ), @190
//          .pmp_lsu_hit         (pmp_lsu_hit[5]           ), @191
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[5]    ), @192
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[5]    ) @193
//         ); @194

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_6"); @198
cr_pmp_comp_hit  x_cr_pmp_comp_hit_6 (
  .addr_match_mode           (regs_comp_addr_mode6[1:0]),
  .ifu_acc_addr              (ifu_bmu_addr[31:0]       ),
  .ifu_addr_ge_bottom        (ifu_addr_ge_bottom[5]    ),
  .ifu_addr_ge_pmpaddr       (ifu_addr_ge_bottom[6]    ),
  .lsu_acc_addr              (lsu_bmu_addr[31:0]       ),
  .lsu_addr_ge_bottom        (lsu_addr_ge_bottom[5]    ),
  .lsu_addr_ge_pmpaddr       (lsu_addr_ge_bottom[6]    ),
  .pmp_ifu_hit               (pmp_ifu_hit[6]           ),
  .pmp_lsu_hit               (pmp_lsu_hit[6]           ),
  .pmpaddr                   (pmpaddr6_value[31:0]     )
);

// &Connect(.addr_match_mode     (regs_comp_addr_mode6[1:0]), @199
//          .pmpaddr             (pmpaddr6_value[31:0]     ), @200
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[5]    ), @201
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[5]    ), @202
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]       ), @203
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]       ),  @204
//          .pmp_ifu_hit         (pmp_ifu_hit[6]           ), @205
//          .pmp_lsu_hit         (pmp_lsu_hit[6]           ), @206
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[6]    ), @207
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[6]    ) @208
//         ); @209

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_7"); @213
cr_pmp_comp_hit  x_cr_pmp_comp_hit_7 (
  .addr_match_mode           (regs_comp_addr_mode7[1:0]),
  .ifu_acc_addr              (ifu_bmu_addr[31:0]       ),
  .ifu_addr_ge_bottom        (ifu_addr_ge_bottom[6]    ),
  .ifu_addr_ge_pmpaddr       (ifu_addr_ge_bottom[7]    ),
  .lsu_acc_addr              (lsu_bmu_addr[31:0]       ),
  .lsu_addr_ge_bottom        (lsu_addr_ge_bottom[6]    ),
  .lsu_addr_ge_pmpaddr       (lsu_addr_ge_bottom[7]    ),
  .pmp_ifu_hit               (pmp_ifu_hit[7]           ),
  .pmp_lsu_hit               (pmp_lsu_hit[7]           ),
  .pmpaddr                   (pmpaddr7_value[31:0]     )
);

// &Connect(.addr_match_mode     (regs_comp_addr_mode7[1:0]), @214
//          .pmpaddr             (pmpaddr7_value[31:0]     ), @215
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[6]    ), @216
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[6]    ), @217
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]       ), @218
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]       ),  @219
//          .pmp_ifu_hit         (pmp_ifu_hit[7]           ), @220
//          .pmp_lsu_hit         (pmp_lsu_hit[7]           ), @221
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[7]    ), @222
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[7]    ) @223
//         ); @224

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_8"); @228
// &Connect(.addr_match_mode     (regs_comp_addr_mode8[1:0]), @229
//          .pmpaddr             (pmpaddr8_value[31:0]     ), @230
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[7]    ), @231
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[7]    ), @232
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]       ), @233
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]       ),  @234
//          .pmp_ifu_hit         (pmp_ifu_hit[8]           ), @235
//          .pmp_lsu_hit         (pmp_lsu_hit[8]           ), @236
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[8]    ), @237
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[8]    ) @238
//         ); @239

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_9"); @243
// &Connect(.addr_match_mode     (regs_comp_addr_mode9[1:0]), @244
//          .pmpaddr             (pmpaddr9_value[31:0]     ), @245
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[8]    ), @246
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[8]    ), @247
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]       ), @248
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]       ),  @249
//          .pmp_ifu_hit         (pmp_ifu_hit[9]           ), @250
//          .pmp_lsu_hit         (pmp_lsu_hit[9]           ), @251
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[9]    ), @252
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[9]    ) @253
//         ); @254

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_10"); @258
// &Connect(.addr_match_mode     (regs_comp_addr_mode10[1:0]), @259
//          .pmpaddr             (pmpaddr10_value[31:0]     ), @260
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[9]     ), @261
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[9]     ), @262
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]        ), @263
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]        ),  @264
//          .pmp_ifu_hit         (pmp_ifu_hit[10]           ), @265
//          .pmp_lsu_hit         (pmp_lsu_hit[10]           ), @266
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[10]    ), @267
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[10]    ) @268
//         ); @269

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_11"); @273
// &Connect(.addr_match_mode     (regs_comp_addr_mode11[1:0]), @274
//          .pmpaddr             (pmpaddr11_value[31:0]     ), @275
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[10]    ), @276
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[10]    ), @277
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]        ), @278
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]        ),  @279
//          .pmp_ifu_hit         (pmp_ifu_hit[11]           ), @280
//          .pmp_lsu_hit         (pmp_lsu_hit[11]           ), @281
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[11]    ), @282
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[11]    ) @283
//         ); @284

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_12"); @288
// &Connect(.addr_match_mode     (regs_comp_addr_mode12[1:0]), @289
//          .pmpaddr             (pmpaddr12_value[31:0]     ), @290
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[11]    ), @291
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[11]    ), @292
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]        ), @293
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]        ),  @294
//          .pmp_ifu_hit         (pmp_ifu_hit[12]           ), @295
//          .pmp_lsu_hit         (pmp_lsu_hit[12]           ), @296
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[12]    ), @297
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[12]    ) @298
//         ); @299

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_13"); @303
// &Connect(.addr_match_mode     (regs_comp_addr_mode13[1:0]), @304
//          .pmpaddr             (pmpaddr13_value[31:0]     ), @305
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[12]    ), @306
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[12]    ), @307
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]        ), @308
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]        ),  @309
//          .pmp_ifu_hit         (pmp_ifu_hit[13]           ), @310
//          .pmp_lsu_hit         (pmp_lsu_hit[13]           ), @311
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[13]    ), @312
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[13]    ) @313
//         ); @314

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_14"); @318
// &Connect(.addr_match_mode     (regs_comp_addr_mode14[1:0]), @319
//          .pmpaddr             (pmpaddr14_value[31:0]     ), @320
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[13]    ), @321
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[13]    ), @322
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]        ), @323
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]        ),  @324
//          .pmp_ifu_hit         (pmp_ifu_hit[14]           ), @325
//          .pmp_lsu_hit         (pmp_lsu_hit[14]           ), @326
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[14]    ), @327
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[14]    ) @328
//         ); @329

// &Instance("cr_pmp_comp_hit", "x_cr_pmp_comp_hit_15"); @333
// &Connect(.addr_match_mode     (regs_comp_addr_mode15[1:0]), @334
//          .pmpaddr             (pmpaddr15_value[31:0]     ), @335
//          .ifu_addr_ge_bottom  (ifu_addr_ge_bottom[14]    ), @336
//          .lsu_addr_ge_bottom  (lsu_addr_ge_bottom[14]    ), @337
//          .ifu_acc_addr        (ifu_bmu_addr[31:0]        ), @338
//          .lsu_acc_addr        (lsu_bmu_addr[31:0]        ),  @339
//          .pmp_ifu_hit         (pmp_ifu_hit[15]           ), @340
//          .pmp_lsu_hit         (pmp_lsu_hit[15]           ), @341
//          .ifu_addr_ge_pmpaddr (ifu_addr_ge_bottom[15]    ), @342
//          .lsu_addr_ge_pmpaddr (lsu_addr_ge_bottom[15]    ) @343
//         ); @344



// &ModuleEnd; @349
endmodule



