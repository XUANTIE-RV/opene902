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

// &ModuleBeg; @24
module cr_ifu_randclk(
  randclk_ibuf_entry_data_mod_en_w16,
  randclk_ibuf_pop_mod_en_w3,
  randclk_ibuf_push_mod_en_w3
);

// &Ports; @25
output  [3:0]  randclk_ibuf_entry_data_mod_en_w16; 
output         randclk_ibuf_pop_mod_en_w3;        
output         randclk_ibuf_push_mod_en_w3;       

// &Regs; @26

// &Wires; @27
wire    [3:0]  randclk_ibuf_entry_data_mod_en_w16; 
wire           randclk_ibuf_pop_mod_en_w3;        
wire           randclk_ibuf_push_mod_en_w3;       


// &Force("bus","seu_ifu_randclk_mod_en",31,0); @31

assign randclk_ibuf_push_mod_en_w3             = 1'b0;
assign randclk_ibuf_pop_mod_en_w3              = 1'b0;
assign randclk_ibuf_entry_data_mod_en_w16[3:0] = 4'b0;
//assign randclk_ibuf_acc_err_mod_en_w3          = 1'b0;



// &ModuleEnd; @77
endmodule


