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
module cr_cp0_randclk(
  randclk_psr_mod_en_w13
);

// &Ports; @25
output       randclk_psr_mod_en_w13; 

// &Regs; @26

// &Wires; @27
wire         randclk_psr_mod_en_w13; 


// &Force("bus","seu_cp0_randclk_mod_en",31,0); @31

//assign randclk_oreg_vec_mod_en_w22 = 1'b0;
//assign randclk_psr_c_mod_en_w2     = 1'b0;
assign randclk_psr_mod_en_w13      = 1'b0;
//assign randclk_psr_epsr_mod_en_w46 = 1'b0;


// &ModuleEnd; @47
endmodule


