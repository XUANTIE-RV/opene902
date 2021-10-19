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

//==========================================================
//                     Do or to sel
//==========================================================
module cr_clic_ff1_onehot(
  data_in,
  ff1_out_onehot
);

parameter WIDTH = 32;

input  [WIDTH-1:0] data_in;
output [WIDTH-1:0] ff1_out_onehot;

wire [WIDTH:0] ff1_tmp;

assign ff1_tmp[WIDTH] = 1'b0;
genvar i;

generate
  for (i = 0; i < WIDTH; i = i+1)
  begin: FF1_ONEHOT
    assign ff1_tmp[i] = data_in[i] || ff1_tmp[i+1];
  end
endgenerate

assign ff1_out_onehot[WIDTH-1:0] = ff1_tmp[WIDTH:1] ^ ff1_tmp[WIDTH-1:0];

endmodule

