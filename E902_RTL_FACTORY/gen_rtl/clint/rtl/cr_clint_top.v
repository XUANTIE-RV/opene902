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
module cr_clint_top(
  clint_cpu_me_int,
  clint_cpu_ms_int,
  clint_cpu_mt_int,
  clint_tcipif_cmplt,
  clint_tcipif_rdata,
  cpu_clint_mode,
  cpurst_b,
  forever_cpuclk,
  pad_yy_gate_clk_en_b,
  sysio_clint_me_int,
  sysio_clint_mtime,
  tcipif_clint_addr,
  tcipif_clint_sel,
  tcipif_clint_wdata,
  tcipif_clint_write
);

// &Ports; @23
input   [1 :0]  cpu_clint_mode;            
input           cpurst_b;                  
input           forever_cpuclk;            
input           pad_yy_gate_clk_en_b;      
input           sysio_clint_me_int;        
input   [63:0]  sysio_clint_mtime;         
input   [15:0]  tcipif_clint_addr;         
input           tcipif_clint_sel;          
input   [31:0]  tcipif_clint_wdata;        
input           tcipif_clint_write;        
output          clint_cpu_me_int;          
output          clint_cpu_ms_int;          
output          clint_cpu_mt_int;          
output          clint_tcipif_cmplt;        
output  [31:0]  clint_tcipif_rdata;        

// &Regs; @24

// &Wires; @25
wire            busif_regs_msip_sel;       
wire            busif_regs_mtimecmp_hi_sel; 
wire            busif_regs_mtimecmp_lo_sel; 
wire    [31:0]  busif_regs_wdata;          
wire            busif_regs_write_vld;      
wire            clint_clk;                 
wire            clint_clk_en;              
wire            clint_cpu_me_int;          
wire            clint_cpu_ms_int;          
wire            clint_cpu_mt_int;          
wire            clint_tcipif_cmplt;        
wire    [31:0]  clint_tcipif_rdata;        
wire    [1 :0]  cpu_clint_mode;            
wire            cpurst_b;                  
wire            forever_cpuclk;            
wire    [31:0]  msip_value;                
wire    [31:0]  mtime_hi_value;            
wire    [31:0]  mtime_lo_value;            
wire    [31:0]  mtimecmp_hi_value;         
wire    [31:0]  mtimecmp_lo_value;         
wire            pad_yy_gate_clk_en_b;      
wire            sysio_clint_me_int;        
wire    [63:0]  sysio_clint_mtime;         
wire    [15:0]  tcipif_clint_addr;         
wire            tcipif_clint_sel;          
wire    [31:0]  tcipif_clint_wdata;        
wire            tcipif_clint_write;        


// &Instance("cr_clint_regs"); @27
cr_clint_regs  x_cr_clint_regs (
  .busif_regs_msip_sel        (busif_regs_msip_sel       ),
  .busif_regs_mtimecmp_hi_sel (busif_regs_mtimecmp_hi_sel),
  .busif_regs_mtimecmp_lo_sel (busif_regs_mtimecmp_lo_sel),
  .busif_regs_wdata           (busif_regs_wdata          ),
  .busif_regs_write_vld       (busif_regs_write_vld      ),
  .clint_clk                  (clint_clk                 ),
  .clint_cpu_me_int           (clint_cpu_me_int          ),
  .clint_cpu_ms_int           (clint_cpu_ms_int          ),
  .clint_cpu_mt_int           (clint_cpu_mt_int          ),
  .cpu_clint_mode             (cpu_clint_mode            ),
  .cpurst_b                   (cpurst_b                  ),
  .msip_value                 (msip_value                ),
  .mtime_hi_value             (mtime_hi_value            ),
  .mtime_lo_value             (mtime_lo_value            ),
  .mtimecmp_hi_value          (mtimecmp_hi_value         ),
  .mtimecmp_lo_value          (mtimecmp_lo_value         ),
  .sysio_clint_me_int         (sysio_clint_me_int        ),
  .sysio_clint_mtime          (sysio_clint_mtime         )
);

// &Instance("cr_clint_busif"); @28
cr_clint_busif  x_cr_clint_busif (
  .busif_regs_msip_sel        (busif_regs_msip_sel       ),
  .busif_regs_mtimecmp_hi_sel (busif_regs_mtimecmp_hi_sel),
  .busif_regs_mtimecmp_lo_sel (busif_regs_mtimecmp_lo_sel),
  .busif_regs_wdata           (busif_regs_wdata          ),
  .busif_regs_write_vld       (busif_regs_write_vld      ),
  .clint_tcipif_cmplt         (clint_tcipif_cmplt        ),
  .clint_tcipif_rdata         (clint_tcipif_rdata        ),
  .msip_value                 (msip_value                ),
  .mtime_hi_value             (mtime_hi_value            ),
  .mtime_lo_value             (mtime_lo_value            ),
  .mtimecmp_hi_value          (mtimecmp_hi_value         ),
  .mtimecmp_lo_value          (mtimecmp_lo_value         ),
  .tcipif_clint_addr          (tcipif_clint_addr         ),
  .tcipif_clint_sel           (tcipif_clint_sel          ),
  .tcipif_clint_wdata         (tcipif_clint_wdata        ),
  .tcipif_clint_write         (tcipif_clint_write        )
);


assign clint_clk_en = tcipif_clint_sel;
// &Instance("gated_clk_cell", "x_clint_gateclk"); @31
gated_clk_cell  x_clint_gateclk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (clint_clk           ),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (clint_clk_en        ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect( .clk_in     (forever_cpuclk), @32
//           .external_en(1'b0          ), @33
//           .global_en  (1'b1          ), @34
//           .module_en  (1'b0          ), @35
//           .local_en   (clint_clk_en  ), @36
//           .clk_out    (clint_clk     ) @37
//          ); @38


// &ModuleEnd; @41
endmodule


