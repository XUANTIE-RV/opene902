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
module clic_kid_golden_ports(
  pad_clic_int_vld
);

// &Wires; @3

// &Ports; @4
input   [63:0]  pad_clic_int_vld; 

// &Force("input", "pad_clic_int_vld"); &Force("bus", "pad_clic_int_vld", `CLIC_INTNUM-17, 0); @6
// &ModuleEnd; @8
endmodule


