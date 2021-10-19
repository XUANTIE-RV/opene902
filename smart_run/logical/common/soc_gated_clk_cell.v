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

module soc_gated_clk_cell(
  clk_in,
  external_en,
  SE,
  clk_out
);

input  clk_in;
input  external_en ;
input  SE;
output clk_out;

//reg    clk_en_af_latch;
//always @(clk_in or external_en)
//begin
//  if(!clk_in)
//    clk_en_af_latch <= external_en;
//end
//
//reg clk_en ;
//always @ (SE or clk_en_af_latch )
//begin
//    clk_en <= clk_en_af_latch || SE ;
//end
assign clk_out = clk_in;
   
endmodule   
