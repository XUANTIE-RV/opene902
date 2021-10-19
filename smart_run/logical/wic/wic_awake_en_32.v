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


// &ModuleBeg; @23
module wic_awake_en_32(
  awake_data,
  awake_disable,
  awake_enable,
  int_cfg,
  int_exit,
  int_pending,
  int_vld,
  pad_cpu_rst_b,
  pending_clr,
  wic_awake_en,
  wic_clk
);

// &Ports; @24
input   [31:0]  awake_data;   
input           awake_disable; 
input           awake_enable; 
input   [31:0]  int_cfg;      
input   [31:0]  int_exit;     
input   [31:0]  int_vld;      
input           pad_cpu_rst_b; 
input   [31:0]  pending_clr;  
input           wic_clk;      
output  [31:0]  int_pending;  
output  [31:0]  wic_awake_en; 

// &Regs; @25

// &Wires; @26
wire    [31:0]  awake_data;   
wire            awake_disable; 
wire            awake_enable; 
wire    [31:0]  int_cfg;      
wire    [31:0]  int_exit;     
wire    [31:0]  int_pending;  
wire    [31:0]  int_vld;      
wire            pad_cpu_rst_b; 
wire    [31:0]  pending_clr;  
wire    [31:0]  wic_awake_en; 
wire            wic_clk;      

// &Instance("wic", "x_wic_0"); @27
wic  x_wic_0 (
  .awake_data      (awake_data[0]  ),
  .awake_disable   (awake_disable  ),
  .awake_enable    (awake_enable   ),
  .int_cfg         (int_cfg[0]     ),
  .int_exit        (int_exit[0]    ),
  .int_pending     (int_pending[0] ),
  .int_vld         (int_vld[0]     ),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pending_clr     (pending_clr[0] ),
  .wic_awake_en    (wic_awake_en[0]),
  .wic_clk         (wic_clk        )
);

// &Connect (.awake_data      (awake_data[0]          ), @28
//           .int_vld         (int_vld[0]             ),        @29
//           .int_cfg         (int_cfg[0]             ),        @30
//           .int_exit        (int_exit[0]            ), @31
//           .int_pending     (int_pending[0]         ), @32
//           .pending_clr     (pending_clr[0]         ), @33
//           .pending_set     (pending_set[0]         ), @34
//           .wic_awake_en    (wic_awake_en[0]        ) @35
//          ); @36

// &Instance("wic", "x_wic_1"); @38
wic  x_wic_1 (
  .awake_data      (awake_data[1]  ),
  .awake_disable   (awake_disable  ),
  .awake_enable    (awake_enable   ),
  .int_cfg         (int_cfg[1]     ),
  .int_exit        (int_exit[1]    ),
  .int_pending     (int_pending[1] ),
  .int_vld         (int_vld[1]     ),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pending_clr     (pending_clr[1] ),
  .wic_awake_en    (wic_awake_en[1]),
  .wic_clk         (wic_clk        )
);

// &Connect (.awake_data      (awake_data[1]          ), @39
//           .int_vld         (int_vld[1]             ),        @40
//           .int_cfg         (int_cfg[1]             ),        @41
//           .int_exit        (int_exit[1]            ), @42
//           .int_pending     (int_pending[1]         ), @43
//           .pending_clr     (pending_clr[1]         ), @44
//           .pending_set     (pending_set[1]         ), @45
//           .wic_awake_en    (wic_awake_en[1]        ) @46
//          ); @47

// &Instance("wic", "x_wic_2"); @49
wic  x_wic_2 (
  .awake_data      (awake_data[2]  ),
  .awake_disable   (awake_disable  ),
  .awake_enable    (awake_enable   ),
  .int_cfg         (int_cfg[2]     ),
  .int_exit        (int_exit[2]    ),
  .int_pending     (int_pending[2] ),
  .int_vld         (int_vld[2]     ),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pending_clr     (pending_clr[2] ),
  .wic_awake_en    (wic_awake_en[2]),
  .wic_clk         (wic_clk        )
);

// &Connect (.awake_data      (awake_data[2]          ), @50
//           .int_vld         (int_vld[2]             ),        @51
//           .int_cfg         (int_cfg[2]             ),        @52
//           .int_exit        (int_exit[2]            ), @53
//           .int_pending     (int_pending[2]         ), @54
//           .pending_clr     (pending_clr[2]         ), @55
//           .pending_set     (pending_set[2]         ), @56
//           .wic_awake_en    (wic_awake_en[2]        ) @57
//          ); @58

// &Instance("wic", "x_wic_3"); @60
wic  x_wic_3 (
  .awake_data      (awake_data[3]  ),
  .awake_disable   (awake_disable  ),
  .awake_enable    (awake_enable   ),
  .int_cfg         (int_cfg[3]     ),
  .int_exit        (int_exit[3]    ),
  .int_pending     (int_pending[3] ),
  .int_vld         (int_vld[3]     ),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pending_clr     (pending_clr[3] ),
  .wic_awake_en    (wic_awake_en[3]),
  .wic_clk         (wic_clk        )
);

// &Connect (.awake_data      (awake_data[3]          ), @61
//           .int_vld         (int_vld[3]             ),        @62
//           .int_cfg         (int_cfg[3]             ),        @63
//           .int_exit        (int_exit[3]            ), @64
//           .int_pending     (int_pending[3]         ), @65
//           .pending_clr     (pending_clr[3]         ), @66
//           .pending_set     (pending_set[3]         ), @67
//           .wic_awake_en    (wic_awake_en[3]        ) @68
//          ); @69

// &Instance("wic", "x_wic_4"); @71
wic  x_wic_4 (
  .awake_data      (awake_data[4]  ),
  .awake_disable   (awake_disable  ),
  .awake_enable    (awake_enable   ),
  .int_cfg         (int_cfg[4]     ),
  .int_exit        (int_exit[4]    ),
  .int_pending     (int_pending[4] ),
  .int_vld         (int_vld[4]     ),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pending_clr     (pending_clr[4] ),
  .wic_awake_en    (wic_awake_en[4]),
  .wic_clk         (wic_clk        )
);

// &Connect (.awake_data      (awake_data[4]          ), @72
//           .int_vld         (int_vld[4]             ),        @73
//           .int_cfg         (int_cfg[4]             ),        @74
//           .int_exit        (int_exit[4]            ), @75
//           .int_pending     (int_pending[4]         ), @76
//           .pending_clr     (pending_clr[4]         ), @77
//           .pending_set     (pending_set[4]         ), @78
//           .wic_awake_en    (wic_awake_en[4]        ) @79
//          ); @80

// &Instance("wic", "x_wic_5"); @82
wic  x_wic_5 (
  .awake_data      (awake_data[5]  ),
  .awake_disable   (awake_disable  ),
  .awake_enable    (awake_enable   ),
  .int_cfg         (int_cfg[5]     ),
  .int_exit        (int_exit[5]    ),
  .int_pending     (int_pending[5] ),
  .int_vld         (int_vld[5]     ),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pending_clr     (pending_clr[5] ),
  .wic_awake_en    (wic_awake_en[5]),
  .wic_clk         (wic_clk        )
);

// &Connect (.awake_data      (awake_data[5]          ), @83
//           .int_vld         (int_vld[5]             ),        @84
//           .int_cfg         (int_cfg[5]             ),        @85
//           .int_exit        (int_exit[5]            ), @86
//           .int_pending     (int_pending[5]         ), @87
//           .pending_clr     (pending_clr[5]         ), @88
//           .pending_set     (pending_set[5]         ), @89
//           .wic_awake_en    (wic_awake_en[5]        ) @90
//          ); @91

// &Instance("wic", "x_wic_6"); @93
wic  x_wic_6 (
  .awake_data      (awake_data[6]  ),
  .awake_disable   (awake_disable  ),
  .awake_enable    (awake_enable   ),
  .int_cfg         (int_cfg[6]     ),
  .int_exit        (int_exit[6]    ),
  .int_pending     (int_pending[6] ),
  .int_vld         (int_vld[6]     ),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pending_clr     (pending_clr[6] ),
  .wic_awake_en    (wic_awake_en[6]),
  .wic_clk         (wic_clk        )
);

// &Connect (.awake_data      (awake_data[6]          ), @94
//           .int_vld         (int_vld[6]             ),        @95
//           .int_cfg         (int_cfg[6]             ),        @96
//           .int_exit        (int_exit[6]            ), @97
//           .int_pending     (int_pending[6]         ), @98
//           .pending_clr     (pending_clr[6]         ), @99
//           .pending_set     (pending_set[6]         ), @100
//           .wic_awake_en    (wic_awake_en[6]        ) @101
//          ); @102

// &Instance("wic", "x_wic_7"); @104
wic  x_wic_7 (
  .awake_data      (awake_data[7]  ),
  .awake_disable   (awake_disable  ),
  .awake_enable    (awake_enable   ),
  .int_cfg         (int_cfg[7]     ),
  .int_exit        (int_exit[7]    ),
  .int_pending     (int_pending[7] ),
  .int_vld         (int_vld[7]     ),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pending_clr     (pending_clr[7] ),
  .wic_awake_en    (wic_awake_en[7]),
  .wic_clk         (wic_clk        )
);

// &Connect (.awake_data      (awake_data[7]          ), @105
//           .int_vld         (int_vld[7]             ),        @106
//           .int_cfg         (int_cfg[7]             ),        @107
//           .int_exit        (int_exit[7]            ), @108
//           .int_pending     (int_pending[7]         ), @109
//           .pending_clr     (pending_clr[7]         ), @110
//           .pending_set     (pending_set[7]         ), @111
//           .wic_awake_en    (wic_awake_en[7]        ) @112
//          ); @113

// &Instance("wic", "x_wic_8"); @115
wic  x_wic_8 (
  .awake_data      (awake_data[8]  ),
  .awake_disable   (awake_disable  ),
  .awake_enable    (awake_enable   ),
  .int_cfg         (int_cfg[8]     ),
  .int_exit        (int_exit[8]    ),
  .int_pending     (int_pending[8] ),
  .int_vld         (int_vld[8]     ),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pending_clr     (pending_clr[8] ),
  .wic_awake_en    (wic_awake_en[8]),
  .wic_clk         (wic_clk        )
);

// &Connect (.awake_data      (awake_data[8]          ), @116
//           .int_vld         (int_vld[8]             ),        @117
//           .int_cfg         (int_cfg[8]             ),        @118
//           .int_exit        (int_exit[8]            ), @119
//           .int_pending     (int_pending[8]         ), @120
//           .pending_clr     (pending_clr[8]         ), @121
//           .pending_set     (pending_set[8]         ), @122
//           .wic_awake_en    (wic_awake_en[8]        ) @123
//          ); @124

// &Instance("wic", "x_wic_9"); @126
wic  x_wic_9 (
  .awake_data      (awake_data[9]  ),
  .awake_disable   (awake_disable  ),
  .awake_enable    (awake_enable   ),
  .int_cfg         (int_cfg[9]     ),
  .int_exit        (int_exit[9]    ),
  .int_pending     (int_pending[9] ),
  .int_vld         (int_vld[9]     ),
  .pad_cpu_rst_b   (pad_cpu_rst_b  ),
  .pending_clr     (pending_clr[9] ),
  .wic_awake_en    (wic_awake_en[9]),
  .wic_clk         (wic_clk        )
);

// &Connect (.awake_data      (awake_data[9]          ), @127
//           .int_vld         (int_vld[9]             ),        @128
//           .int_cfg         (int_cfg[9]             ),        @129
//           .int_exit        (int_exit[9]            ), @130
//           .int_pending     (int_pending[9]         ), @131
//           .pending_clr     (pending_clr[9]         ), @132
//           .pending_set     (pending_set[9]         ), @133
//           .wic_awake_en    (wic_awake_en[9]        ) @134
//          ); @135

// &Instance("wic", "x_wic_10"); @137
wic  x_wic_10 (
  .awake_data       (awake_data[10]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[10]     ),
  .int_exit         (int_exit[10]    ),
  .int_pending      (int_pending[10] ),
  .int_vld          (int_vld[10]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[10] ),
  .wic_awake_en     (wic_awake_en[10]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[10]          ), @138
//           .int_vld         (int_vld[10]             ),        @139
//           .int_cfg         (int_cfg[10]             ),        @140
//           .int_exit        (int_exit[10]            ), @141
//           .int_pending     (int_pending[10]         ), @142
//           .pending_clr     (pending_clr[10]         ), @143
//           .pending_set     (pending_set[10]         ), @144
//           .wic_awake_en    (wic_awake_en[10]        ) @145
//          ); @146

// &Instance("wic", "x_wic_11"); @148
wic  x_wic_11 (
  .awake_data       (awake_data[11]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[11]     ),
  .int_exit         (int_exit[11]    ),
  .int_pending      (int_pending[11] ),
  .int_vld          (int_vld[11]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[11] ),
  .wic_awake_en     (wic_awake_en[11]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[11]          ), @149
//           .int_vld         (int_vld[11]             ),        @150
//           .int_cfg         (int_cfg[11]             ),        @151
//           .int_exit        (int_exit[11]            ), @152
//           .int_pending     (int_pending[11]         ), @153
//           .pending_clr     (pending_clr[11]         ), @154
//           .pending_set     (pending_set[11]         ), @155
//           .wic_awake_en    (wic_awake_en[11]        ) @156
//          ); @157

// &Instance("wic", "x_wic_12"); @159
wic  x_wic_12 (
  .awake_data       (awake_data[12]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[12]     ),
  .int_exit         (int_exit[12]    ),
  .int_pending      (int_pending[12] ),
  .int_vld          (int_vld[12]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[12] ),
  .wic_awake_en     (wic_awake_en[12]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[12]          ), @160
//           .int_vld         (int_vld[12]             ),        @161
//           .int_cfg         (int_cfg[12]             ),        @162
//           .int_exit        (int_exit[12]            ), @163
//           .int_pending     (int_pending[12]         ), @164
//           .pending_clr     (pending_clr[12]         ), @165
//           .pending_set     (pending_set[12]         ), @166
//           .wic_awake_en    (wic_awake_en[12]        ) @167
//          ); @168

// &Instance("wic", "x_wic_13"); @170
wic  x_wic_13 (
  .awake_data       (awake_data[13]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[13]     ),
  .int_exit         (int_exit[13]    ),
  .int_pending      (int_pending[13] ),
  .int_vld          (int_vld[13]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[13] ),
  .wic_awake_en     (wic_awake_en[13]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[13]          ), @171
//           .int_vld         (int_vld[13]             ),        @172
//           .int_cfg         (int_cfg[13]             ),        @173
//           .int_exit        (int_exit[13]            ), @174
//           .int_pending     (int_pending[13]         ), @175
//           .pending_clr     (pending_clr[13]         ), @176
//           .pending_set     (pending_set[13]         ), @177
//           .wic_awake_en    (wic_awake_en[13]        ) @178
//          ); @179

// &Instance("wic", "x_wic_14"); @181
wic  x_wic_14 (
  .awake_data       (awake_data[14]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[14]     ),
  .int_exit         (int_exit[14]    ),
  .int_pending      (int_pending[14] ),
  .int_vld          (int_vld[14]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[14] ),
  .wic_awake_en     (wic_awake_en[14]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[14]          ), @182
//           .int_vld         (int_vld[14]             ),        @183
//           .int_cfg         (int_cfg[14]             ),        @184
//           .int_exit        (int_exit[14]            ), @185
//           .int_pending     (int_pending[14]         ), @186
//           .pending_clr     (pending_clr[14]         ), @187
//           .pending_set     (pending_set[14]         ), @188
//           .wic_awake_en    (wic_awake_en[14]        ) @189
//          ); @190

// &Instance("wic", "x_wic_15"); @192
wic  x_wic_15 (
  .awake_data       (awake_data[15]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[15]     ),
  .int_exit         (int_exit[15]    ),
  .int_pending      (int_pending[15] ),
  .int_vld          (int_vld[15]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[15] ),
  .wic_awake_en     (wic_awake_en[15]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[15]          ), @193
//           .int_vld         (int_vld[15]             ),        @194
//           .int_cfg         (int_cfg[15]             ),        @195
//           .int_exit        (int_exit[15]            ), @196
//           .int_pending     (int_pending[15]         ), @197
//           .pending_clr     (pending_clr[15]         ), @198
//           .pending_set     (pending_set[15]         ), @199
//           .wic_awake_en    (wic_awake_en[15]        ) @200
//          ); @201

// &Instance("wic", "x_wic_16"); @203
wic  x_wic_16 (
  .awake_data       (awake_data[16]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[16]     ),
  .int_exit         (int_exit[16]    ),
  .int_pending      (int_pending[16] ),
  .int_vld          (int_vld[16]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[16] ),
  .wic_awake_en     (wic_awake_en[16]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[16]          ), @204
//           .int_vld         (int_vld[16]             ),        @205
//           .int_cfg         (int_cfg[16]             ),        @206
//           .int_exit        (int_exit[16]            ), @207
//           .int_pending     (int_pending[16]         ), @208
//           .pending_clr     (pending_clr[16]         ), @209
//           .pending_set     (pending_set[16]         ), @210
//           .wic_awake_en    (wic_awake_en[16]        ) @211
//          ); @212

// &Instance("wic", "x_wic_17"); @214
wic  x_wic_17 (
  .awake_data       (awake_data[17]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[17]     ),
  .int_exit         (int_exit[17]    ),
  .int_pending      (int_pending[17] ),
  .int_vld          (int_vld[17]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[17] ),
  .wic_awake_en     (wic_awake_en[17]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[17]          ), @215
//           .int_vld         (int_vld[17]             ),        @216
//           .int_cfg         (int_cfg[17]             ),        @217
//           .int_exit        (int_exit[17]            ), @218
//           .int_pending     (int_pending[17]         ), @219
//           .pending_clr     (pending_clr[17]         ), @220
//           .pending_set     (pending_set[17]         ), @221
//           .wic_awake_en    (wic_awake_en[17]        ) @222
//          ); @223

// &Instance("wic", "x_wic_18"); @225
wic  x_wic_18 (
  .awake_data       (awake_data[18]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[18]     ),
  .int_exit         (int_exit[18]    ),
  .int_pending      (int_pending[18] ),
  .int_vld          (int_vld[18]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[18] ),
  .wic_awake_en     (wic_awake_en[18]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[18]          ), @226
//           .int_vld         (int_vld[18]             ),        @227
//           .int_cfg         (int_cfg[18]             ),        @228
//           .int_exit        (int_exit[18]            ), @229
//           .int_pending     (int_pending[18]         ), @230
//           .pending_clr     (pending_clr[18]         ), @231
//           .pending_set     (pending_set[18]         ), @232
//           .wic_awake_en    (wic_awake_en[18]        ) @233
//          ); @234

// &Instance("wic", "x_wic_19"); @236
wic  x_wic_19 (
  .awake_data       (awake_data[19]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[19]     ),
  .int_exit         (int_exit[19]    ),
  .int_pending      (int_pending[19] ),
  .int_vld          (int_vld[19]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[19] ),
  .wic_awake_en     (wic_awake_en[19]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[19]          ), @237
//           .int_vld         (int_vld[19]             ),        @238
//           .int_cfg         (int_cfg[19]             ),        @239
//           .int_exit        (int_exit[19]            ), @240
//           .int_pending     (int_pending[19]         ), @241
//           .pending_clr     (pending_clr[19]         ), @242
//           .pending_set     (pending_set[19]         ), @243
//           .wic_awake_en    (wic_awake_en[19]        ) @244
//          ); @245

// &Instance("wic", "x_wic_20"); @247
wic  x_wic_20 (
  .awake_data       (awake_data[20]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[20]     ),
  .int_exit         (int_exit[20]    ),
  .int_pending      (int_pending[20] ),
  .int_vld          (int_vld[20]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[20] ),
  .wic_awake_en     (wic_awake_en[20]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[20]          ), @248
//           .int_vld         (int_vld[20]             ),        @249
//           .int_cfg         (int_cfg[20]             ),        @250
//           .int_exit        (int_exit[20]            ), @251
//           .int_pending     (int_pending[20]         ), @252
//           .pending_clr     (pending_clr[20]         ), @253
//           .pending_set     (pending_set[20]         ), @254
//           .wic_awake_en    (wic_awake_en[20]        ) @255
//          ); @256

// &Instance("wic", "x_wic_21"); @258
wic  x_wic_21 (
  .awake_data       (awake_data[21]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[21]     ),
  .int_exit         (int_exit[21]    ),
  .int_pending      (int_pending[21] ),
  .int_vld          (int_vld[21]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[21] ),
  .wic_awake_en     (wic_awake_en[21]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[21]          ), @259
//           .int_vld         (int_vld[21]             ),        @260
//           .int_cfg         (int_cfg[21]             ),        @261
//           .int_exit        (int_exit[21]            ), @262
//           .int_pending     (int_pending[21]         ), @263
//           .pending_clr     (pending_clr[21]         ), @264
//           .pending_set     (pending_set[21]         ), @265
//           .wic_awake_en    (wic_awake_en[21]        ) @266
//          ); @267

// &Instance("wic", "x_wic_22"); @269
wic  x_wic_22 (
  .awake_data       (awake_data[22]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[22]     ),
  .int_exit         (int_exit[22]    ),
  .int_pending      (int_pending[22] ),
  .int_vld          (int_vld[22]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[22] ),
  .wic_awake_en     (wic_awake_en[22]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[22]          ), @270
//           .int_vld         (int_vld[22]             ),        @271
//           .int_cfg         (int_cfg[22]             ),        @272
//           .int_exit        (int_exit[22]            ), @273
//           .int_pending     (int_pending[22]         ), @274
//           .pending_clr     (pending_clr[22]         ), @275
//           .pending_set     (pending_set[22]         ), @276
//           .wic_awake_en    (wic_awake_en[22]        ) @277
//          ); @278

// &Instance("wic", "x_wic_23"); @280
wic  x_wic_23 (
  .awake_data       (awake_data[23]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[23]     ),
  .int_exit         (int_exit[23]    ),
  .int_pending      (int_pending[23] ),
  .int_vld          (int_vld[23]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[23] ),
  .wic_awake_en     (wic_awake_en[23]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[23]          ), @281
//           .int_vld         (int_vld[23]             ),        @282
//           .int_cfg         (int_cfg[23]             ),        @283
//           .int_exit        (int_exit[23]            ), @284
//           .int_pending     (int_pending[23]         ), @285
//           .pending_clr     (pending_clr[23]         ), @286
//           .pending_set     (pending_set[23]         ), @287
//           .wic_awake_en    (wic_awake_en[23]        ) @288
//          ); @289

// &Instance("wic", "x_wic_24"); @291
wic  x_wic_24 (
  .awake_data       (awake_data[24]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[24]     ),
  .int_exit         (int_exit[24]    ),
  .int_pending      (int_pending[24] ),
  .int_vld          (int_vld[24]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[24] ),
  .wic_awake_en     (wic_awake_en[24]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[24]          ), @292
//           .int_vld         (int_vld[24]             ),        @293
//           .int_cfg         (int_cfg[24]             ),        @294
//           .int_exit        (int_exit[24]            ), @295
//           .int_pending     (int_pending[24]         ), @296
//           .pending_clr     (pending_clr[24]         ), @297
//           .pending_set     (pending_set[24]         ), @298
//           .wic_awake_en    (wic_awake_en[24]        ) @299
//          ); @300

// &Instance("wic", "x_wic_25"); @302
wic  x_wic_25 (
  .awake_data       (awake_data[25]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[25]     ),
  .int_exit         (int_exit[25]    ),
  .int_pending      (int_pending[25] ),
  .int_vld          (int_vld[25]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[25] ),
  .wic_awake_en     (wic_awake_en[25]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[25]          ), @303
//           .int_vld         (int_vld[25]             ),        @304
//           .int_cfg         (int_cfg[25]             ),        @305
//           .int_exit        (int_exit[25]            ), @306
//           .int_pending     (int_pending[25]         ), @307
//           .pending_clr     (pending_clr[25]         ), @308
//           .pending_set     (pending_set[25]         ), @309
//           .wic_awake_en    (wic_awake_en[25]        ) @310
//          ); @311

// &Instance("wic", "x_wic_26"); @313
wic  x_wic_26 (
  .awake_data       (awake_data[26]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[26]     ),
  .int_exit         (int_exit[26]    ),
  .int_pending      (int_pending[26] ),
  .int_vld          (int_vld[26]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[26] ),
  .wic_awake_en     (wic_awake_en[26]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[26]          ), @314
//           .int_vld         (int_vld[26]             ),        @315
//           .int_cfg         (int_cfg[26]             ),        @316
//           .int_exit        (int_exit[26]            ), @317
//           .int_pending     (int_pending[26]         ), @318
//           .pending_clr     (pending_clr[26]         ), @319
//           .pending_set     (pending_set[26]         ), @320
//           .wic_awake_en    (wic_awake_en[26]        ) @321
//          ); @322

// &Instance("wic", "x_wic_27"); @324
wic  x_wic_27 (
  .awake_data       (awake_data[27]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[27]     ),
  .int_exit         (int_exit[27]    ),
  .int_pending      (int_pending[27] ),
  .int_vld          (int_vld[27]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[27] ),
  .wic_awake_en     (wic_awake_en[27]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[27]          ), @325
//           .int_vld         (int_vld[27]             ),        @326
//           .int_cfg         (int_cfg[27]             ),        @327
//           .int_exit        (int_exit[27]            ), @328
//           .int_pending     (int_pending[27]         ), @329
//           .pending_clr     (pending_clr[27]         ), @330
//           .pending_set     (pending_set[27]         ), @331
//           .wic_awake_en    (wic_awake_en[27]        ) @332
//          ); @333

// &Instance("wic", "x_wic_28"); @335
wic  x_wic_28 (
  .awake_data       (awake_data[28]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[28]     ),
  .int_exit         (int_exit[28]    ),
  .int_pending      (int_pending[28] ),
  .int_vld          (int_vld[28]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[28] ),
  .wic_awake_en     (wic_awake_en[28]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[28]          ), @336
//           .int_vld         (int_vld[28]             ),        @337
//           .int_cfg         (int_cfg[28]             ),        @338
//           .int_exit        (int_exit[28]            ), @339
//           .int_pending     (int_pending[28]         ), @340
//           .pending_clr     (pending_clr[28]         ), @341
//           .pending_set     (pending_set[28]         ), @342
//           .wic_awake_en    (wic_awake_en[28]        ) @343
//          ); @344

// &Instance("wic", "x_wic_29"); @346
wic  x_wic_29 (
  .awake_data       (awake_data[29]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[29]     ),
  .int_exit         (int_exit[29]    ),
  .int_pending      (int_pending[29] ),
  .int_vld          (int_vld[29]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[29] ),
  .wic_awake_en     (wic_awake_en[29]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[29]          ), @347
//           .int_vld         (int_vld[29]             ),        @348
//           .int_cfg         (int_cfg[29]             ),        @349
//           .int_exit        (int_exit[29]            ), @350
//           .int_pending     (int_pending[29]         ), @351
//           .pending_clr     (pending_clr[29]         ), @352
//           .pending_set     (pending_set[29]         ), @353
//           .wic_awake_en    (wic_awake_en[29]        ) @354
//          ); @355

// &Instance("wic", "x_wic_30"); @357
wic  x_wic_30 (
  .awake_data       (awake_data[30]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[30]     ),
  .int_exit         (int_exit[30]    ),
  .int_pending      (int_pending[30] ),
  .int_vld          (int_vld[30]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[30] ),
  .wic_awake_en     (wic_awake_en[30]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[30]          ), @358
//           .int_vld         (int_vld[30]             ),        @359
//           .int_cfg         (int_cfg[30]             ),        @360
//           .int_exit        (int_exit[30]            ), @361
//           .int_pending     (int_pending[30]         ), @362
//           .pending_clr     (pending_clr[30]         ), @363
//           .pending_set     (pending_set[30]         ), @364
//           .wic_awake_en    (wic_awake_en[30]        ) @365
//          ); @366

// &Instance("wic", "x_wic_31"); @368
wic  x_wic_31 (
  .awake_data       (awake_data[31]  ),
  .awake_disable    (awake_disable   ),
  .awake_enable     (awake_enable    ),
  .int_cfg          (int_cfg[31]     ),
  .int_exit         (int_exit[31]    ),
  .int_pending      (int_pending[31] ),
  .int_vld          (int_vld[31]     ),
  .pad_cpu_rst_b    (pad_cpu_rst_b   ),
  .pending_clr      (pending_clr[31] ),
  .wic_awake_en     (wic_awake_en[31]),
  .wic_clk          (wic_clk         )
);

// &Connect (.awake_data      (awake_data[31]          ), @369
//           .int_vld         (int_vld[31]             ),        @370
//           .int_cfg         (int_cfg[31]             ),        @371
//           .int_exit        (int_exit[31]            ), @372
//           .int_pending     (int_pending[31]         ), @373
//           .pending_clr     (pending_clr[31]         ), @374
//           .pending_set     (pending_set[31]         ), @375
//           .wic_awake_en    (wic_awake_en[31]        ) @376
//          ); @377

// &ModuleEnd; @379
endmodule


