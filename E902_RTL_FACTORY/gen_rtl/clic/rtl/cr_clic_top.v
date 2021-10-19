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

// &ModuleBeg; @26
module cr_clic_top(
  clic_cpu_int_hv,
  clic_cpu_int_id,
  clic_cpu_int_il,
  clic_cpu_int_priv,
  clic_tcipif_cmplt,
  clic_tcipif_rdata,
  clint_cpu_me_int,
  clint_cpu_ms_int,
  clint_cpu_mt_int,
  cpu_clic_curid,
  cpu_clic_int_exit,
  cpu_clic_mode,
  cpurst_b,
  forever_cpuclk,
  pad_clic_int_vld,
  pad_yy_gate_clk_en_b,
  tcipif_clic_addr,
  tcipif_clic_sel,
  tcipif_clic_size,
  tcipif_clic_wdata,
  tcipif_clic_write
);

// &Ports; @27
input             clint_cpu_me_int;         
input             clint_cpu_ms_int;         
input             clint_cpu_mt_int;         
input   [11  :0]  cpu_clic_curid;           
input             cpu_clic_int_exit;        
input   [1   :0]  cpu_clic_mode;            
input             cpurst_b;                 
input             forever_cpuclk;           
input   [63  :0]  pad_clic_int_vld;         
input             pad_yy_gate_clk_en_b;     
input   [15  :0]  tcipif_clic_addr;         
input             tcipif_clic_sel;          
input   [1   :0]  tcipif_clic_size;         
input   [31  :0]  tcipif_clic_wdata;        
input             tcipif_clic_write;        
output            clic_cpu_int_hv;          
output  [11  :0]  clic_cpu_int_id;          
output  [7   :0]  clic_cpu_int_il;          
output  [1   :0]  clic_cpu_int_priv;        
output            clic_tcipif_cmplt;        
output  [31  :0]  clic_tcipif_rdata;        

// &Regs; @28

// &Wires; @29
wire              arb_ctrl_int_hv;          
wire    [11  :0]  arb_ctrl_int_id;          
wire    [7   :0]  arb_ctrl_int_il;          
wire              arb_ctrl_int_mode;        
wire              busif_ctrl_cliccfg_sel;   
wire              busif_ctrl_clicinfo_sel;  
wire              busif_ctrl_mintthresh_sel; 
wire    [79  :0]  busif_kid_clicintattr_sel; 
wire    [79  :0]  busif_kid_clicintctl_sel; 
wire    [79  :0]  busif_kid_clicintie_sel;  
wire    [79  :0]  busif_kid_clicintip_sel;  
wire    [31  :0]  busif_kid_wdata;          
wire              busif_xx_write_vld;       
wire              clic_cpu_int_hv;          
wire    [11  :0]  clic_cpu_int_id;          
wire    [7   :0]  clic_cpu_int_il;          
wire    [1   :0]  clic_cpu_int_priv;        
wire              clic_tcipif_cmplt;        
wire    [31  :0]  clic_tcipif_rdata;        
wire              clicintattr_clk;          
wire              clicintctl_clk;           
wire              clicintie_clk;            
wire              clicintip_clk;            
wire              clicreg_clk;              
wire              clint_cpu_me_int;         
wire              clint_cpu_ms_int;         
wire              clint_cpu_mt_int;         
wire    [11  :0]  cpu_clic_curid;           
wire              cpu_clic_int_exit;        
wire    [1   :0]  cpu_clic_mode;            
wire              cpurst_b;                 
wire    [31  :0]  ctrl_busif_cliccfg_val;   
wire    [31  :0]  ctrl_busif_clicinfo_val;  
wire    [31  :0]  ctrl_busif_mintthresh_val; 
wire              ctrl_clicintattr_en;      
wire              ctrl_clicintctl_en;       
wire              ctrl_clicintie_en;        
wire              ctrl_clicintip_en;        
wire              ctrl_clicreg_en;          
wire    [79  :0]  ctrl_kid_ack_int;         
wire              ctrl_sample_en;           
wire    [2   :0]  ctrl_xx_int_lv_or_mask;   
wire              forever_cpuclk;           
wire    [319 :0]  kid_arb_int_all_vec;      
wire    [79  :0]  kid_arb_int_hv;           
wire    [79  :0]  kid_arb_int_req;          
wire    [2559:0]  kid_busif_rdata_vec;      
wire    [79  :0]  kid_ctrl_clicintattr_en;  
wire    [79  :0]  kid_ctrl_clicintctl_en;   
wire    [79  :0]  kid_ctrl_clicintie_en;    
wire    [79  :0]  kid_ctrl_clicintip_en;    
wire    [79  :0]  kid_ctrl_sample_en;       
wire    [79  :0]  kid_int_vld;              
wire              out_clk;                  
wire              out_clk_en;               
wire    [63  :0]  pad_clic_int_vld;         
wire              pad_yy_gate_clk_en_b;     
wire              sample_clk;               
wire    [15  :0]  tcipif_clic_addr;         
wire              tcipif_clic_sel;          
wire    [1   :0]  tcipif_clic_size;         
wire    [31  :0]  tcipif_clic_wdata;        
wire              tcipif_clic_write;        


parameter CLICINTNUM     = `CLIC_INTNUM;
parameter CLICINTCTLBITS = `CLIC_INTCTLBITS;

// &Instance("cr_clic_arb"); @34
cr_clic_arb  x_cr_clic_arb (
  .arb_ctrl_int_hv        (arb_ctrl_int_hv       ),
  .arb_ctrl_int_id        (arb_ctrl_int_id       ),
  .arb_ctrl_int_il        (arb_ctrl_int_il       ),
  .arb_ctrl_int_mode      (arb_ctrl_int_mode     ),
  .cpurst_b               (cpurst_b              ),
  .ctrl_xx_int_lv_or_mask (ctrl_xx_int_lv_or_mask),
  .kid_arb_int_all_vec    (kid_arb_int_all_vec   ),
  .kid_arb_int_hv         (kid_arb_int_hv        ),
  .kid_arb_int_req        (kid_arb_int_req       ),
  .out_clk                (out_clk               ),
  .out_clk_en             (out_clk_en            )
);

// &Instance("cr_clic_busif"); @35
cr_clic_busif  x_cr_clic_busif (
  .busif_ctrl_cliccfg_sel    (busif_ctrl_cliccfg_sel   ),
  .busif_ctrl_clicinfo_sel   (busif_ctrl_clicinfo_sel  ),
  .busif_ctrl_mintthresh_sel (busif_ctrl_mintthresh_sel),
  .busif_kid_clicintattr_sel (busif_kid_clicintattr_sel),
  .busif_kid_clicintctl_sel  (busif_kid_clicintctl_sel ),
  .busif_kid_clicintie_sel   (busif_kid_clicintie_sel  ),
  .busif_kid_clicintip_sel   (busif_kid_clicintip_sel  ),
  .busif_kid_wdata           (busif_kid_wdata          ),
  .busif_xx_write_vld        (busif_xx_write_vld       ),
  .clic_tcipif_cmplt         (clic_tcipif_cmplt        ),
  .clic_tcipif_rdata         (clic_tcipif_rdata        ),
  .ctrl_busif_cliccfg_val    (ctrl_busif_cliccfg_val   ),
  .ctrl_busif_clicinfo_val   (ctrl_busif_clicinfo_val  ),
  .ctrl_busif_mintthresh_val (ctrl_busif_mintthresh_val),
  .kid_busif_rdata_vec       (kid_busif_rdata_vec      ),
  .tcipif_clic_addr          (tcipif_clic_addr         ),
  .tcipif_clic_sel           (tcipif_clic_sel          ),
  .tcipif_clic_size          (tcipif_clic_size         ),
  .tcipif_clic_wdata         (tcipif_clic_wdata        ),
  .tcipif_clic_write         (tcipif_clic_write        )
);

// &Instance("cr_clic_ctrl"); @36
cr_clic_ctrl  x_cr_clic_ctrl (
  .arb_ctrl_int_hv           (arb_ctrl_int_hv          ),
  .arb_ctrl_int_id           (arb_ctrl_int_id          ),
  .arb_ctrl_int_il           (arb_ctrl_int_il          ),
  .arb_ctrl_int_mode         (arb_ctrl_int_mode        ),
  .busif_ctrl_cliccfg_sel    (busif_ctrl_cliccfg_sel   ),
  .busif_ctrl_clicinfo_sel   (busif_ctrl_clicinfo_sel  ),
  .busif_ctrl_mintthresh_sel (busif_ctrl_mintthresh_sel),
  .busif_kid_wdata           (busif_kid_wdata          ),
  .busif_xx_write_vld        (busif_xx_write_vld       ),
  .clic_cpu_int_hv           (clic_cpu_int_hv          ),
  .clic_cpu_int_id           (clic_cpu_int_id          ),
  .clic_cpu_int_il           (clic_cpu_int_il          ),
  .clic_cpu_int_priv         (clic_cpu_int_priv        ),
  .clicreg_clk               (clicreg_clk              ),
  .cpu_clic_curid            (cpu_clic_curid           ),
  .cpu_clic_int_exit         (cpu_clic_int_exit        ),
  .cpu_clic_mode             (cpu_clic_mode            ),
  .cpurst_b                  (cpurst_b                 ),
  .ctrl_busif_cliccfg_val    (ctrl_busif_cliccfg_val   ),
  .ctrl_busif_clicinfo_val   (ctrl_busif_clicinfo_val  ),
  .ctrl_busif_mintthresh_val (ctrl_busif_mintthresh_val),
  .ctrl_clicintattr_en       (ctrl_clicintattr_en      ),
  .ctrl_clicintctl_en        (ctrl_clicintctl_en       ),
  .ctrl_clicintie_en         (ctrl_clicintie_en        ),
  .ctrl_clicintip_en         (ctrl_clicintip_en        ),
  .ctrl_clicreg_en           (ctrl_clicreg_en          ),
  .ctrl_kid_ack_int          (ctrl_kid_ack_int         ),
  .ctrl_sample_en            (ctrl_sample_en           ),
  .ctrl_xx_int_lv_or_mask    (ctrl_xx_int_lv_or_mask   ),
  .kid_ctrl_clicintattr_en   (kid_ctrl_clicintattr_en  ),
  .kid_ctrl_clicintctl_en    (kid_ctrl_clicintctl_en   ),
  .kid_ctrl_clicintie_en     (kid_ctrl_clicintie_en    ),
  .kid_ctrl_clicintip_en     (kid_ctrl_clicintip_en    ),
  .kid_ctrl_sample_en        (kid_ctrl_sample_en       ),
  .out_clk                   (out_clk                  )
);


assign kid_int_vld[CLICINTNUM-1:16] = pad_clic_int_vld[CLICINTNUM-17:0];
// &Force("input", "pad_clic_int_vld"); &Force("bus", "pad_clic_int_vld", CLICINTNUM-17, 0); @40
assign kid_int_vld[15:0] = {3'b0, 1'b0,   // clic software int
                            clint_cpu_me_int, 3'b0,
                            clint_cpu_mt_int, 3'b0,
                            clint_cpu_ms_int, 3'b0};
// &Force("nonport", "kid_int_vld"); @46

// &Force("nonport", "kid_busif_rdata_bus"); @48
// &Force("nonport", "busif_kid_clicintattr_sel"); @49
// &Force("nonport", "busif_kid_clicintctl_sel"); @50
// &Force("nonport", "busif_kid_clicintie_sel"); @51
// &Force("nonport", "busif_kid_clicintip_sel"); @52
// &Force("nonport", "clicintattr_clk"); @53
// &Force("nonport", "clicintctl_clk"); @54
// &Force("nonport", "clicintie_clk"); @55
// &Force("nonport", "clicintip_clk"); @56
// &Force("nonport", "sample_clk"); @57
// &Force("nonport", "ctrl_kid_ack_int"); @58
// &Force("nonport", "kid_arb_int_all_vec"); @59
// &Force("nonport", "kid_arb_int_hv"); @60
// &Force("nonport", "kid_arb_int_req"); @61
// &Force("nonport", "kid_busif_rdata_vec"); @62
// &Force("nonport", "kid_ctrl_clicintattr_en"); @63
// &Force("nonport", "kid_ctrl_clicintctl_en"); @64
// &Force("nonport", "kid_ctrl_clicintie_en"); @65
// &Force("nonport", "kid_ctrl_clicintip_en"); @66
// &Force("nonport", "kid_ctrl_sample_en"); @67
//csky vperl_off
genvar i;
generate
for (i = 0; i < CLICINTNUM; i = i+1)
begin:INT_KID
  case(i)
    0, 1, 2,
    4, 5, 6,
    8, 9, 10,
    13, 14, 15:
      cr_clic_kid_dummy x_cr_clic_kid(
        .kid_arb_int_all            (kid_arb_int_all_vec[(CLICINTCTLBITS+1)*i+:(CLICINTCTLBITS+1)]),
        .kid_arb_int_hv             (kid_arb_int_hv[i]),
        .kid_arb_int_req            (kid_arb_int_req[i]),
        .kid_busif_rdata            (kid_busif_rdata_vec[32*i+:32]),
        .kid_ctrl_clicintattr_en    (kid_ctrl_clicintattr_en[i]),
        .kid_ctrl_clicintctl_en     (kid_ctrl_clicintctl_en[i]),
        .kid_ctrl_clicintie_en      (kid_ctrl_clicintie_en[i]),
        .kid_ctrl_clicintip_en      (kid_ctrl_clicintip_en[i]),
        .kid_ctrl_sample_en         (kid_ctrl_sample_en[i])
      );
    default:
      cr_clic_kid x_cr_clic_kid(
        .busif_kid_clicintattr_sel  (busif_kid_clicintattr_sel[i]),
        .busif_kid_clicintctl_sel   (busif_kid_clicintctl_sel[i]),
        .busif_kid_clicintie_sel    (busif_kid_clicintie_sel[i]),
        .busif_kid_clicintip_sel    (busif_kid_clicintip_sel[i]),
        .busif_kid_wdata            (busif_kid_wdata),
        .busif_xx_write_vld         (busif_xx_write_vld),
        .clicintattr_clk            (clicintattr_clk),
        .clicintctl_clk             (clicintctl_clk),
        .clicintie_clk              (clicintie_clk),
        .clicintip_clk              (clicintip_clk),
        .cpu_clic_mode              (cpu_clic_mode),
        .cpurst_b                   (cpurst_b),
        .ctrl_kid_ack_int           (ctrl_kid_ack_int[i]),
        .kid_arb_int_all            (kid_arb_int_all_vec[(CLICINTCTLBITS+1)*i+:(CLICINTCTLBITS+1)]),
        .kid_arb_int_hv             (kid_arb_int_hv[i]),
        .kid_arb_int_req            (kid_arb_int_req[i]),
        .kid_busif_rdata            (kid_busif_rdata_vec[32*i+:32]),
        .kid_ctrl_clicintattr_en    (kid_ctrl_clicintattr_en[i]),
        .kid_ctrl_clicintctl_en     (kid_ctrl_clicintctl_en[i]),
        .kid_ctrl_clicintie_en      (kid_ctrl_clicintie_en[i]),
        .kid_ctrl_clicintip_en      (kid_ctrl_clicintip_en[i]),
        .kid_ctrl_sample_en         (kid_ctrl_sample_en[i]),
        .kid_int_vld                (kid_int_vld[i]),
        .sample_clk                 (sample_clk)
      );
  endcase
end
endgenerate
//csky vperl_on

//==========================================================
//                    Gate Clk Cell
//==========================================================
// &Instance("gated_clk_cell", "x_sample_clk"); @124
gated_clk_cell  x_sample_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (sample_clk          ),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (ctrl_sample_en      ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in      (forever_cpuclk), @125
//          .external_en (1'b0), @126
//          .global_en   (1'b1), @127
//          .module_en   (1'b0), @128
//          .local_en    (ctrl_sample_en), @129
//          .clk_out     (sample_clk)); @130

// &Instance("gated_clk_cell", "x_clicintip_clk"); @132
gated_clk_cell  x_clicintip_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (clicintip_clk       ),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (ctrl_clicintip_en   ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in      (forever_cpuclk), @133
//          .external_en (1'b0), @134
//          .global_en   (1'b1), @135
//          .module_en   (1'b0), @136
//          .local_en    (ctrl_clicintip_en), @137
//          .clk_out     (clicintip_clk)); @138

// &Instance("gated_clk_cell", "x_clicintie_clk"); @140
gated_clk_cell  x_clicintie_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (clicintie_clk       ),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (ctrl_clicintie_en   ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in      (forever_cpuclk), @141
//          .external_en (1'b0), @142
//          .global_en   (1'b1), @143
//          .module_en   (1'b0), @144
//          .local_en    (ctrl_clicintie_en), @145
//          .clk_out     (clicintie_clk)); @146

// &Instance("gated_clk_cell", "x_clicintattr_clk"); @148
gated_clk_cell  x_clicintattr_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (clicintattr_clk     ),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (ctrl_clicintattr_en ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in      (forever_cpuclk), @149
//          .external_en (1'b0), @150
//          .global_en   (1'b1), @151
//          .module_en   (1'b0), @152
//          .local_en    (ctrl_clicintattr_en), @153
//          .clk_out     (clicintattr_clk)); @154

// &Instance("gated_clk_cell", "x_clicintctl_clk"); @156
gated_clk_cell  x_clicintctl_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (clicintctl_clk      ),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (ctrl_clicintctl_en  ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in      (forever_cpuclk), @157
//          .external_en (1'b0), @158
//          .global_en   (1'b1), @159
//          .module_en   (1'b0), @160
//          .local_en    (ctrl_clicintctl_en), @161
//          .clk_out     (clicintctl_clk)); @162

// &Instance("gated_clk_cell", "x_clicreg_clk"); @164
gated_clk_cell  x_clicreg_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (clicreg_clk         ),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (ctrl_clicreg_en     ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in      (forever_cpuclk), @165
//          .external_en (1'b0), @166
//          .global_en   (1'b1), @167
//          .module_en   (1'b0), @168
//          .local_en    (ctrl_clicreg_en), @169
//          .clk_out     (clicreg_clk)); @170

// &Instance("gated_clk_cell", "x_out_clk"); @172
gated_clk_cell  x_out_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (out_clk             ),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (out_clk_en          ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in      (forever_cpuclk), @173
//          .external_en (1'b0), @174
//          .global_en   (1'b1), @175
//          .module_en   (1'b0), @176
//          .local_en    (out_clk_en), @177
//          .clk_out     (out_clk)); @178


// &ModuleEnd; @181
endmodule


