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
module cr_rst_top(
  cpurst_b,
  hadrst_b,
  pad_cpu_rst_b,
  pad_had_jtg_trst_b,
  pad_had_rst_b,
  pad_yy_test_mode,
  trst_b
);

// &Ports; @23
input        pad_cpu_rst_b;     
input        pad_had_jtg_trst_b; 
input        pad_had_rst_b;     
input        pad_yy_test_mode;  
output       cpurst_b;          
output       hadrst_b;          
output       trst_b;            

// &Regs; @24

// &Wires; @25
wire         cpurst_b;          
wire         hadrst_b;          
wire         pad_cpu_rst_b;     
wire         pad_had_jtg_trst_b; 
wire         pad_had_rst_b;     
wire         pad_yy_test_mode;  
wire         trst_b;            


//cpu reset 
assign cpurst_b = pad_yy_test_mode ? pad_had_jtg_trst_b : pad_cpu_rst_b;

//had reset
//signal for reset cpuclk domain reg in HAD
assign hadrst_b = pad_yy_test_mode ? pad_had_jtg_trst_b : pad_had_rst_b;
//signal for reset JTAG in HAD
assign trst_b = pad_had_jtg_trst_b;

// &ModuleEnd; @36
endmodule


