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
module cr_ifu_ifctrl(
  cpuclk,
  cpurst_b,
  had_ifu_ir_vld,
  ibuf_ifctrl_inst32_low,
  ibuf_ifctrl_inst_vld,
  ibuf_ifctrl_pop0_mad32_low,
  ibuf_ifdp_inst_dbg_disable,
  ibuf_xx_empty,
  ibusif_ifctrl_inst_mad32_high,
  ibusif_ifctrl_inst_no_bypass,
  ibusif_xx_16bit_inst,
  ibusif_xx_trans_cmplt,
  ibusif_xx_unalign_fetch,
  ifctrl_ibuf_bypass_vld,
  ifctrl_ibuf_inst_pipe_down,
  ifctrl_ibuf_pop_en,
  ifctrl_xx_ifcancel,
  ifu_iu_ex_inst_vld,
  ifu_iu_inst_buf_inst_dbg_disable,
  ifu_iu_inst_buf_inst_vld,
  iu_ifu_ex_stall,
  iu_ifu_inst_fetch,
  iu_ifu_inst_fetch_without_dbg_disable,
  iu_ifu_wb_stall,
  iu_yy_xx_dbgon,
  iu_yy_xx_flush,
  split_ifctrl_hs_stall,
  split_ifctrl_hs_stall_part
);

// &Ports; @24
input        cpuclk;                               
input        cpurst_b;                             
input        had_ifu_ir_vld;                       
input        ibuf_ifctrl_inst32_low;               
input        ibuf_ifctrl_inst_vld;                 
input        ibuf_ifctrl_pop0_mad32_low;           
input        ibuf_ifdp_inst_dbg_disable;           
input        ibuf_xx_empty;                        
input        ibusif_ifctrl_inst_mad32_high;        
input        ibusif_ifctrl_inst_no_bypass;         
input        ibusif_xx_16bit_inst;                 
input        ibusif_xx_trans_cmplt;                
input        ibusif_xx_unalign_fetch;              
input        iu_ifu_ex_stall;                      
input        iu_ifu_inst_fetch;                    
input        iu_ifu_inst_fetch_without_dbg_disable; 
input        iu_ifu_wb_stall;                      
input        iu_yy_xx_dbgon;                       
input        iu_yy_xx_flush;                       
input        split_ifctrl_hs_stall;                
input        split_ifctrl_hs_stall_part;           
output       ifctrl_ibuf_bypass_vld;               
output       ifctrl_ibuf_inst_pipe_down;           
output       ifctrl_ibuf_pop_en;                   
output       ifctrl_xx_ifcancel;                   
output       ifu_iu_ex_inst_vld;                   
output       ifu_iu_inst_buf_inst_dbg_disable;     
output       ifu_iu_inst_buf_inst_vld;             

// &Regs; @25
reg          ex_inst_vld;                          

// &Wires; @26
wire         cpuclk;                               
wire         cpurst_b;                             
wire         had_ifu_ir_vld;                       
wire         ibuf_bypass_vld;                      
wire         ibuf_ifctrl_inst32_low;               
wire         ibuf_ifctrl_inst_vld;                 
wire         ibuf_ifctrl_pop0_mad32_low;           
wire         ibuf_ifdp_inst_dbg_disable;           
wire         ibuf_inst_vld;                        
wire         ibuf_pop_en;                          
wire         ibuf_xx_empty;                        
wire         ibus_bypass_inst_vld;                 
wire         ibusif_ifctrl_inst_mad32_high;        
wire         ibusif_ifctrl_inst_no_bypass;         
wire         ibusif_xx_16bit_inst;                 
wire         ibusif_xx_trans_cmplt;                
wire         ibusif_xx_unalign_fetch;              
wire         if_cancel;                            
wire         if_cancel_for_pipeline;               
wire         if_inst_stall;                        
wire         if_inst_vld;                          
wire         if_inst_vld_for_ex;                   
wire         if_inst_vld_for_ex_aft_hs;            
wire         if_pipe_down;                         
wire         ifctrl_ibuf_bypass_vld;               
wire         ifctrl_ibuf_inst_pipe_down;           
wire         ifctrl_ibuf_pop_en;                   
wire         ifctrl_xx_ifcancel;                   
wire         ifu_iu_ex_inst_vld;                   
wire         ifu_iu_inst_buf_inst_dbg_disable;     
wire         ifu_iu_inst_buf_inst_vld;             
wire         inst_vld;                             
wire         iu_ifu_ex_stall;                      
wire         iu_ifu_inst_fetch;                    
wire         iu_ifu_inst_fetch_without_dbg_disable; 
wire         iu_ifu_wb_stall;                      
wire         iu_yy_xx_dbgon;                       
wire         iu_yy_xx_flush;                       
wire         random_inst_vld;                      
wire         split_ifctrl_hs_inst_vld;             
wire         split_ifctrl_hs_stall;                
wire         split_ifctrl_hs_stall_part;           
wire         split_ifctrl_mad_stall;               
wire         split_ifctrl_push_pop_stall;          


//==============================================================================
//                            Instruction Valid
//==============================================================================
assign ibuf_inst_vld = ibuf_ifctrl_inst_vld && !split_ifctrl_hs_stall;

//the inst of IF stage come from 3 sources, so the valid signal will condifer
//all these sources
assign inst_vld = ibuf_inst_vld || ibus_bypass_inst_vld
               || iu_yy_xx_dbgon && had_ifu_ir_vld;

//the bypass inst is valid when:
//1.the ibus trasacntion is completed
//2.ibuf is empty or only has one entry valid and it is high half of 32bit inst
//3.the ibus transaction is word algin
//4.the inst from ibus is not a split inst(mls or mad)
assign ibus_bypass_inst_vld = ibusif_xx_trans_cmplt &&
                              !split_ifctrl_hs_stall_part && 
//conditoin1: ibuf is empty, the inst from ibus
                              ( (ibuf_xx_empty &&
                                 (!ibusif_xx_unalign_fetch ||
                                  ibusif_xx_16bit_inst 
                                 ) &&
                                 !ibusif_ifctrl_inst_no_bypass
                                ) ||
//condition2: ibuf only have one entry valid and it is high half of 32-bit
//            inst, so half of the inst from ibuf and half of the inst from
//            ibus
                                (ibuf_ifctrl_inst32_low &&
                                 !(ibuf_ifctrl_pop0_mad32_low &&
                                   ibusif_ifctrl_inst_mad32_high
                                  )
                                )
                              );

//the inst at IF stage is only valid when no IF cancel signal is asserted
assign if_inst_vld = inst_vld && !if_cancel; 
                 
//the valid signal for ex is assert when no branch or jmp x1 stall asserted
assign if_inst_vld_for_ex = if_inst_vld && !if_inst_stall;

assign if_inst_stall = split_ifctrl_push_pop_stall ||
                       split_ifctrl_mad_stall;

//==============================================================================
//                            IF Cancel Signal
//==============================================================================
//IF stage will be cenceled when IU asserts the inst fetch signal or flush
// signal
assign if_cancel = iu_ifu_inst_fetch || iu_yy_xx_flush;

assign if_cancel_for_pipeline = iu_ifu_inst_fetch_without_dbg_disable 
                                && !split_ifctrl_hs_stall_part 
                             || iu_yy_xx_flush;


//==============================================================================
//                            IF Stage Pipe Down
//==============================================================================
//the inst at IF stage can only be piped down to EX when:
//1.the inst at IF is valid
//2.IU not stall
assign if_pipe_down = ex_inst_vld && !iu_ifu_ex_stall;

assign split_ifctrl_hs_inst_vld = 1'b0;
assign split_ifctrl_mad_stall = 1'b0;
assign split_ifctrl_push_pop_stall = 1'b0;
//assign if_pipe_down_for_hs = split_ifctrl_hs_inst_vld && !iu_ifu_ex_stall;

//==============================================================================
//                            Instruction Valid to EX Stage
//==============================================================================
assign if_inst_vld_for_ex_aft_hs = if_inst_vld_for_ex
                                || split_ifctrl_hs_inst_vld;
always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ex_inst_vld <= 1'b0;
  else if(if_cancel_for_pipeline)
    ex_inst_vld <= 1'b0;
  else if(!iu_ifu_ex_stall)
    ex_inst_vld <= if_inst_vld_for_ex_aft_hs;
end

assign ifu_iu_ex_inst_vld = ex_inst_vld;

assign ifu_iu_inst_buf_inst_vld = ibuf_inst_vld;
assign ifu_iu_inst_buf_inst_dbg_disable = ibuf_ifdp_inst_dbg_disable;


//==============================================================================
//                Control Signal of Inst Buf
//==============================================================================
//==========================================================
//                Bypass Signal if Ibuf
//==========================================================
//the inst buf will be bypassed when:
//1.the bypass inst is valid
//2.the IU not stall
//3.no random inst is valid
assign ibuf_bypass_vld = if_pipe_down &&
                         ibus_bypass_inst_vld &&
                         !random_inst_vld;

//==========================================================
//                Pop Enable of Ibuf
//==========================================================
assign ibuf_pop_en = if_pipe_down &&
                     !random_inst_vld;// &&
//                     !split_xx_stall;

//assign ibuf_inst_vld_after_cancel = ibuf_inst_vld && !if_cancel;


//==============================================================================
//                Interface to Other Module 
//==============================================================================
//==========================================================
//                Globle Signal
//==========================================================
assign random_inst_vld = 1'b0;
//assign ifctrl_xx_ifcancel = iu_yy_xx_flush || iu_ifu_inst_fetch_without_dbg_disable;
assign ifctrl_xx_ifcancel = iu_yy_xx_flush || iu_ifu_inst_fetch && !iu_ifu_wb_stall;
//assign ifctrl_xx_random_inst_vld = random_inst_vld;

//==========================================================
//                Interface to Ibuf
//==========================================================
//assign ibuf_empty = !ibuf_inst_vld;
assign ifctrl_ibuf_bypass_vld = ibuf_bypass_vld && 1'b0;
assign ifctrl_ibuf_inst_pipe_down = if_pipe_down && !random_inst_vld;
assign ifctrl_ibuf_pop_en = ibuf_pop_en;

//==========================================================
//                Interface to Split
//==========================================================
//the split inst can only come from ibuf
//assign ifctrl_split_inst_vld_no_cancel = ibuf_inst_vld 								
//                                      && !split_ifctrl_hs_stall;

//==========================================================
//                Interface to IF Data Path
//==========================================================
//assign ifctrl_ifdp_pipe_down = if_inst_vld_for_ex_aft_hs && !iu_ifu_ex_stall && !if_cancel_for_pipeline;
//assign ifctrl_ifdp_pipe_down_for_hs = if_pipe_down_for_hs;

// &ModuleEnd; @188
endmodule



