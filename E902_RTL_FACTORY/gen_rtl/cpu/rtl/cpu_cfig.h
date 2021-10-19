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
`define PRODUCT_ID 12'h000




`define RESET_VAL 16'hABCD




`define REVISION    4'd2
`define SUB_VERSION 6'd2
`define PATCH       6'd2




`define FPGA_MEM














































`define USER_MODE
`ifdef USER_MODE
  //`define MACHINE_SP
`endif




`define CLIC_MODE
















`define GPR_16









`define VEC_BASE





`define LOAD_FAST_RETIRE













`define MAD_SMALL



















`define IAHB_LITE


`ifdef IAHB_LITE
  //`define FLOP_OUT_IBUS
  //`define IBUS_16
  `define IBUS_32
`endif






`define SYS_AHB_LITE






`define BIU_32




`ifdef FLOP_OUT_BIU
`define FLOP_OUT_BUS
`else
  `ifdef FLOP_OUT_IBUS
  `define FLOP_OUT_BUS
  `else
    `ifdef FLOP_OUT_DBUS
    `define FLOP_OUT_BUS
    `else
    `endif
  `endif
`endif








`define PMP

`ifdef PMP
  //`define PMP_REGION_2
  //`define PMP_REGION_4
  `define PMP_REGION_8
  //`define PMP_REGION_16
`endif

`ifdef PMP_REGION_2
  `define REGION_ENTRY0
  `define REGION_ENTRY1
`endif

`ifdef PMP_REGION_4
  `define REGION_ENTRY0
  `define REGION_ENTRY1
  `define REGION_ENTRY2
  `define REGION_ENTRY3
`endif

`ifdef PMP_REGION_8
  `define REGION_ENTRY0
  `define REGION_ENTRY1
  `define REGION_ENTRY2
  `define REGION_ENTRY3
  `define REGION_ENTRY4
  `define REGION_ENTRY5
  `define REGION_ENTRY6
  `define REGION_ENTRY7
`endif

`ifdef PMP_REGION_16
  `define REGION_ENTRY0
  `define REGION_ENTRY1
  `define REGION_ENTRY2
  `define REGION_ENTRY3
  `define REGION_ENTRY4
  `define REGION_ENTRY5
  `define REGION_ENTRY6
  `define REGION_ENTRY7
  `define REGION_ENTRY8
  `define REGION_ENTRY9
  `define REGION_ENTRY10
  `define REGION_ENTRY11
  `define REGION_ENTRY12
  `define REGION_ENTRY13
  `define REGION_ENTRY14
  `define REGION_ENTRY15
`endif
















`define TCIPIF

`ifdef TCIPIF


  //`define CTIM     // Core Timer Hareware Implementation
  `ifdef CLIC_MODE
    `define CLIC      // Interrupt controller Configuration
  `endif

`endif

`ifdef CLIC
  // Attention:
  //   1. EXT_INT_NUM *MUST* > 0.
  //   2. If you don't want to use extensional clic int, use //`define EXT_INT_NUM rather than change EXT_INT_NUM to 0.
  //   3. If EXT_INT_NUM > 48, you need define CLIC_2_CYCLES unless the timing is loose.
  //   4. Don't change definition of CLIC_INTNUM.

  `define CLIC_INTCTLBITS      3
  `define EXT_INT_NUM          64

  `ifdef EXT_INT_NUM
    `define CLIC_INTNUM   `EXT_INT_NUM+16
  `else
    `define CLIC_INTNUM   16
    `define INT_NUM_16
  `endif
`endif






















`ifdef CACHE
  `define CACHE_2K
  //`define CACHE_4K
  //`define CACHE_8K
`endif

`ifdef CACHE
  `define CACHE_2WAY
  //`define CACHE_4WAY
`endif

`ifdef CACHE
  `define CACHE_LINE_16B
  //`define CACHE_LINE_32B
`endif

`ifdef CACHE
  //`define CACHE_REGION_1
  `define CACHE_REGION_2
  //`define CACHE_REGION_3
  //`define CACHE_REGION_4
`endif

`ifdef CACHE_REGION_4
  `define REGION_REG3
  `define REGION_REG2
  `define REGION_REG1
  `define REGION_REG0
`endif

`ifdef CACHE_REGION_3
  `define REGION_REG2
  `define REGION_REG1
  `define REGION_REG0
`endif

`ifdef CACHE_REGION_2
  `define REGION_REG1
  `define REGION_REG0
`endif

`ifdef CACHE_REGION_1
  `define REGION_REG0
`endif

`ifdef CACHE
  //`define CACHE_USER_DEFINED
`endif

`ifdef CACHE
  //`define CACHE_MBIST
`endif

`ifdef CACHE
  //`define CACHE_LFIDLE_REQ
`endif















`define HAD_IM

`ifdef HAD_IM
  //`define PCFIFO_FOR_DBG
  `define HAD_JTAG_2
  `define HAD_MBKPTB //now, MBKPTB indicates five breakpoints: A, B, C, D, E
  `ifdef HAD_MBKPTB
    //`define HAD_MBKPT_7 //indicates other four breakpoints: F, G
    //`define HAD_MBKPT_9 //indicates other four breakpoints: F, G, H, I
  `endif
  //`define HAD_INST_DEBUG_DISABLE
  //`define HAD_PROF_CNT
  //`define DDMA //debug direct memory access
  `ifdef TCIPIF
    //`define DBG_EXP // debug exception
    `define CSKY_DCC
  `endif
`endif


`define NO_PRE_DECODE
