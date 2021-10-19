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
module cr_iu_randclk(
  randclk_mad_mod_en_w2,
  randclk_oper_gpr_mod_en_w32,
  randclk_pcgen_mod_en_w32,
  randclk_retire_mod_en_w2,
  randclk_wb_buf_mod_en_w32,
  randclk_wb_ctrl_mod_en_w2,
  randclk_wb_idx_mod_en_w5
);

// &Ports; @25
output          randclk_mad_mod_en_w2;      
output  [20:0]  randclk_oper_gpr_mod_en_w32; 
output          randclk_pcgen_mod_en_w32;   
output          randclk_retire_mod_en_w2;   
output          randclk_wb_buf_mod_en_w32;  
output          randclk_wb_ctrl_mod_en_w2;  
output          randclk_wb_idx_mod_en_w5;   

// &Regs; @26

// &Wires; @27
wire            randclk_mad_mod_en_w2;      
wire    [20:0]  randclk_oper_gpr_mod_en_w32; 
wire            randclk_pcgen_mod_en_w32;   
wire            randclk_retire_mod_en_w2;   
wire            randclk_wb_buf_mod_en_w32;  
wire            randclk_wb_ctrl_mod_en_w2;  
wire            randclk_wb_idx_mod_en_w5;   


// &Force("bus","seu_iu_randclk_mod_en",31,0); @31

//assign randclk_branch_mod_en_w2          = 1'b0;
assign randclk_mad_mod_en_w2             = 1'b0;
assign randclk_oper_gpr_mod_en_w32[20:0] = 21'b0;
assign randclk_pcgen_mod_en_w32          = 1'b0;
assign randclk_retire_mod_en_w2          = 1'b0;
//assign randclk_vector_mod_en_w3          = 1'b0;
assign randclk_wb_buf_mod_en_w32         = 1'b0;
assign randclk_wb_ctrl_mod_en_w2         = 1'b0;
assign randclk_wb_idx_mod_en_w5          = 1'b0;
//assign randclk_wb_pc_mod_en_w31          = 1'b0;


// &ModuleEnd; @82
endmodule


