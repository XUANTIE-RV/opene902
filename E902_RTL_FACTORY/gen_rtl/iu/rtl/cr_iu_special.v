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

// &ModuleBeg; @25
module cr_iu_special(
  cp0_iu_cache_inv_done,
  ctrl_special_ex_data_sel,
  ctrl_special_ex_sel,
  ctrl_special_expt_vec,
  ctrl_special_expt_vld,
  decd_special_fencei,
  decd_special_icall,
  decd_special_icpa,
  special_ctrl_stall,
  special_ctrl_stall_noinput,
  special_pcgen_chgflw_vld,
  special_rbus_expt_vec,
  special_rbus_expt_vld,
  special_rbus_flush,
  special_rbus_req,
  special_retire_inst_wsc,
  wb_special_st_uncmplt
);

// &Ports; @26
input          cp0_iu_cache_inv_done;     
input          ctrl_special_ex_data_sel;  
input          ctrl_special_ex_sel;       
input   [4:0]  ctrl_special_expt_vec;     
input          ctrl_special_expt_vld;     
input          decd_special_fencei;       
input          decd_special_icall;        
input          decd_special_icpa;         
input          wb_special_st_uncmplt;     
output         special_ctrl_stall;        
output         special_ctrl_stall_noinput; 
output         special_pcgen_chgflw_vld;  
output  [4:0]  special_rbus_expt_vec;     
output         special_rbus_expt_vld;     
output         special_rbus_flush;        
output         special_rbus_req;          
output         special_retire_inst_wsc;   

// &Regs; @27

// &Wires; @28
wire           cp0_iu_cache_inv_done;     
wire           ctrl_special_ex_data_sel;  
wire           ctrl_special_ex_sel;       
wire    [4:0]  ctrl_special_expt_vec;     
wire           ctrl_special_expt_vld;     
wire           decd_special_fencei;       
wire           decd_special_icall;        
wire           decd_special_icpa;         
wire           special_cmplt;             
wire           special_ctrl_stall;        
wire           special_ctrl_stall_noinput; 
wire           special_pcgen_chgflw_vld;  
wire    [4:0]  special_rbus_expt_vec;     
wire           special_rbus_expt_vld;     
wire           special_rbus_flush;        
wire           special_rbus_req;          
wire           special_retire_inst_wsc;   
wire           special_stall;             
wire           wb_special_st_uncmplt;     


//==============================================================================
// SEPCIAL result request
//==============================================================================
// fencei judge
assign special_stall = (decd_special_fencei || decd_special_icall
                    || decd_special_icpa)
                    && (wb_special_st_uncmplt || !cp0_iu_cache_inv_done);
assign special_cmplt  = (decd_special_fencei || decd_special_icall
                    || decd_special_icpa)
                    && !wb_special_st_uncmplt
                    && cp0_iu_cache_inv_done;

//result bus request
assign special_rbus_req         = ctrl_special_ex_sel && !special_stall;
assign special_rbus_flush       = ctrl_special_ex_sel && special_cmplt;
assign special_pcgen_chgflw_vld = ctrl_special_ex_sel && special_cmplt;
//data and data valid : special does not write back

//exception valid and vector
assign special_rbus_expt_vld      = ctrl_special_ex_sel && ctrl_special_expt_vld;
assign special_rbus_expt_vec[4:0] = ctrl_special_expt_vec[4:0];

assign special_ctrl_stall = ctrl_special_ex_data_sel && special_stall;
assign special_ctrl_stall_noinput = ctrl_special_ex_data_sel 
                         && (decd_special_fencei || decd_special_icall
                         || decd_special_icpa);

assign special_retire_inst_wsc = 1'b0;

// &ModuleEnd; @68
endmodule


