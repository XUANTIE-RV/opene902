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
module cr_clk_top(
  forever_cpuclk,
  forever_cpuclk_nogated,
  forever_jtgclk,
  pad_had_jtg_tclk,
  pad_yy_test_mode,
  pll_core_cpuclk
);

// &Ports; @24
input        pad_had_jtg_tclk;      
input        pad_yy_test_mode;      
input        pll_core_cpuclk;       
output       forever_cpuclk;        
output       forever_cpuclk_nogated; 
output       forever_jtgclk;        

// &Regs; @25

// &Wires; @26
wire         forever_cpuclk;        
wire         forever_cpuclk_nogated; 
wire         forever_jtgclk;        
wire         pad_had_jtg_tclk;      
wire         pad_yy_test_mode;      
wire         pll_core_cpuclk;       


assign forever_jtgclk = pad_had_jtg_tclk;
assign forever_cpuclk = pad_yy_test_mode ? pad_had_jtg_tclk : pll_core_cpuclk;
assign forever_cpuclk_nogated = pad_yy_test_mode ? pad_had_jtg_tclk : pll_core_cpuclk;

// &ModuleEnd; @34
endmodule


