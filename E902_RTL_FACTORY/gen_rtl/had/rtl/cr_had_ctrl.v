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
module cr_had_ctrl(
  bkpta_ctrl_inst_fetch_dbq_req,
  bkpta_ctrl_req,
  bkptb_ctrl_inst_fetch_dbq_req,
  bkptb_ctrl_req,
  bkptc_ctrl_inst_fetch_dbq_req,
  bkptc_ctrl_req,
  bkptd_ctrl_inst_fetch_dbq_req,
  bkptd_ctrl_req,
  bkpte_ctrl_inst_fetch_dbq_req,
  bkpte_ctrl_req,
  cpuclk,
  ctrl_regs_exit_dbg,
  ctrl_regs_update_adro,
  ctrl_regs_update_dro,
  ctrl_regs_update_mbo,
  ctrl_regs_update_swo,
  ctrl_regs_update_to,
  had_ifu_inst_bkpt_dbq_req,
  had_ifu_inst_bkpt_dbqexp_req,
  had_iu_bkpt_trace_en,
  had_iu_dr_set_req,
  had_iu_mbkpt_fsm_index_mbee,
  had_iu_mem_bkpt_exp_req,
  had_iu_mem_bkpt_mask,
  had_iu_mem_bkpt_req,
  had_iu_trace_req,
  had_iu_trace_req_for_dbg_disable,
  had_iu_xx_jdbreq,
  had_yy_xx_dbg,
  had_yy_xx_dp_index_mbee,
  had_yy_xx_exit_dbg,
  hadrst_b,
  iu_had_adr_dbg_ack,
  iu_had_chgflw_dst_pc,
  iu_had_chgflw_vld,
  iu_had_data_bkpt_occur_vld,
  iu_had_dbg_disable_for_tee,
  iu_had_dr_dbg_ack,
  iu_had_inst_bkpt_occur_vld,
  iu_had_trace_occur_vld,
  iu_had_xx_bkpt_inst,
  iu_yy_xx_dbgon,
  jtag_xx_update_dr,
  pin_ctrl_jdb_req,
  regs_bkpta_bkpti_en,
  regs_ctrl_adr,
  regs_ctrl_dr,
  regs_ctrl_exit_sel,
  regs_ctrl_hacr_ex,
  regs_ctrl_hacr_go,
  regs_ctrl_had_int_on,
  regs_ctrl_mbee,
  regs_trace_en,
  sysio_had_sdb_req_b,
  trace_ctrl_req,
  trace_ctrl_req_for_dbg_disable
);

// &Ports; @21
input           bkpta_ctrl_inst_fetch_dbq_req;   
input           bkpta_ctrl_req;                  
input           bkptb_ctrl_inst_fetch_dbq_req;   
input           bkptb_ctrl_req;                  
input           bkptc_ctrl_inst_fetch_dbq_req;   
input           bkptc_ctrl_req;                  
input           bkptd_ctrl_inst_fetch_dbq_req;   
input           bkptd_ctrl_req;                  
input           bkpte_ctrl_inst_fetch_dbq_req;   
input           bkpte_ctrl_req;                  
input           cpuclk;                          
input           hadrst_b;                        
input           iu_had_adr_dbg_ack;              
input   [31:0]  iu_had_chgflw_dst_pc;            
input           iu_had_chgflw_vld;               
input           iu_had_data_bkpt_occur_vld;      
input           iu_had_dbg_disable_for_tee;      
input           iu_had_dr_dbg_ack;               
input           iu_had_inst_bkpt_occur_vld;      
input           iu_had_trace_occur_vld;          
input           iu_had_xx_bkpt_inst;             
input           iu_yy_xx_dbgon;                  
input           jtag_xx_update_dr;               
input           pin_ctrl_jdb_req;                
input           regs_bkpta_bkpti_en;             
input           regs_ctrl_adr;                   
input           regs_ctrl_dr;                    
input           regs_ctrl_exit_sel;              
input           regs_ctrl_hacr_ex;               
input           regs_ctrl_hacr_go;               
input           regs_ctrl_had_int_on;            
input   [8 :0]  regs_ctrl_mbee;                  
input           regs_trace_en;                   
input           sysio_had_sdb_req_b;             
input           trace_ctrl_req;                  
input           trace_ctrl_req_for_dbg_disable;  
output          ctrl_regs_exit_dbg;              
output          ctrl_regs_update_adro;           
output          ctrl_regs_update_dro;            
output          ctrl_regs_update_mbo;            
output          ctrl_regs_update_swo;            
output          ctrl_regs_update_to;             
output          had_ifu_inst_bkpt_dbq_req;       
output          had_ifu_inst_bkpt_dbqexp_req;    
output          had_iu_bkpt_trace_en;            
output          had_iu_dr_set_req;               
output          had_iu_mbkpt_fsm_index_mbee;     
output          had_iu_mem_bkpt_exp_req;         
output          had_iu_mem_bkpt_mask;            
output          had_iu_mem_bkpt_req;             
output          had_iu_trace_req;                
output          had_iu_trace_req_for_dbg_disable; 
output          had_iu_xx_jdbreq;                
output          had_yy_xx_dbg;                   
output          had_yy_xx_dp_index_mbee;         
output          had_yy_xx_exit_dbg;              

// &Regs; @22
reg             ctrl_exit_dbg;                   

// &Wires; @23
wire            adr_set_req;                     
wire            bkpta_ctrl_inst_fetch_dbq_req;   
wire            bkpta_ctrl_req;                  
wire            bkptb_ctrl_inst_fetch_dbq_req;   
wire            bkptb_ctrl_req;                  
wire            bkptc_ctrl_inst_fetch_dbq_req;   
wire            bkptc_ctrl_req;                  
wire            bkptd_ctrl_inst_fetch_dbq_req;   
wire            bkptd_ctrl_req;                  
wire            bkpte_ctrl_inst_fetch_dbq_req;   
wire            bkpte_ctrl_req;                  
wire            cpuclk;                          
wire            ctrl_regs_exit_dbg;              
wire            ctrl_regs_update_adro;           
wire            ctrl_regs_update_dro;            
wire            ctrl_regs_update_mbo;            
wire            ctrl_regs_update_swo;            
wire            ctrl_regs_update_to;             
wire            dr_set_req;                      
wire            exit_dbg;                        
wire            had_ifu_inst_bkpt_dbq_req;       
wire            had_ifu_inst_bkpt_dbqexp_req;    
wire            had_iu_bkpt_trace_en;            
wire            had_iu_dr_set_req;               
wire            had_iu_mbkpt_fsm_index_mbee;     
wire            had_iu_mem_bkpt_exp_req;         
wire            had_iu_mem_bkpt_mask;            
wire            had_iu_mem_bkpt_req;             
wire            had_iu_trace_req;                
wire            had_iu_trace_req_for_dbg_disable; 
wire            had_iu_xx_jdbreq;                
wire            had_yy_xx_dbg;                   
wire            had_yy_xx_dp_index_mbee;         
wire            had_yy_xx_exit_dbg;              
wire            hadrst_b;                        
wire            iu_had_adr_dbg_ack;              
wire            iu_had_data_bkpt_occur_vld;      
wire            iu_had_dbg_disable_for_tee;      
wire            iu_had_dr_dbg_ack;               
wire            iu_had_inst_bkpt_occur_vld;      
wire            iu_had_trace_occur_vld;          
wire            iu_had_xx_bkpt_inst;             
wire            iu_yy_xx_dbgon;                  
wire            jtag_xx_update_dr;               
wire            mem_bkpt_dbg_req;                
wire            mem_bkpt_dbgexp_req;             
wire            pin_ctrl_jdb_req;                
wire            regs_bkpta_bkpti_en;             
wire            regs_ctrl_adr;                   
wire            regs_ctrl_dr;                    
wire            regs_ctrl_exit_sel;              
wire            regs_ctrl_hacr_ex;               
wire            regs_ctrl_hacr_go;               
wire            regs_ctrl_had_int_on;            
wire    [8 :0]  regs_ctrl_mbee;                  
wire            regs_trace_en;                   
wire            sync_dbg_req;                    
wire            sysio_had_sdb_req_b;             
wire            trace_ctrl_req;                  
wire            trace_ctrl_req_for_dbg_disable;  
wire            trace_req;                       


//==============================================================================
// debug request to IU
//==============================================================================

//==========================================================
// Two major kinds of debug requests are sent to IU from HAD
// 1. had_iu_xx_jdbreq : asynchronous debug request
// 2. compulsive debug: DR
// 3. trace
// 4. memory bkpt
//==========================================================

// &Force("bus","regs_ctrl_mbee",8,0); @37
assign trace_req = trace_ctrl_req;

// &CombBeg; @83
// &CombEnd; @96
// &CombBeg; @100
// &CombEnd; @113
// &CombBeg; @117
// &CombEnd; @130
// &CombBeg; @171
// &CombEnd; @182
// &CombBeg; @186
// &CombEnd; @197
// &CombBeg; @201
// &CombEnd; @212
assign mem_bkpt_dbg_req    = (bkpta_ctrl_req && !regs_ctrl_mbee[0])
                          || (bkptb_ctrl_req && !regs_ctrl_mbee[1])
                          || (bkptc_ctrl_req && !regs_ctrl_mbee[2])
                          || (bkptd_ctrl_req && !regs_ctrl_mbee[3])
                          || (bkpte_ctrl_req && !regs_ctrl_mbee[4]);
assign mem_bkpt_dbgexp_req = (bkpta_ctrl_req &&  regs_ctrl_mbee[0])
                          || (bkptb_ctrl_req &&  regs_ctrl_mbee[1])
                          || (bkptc_ctrl_req &&  regs_ctrl_mbee[2])
                          || (bkptd_ctrl_req &&  regs_ctrl_mbee[3])
                          || (bkpte_ctrl_req &&  regs_ctrl_mbee[4]);
// &CombBeg; @244
// &CombEnd; @253
// &CombBeg; @257
// &CombEnd; @266
// &CombBeg; @270
// &CombEnd; @279

//the inst bkpt dbq req is judged in IF
// &Force("output","had_ifu_inst_bkpt_dbq_req"); @304
// &Force("output","had_ifu_inst_bkpt_dbqexp_req"); @305
assign had_ifu_inst_bkpt_dbq_req = ((bkpta_ctrl_inst_fetch_dbq_req
                                 && !regs_ctrl_mbee[0])
                                 || (bkptb_ctrl_inst_fetch_dbq_req
                                 && !regs_ctrl_mbee[1])
                                 || (bkptc_ctrl_inst_fetch_dbq_req
                                 && !regs_ctrl_mbee[2])
                                 || (bkptd_ctrl_inst_fetch_dbq_req
                                 && !regs_ctrl_mbee[3])
                                 || (bkpte_ctrl_inst_fetch_dbq_req
                                 && !regs_ctrl_mbee[4])
                                   ) && !regs_ctrl_had_int_on
                                     && !iu_had_dbg_disable_for_tee;

assign had_ifu_inst_bkpt_dbqexp_req = ((bkpta_ctrl_inst_fetch_dbq_req
                                    &&  regs_ctrl_mbee[0])
                                    || (bkptb_ctrl_inst_fetch_dbq_req
                                    &&  regs_ctrl_mbee[1])
                                    || (bkptc_ctrl_inst_fetch_dbq_req
                                    &&  regs_ctrl_mbee[2])
                                    || (bkptd_ctrl_inst_fetch_dbq_req
                                    &&  regs_ctrl_mbee[3])
                                    || (bkpte_ctrl_inst_fetch_dbq_req
                                    &&  regs_ctrl_mbee[4])
                                      ) && !regs_ctrl_had_int_on
                                        && !iu_had_dbg_disable_for_tee;


assign dr_set_req  = regs_ctrl_dr;

assign adr_set_req = regs_ctrl_adr;

assign sync_dbg_req = dr_set_req || !sysio_had_sdb_req_b;

assign had_iu_dr_set_req = sync_dbg_req && !iu_yy_xx_dbgon;

assign had_iu_trace_req = trace_req && !iu_yy_xx_dbgon;

assign had_iu_mem_bkpt_req = mem_bkpt_dbg_req && !iu_yy_xx_dbgon;

assign had_iu_mem_bkpt_mask = (mem_bkpt_dbg_req || mem_bkpt_dbgexp_req) && !iu_yy_xx_dbgon;

assign had_iu_mem_bkpt_exp_req = 1'b0;

assign had_iu_xx_jdbreq =  (pin_ctrl_jdb_req || adr_set_req) 
                        && !iu_yy_xx_dbgon;

//dbg diable for branch inst
assign had_iu_trace_req_for_dbg_disable = trace_ctrl_req_for_dbg_disable
                                       && !iu_yy_xx_dbgon;

//when trace and bkpt is enable, speculate stack for INT is disabled
assign had_iu_bkpt_trace_en = regs_bkpta_bkpti_en || regs_trace_en;

//==============================================================================
// debug request to CP0 to force CPU to exit low power mode 
// debug request to SYSIO to indicating CPU wake up ack 
// including sync and async dbg req ack
//==============================================================================

assign had_yy_xx_dbg = dr_set_req
                    || pin_ctrl_jdb_req
                    || adr_set_req;

//==============================================================================
// Update HCR
//==============================================================================

//==========================================================
// All the debug request will be acknowledged
//==========================================================

//======================================
// Update ADRO 
//======================================

assign ctrl_regs_update_adro = iu_had_adr_dbg_ack;

//======================================
// Update DRO 
//======================================

assign ctrl_regs_update_dro = iu_had_dr_dbg_ack;

//======================================
// Update MBO 
//======================================

assign ctrl_regs_update_mbo = iu_had_data_bkpt_occur_vld 
                           || iu_had_inst_bkpt_occur_vld;

//======================================
// Update SWO 
//======================================

assign ctrl_regs_update_swo = iu_had_xx_bkpt_inst;

//======================================
// Update TO 
//======================================

assign ctrl_regs_update_to = iu_had_trace_occur_vld;


//==============================================================================
// Exit debug mode 
//==============================================================================

//assign exit_dbg = (ir_ctrl_ex && ir_ctrl_go) && sm_ctrl_exit && iu_yy_xx_dbgon;
assign exit_dbg = (regs_ctrl_hacr_ex && regs_ctrl_hacr_go) &&
                  jtag_xx_update_dr && regs_ctrl_exit_sel  &&
                  iu_yy_xx_dbgon;
// exit_dbg is a pulse signal, flop one cylce to generate exit debug signal
always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    ctrl_exit_dbg <= 1'b0;
  else 
    ctrl_exit_dbg <= exit_dbg;
end

assign ctrl_regs_exit_dbg = ctrl_exit_dbg;

assign had_yy_xx_exit_dbg = ctrl_exit_dbg;

//================================================
// Go in debug mode
//================================================
//assign ctrl_regs_go_noex = !ir_ctrl_ex && ir_ctrl_go;

//   &CombBeg; @535
//   &CombEnd; @548
  assign had_iu_mbkpt_fsm_index_mbee = 1'b0;

// &CombBeg; @558
// &CombEnd; @571
assign had_yy_xx_dp_index_mbee = 1'b0;



//==========================================================
//               pcfifo enable only for debug(not verified)
//==========================================================

// pcfifo write enable contains three conditions:
//   1. pcfifo not frozen
//   2. change flow inst retire normally
//   3. not in debug mode

//assign ctrl_pcfifo_wen = !regs_ctrl_pcfifo_frozen && !inst_bkpt_req &&
//                         rtu_had_chg_flw_inst && rtu_yy_xx_retire &&
//			 cp0_had_pcfifo_wen &&
//                         !rtu_yy_xx_dbgon;
// &Force("input","iu_had_chgflw_vld"); @622
// &Force("input","iu_had_chgflw_dst_pc"); @623
// &Force("bus","iu_had_chgflw_dst_pc",31,0); @624
// &ModuleEnd; @626
endmodule



