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
module cr_pwrm_top_dummy(
  pwrm_cpu_bus_peak_power_limit_en
);

// &Ports; @23
output       pwrm_cpu_bus_peak_power_limit_en; 

// &Regs; @24

// &Wires; @25
wire         pwrm_cpu_bus_peak_power_limit_en; 


//assign pwrm_cpu_avrg_power_inst_issue = 1'b1;
//assign pwrm_cpu_peak_power_limit_en   = 1'b0;

assign pwrm_cpu_bus_peak_power_limit_en = 1'b0;
//assign pwrm_cpu_inst_peak_power_limit_en = 1'b0;

// &ModuleEnd; @33
endmodule



