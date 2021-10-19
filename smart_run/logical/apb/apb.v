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
module apb(
  b_pad_gpio_porta,
  biu_pad_lpmd_b,
  clk_en,
  corec_pmu_sleep_out,
  cpu_clk,
  fifo_pad_haddr,
  fifo_pad_hprot,
  haddr_s2,
  hrdata_s2,
  hready_s2,
  hresp_s2,
  hsel_s2,
  hwdata_s2,
  hwrite_s2,
  i_pad_cpu_jtg_rst_b,
  i_pad_jtg_tclk,
  nmi_req,
  pad_clk,
  pad_cpu_rst_b,
  pad_had_jtg_tap_en,
  pad_had_jtg_tms_i,
  pad_had_jtg_trst_b,
  pad_had_jtg_trst_b_pre,
  pad_vic_int_vld,
  per_clk,
  pg_reset_b,
  pmu_corec_isolation,
  pmu_corec_sleep_in,
  smpu_deny,
  sys_rst,
  uart0_sin,
  uart0_sout,
  wakeup_req
);

// &Ports; @21
input   [1 :0]  biu_pad_lpmd_b;        
input           corec_pmu_sleep_out;   
input   [31:0]  fifo_pad_haddr;        
input   [3 :0]  fifo_pad_hprot;        
input   [31:0]  haddr_s2;              
input           hsel_s2;               
input   [31:0]  hwdata_s2;             
input           hwrite_s2;             
input           i_pad_cpu_jtg_rst_b;   
input           i_pad_jtg_tclk;        
input           pad_clk;               
input           pad_cpu_rst_b;         
input           pad_had_jtg_tap_en;    
input           pad_had_jtg_tms_i;     
input           pad_had_jtg_trst_b_pre; 
input           sys_rst;               
input           uart0_sin;             
output          clk_en;                
output          cpu_clk;               
output  [31:0]  hrdata_s2;             
output          hready_s2;             
output  [1 :0]  hresp_s2;              
output          nmi_req;               
output          pad_had_jtg_trst_b;    
output  [31:0]  pad_vic_int_vld;       
output          per_clk;               
output          pg_reset_b;            
output          pmu_corec_isolation;   
output          pmu_corec_sleep_in;    
output          smpu_deny;             
output          uart0_sout;            
output          wakeup_req;            
inout   [7 :0]  b_pad_gpio_porta;      

// &Regs; @22

// &Wires; @23
wire            apb_clkgen_psel;       
wire            apb_gpio_psel;         
wire            apb_nmi_wake_psel;     
wire            apb_pmu_psel;          
wire            apb_smpu_psel;         
wire            apb_stim_psel;         
wire            apb_tim_psel;          
wire            apb_uart_psel;         
wire    [31:0]  apb_xx_paddr;          
wire            apb_xx_penable;        
wire    [31:0]  apb_xx_pwdata;         
wire            apb_xx_pwrite;         
wire    [7 :0]  b_pad_gpio_porta;      
wire    [1 :0]  biu_pad_lpmd_b;        
wire            clk_div_1;             
wire            clk_div_2;             
wire            clk_div_3;             
wire            clk_div_4;             
wire            clk_div_5;             
wire            clk_div_6;             
wire            clk_div_7;             
wire            clk_div_8;             
wire            clk_en;                
wire            clk_en_1;              
wire            clk_en_2;              
wire            clk_en_3;              
wire            clk_en_4;              
wire            clk_en_5;              
wire            clk_en_6;              
wire            clk_en_7;              
wire            clk_en_8;              
wire    [31:0]  clkgen_apb_prdata;     
wire            corec_pmu_sleep_out;   
wire            cpu_clk;               
wire    [31:0]  fifo_pad_haddr;        
wire    [3 :0]  fifo_pad_hprot;        
wire            gate_en0;              
wire            gate_en1;              
wire    [31:0]  gpio_apb_prdata;       
wire    [7 :0]  gpio_vic_int;          
wire    [31:0]  haddr_s2;              
wire    [31:0]  hrdata_s2;             
wire            hready_s2;             
wire    [1 :0]  hresp_s2;              
wire            hsel_s2;               
wire    [31:0]  hwdata_s2;             
wire            hwrite_s2;             
wire            i_pad_cpu_jtg_rst_b;   
wire            i_pad_jtg_tclk;        
wire            intraw_vld;            
wire            nmi_req;               
wire    [31:0]  nmi_wake_apb_prdata;   
wire    [3 :0]  nmi_wake_int;          
wire            pad_clk;               
wire            pad_cpu_rst_b;         
wire            pad_had_jtg_tap_en;    
wire            pad_had_jtg_tms_i;     
wire            pad_had_jtg_trst_b;    
wire            pad_had_jtg_trst_b_pre; 
wire    [31:0]  pad_vic_int_vld;       
wire            per_clk;               
wire            pg_reset_b;            
wire    [31:0]  pmu_apb_prdata;        
wire            pmu_clk;               
wire            pmu_corec_isolation;   
wire            pmu_corec_sleep_in;    
wire    [31:0]  smpu_apb_prdata;       
wire            smpu_deny;             
wire    [31:0]  stim_apb_prdata;       
wire    [3 :0]  stim_vic_int;          
wire            sys_rst;               
wire    [31:0]  tim_apb_prdata;        
wire    [3 :0]  tim_vic_int;           
wire            uart0_sin;             
wire            uart0_sout;            
wire            uart0_vic_int;         
wire    [31:0]  uart_apb_prdata;       
wire            wakeup_req;            
wire            wic_clk;               



// &Instance("apb_bridge", "x_apb_bridge"); @26
apb_bridge  x_apb_bridge (
  .apb_harb_hrdata     (hrdata_s2          ),
  .apb_harb_hready     (hready_s2          ),
  .apb_harb_hresp      (hresp_s2           ),
  .apb_xx_paddr        (apb_xx_paddr       ),
  .apb_xx_penable      (apb_xx_penable     ),
  .apb_xx_pwdata       (apb_xx_pwdata      ),
  .apb_xx_pwrite       (apb_xx_pwrite      ),
  .harb_apb_hsel       (hsel_s2            ),
  .harb_xx_haddr       (haddr_s2           ),
  .harb_xx_hwdata      (hwdata_s2          ),
  .harb_xx_hwrite      (hwrite_s2          ),
  .hclk                (per_clk            ),
  .hrst_b              (pg_reset_b         ),
  .prdata_s1           (uart_apb_prdata    ),
  .prdata_s2           (tim_apb_prdata     ),
  .prdata_s3           (pmu_apb_prdata     ),
  .prdata_s4           (gpio_apb_prdata    ),
  .prdata_s5           (stim_apb_prdata    ),
  .prdata_s6           (clkgen_apb_prdata  ),
  .prdata_s7           (smpu_apb_prdata    ),
  .prdata_s8           (nmi_wake_apb_prdata),
  .psel_s1             (apb_uart_psel      ),
  .psel_s2             (apb_tim_psel       ),
  .psel_s3             (apb_pmu_psel       ),
  .psel_s4             (apb_gpio_psel      ),
  .psel_s5             (apb_stim_psel      ),
  .psel_s6             (apb_clkgen_psel    ),
  .psel_s7             (apb_smpu_psel      ),
  .psel_s8             (apb_nmi_wake_psel  )
);

// &Connect( @27
//   .hclk                   (per_clk), @28
//   .hrst_b                 (pg_reset_b), @29
//   .harb_apb_hsel          (hsel_s2), @30
//   .harb_xx_haddr          (haddr_s2), @31
//   .harb_xx_hwdata         (hwdata_s2), @32
//   .harb_xx_hwrite         (hwrite_s2), @33
//   .apb_harb_hrdata        (hrdata_s2), @34
//   .apb_harb_hready        (hready_s2), @35
//   .apb_harb_hresp         (hresp_s2), @36
//   .apb_xx_paddr           (apb_xx_paddr), @37
//   .apb_xx_penable         (apb_xx_penable), @38
//   .apb_xx_pwdata          (apb_xx_pwdata), @39
//   .apb_xx_pwrite          (apb_xx_pwrite), @40
//   .prdata_s1              (uart_apb_prdata), @41
//   .prdata_s2              (tim_apb_prdata), @42
//   .prdata_s3              (pmu_apb_prdata), @43
//   .prdata_s4              (gpio_apb_prdata), @44
//   .prdata_s5              (stim_apb_prdata), @45
//   .prdata_s6              (clkgen_apb_prdata), @46
//   .prdata_s7              (smpu_apb_prdata), @47
//   .prdata_s8              (nmi_wake_apb_prdata), @48
//   .psel_s1                (apb_uart_psel), @49
//   .psel_s2                (apb_tim_psel), @50
//   .psel_s3                (apb_pmu_psel), @51
//   .psel_s4                (apb_gpio_psel), @52
//   .psel_s5                (apb_stim_psel), @53
//   .psel_s6                (apb_clkgen_psel), @54
//   .psel_s7                (apb_smpu_psel), @55
//   .psel_s8                (apb_nmi_wake_psel) @56
// ); @57

// &Instance("pmu", "x_pmu"); @59
pmu  x_pmu (
  .apb_pmu_paddr          (apb_xx_paddr[11:0]    ),
  .apb_pmu_penable        (apb_xx_penable        ),
  .apb_pmu_psel           (apb_pmu_psel          ),
  .apb_pmu_pwdata         (apb_xx_pwdata         ),
  .apb_pmu_pwrite         (apb_xx_pwrite         ),
  .biu_pad_lpmd_b         (biu_pad_lpmd_b        ),
  .corec_pmu_sleep_out    (corec_pmu_sleep_out   ),
  .cpu_clk                (cpu_clk               ),
  .gate_en0               (gate_en0              ),
  .gate_en1               (gate_en1              ),
  .had_pad_wakeup_req_b   (1'b1                  ),
  .i_pad_cpu_jtg_rst_b    (i_pad_cpu_jtg_rst_b   ),
  .i_pad_jtg_tclk         (i_pad_jtg_tclk        ),
  .intraw_vld             (intraw_vld            ),
  .pad_cpu_rst_b          (pad_cpu_rst_b         ),
  .pad_had_jtg_tap_en     (pad_had_jtg_tap_en    ),
  .pad_had_jtg_tms_i      (pad_had_jtg_tms_i     ),
  .pad_had_jtg_trst_b     (pad_had_jtg_trst_b    ),
  .pad_had_jtg_trst_b_pre (pad_had_jtg_trst_b_pre),
  .pg_reset_b             (pg_reset_b            ),
  .pmu_apb_prdata         (pmu_apb_prdata        ),
  .pmu_clk                (pmu_clk               ),
  .pmu_corec_isolation    (pmu_corec_isolation   ),
  .pmu_corec_sleep_in     (pmu_corec_sleep_in    ),
  .sys_rst                (sys_rst               )
);

// &Connect( @60
//   .apb_pmu_psel          (apb_pmu_psel), @61
//   .apb_pmu_paddr         (apb_xx_paddr[11:0]), @62
//   .apb_pmu_penable       (apb_xx_penable), @63
//   .apb_pmu_pwdata        (apb_xx_pwdata), @64
//   .apb_pmu_pwrite        (apb_xx_pwrite), @65
//   .pad_cpu_rst_b         (pad_cpu_rst_b), @66
//   .pmu_apb_prdata        (pmu_apb_prdata), @67
//   .intraw_b              (wic_vic_intraw_b), @68
//   .had_pad_wakeup_req_b  (1'b1            ) @69
// //  .ctl_xx_awake_enable   (32'hffffffff), @70
// //  .pulse_int             (1'b0) @71
//  // .pad_vic_event_vld     (1'b0) @72
// ); @73


// &Instance("uart", "x_uart"); @76
uart  x_uart (
  .apb_uart_paddr   (apb_xx_paddr    ),
  .apb_uart_penable (apb_xx_penable  ),
  .apb_uart_psel    (apb_uart_psel   ),
  .apb_uart_pwdata  (apb_xx_pwdata   ),
  .apb_uart_pwrite  (apb_xx_pwrite   ),
  .rst_b            (pad_cpu_rst_b   ),
  .s_in             (uart0_sin       ),
  .s_out            (uart0_sout      ),
  .sys_clk          (pmu_clk         ),
  .uart_apb_prdata  (uart_apb_prdata ),
  .uart_vic_int     (uart0_vic_int   )
);

// &Connect( @77
//   .sys_clk                (pmu_clk), @78
//   .apb_uart_psel          (apb_uart_psel), @79
//   .apb_uart_paddr         (apb_xx_paddr), @80
//   .apb_uart_penable       (apb_xx_penable), @81
//   .apb_uart_pwdata        (apb_xx_pwdata), @82
//   .apb_uart_pwrite        (apb_xx_pwrite), @83
//   .rst_b                  (pad_cpu_rst_b), @84
//   .uart_apb_prdata        (uart_apb_prdata), @85
//   .uart_vic_int           (uart0_vic_int), @86
//   .s_in                   (uart0_sin), @87
//   .s_out                  (uart0_sout) @88
// ); @89

// &Instance("timer", "x_timer"); @91
timer  x_timer (
  .paddr              (apb_xx_paddr[15:0]),
  .pclk               (pmu_clk           ),
  .penable            (apb_xx_penable    ),
  .prdata             (tim_apb_prdata    ),
  .presetn            (pad_cpu_rst_b     ),
  .psel               (apb_tim_psel      ),
  .pwdata             (apb_xx_pwdata     ),
  .pwrite             (apb_xx_pwrite     ),
  .timer_int          (tim_vic_int       )
);

// &Connect( @92
//   .presetn                (pad_cpu_rst_b), @93
//   .prdata                 (tim_apb_prdata), @94
//   .timer_int              (tim_vic_int), @95
//   .pclk                   (pmu_clk), @96
//   .penable                (apb_xx_penable), @97
//   .paddr                  (apb_xx_paddr[15:0]), @98
//   .psel                   (apb_tim_psel), @99
//   .pwdata                 (apb_xx_pwdata), @100
//   .pwrite                 (apb_xx_pwrite) @101
// ); @102

// &Instance("timer", "x_stimer"); @104
timer  x_stimer (
  .paddr              (apb_xx_paddr[15:0]),
  .pclk               (pmu_clk           ),
  .penable            (apb_xx_penable    ),
  .prdata             (stim_apb_prdata   ),
  .presetn            (pad_cpu_rst_b     ),
  .psel               (apb_stim_psel     ),
  .pwdata             (apb_xx_pwdata     ),
  .pwrite             (apb_xx_pwrite     ),
  .timer_int          (stim_vic_int      )
);

// &Connect( @105
//   .presetn                (pad_cpu_rst_b), @106
//   .prdata                 (stim_apb_prdata), @107
//   .timer_int              (stim_vic_int), @108
//   .pclk                   (pmu_clk), @109
//   .penable                (apb_xx_penable), @110
//   .paddr                  (apb_xx_paddr[15:0]), @111
//   .psel                   (apb_stim_psel), @112
//   .pwdata                 (apb_xx_pwdata), @113
//   .pwrite                 (apb_xx_pwrite) @114
// ); @115

// &Instance("timer", "x_nmi_wake"); @117
timer  x_nmi_wake (
  .paddr               (apb_xx_paddr[15:0] ),
  .pclk                (pmu_clk            ),
  .penable             (apb_xx_penable     ),
  .prdata              (nmi_wake_apb_prdata),
  .presetn             (pad_cpu_rst_b      ),
  .psel                (apb_nmi_wake_psel  ),
  .pwdata              (apb_xx_pwdata      ),
  .pwrite              (apb_xx_pwrite      ),
  .timer_int           (nmi_wake_int       )
);

// &Connect( @118
//   .presetn                (pad_cpu_rst_b), @119
//   .prdata                 (nmi_wake_apb_prdata), @120
//   .timer_int              (nmi_wake_int), @121
//   .pclk                   (pmu_clk), @122
//   .penable                (apb_xx_penable), @123
//   .paddr                  (apb_xx_paddr[15:0]), @124
//   .psel                   (apb_nmi_wake_psel), @125
//   .pwdata                 (apb_xx_pwdata), @126
//   .pwrite                 (apb_xx_pwrite) @127
// ); @128
assign nmi_req = nmi_wake_int[0];
assign wakeup_req = nmi_wake_int[1];

// &Instance("fpga_clk_gen", "x_fpga_clk_gen"); @133
// &Connect( @134
//   .penable               (apb_xx_penable    ), @135
//   .psel                  (apb_clkgen_psel   ), @136
//   .prdata                (clkgen_apb_prdata ), @137
//   .pwdata                (apb_xx_pwdata[2:0]), @138
//   .pwrite                (apb_xx_pwrite     ), @139
//   .clkrst_b              (pad_cpu_rst_b     ) @140
// ); @141
// &Instance("clk_aligner", "x_clk_aligner"); @143
clk_aligner  x_clk_aligner (
  .clk_div_1          (clk_div_1         ),
  .clk_div_2          (clk_div_2         ),
  .clk_div_3          (clk_div_3         ),
  .clk_div_4          (clk_div_4         ),
  .clk_div_5          (clk_div_5         ),
  .clk_div_6          (clk_div_6         ),
  .clk_div_7          (clk_div_7         ),
  .clk_div_8          (clk_div_8         ),
  .clk_en             (clk_en            ),
  .clk_en_1           (clk_en_1          ),
  .clk_en_2           (clk_en_2          ),
  .clk_en_3           (clk_en_3          ),
  .clk_en_4           (clk_en_4          ),
  .clk_en_5           (clk_en_5          ),
  .clk_en_6           (clk_en_6          ),
  .clk_en_7           (clk_en_7          ),
  .clk_en_8           (clk_en_8          ),
  .clkrst_b           (pad_cpu_rst_b     ),
  .cpu_clk            (cpu_clk           ),
  .forever_cpuclk     (pad_clk           ),
  .gate_en0           (gate_en0          ),
  .gate_en1           (gate_en1          ),
  .paddr              (apb_xx_paddr[11:0]),
  .penable            (apb_xx_penable    ),
  .per_clk            (per_clk           ),
  .pmu_clk            (pmu_clk           ),
  .prdata             (clkgen_apb_prdata ),
  .psel               (apb_clkgen_psel   ),
  .pwdata             (apb_xx_pwdata[2:0]),
  .pwrite             (apb_xx_pwrite     ),
  .wic_clk            (wic_clk           )
);

// &Connect( @144
//   .forever_cpuclk          (pad_clk           ), @145
//   .penable                 (apb_xx_penable    ), @146
//   .paddr                   (apb_xx_paddr[11:0]), @147
//   .psel                    (apb_clkgen_psel   ), @148
//   .prdata                  (clkgen_apb_prdata ), @149
//   .pwdata                  (apb_xx_pwdata[2:0]), @150
//   .pwrite                  (apb_xx_pwrite     ), @151
//   .clkrst_b                (pad_cpu_rst_b     ) @152
// ); @153

// &Instance("clk_divider", "x_clk_divider"); @155
clk_divider  x_clk_divider (
  .clk_div_1     (clk_div_1    ),
  .clk_div_2     (clk_div_2    ),
  .clk_div_3     (clk_div_3    ),
  .clk_div_4     (clk_div_4    ),
  .clk_div_5     (clk_div_5    ),
  .clk_div_6     (clk_div_6    ),
  .clk_div_7     (clk_div_7    ),
  .clk_div_8     (clk_div_8    ),
  .clk_en_1      (clk_en_1     ),
  .clk_en_2      (clk_en_2     ),
  .clk_en_3      (clk_en_3     ),
  .clk_en_4      (clk_en_4     ),
  .clk_en_5      (clk_en_5     ),
  .clk_en_6      (clk_en_6     ),
  .clk_en_7      (clk_en_7     ),
  .clk_en_8      (clk_en_8     ),
  .osc_clk       (pad_clk      ),
  .pad_cpu_rst_b (pad_cpu_rst_b)
);

// &Connect( @156
//   .osc_clk                 (pad_clk) @157
// ); @158



// &Instance("gpio", "x_gpio"); @163
gpio  x_gpio (
  .b_pad_gpio_porta  (b_pad_gpio_porta ),
  .gpio_intr         (gpio_vic_int     ),
  .paddr             (apb_xx_paddr[6:2]),
  .pclk              (pmu_clk          ),
  .pclk_intr         (pmu_clk          ),
  .penable           (apb_xx_penable   ),
  .prdata            (gpio_apb_prdata  ),
  .presetn           (pad_cpu_rst_b    ),
  .psel              (apb_gpio_psel    ),
  .pwdata            (apb_xx_pwdata    ),
  .pwrite            (apb_xx_pwrite    )
);

// &Connect( @164
//   .paddr                  (apb_xx_paddr[6:2]), @165
//   .pclk                   (pmu_clk), @166
//   .pclk_intr              (pmu_clk), @167
//   .penable                (apb_xx_penable), @168
//   .presetn                (pad_cpu_rst_b), @169
//   .psel                   (apb_gpio_psel), @170
//   .pwdata                 (apb_xx_pwdata), @171
//   .pwrite                 (apb_xx_pwrite), @172
//   .gpio_intr              (gpio_vic_int), @173
//   .prdata                 (gpio_apb_prdata) @174
// ); @175

// &Instance("smpu_top", "x_smpu_top"); @177
smpu_top  x_smpu_top (
  .biu_pad_haddr     (fifo_pad_haddr   ),
  .biu_pad_hprot     (fifo_pad_hprot   ),
  .paddr             (apb_xx_paddr[3:2]),
  .pclk              (per_clk          ),
  .penable           (apb_xx_penable   ),
  .prdata            (smpu_apb_prdata  ),
  .presetn           (pg_reset_b       ),
  .psel              (apb_smpu_psel    ),
  .pwdata            (apb_xx_pwdata    ),
  .pwrite            (apb_xx_pwrite    ),
  .smpu_deny         (smpu_deny        )
);

// &Connect( @178
//   .paddr                  (apb_xx_paddr[3:2]), @179
//   .pclk                   (per_clk), @180
//   .penable                (apb_xx_penable), @181
//   .presetn                (pg_reset_b), @182
//   .psel                   (apb_smpu_psel), @183
//   .pwdata                 (apb_xx_pwdata), @184
//   .pwrite                 (apb_xx_pwrite), @185
//   .prdata                 (smpu_apb_prdata), @186
//   .biu_pad_haddr          (fifo_pad_haddr ), @187
//   .biu_pad_hprot          (fifo_pad_hprot ) @188
// ); @189

// &Instance("wic_top", "x_wic_top"); @191
wic_top  x_wic_top (
  .ctl_xx_awake_enable (32'hffffffff       ),
  .gpio_vic_int        (gpio_vic_int       ),
  .intraw_vld          (intraw_vld         ),
  .pad_cpu_rst_b       (pad_cpu_rst_b      ),
  .pad_vic_int_vld     (pad_vic_int_vld    ),
  .pulse_int           (1'b0               ),
  .stim_vic_int        (stim_vic_int       ),
  .tim_vic_int         (tim_vic_int        ),
  .uart0_vic_int       (uart0_vic_int      ),
  .wic_clk             (wic_clk            )
);

// &Connect( @192
//    .pulse_int              (1'b0         ), @193
//    .ctl_xx_awake_enable   (32'hffffffff  ) @194
//  @195
// ); @196
// &Force("nonport","pulse_int"); @198
// &Force("nonport","stim_vic_int"); @199
// &Force("nonport","gpio_vic_int"); @200

// &Force("nonport", "pulse_int"); @204
// &Force("nonport", "stim_vic_int"); @205

//assign pll_core_cpuclk = per_clk;
// &Force("output","per_clk"); @209
// &Force("output","cpu_clk"); @210
// &Force("output","pg_reset_b"); @211

// //&Force("output","cpu_clk"); @213
// //&Force("output",""); @214

// &ModuleEnd; @216
endmodule




