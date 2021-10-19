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
module cr_lsu_unalign(
  unalign_ctrl_not_last_beat,
  unalign_ctrl_stall,
  unalign_dp_first_req,
  unalign_dp_load_data_byte1_to_byte1,
  unalign_dp_load_data_byte1_to_byte2,
  unalign_dp_load_data_byte1_to_byte3,
  unalign_dp_load_data_byte1_to_byte4,
  unalign_dp_load_data_byte2_to_byte1,
  unalign_dp_load_data_byte2_to_byte2,
  unalign_dp_load_data_byte2_to_byte3,
  unalign_dp_load_data_byte2_to_byte4,
  unalign_dp_load_data_byte3_to_byte1,
  unalign_dp_load_data_byte3_to_byte2,
  unalign_dp_load_data_byte3_to_byte3,
  unalign_dp_load_data_byte3_to_byte4,
  unalign_dp_load_data_byte4_to_byte1,
  unalign_dp_load_data_byte4_to_byte2,
  unalign_dp_load_data_byte4_to_byte3,
  unalign_dp_load_data_byte4_to_byte4,
  unalign_dp_store_data_byte1_to_byte1,
  unalign_dp_store_data_byte1_to_byte2,
  unalign_dp_store_data_byte1_to_byte3,
  unalign_dp_store_data_byte1_to_byte4,
  unalign_dp_store_data_byte2_to_byte1,
  unalign_dp_store_data_byte2_to_byte2,
  unalign_dp_store_data_byte2_to_byte3,
  unalign_dp_store_data_byte2_to_byte4,
  unalign_dp_store_data_byte3_to_byte1,
  unalign_dp_store_data_byte3_to_byte2,
  unalign_dp_store_data_byte3_to_byte3,
  unalign_dp_store_data_byte3_to_byte4,
  unalign_dp_store_data_byte4_to_byte1,
  unalign_dp_store_data_byte4_to_byte2,
  unalign_dp_store_data_byte4_to_byte3,
  unalign_dp_store_data_byte4_to_byte4,
  unalign_top_clk_en,
  unalign_xx_split_on
);

// &Ports; @23
output       unalign_ctrl_not_last_beat;          
output       unalign_ctrl_stall;                  
output       unalign_dp_first_req;                
output       unalign_dp_load_data_byte1_to_byte1; 
output       unalign_dp_load_data_byte1_to_byte2; 
output       unalign_dp_load_data_byte1_to_byte3; 
output       unalign_dp_load_data_byte1_to_byte4; 
output       unalign_dp_load_data_byte2_to_byte1; 
output       unalign_dp_load_data_byte2_to_byte2; 
output       unalign_dp_load_data_byte2_to_byte3; 
output       unalign_dp_load_data_byte2_to_byte4; 
output       unalign_dp_load_data_byte3_to_byte1; 
output       unalign_dp_load_data_byte3_to_byte2; 
output       unalign_dp_load_data_byte3_to_byte3; 
output       unalign_dp_load_data_byte3_to_byte4; 
output       unalign_dp_load_data_byte4_to_byte1; 
output       unalign_dp_load_data_byte4_to_byte2; 
output       unalign_dp_load_data_byte4_to_byte3; 
output       unalign_dp_load_data_byte4_to_byte4; 
output       unalign_dp_store_data_byte1_to_byte1; 
output       unalign_dp_store_data_byte1_to_byte2; 
output       unalign_dp_store_data_byte1_to_byte3; 
output       unalign_dp_store_data_byte1_to_byte4; 
output       unalign_dp_store_data_byte2_to_byte1; 
output       unalign_dp_store_data_byte2_to_byte2; 
output       unalign_dp_store_data_byte2_to_byte3; 
output       unalign_dp_store_data_byte2_to_byte4; 
output       unalign_dp_store_data_byte3_to_byte1; 
output       unalign_dp_store_data_byte3_to_byte2; 
output       unalign_dp_store_data_byte3_to_byte3; 
output       unalign_dp_store_data_byte3_to_byte4; 
output       unalign_dp_store_data_byte4_to_byte1; 
output       unalign_dp_store_data_byte4_to_byte2; 
output       unalign_dp_store_data_byte4_to_byte3; 
output       unalign_dp_store_data_byte4_to_byte4; 
output       unalign_top_clk_en;                  
output       unalign_xx_split_on;                 

// &Regs; @24

// &Wires; @25
wire         unalign_ctrl_not_last_beat;          
wire         unalign_ctrl_stall;                  
wire         unalign_dp_first_req;                
wire         unalign_dp_load_data_byte1_to_byte1; 
wire         unalign_dp_load_data_byte1_to_byte2; 
wire         unalign_dp_load_data_byte1_to_byte3; 
wire         unalign_dp_load_data_byte1_to_byte4; 
wire         unalign_dp_load_data_byte2_to_byte1; 
wire         unalign_dp_load_data_byte2_to_byte2; 
wire         unalign_dp_load_data_byte2_to_byte3; 
wire         unalign_dp_load_data_byte2_to_byte4; 
wire         unalign_dp_load_data_byte3_to_byte1; 
wire         unalign_dp_load_data_byte3_to_byte2; 
wire         unalign_dp_load_data_byte3_to_byte3; 
wire         unalign_dp_load_data_byte3_to_byte4; 
wire         unalign_dp_load_data_byte4_to_byte1; 
wire         unalign_dp_load_data_byte4_to_byte2; 
wire         unalign_dp_load_data_byte4_to_byte3; 
wire         unalign_dp_load_data_byte4_to_byte4; 
wire         unalign_dp_store_data_byte1_to_byte1; 
wire         unalign_dp_store_data_byte1_to_byte2; 
wire         unalign_dp_store_data_byte1_to_byte3; 
wire         unalign_dp_store_data_byte1_to_byte4; 
wire         unalign_dp_store_data_byte2_to_byte1; 
wire         unalign_dp_store_data_byte2_to_byte2; 
wire         unalign_dp_store_data_byte2_to_byte3; 
wire         unalign_dp_store_data_byte2_to_byte4; 
wire         unalign_dp_store_data_byte3_to_byte1; 
wire         unalign_dp_store_data_byte3_to_byte2; 
wire         unalign_dp_store_data_byte3_to_byte3; 
wire         unalign_dp_store_data_byte3_to_byte4; 
wire         unalign_dp_store_data_byte4_to_byte1; 
wire         unalign_dp_store_data_byte4_to_byte2; 
wire         unalign_dp_store_data_byte4_to_byte3; 
wire         unalign_dp_store_data_byte4_to_byte4; 
wire         unalign_top_clk_en;                  
wire         unalign_xx_split_on;                 


// //&Connect(.clk_in      (forever_cpuclk), @39
// //         .external_en (1'b0), @40
// //         .global_en   (cp0_yy_clk_en), @41
// //         .module_en   (randclk_unalign_mod_en_w2), @42
// //         .local_en    (unalign_en), @43
// //         .clk_out     (unalign_clk)); @44
// &CombBeg; @91
// &CombEnd; @125
assign unalign_top_clk_en = 1'b0;
//assign lsu_iu_unalign_split_stall = 1'b0;
assign unalign_ctrl_not_last_beat = 1'b0;
assign unalign_ctrl_stall = 1'b0;
assign unalign_dp_first_req = 1'b1;
assign unalign_xx_split_on = 1'b0;


//assign unalign_ctrl_load_mask = 1'b0;
assign unalign_dp_load_data_byte1_to_byte1 = 1'b0;
assign unalign_dp_load_data_byte1_to_byte2 = 1'b0;
assign unalign_dp_load_data_byte1_to_byte3 = 1'b0;
assign unalign_dp_load_data_byte1_to_byte4 = 1'b0;
assign unalign_dp_load_data_byte2_to_byte1 = 1'b0;
assign unalign_dp_load_data_byte2_to_byte2 = 1'b0;
assign unalign_dp_load_data_byte2_to_byte3 = 1'b0;
assign unalign_dp_load_data_byte2_to_byte4 = 1'b0;
assign unalign_dp_load_data_byte3_to_byte1 = 1'b0;
assign unalign_dp_load_data_byte3_to_byte2 = 1'b0;
assign unalign_dp_load_data_byte3_to_byte3 = 1'b0;
assign unalign_dp_load_data_byte3_to_byte4 = 1'b0;
assign unalign_dp_load_data_byte4_to_byte1 = 1'b0;
assign unalign_dp_load_data_byte4_to_byte2 = 1'b0;
assign unalign_dp_load_data_byte4_to_byte3 = 1'b0;
assign unalign_dp_load_data_byte4_to_byte4 = 1'b0;
//assign unalign_dp_plus1_addr;
//assign unalign_dp_plus2_addr;
//assign unalign_dp_plus3_addr;
//assign unalign_dp_size_half;
//assign unalign_dp_size_word;
assign unalign_dp_store_data_byte1_to_byte1 = 1'b0;
assign unalign_dp_store_data_byte1_to_byte2 = 1'b0;
assign unalign_dp_store_data_byte1_to_byte3 = 1'b0;
assign unalign_dp_store_data_byte1_to_byte4 = 1'b0;
assign unalign_dp_store_data_byte2_to_byte1 = 1'b0;
assign unalign_dp_store_data_byte2_to_byte2 = 1'b0;
assign unalign_dp_store_data_byte2_to_byte3 = 1'b0;
assign unalign_dp_store_data_byte2_to_byte4 = 1'b0;
assign unalign_dp_store_data_byte3_to_byte1 = 1'b0;
assign unalign_dp_store_data_byte3_to_byte2 = 1'b0;
assign unalign_dp_store_data_byte3_to_byte3 = 1'b0;
assign unalign_dp_store_data_byte3_to_byte4 = 1'b0;
assign unalign_dp_store_data_byte4_to_byte1 = 1'b0;
assign unalign_dp_store_data_byte4_to_byte2 = 1'b0;
assign unalign_dp_store_data_byte4_to_byte3 = 1'b0;
assign unalign_dp_store_data_byte4_to_byte4 = 1'b0;





// &ModuleEnd; @411
endmodule



