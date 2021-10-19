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
module cr_clic_sel(
  // input
  data_in,
  sel_in_onehot,
  // output
  data_out
);

parameter DATA_WIDTH   = 32;
parameter SEL_NUM      = 256;

input  [DATA_WIDTH*SEL_NUM-1:0] data_in;
input  [SEL_NUM-1:0]            sel_in_onehot;

output [DATA_WIDTH-1:0]         data_out;

wire   [DATA_WIDTH-1:0]         data_in_2d[SEL_NUM-1:0];
wire   [SEL_NUM-1:0]            data_in_2d_rev[DATA_WIDTH-1:0];
wire   [DATA_WIDTH-1:0]         data_out;

//==========================================================
//                  Generate 2D signal
//==========================================================
genvar i;
genvar j;

generate
  for (i = 0; i < SEL_NUM; i = i+1) begin: EXPAND
    assign data_in_2d[i][DATA_WIDTH-1:0] = data_in[i*DATA_WIDTH+:DATA_WIDTH] & {DATA_WIDTH{sel_in_onehot[i]}};
  end
endgenerate

//==========================================================
//                   Reverse 2D signal
//==========================================================
generate
  for (i = 0; i < SEL_NUM; i = i+1) begin: REVERSEI
    for (j = 0; j < DATA_WIDTH; j = j+1) begin: REVERSEJ
      assign data_in_2d_rev[j][i] = data_in_2d[i][j];
    end
  end
endgenerate

//==========================================================
//                     Do or to sel
//==========================================================
generate
  for (i = 0; i < DATA_WIDTH; i = i+1) begin: OR_SEL
    assign data_out[i] = |data_in_2d_rev[i][SEL_NUM-1:0];
  end
endgenerate


endmodule
