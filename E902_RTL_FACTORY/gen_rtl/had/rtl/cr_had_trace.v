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
module cr_had_trace(
  had_core_dbg_mode_req,
  iu_had_xx_mldst,
  iu_had_xx_retire,
  iu_had_xx_retire_normal,
  iu_yy_xx_dbgon,
  regs_trace_en,
  trace_ctrl_req,
  trace_ctrl_req_for_dbg_disable
);

// &Ports; @24
input        had_core_dbg_mode_req;         
input        iu_had_xx_mldst;               
input        iu_had_xx_retire;              
input        iu_had_xx_retire_normal;       
input        iu_yy_xx_dbgon;                
input        regs_trace_en;                 
output       trace_ctrl_req;                
output       trace_ctrl_req_for_dbg_disable; 

// &Regs; @25

// &Wires; @26
wire         had_core_dbg_mode_req;         
wire         iu_had_xx_mldst;               
wire         iu_had_xx_retire;              
wire         iu_had_xx_retire_normal;       
wire         iu_yy_xx_dbgon;                
wire         regs_trace_en;                 
wire         trace_counter_eq_0;            
wire         trace_ctrl_req;                
wire         trace_ctrl_req_for_dbg_disable; 
wire         trace_en;                      
wire         trace_vld;                     


//==============================================================================
// trace valid conditions(AND):
// 1. retire normally, without exception.
// 2. not a lls instruction or the last of the lls instruction.
// 3. not in debug mode.
// 4. trace mode enable.
// The last condition is designed for low power.
//==============================================================================

assign trace_en  = !iu_yy_xx_dbgon
                && regs_trace_en
                && !had_core_dbg_mode_req;

assign trace_vld =    iu_had_xx_retire
                  && !iu_had_xx_mldst
                  && trace_en;
//==============================================================================
// trace counter decrease condition (AND):
// 1. trace valid
// 2. trace counter dosen't equal to zero.
//==============================================================================

//assign trace_counter_dec = (trace_vld || iu_had_expt_during_split && trace_en)
//                           && !trace_counter_eq_0;

//==============================================================================
// trace counter logic
//==============================================================================

// //&Force("bus", "regs_xx_wdata", 31, 0); @57
//
//always @(posedge cpuclk)
//begin
//  if (regs_trace_cnt_sel)
//    trace_counter[7:0] <= regs_xx_wdata[7:0];
//  else if (trace_counter_dec)
//    trace_counter[7:0] <= trace_counter[7:0] - 1'b1;
//  else
//    trace_counter[7:0] <= trace_counter[7:0];
//end                           

//==============================================================================
// trace counter to regs
//==============================================================================

//assign trace_regs_counter[7:0] = trace_counter[7:0];

//==============================================================================
// trace counter equals to zero
//==============================================================================

//assign trace_counter_eq_0 = (trace_counter[7:0] == 8'b0);

assign trace_counter_eq_0 = 1'b1;

//==============================================================================
// trace request to HAD control path conditions (AND):
// 1. trace_vld
// 2. trace counter equals to zero.
//==============================================================================

assign trace_ctrl_req = trace_vld && trace_counter_eq_0
                        && iu_had_xx_retire_normal;

assign trace_ctrl_req_for_dbg_disable = 1'b0;


// &ModuleEnd; @99
endmodule



