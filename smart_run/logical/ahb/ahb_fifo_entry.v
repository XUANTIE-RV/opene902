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
module ahb_fifo_entry(
  create_en,
  data_in,
  data_out,
  entry_clk,
  entry_rst_b
);

// &Ports; @20
input           create_en;  
input   [54:0]  data_in;    
input           entry_clk;  
input           entry_rst_b; 
output  [54:0]  data_out;   

// &Regs; @21
reg     [54:0]  data_out;   

// &Wires; @22
wire            create_en;  
wire    [54:0]  data_in;    
wire            entry_clk;  
wire            entry_rst_b; 


always @(posedge entry_clk or negedge entry_rst_b)
begin
  if (!entry_rst_b)
    data_out[54:0] <= 54'b0;
  else if (create_en)
    data_out[54:0] <= data_in[54:0];
  else
    data_out[54:0] <= data_out[54:0];
end

// &Force("output","data_out"); @34




// &ModuleEnd; @39
endmodule


