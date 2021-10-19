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
module cr_had_bkpt(
  bkpt_ctrl_inst_fetch_dbq_req,
  bkpt_ctrl_req,
  cpuclk,
  had_core_dbg_mode_req,
  hadrst_b,
  ifu_had_chg_flw_inst,
  ifu_had_fetch_expt_vld,
  ifu_had_inst_dbg_disable,
  ifu_had_match_pc,
  ifu_had_split_first,
  iu_had_expt_vld,
  iu_had_flush,
  iu_had_xx_mldst,
  iu_had_xx_retire,
  iu_had_xx_retire_normal,
  iu_yy_xx_dbgon,
  lsu_had_addr,
  lsu_had_addr_vld,
  lsu_had_ex_cmplt,
  lsu_had_st,
  regs_bkpt_base,
  regs_bkpt_ctrl,
  regs_bkpt_mask
);

// &Ports; @24
input           cpuclk;                      
input           had_core_dbg_mode_req;       
input           hadrst_b;                    
input           ifu_had_chg_flw_inst;        
input           ifu_had_fetch_expt_vld;      
input           ifu_had_inst_dbg_disable;    
input   [31:0]  ifu_had_match_pc;            
input           ifu_had_split_first;         
input           iu_had_expt_vld;             
input           iu_had_flush;                
input           iu_had_xx_mldst;             
input           iu_had_xx_retire;            
input           iu_had_xx_retire_normal;     
input           iu_yy_xx_dbgon;              
input   [31:0]  lsu_had_addr;                
input           lsu_had_addr_vld;            
input           lsu_had_ex_cmplt;            
input           lsu_had_st;                  
input   [31:0]  regs_bkpt_base;              
input   [2 :0]  regs_bkpt_ctrl;              
input   [7 :0]  regs_bkpt_mask;              
output          bkpt_ctrl_inst_fetch_dbq_req; 
output          bkpt_ctrl_req;               

// &Regs; @25
reg             bkpt_counter;                
reg             data_bkpt_vld_pre;           
reg             inst_fetch_bkpt_vld;         
reg             lsu_had_addr_vld_latch;      

// &Wires; @26
wire            bkpt_ctrl_inst_fetch_dbq_req; 
wire            bkpt_ctrl_req;               
wire            bkpt_en;                     
wire            bkpt_expt_reset;             
wire            counter_neg_dbg_req;         
wire            cpuclk;                      
wire            data_addr_match;             
wire            data_bkpt_dbg_req;           
wire            data_bkpt_match;             
wire            data_bkpt_match_vld;         
wire            data_bkpt_occur;             
wire            data_bkpt_vld;               
wire            had_core_dbg_mode_req;       
wire            hadrst_b;                    
wire            ifu_had_chg_flw_inst;        
wire            ifu_had_fetch_expt_vld;      
wire            ifu_had_inst_dbg_disable;    
wire    [31:0]  ifu_had_match_pc;            
wire            ifu_had_split_first;         
wire            inst_fetch_addr_match;       
wire            inst_fetch_bkpt_hit;         
wire            iu_had_expt_vld;             
wire            iu_had_flush;                
wire            iu_had_xx_mldst;             
wire            iu_had_xx_retire;            
wire            iu_had_xx_retire_normal;     
wire            iu_yy_xx_dbgon;              
wire    [31:0]  lsu_had_addr;                
wire            lsu_had_addr_vld;            
wire            lsu_had_ex_cmplt;            
wire            lsu_had_st;                  
wire    [31:0]  regs_bkpt_base;              
wire    [2 :0]  regs_bkpt_ctrl;              
wire    [7 :0]  regs_bkpt_mask;              


//==============================================================================
// memory bkpt enable condition (AND):
// 1. BC bits in HCR doesn't forbid memory bkpt;
// 2. CPUSCR CSR FDB bit is set.
//==============================================================================

assign bkpt_en = |regs_bkpt_ctrl[2:0];

//==============================================================================
// data bkpt occur condition (AND):
// 1. data address match
// 2. address from LSU is valid
//==============================================================================

assign data_addr_match = ((lsu_had_addr[31:0] & {24'hFF_FFFF,regs_bkpt_mask[7:0]})
                           == regs_bkpt_base[31:0]);

assign data_bkpt_match     = data_addr_match;
assign data_bkpt_match_vld = data_bkpt_match && lsu_had_addr_vld;

//when fast retire, data_bkpt_match_vld is 1'b1 when retire
//when no fast retire, the data_bkpt_match_vld is latched
assign data_bkpt_occur = (data_bkpt_match_vld || lsu_had_addr_vld_latch) &&
                         iu_had_xx_retire;

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    lsu_had_addr_vld_latch <= 1'b0;
  else if (lsu_had_ex_cmplt || iu_had_flush)
    lsu_had_addr_vld_latch <= 1'b0;
  else if (data_bkpt_match_vld)
    lsu_had_addr_vld_latch <= 1'b1;
  else
    lsu_had_addr_vld_latch <= lsu_had_addr_vld_latch;
end


//==============================================================================
// inst bkpt occur condition (AND):
// 1. inst retire address match
// 2. memory bkpt is enabled;
// 3. the current instruction in EX stage is retiring normally.
//==============================================================================

//assign inst_addr_match = ((iu_had_match_pc[31:0] & {24'hFF_FFFF, regs_bkpt_mask[7:0]})
//                             == regs_bkpt_base[31:0]);

//the inst bkpt hit and dbq req is judged in IF stage
assign inst_fetch_addr_match = ((ifu_had_match_pc[31:0]
                                 & {24'hFF_FFFF, regs_bkpt_mask[7:0]}
                                ) == regs_bkpt_base[31:0]
                               ); 

assign inst_fetch_bkpt_hit = inst_fetch_addr_match
                             && bkpt_en
                             && ifu_had_split_first
                             && !had_core_dbg_mode_req;

//assign had_ifu_inst_bkpt_hit_vld = inst_fetch_bkpt_vld
//                                   && !bkpt_counter_req_en;
//
////when inst bkpt hit and the counter is certain value, the bkpt will be
////triggled
//assign bkpt_ctrl_inst_fetch_dbq_req = inst_fetch_bkpt_vld
//                                      && bkpt_counter_req_en
//                                      && !ifu_had_fetch_expt_vld
//                                      && !ifu_had_inst_dbg_disable
//                                      && !iu_yy_xx_dbgon;
//
//assign bkpt_counter_req_en = bkpt_counter_eq_0
//                          || bkpt_counter_eq_1 && bkpt_counter_dec_1
//                          || bkpt_counter_eq_2 && bkpt_counter_dec_2;
//
//
////the inst bkpt counter dec is judged when inst retire
////when iu_had_inst_bkpt_hit is asserted, it means no inst fetch expt and no
////mldst inst, and the fetch addr in IF hit bkpt
//assign inst_addr_match = iu_had_inst_bkpt_hit; 
//
//assign inst_bkpt_occur = inst_addr_match
//                         && iu_had_xx_retire;
////==============================================================================
//// memory bkpt is controlled by BC bits in access property
////==============================================================================
////the inst bkpt is judge in IF, and when the inst is retired, the only job is 
////reduce the counter
//assign inst_bkpt_vld = inst_bkpt_occur;

// &CombBeg; @117
always @( regs_bkpt_ctrl[2:0]
       or ifu_had_chg_flw_inst
       or inst_fetch_bkpt_hit
       or data_bkpt_occur
       or lsu_had_st)
begin
  inst_fetch_bkpt_vld = 1'b0;
  data_bkpt_vld_pre = 1'b0;
  case (regs_bkpt_ctrl[2:0])
    3'b001: begin     // any access may cause bkpt
      inst_fetch_bkpt_vld = inst_fetch_bkpt_hit;
      data_bkpt_vld_pre = data_bkpt_occur;
    end
    3'b010:           // any instruction access may cause bkpt
      inst_fetch_bkpt_vld = inst_fetch_bkpt_hit;
    3'b011:           // any data access may cause bkpt
      data_bkpt_vld_pre = data_bkpt_occur;
    3'b100:           // any change flow instruction may casue bkpt 
      inst_fetch_bkpt_vld = inst_fetch_bkpt_hit && ifu_had_chg_flw_inst;
    3'b101:           // any store data access may cause bkpt
      data_bkpt_vld_pre = data_bkpt_occur && lsu_had_st;
    3'b110:           // any load data access may cause bkpt
      data_bkpt_vld_pre = data_bkpt_occur && !lsu_had_st;
    default: begin
      inst_fetch_bkpt_vld = 1'b0;
      data_bkpt_vld_pre = 1'b0;
    end
  endcase
// &CombEnd; @140
end

assign data_bkpt_vld = bkpt_en && data_bkpt_vld_pre;
assign bkpt_ctrl_inst_fetch_dbq_req = inst_fetch_bkpt_vld
                                  && !ifu_had_fetch_expt_vld
                                  && !ifu_had_inst_dbg_disable
                                  && !iu_yy_xx_dbgon;

assign bkpt_expt_reset = iu_had_expt_vld;
 
//the counter to record the bkpt hit when split
always @(posedge cpuclk or negedge hadrst_b)
begin
  if(!hadrst_b)
    bkpt_counter <= 1'b0;
  else if (bkpt_ctrl_req || bkpt_expt_reset)
    bkpt_counter <= 1'b0;
  else if (!bkpt_counter && data_bkpt_vld && iu_had_xx_mldst)
    bkpt_counter <= 1'b1;
  else
    bkpt_counter <= bkpt_counter;
end

assign data_bkpt_dbg_req   = !bkpt_counter && data_bkpt_vld && !iu_had_xx_mldst;

assign counter_neg_dbg_req = bkpt_counter  && !iu_had_xx_mldst
                          && iu_had_xx_retire;

// &Force("output","bkpt_ctrl_req"); @168
assign bkpt_ctrl_req =   (data_bkpt_dbg_req || counter_neg_dbg_req)
                      && !iu_yy_xx_dbgon
                      && bkpt_en
                      && iu_had_xx_retire_normal;

// &ModuleEnd; @174
endmodule



