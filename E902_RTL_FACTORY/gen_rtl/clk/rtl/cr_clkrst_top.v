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

// &ModuleBeg; @22
module cr_clkrst_top(
  cpurst_b,
  forever_cpuclk,
  forever_cpuclk_nogated,
  forever_jtgclk,
  hadrst_b,
  pad_cpu_rst_b,
  pad_had_jtg_tclk,
  pad_had_jtg_trst_b,
  pad_had_rst_b,
  pad_yy_test_mode,
  pll_core_cpuclk,
  trst_b
);

// &Ports; @23
input        pad_cpu_rst_b;         
input        pad_had_jtg_tclk;      
input        pad_had_jtg_trst_b;    
input        pad_had_rst_b;         
input        pad_yy_test_mode;      
input        pll_core_cpuclk;       
output       cpurst_b;              
output       forever_cpuclk;        
output       forever_cpuclk_nogated; 
output       forever_jtgclk;        
output       hadrst_b;              
output       trst_b;                

// &Regs; @24

// &Wires; @25
wire         cpurst_b;              
wire         forever_cpuclk;        
wire         forever_cpuclk_nogated; 
wire         forever_jtgclk;        
wire         hadrst_b;              
wire         pad_cpu_rst_b;         
wire         pad_had_jtg_tclk;      
wire         pad_had_jtg_trst_b;    
wire         pad_had_rst_b;         
wire         pad_yy_test_mode;      
wire         pll_core_cpuclk;       
wire         trst_b;                


// &Force("output", "forever_cpuclk"); @27
// &Force("output", "forever_cpuclk_nogated"); @29

//----------------------------------------------------------
// clock top
//----------------------------------------------------------
// &Instance("cr_clk_top"); @35
cr_clk_top  x_cr_clk_top (
  .forever_cpuclk         (forever_cpuclk        ),
  .forever_cpuclk_nogated (forever_cpuclk_nogated),
  .forever_jtgclk         (forever_jtgclk        ),
  .pad_had_jtg_tclk       (pad_had_jtg_tclk      ),
  .pad_yy_test_mode       (pad_yy_test_mode      ),
  .pll_core_cpuclk        (pll_core_cpuclk       )
);


//----------------------------------------------------------
// reset top
//----------------------------------------------------------
// &Instance("cr_rst_top"); @40
cr_rst_top  x_cr_rst_top (
  .cpurst_b           (cpurst_b          ),
  .hadrst_b           (hadrst_b          ),
  .pad_cpu_rst_b      (pad_cpu_rst_b     ),
  .pad_had_jtg_trst_b (pad_had_jtg_trst_b),
  .pad_had_rst_b      (pad_had_rst_b     ),
  .pad_yy_test_mode   (pad_yy_test_mode  ),
  .trst_b             (trst_b            )
);

// &ModuleEnd; @41
endmodule


