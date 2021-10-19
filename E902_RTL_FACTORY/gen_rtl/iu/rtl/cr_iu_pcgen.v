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

// &ModuleBeg; @26
module cr_iu_pcgen(
  branch_pcgen_add_pc,
  branch_pcgen_br_chgflw_vld,
  branch_pcgen_br_chgflw_vld_for_data,
  branch_pcgen_br_pc_chgflw_vld,
  branch_pcgen_branch_chgflw_vld_for_data,
  branch_pcgen_jmp_chgflw_vld_for_data,
  branch_pcgen_reg_pc,
  cp0_iu_epc_for_chgflw,
  cp0_iu_flush_chgflw_vld,
  cp0_iu_rte_chgflw_vld,
  cp0_iu_rte_chgflw_vld_for_data,
  cp0_yy_clk_en,
  cpurst_b,
  forever_cpuclk,
  had_iu_pc,
  had_iu_rte_pc_sel,
  had_yy_xx_exit_dbg,
  hs_split_iu_unstack_chgflw,
  ifu_iu_ibus_idle,
  ifu_iu_spcu_retire_mask,
  ifu_iu_xx_ibus_data,
  iu_ifu_addr,
  iu_ifu_data_fetch,
  iu_ifu_data_fetch_for_data,
  iu_ifu_inst_fetch,
  iu_ifu_inst_fetch_for_data,
  iu_ifu_inst_fetch_without_dbg_disable,
  iu_yy_xx_flush,
  iu_yy_xx_retire,
  misc_clk,
  nie_flush_chgflw,
  pad_yy_gate_clk_en_b,
  pcgen_ctrl_stall,
  pcgen_retire_updt_pc,
  pcgen_top_abort_clk_en,
  pcgen_vector_expt_taken,
  pcgen_xx_cur_pc,
  pcgen_xx_ibus_idle,
  randclk_pcgen_mod_en_w32,
  retire_branch_stall,
  retire_pcgen_curpc_update,
  retire_xx_normal_retire,
  special_pcgen_chgflw_vld,
  sysio_iu_rst_addr,
  vector_pcgen_buf_vbr,
  vector_pcgen_chgflw_vld,
  vector_pcgen_cur_pc_vld,
  vector_pcgen_enter_addr,
  vector_pcgen_ibus_req,
  vector_pcgen_reset_vld,
  wb_pcgen_ldst_stall,
  wb_pcgen_pc_updt_val,
  wb_pcgen_switch_ld_pc,
  wb_retire_fast_retire_load_pc
);

// &Ports; @27
input   [30:0]  branch_pcgen_add_pc;                    
input           branch_pcgen_br_chgflw_vld;             
input           branch_pcgen_br_chgflw_vld_for_data;    
input           branch_pcgen_br_pc_chgflw_vld;          
input           branch_pcgen_branch_chgflw_vld_for_data; 
input           branch_pcgen_jmp_chgflw_vld_for_data;   
input   [30:0]  branch_pcgen_reg_pc;                    
input   [30:0]  cp0_iu_epc_for_chgflw;                  
input           cp0_iu_flush_chgflw_vld;                
input           cp0_iu_rte_chgflw_vld;                  
input           cp0_iu_rte_chgflw_vld_for_data;         
input           cp0_yy_clk_en;                          
input           cpurst_b;                               
input           forever_cpuclk;                         
input   [30:0]  had_iu_pc;                              
input           had_iu_rte_pc_sel;                      
input           had_yy_xx_exit_dbg;                     
input           hs_split_iu_unstack_chgflw;             
input           ifu_iu_ibus_idle;                       
input           ifu_iu_spcu_retire_mask;                
input   [31:0]  ifu_iu_xx_ibus_data;                    
input           iu_yy_xx_flush;                         
input           iu_yy_xx_retire;                        
input           misc_clk;                               
input           nie_flush_chgflw;                       
input           pad_yy_gate_clk_en_b;                   
input           randclk_pcgen_mod_en_w32;               
input           retire_branch_stall;                    
input           retire_pcgen_curpc_update;              
input           retire_xx_normal_retire;                
input           special_pcgen_chgflw_vld;               
input   [31:0]  sysio_iu_rst_addr;                      
input           vector_pcgen_buf_vbr;                   
input           vector_pcgen_chgflw_vld;                
input           vector_pcgen_cur_pc_vld;                
input   [30:0]  vector_pcgen_enter_addr;                
input           vector_pcgen_ibus_req;                  
input           vector_pcgen_reset_vld;                 
input           wb_pcgen_ldst_stall;                    
input   [30:0]  wb_pcgen_pc_updt_val;                   
input           wb_pcgen_switch_ld_pc;                  
input   [30:0]  wb_retire_fast_retire_load_pc;          
output  [30:0]  iu_ifu_addr;                            
output          iu_ifu_data_fetch;                      
output          iu_ifu_data_fetch_for_data;             
output          iu_ifu_inst_fetch;                      
output          iu_ifu_inst_fetch_for_data;             
output          iu_ifu_inst_fetch_without_dbg_disable;  
output          pcgen_ctrl_stall;                       
output  [30:0]  pcgen_retire_updt_pc;                   
output          pcgen_top_abort_clk_en;                 
output          pcgen_vector_expt_taken;                
output  [30:0]  pcgen_xx_cur_pc;                        
output          pcgen_xx_ibus_idle;                     

// &Regs; @28
reg             cur_state;                              
reg             fetch_cur_state;                        
reg             fetch_next_state;                       
reg             next_state;                             
reg     [30:0]  pcgen_cur_pc;                           

// &Wires; @29
wire    [30:0]  bctm_pcgen_chgflw_pc;                   
wire            bctm_pcgen_chk_chgflw_vld;              
wire            bctm_pcgen_chk_fail_pc_vld;             
wire            bctm_pcgen_jmp_chgflw_vld;              
wire            bctm_pcgen_jmp_chgflw_vld_for_data;     
wire    [30:0]  branch_pcgen_add_pc;                    
wire            branch_pcgen_br_chgflw_vld;             
wire            branch_pcgen_br_chgflw_vld_for_data;    
wire            branch_pcgen_br_pc_chgflw_vld;          
wire            branch_pcgen_branch_chgflw_vld_for_data; 
wire            branch_pcgen_jmp_chgflw_vld_for_data;   
wire    [30:0]  branch_pcgen_reg_pc;                    
wire    [30:0]  cp0_iu_epc_for_chgflw;                  
wire            cp0_iu_flush_chgflw_vld;                
wire            cp0_iu_rte_chgflw_vld;                  
wire            cp0_iu_rte_chgflw_vld_for_data;         
wire            cp0_yy_clk_en;                          
wire            cpurst_b;                               
wire            curpc_10_0_clk;                         
wire            curpc_10_0_clk_en;                      
wire            curpc_30_11_clk;                        
wire            curpc_30_11_clk_en;                     
wire            curpc_sel_from_wb;                      
wire            curpc_sel_not_hs;                       
wire            forever_cpuclk;                         
wire    [30:0]  had_iu_pc;                              
wire            had_iu_rte_pc_sel;                      
wire            had_yy_xx_exit_dbg;                     
wire            hs_split_iu_unstack_chgflw;             
wire            ifu_iu_ibus_idle;                       
wire            ifu_iu_spcu_retire_mask;                
wire    [31:0]  ifu_iu_xx_ibus_data;                    
wire            inst_fetch_mask;                        
wire    [30:0]  iu_ifu_addr;                            
wire            iu_ifu_data_fetch;                      
wire            iu_ifu_data_fetch_for_data;             
wire            iu_ifu_inst_fetch;                      
wire            iu_ifu_inst_fetch_for_data;             
wire            iu_ifu_inst_fetch_without_dbg_disable;  
wire            iu_yy_xx_flush;                         
wire            iu_yy_xx_retire;                        
wire            misc_clk;                               
wire            nie_flush_chgflw;                       
wire            pad_yy_gate_clk_en_b;                   
wire            pcgen_abort_chgflw_vld;                 
wire            pcgen_abort_chgflw_vld_for_data;        
wire    [30:0]  pcgen_addr_after_bctm;                  
wire    [30:0]  pcgen_addr_chgflw_asap;                 
wire    [30:0]  pcgen_addr_chgflw_delay;                
wire    [30:0]  pcgen_addr_except_chgflw_delay;         
wire            pcgen_address_add;                      
wire            pcgen_address_cur;                      
wire            pcgen_address_epc;                      
wire            pcgen_address_had;                      
wire            pcgen_address_ibus;                     
wire            pcgen_address_inc;                      
wire            pcgen_address_reg;                      
wire            pcgen_address_svbr;                     
wire            pcgen_address_vec;                      
wire            pcgen_chfglw_asap_vld_for_data;         
wire            pcgen_chgflw_asap_vld;                  
wire            pcgen_chgflw_delay_sel;                 
wire            pcgen_ctrl_stall;                       
wire    [30:0]  pcgen_cur_pc_next_val;                  
wire    [30:0]  pcgen_cur_pc_next_val_before_hs;        
wire            pcgen_cur_pc_updt_vld;                  
wire            pcgen_cur_pc_updt_vld_by_inst;          
wire            pcgen_cur_pc_updt_vld_chgflw;           
wire            pcgen_cur_pc_updt_vld_normal;           
wire            pcgen_cur_pc_updt_vld_not_by_inst;      
wire            pcgen_fetch_mask_trig;                  
wire            pcgen_idle_chgflw_vld;                  
wire            pcgen_idle_chgflw_vld_for_data;         
wire    [30:0]  pcgen_increase_pc;                      
wire            pcgen_inst_fetch;                       
wire    [30:0]  pcgen_retire_updt_pc;                   
wire            pcgen_top_abort_clk_en;                 
wire            pcgen_vector_expt_taken;                
wire            pcgen_wait_idle_trig;                   
wire    [30:0]  pcgen_xx_cur_pc;                        
wire            pcgen_xx_ibus_idle;                     
wire            randclk_pcgen_mod_en_w32;               
wire            retire_branch_stall;                    
wire            retire_pcgen_curpc_update;              
wire            retire_xx_normal_retire;                
wire            special_pcgen_chgflw_vld;               
wire    [31:0]  sysio_iu_rst_addr;                      
wire            vector_pcgen_buf_vbr;                   
wire            vector_pcgen_chgflw_vld;                
wire            vector_pcgen_cur_pc_vld;                
wire    [30:0]  vector_pcgen_enter_addr;                
wire            vector_pcgen_ibus_req;                  
wire            vector_pcgen_reset_vld;                 
wire            wb_pcgen_ldst_stall;                    
wire    [30:0]  wb_pcgen_pc_updt_val;                   
wire            wb_pcgen_switch_ld_pc;                  
wire    [30:0]  wb_retire_fast_retire_load_pc;          


parameter IDLE       = 1'b0;
parameter WAIT_IDLE  = 1'b1;
parameter FETCH_IDLE = 1'b0;
parameter FETCH_MASK = 1'b1;
parameter EMMU_IDLE       = 1'b0;
parameter EMMU_WAIT_IDLE  = 1'b1;

//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign pcgen_top_abort_clk_en = pcgen_wait_idle_trig
                             || pcgen_fetch_mask_trig
                             || (cur_state != IDLE)
                             || (fetch_cur_state != FETCH_IDLE);

//Depending on principle of locality ,the program will execute in certain pc range,
//so the changing frequency of high bit of cur_pc[30:0] will be rather small. As
//a result ,we separate cur_pc[30:0] into two part to reduce power
assign curpc_10_0_clk_en = pcgen_cur_pc_updt_vld || vector_pcgen_reset_vld;
// &Instance("gated_clk_cell", "x_curpc_gated_clk"); @50
gated_clk_cell  x_curpc_gated_clk (
  .clk_in                   (forever_cpuclk          ),
  .clk_out                  (curpc_10_0_clk          ),
  .external_en              (1'b0                    ),
  .global_en                (cp0_yy_clk_en           ),
  .local_en                 (curpc_10_0_clk_en       ),
  .module_en                (randclk_pcgen_mod_en_w32),
  .pad_yy_gate_clk_en_b     (pad_yy_gate_clk_en_b    )
);

// &Connect(.clk_in      (forever_cpuclk), @51
//          .external_en (1'b0), @52
//          .global_en   (cp0_yy_clk_en), @53
//          .module_en   (randclk_pcgen_mod_en_w32), @54
//          .local_en    (curpc_10_0_clk_en), @55
//          .clk_out     (curpc_10_0_clk)); @56

assign curpc_30_11_clk_en = pcgen_cur_pc_updt_vld_chgflw
                         || vector_pcgen_reset_vld
                         || pcgen_cur_pc_updt_vld_normal
                            && (pcgen_cur_pc[11] ^ pcgen_cur_pc_next_val[11]);
// &Instance("gated_clk_cell", "x_curpc_30_11_gated_clk"); @64
gated_clk_cell  x_curpc_30_11_gated_clk (
  .clk_in                   (forever_cpuclk          ),
  .clk_out                  (curpc_30_11_clk         ),
  .external_en              (1'b0                    ),
  .global_en                (cp0_yy_clk_en           ),
  .local_en                 (curpc_30_11_clk_en      ),
  .module_en                (randclk_pcgen_mod_en_w32),
  .pad_yy_gate_clk_en_b     (pad_yy_gate_clk_en_b    )
);

// &Connect(.clk_in      (forever_cpuclk), @65
//          .external_en (1'b0), @66
//          .global_en   (cp0_yy_clk_en), @67
//          .module_en   (randclk_pcgen_mod_en_w32), @68
//          .local_en    (curpc_30_11_clk_en), @69
//          .clk_out     (curpc_30_11_clk)); @70
//==========================================================
//          The Original Instruction Fetch Sources
//==========================================================
//the original change flow (instruction fetch) sources are:
// 1.exit of debug mode
// 2.direct branch without exception (interrupt)
// 3.return from exception (rte) exception (interrupt, cp0
//   will not change flow when privilege violation)
// 4.cp0 flush without exception (interrupt) will change
//   flow (not include rte change flow)
// 5.change flow to exception service routine from vector
//   machine
// 6.jmpix without exception (interrupt) (ifdef BCTM)
// 7.check fail change flow
assign bctm_pcgen_jmp_chgflw_vld          = 1'b0;
assign bctm_pcgen_jmp_chgflw_vld_for_data = 1'b0;
assign bctm_pcgen_chgflw_pc[30:0] = 31'b0;
assign bctm_pcgen_chk_fail_pc_vld = 1'b0;
assign bctm_pcgen_chk_chgflw_vld = 1'b0;

assign pcgen_inst_fetch = branch_pcgen_br_chgflw_vld
                       || cp0_iu_rte_chgflw_vld
                       || cp0_iu_flush_chgflw_vld 
                       || had_yy_xx_exit_dbg
                       || vector_pcgen_chgflw_vld 
                       || special_pcgen_chgflw_vld 
                       || bctm_pcgen_jmp_chgflw_vld
                       || bctm_pcgen_chk_chgflw_vld
                       || hs_split_iu_unstack_chgflw 
                       || nie_flush_chgflw;

//==========================================================
//            The Abort State Machine implement  
//==========================================================
//-----------------------------------------------------
// Once IFU had requested the ibus, the address cannot
// change, so instruction fetch have to wait IFU finish
// the previous transfer (idle)
//-----------------------------------------------------
//------------------FSM of abort logic-----------------
// State Description:
// IDLE       : no instruction fetch or ibus idle
// WAIT_IDLE  : wait idle of ibus
//-----------------------------------------------------
//the pcgen state machine does not affect by flush
always @(posedge misc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cur_state <= IDLE;
  else
    cur_state <= next_state;
end

//-----------------------------------------------------
// State change signals
//-----------------------------------------------------
assign pcgen_chgflw_asap_vld          = branch_pcgen_br_chgflw_vld;
assign pcgen_chfglw_asap_vld_for_data = branch_pcgen_br_chgflw_vld_for_data; 

assign pcgen_wait_idle_trig = pcgen_inst_fetch && !pcgen_chgflw_asap_vld;
// &CombBeg; @135
always @( cur_state
       or pcgen_wait_idle_trig
       or ifu_iu_ibus_idle)
begin
  case(cur_state)
  IDLE      : if(pcgen_wait_idle_trig)
                next_state = WAIT_IDLE;
              else
                next_state = IDLE;
  WAIT_IDLE : if(ifu_iu_ibus_idle)
                next_state = IDLE;
              else
                next_state = WAIT_IDLE;
  default   :   next_state = IDLE;
  endcase
// &CombEnd; @147
end

always @(posedge misc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    fetch_cur_state <= FETCH_IDLE;
  else if(iu_yy_xx_flush)
    fetch_cur_state <= FETCH_IDLE;
  else
    fetch_cur_state <= fetch_next_state;
end

assign pcgen_fetch_mask_trig = pcgen_chgflw_asap_vld && !iu_yy_xx_retire;
// &CombBeg; @160
always @( pcgen_fetch_mask_trig
       or iu_yy_xx_retire
       or fetch_cur_state)
begin
  case(fetch_cur_state)
  FETCH_IDLE : if(pcgen_fetch_mask_trig)
                 fetch_next_state = FETCH_MASK;
               else
                 fetch_next_state = FETCH_IDLE;
  FETCH_MASK : if(iu_yy_xx_retire)
                 fetch_next_state = FETCH_IDLE;
               else
                 fetch_next_state = FETCH_MASK;
  default    :   fetch_next_state = FETCH_IDLE;
  endcase
// &CombEnd; @172
end

assign inst_fetch_mask = (fetch_cur_state == FETCH_MASK);
assign pcgen_xx_ibus_idle = ifu_iu_ibus_idle || inst_fetch_mask;

//==========================================================
//                  Instruction Fetch
//==========================================================
//if ibus is idle, the directly request instruction fetch
//otherwise wait until ibus idle
assign pcgen_idle_chgflw_vld  = pcgen_chgflw_asap_vld 
                                && !inst_fetch_mask;
assign pcgen_abort_chgflw_vld = (cur_state == WAIT_IDLE)
                                && ifu_iu_ibus_idle;
// &Force("output","iu_ifu_inst_fetch"); @186
assign iu_ifu_inst_fetch  = pcgen_abort_chgflw_vld || pcgen_idle_chgflw_vld;

assign pcgen_idle_chgflw_vld_for_data  = pcgen_chfglw_asap_vld_for_data
                                         && !inst_fetch_mask;
assign pcgen_abort_chgflw_vld_for_data = (cur_state == WAIT_IDLE)
                                         && ifu_iu_ibus_idle; 
assign iu_ifu_inst_fetch_for_data = pcgen_abort_chgflw_vld_for_data ||
                                    pcgen_idle_chgflw_vld_for_data;

assign iu_ifu_inst_fetch_without_dbg_disable = iu_ifu_inst_fetch && !retire_branch_stall
                                               && !wb_pcgen_ldst_stall;

//==============================================================================
//                                 Data Fetch 
//==============================================================================

//-----------------------------------------------------
// the data fetch from ibus includes lrw and vector
// intermediate value fetch, which will wait ibus idle
// so data fetch needs no abort
//-----------------------------------------------------
assign iu_ifu_data_fetch = vector_pcgen_ibus_req;
assign iu_ifu_data_fetch_for_data = vector_pcgen_ibus_req;
//==========================================================
//                     Abort stall
//==========================================================
//IU should prevent wrong after change flow instruction
//pipedown after change flow flush, these wrong instructions
//will be stop by abort stall and abort instruction fetch 
//request will get right instruction
//IDLE state does not need stall since change flow flush
assign pcgen_ctrl_stall   = (cur_state == WAIT_IDLE)
                         && !ifu_iu_spcu_retire_mask;// && !ifu_iu_ibus_idle;

//==============================================================================
//                  Address Mux of inst fetch and data fetch
//==============================================================================
//the reqeust address of inst fetch and data fetch are
//1.from had pc when exit debug mode
assign pcgen_address_had  = had_yy_xx_exit_dbg
                         || cp0_iu_rte_chgflw_vld_for_data && had_iu_rte_pc_sel;
                    
//2.from vbr and vec when vector intermediate value
assign pcgen_address_vec  = vector_pcgen_buf_vbr;
assign pcgen_address_ibus = vector_pcgen_cur_pc_vld;
//3.from epc after rte flush
assign pcgen_address_epc  = cp0_iu_rte_chgflw_vld_for_data && !had_iu_rte_pc_sel
                            && !pcgen_address_svbr;

//4-5.from register or offset summation when direct branch
//    when brach mispred as not-taken, chgflw pc is from offset
assign pcgen_address_add  = branch_pcgen_branch_chgflw_vld_for_data
                            && !pcgen_address_svbr;
assign pcgen_address_reg  = branch_pcgen_jmp_chgflw_vld_for_data
                            && !pcgen_address_svbr;
//6.from svbr with offset when jmpix or check fail change flow
assign pcgen_address_svbr = bctm_pcgen_jmp_chgflw_vld_for_data
                         || bctm_pcgen_chk_fail_pc_vld;
//7.from increase pc after mtcr flush and normal retire
assign pcgen_address_inc  = !(pcgen_address_add
                             || pcgen_address_reg
                             || pcgen_address_svbr
                             || pcgen_address_cur);
//8.from current pc when inst fetch abort
//  when expt, the vector table addr and expt enter addr are from curpc
//  when exit dbg mode, the pc is from curpc
//  when rte, the pc is flop to curpc and then chflgw from curpc
assign pcgen_address_cur  = (cur_state == WAIT_IDLE) || vector_pcgen_ibus_req;

//-----------------------------------------------------
// request address mux
//-----------------------------------------------------
//the address mux does not include current pc, the result
//is reuse with current pc update value
assign pcgen_addr_chgflw_delay[30:0] = 
             {31{pcgen_address_had}}  & had_iu_pc[30:0]
           | {31{pcgen_address_vec}}  & vector_pcgen_enter_addr[30:0]
           | {31{pcgen_address_ibus}} & ifu_iu_xx_ibus_data[31:1]
           | {31{pcgen_address_epc}}  & cp0_iu_epc_for_chgflw[30:0];

//the asap pc is for ifu inst fetch
assign pcgen_addr_chgflw_asap[30:0] =
             {31{pcgen_address_add}}  & branch_pcgen_add_pc[30:0]
           | {31{pcgen_address_reg}}  & branch_pcgen_reg_pc[30:0]
           | {31{pcgen_address_inc}}  & pcgen_increase_pc[30:0]
           | {31{pcgen_address_cur}}  & pcgen_cur_pc[30:0];
// &Force("bus","ifu_iu_xx_ibus_data",31,0); @273
assign pcgen_addr_after_bctm[30:0] = 
             {31{pcgen_address_svbr}}  & bctm_pcgen_chgflw_pc[30:0]
           | {31{!pcgen_address_svbr}} & pcgen_addr_chgflw_asap[30:0];

assign pcgen_addr_except_chgflw_delay[30:0] = pcgen_cur_pc_updt_vld
                                      ? pcgen_addr_after_bctm[30:0]
                                      : pcgen_cur_pc[30:0];

//the PC to updata EPC or HAD PC when:
//1.expt happens -> EPC
//2.acc err after int -> EPC
//3.acc err after dbg -> HAD PC
//4.bstack chk fail after int -> EPC
//5.bstack chk fail after dbg -> HAD PC
assign pcgen_retire_updt_pc[30:0] = pcgen_addr_except_chgflw_delay[30:0]; 

//-----------------------------------------------------
//     Value to Updata CurPC  
//-----------------------------------------------------
assign pcgen_chgflw_delay_sel = pcgen_cur_pc_updt_vld
                             && (pcgen_address_had
                                 || pcgen_address_vec
                                 || pcgen_address_ibus
                                 || pcgen_address_epc);

assign pcgen_cur_pc_next_val_before_hs[30:0] = pcgen_chgflw_delay_sel
                                      ? pcgen_addr_chgflw_delay[30:0]
                                      : pcgen_addr_except_chgflw_delay[30:0];

assign curpc_sel_from_wb = retire_pcgen_curpc_update
                        && !bctm_pcgen_chk_fail_pc_vld;
assign curpc_sel_not_hs = !curpc_sel_from_wb
                       && !wb_pcgen_switch_ld_pc;
assign pcgen_cur_pc_next_val[30:0] = 
        {31{curpc_sel_from_wb}}     & wb_retire_fast_retire_load_pc[30:0]
      | {31{wb_pcgen_switch_ld_pc}} & wb_pcgen_pc_updt_val[30:0]
      | {31{curpc_sel_not_hs}}      & pcgen_cur_pc_next_val_before_hs[30:0];

//==========================================================
//   The addr to IFU (including data fetch and inst fetch)   
//==========================================================
assign iu_ifu_addr[30:0] = pcgen_addr_chgflw_asap[30:0]; 


//==============================================================================
//                            Current PC maintain
//==============================================================================
//current pc update valid signal
//1.exit debug mode
//2.direct branch change flow
//3.the vbr will be buffered in curPC first, then sent to IFU
//4.vector change flow
//5.return from exception
assign pcgen_cur_pc_updt_vld_not_by_inst = had_yy_xx_exit_dbg
                                        || vector_pcgen_cur_pc_vld
                                        || vector_pcgen_buf_vbr
                                        || bctm_pcgen_chk_fail_pc_vld
                                        || retire_pcgen_curpc_update
                                        || wb_pcgen_switch_ld_pc;

//6.jmpix and check fail change flow
assign pcgen_cur_pc_updt_vld_by_inst = branch_pcgen_br_pc_chgflw_vld
                                    || cp0_iu_rte_chgflw_vld
                                    || bctm_pcgen_jmp_chgflw_vld;

//7.cp0 flush and normal retire
//when EMMU and BCTM, when BCTM check fail, the cur pc cannot be updt in order
//to maintain the check fail chgflw for EMMU check
assign pcgen_cur_pc_updt_vld_normal = retire_xx_normal_retire;

assign pcgen_cur_pc_updt_vld_chgflw = pcgen_cur_pc_updt_vld_not_by_inst 
                                   || pcgen_cur_pc_updt_vld_by_inst;

assign pcgen_cur_pc_updt_vld = pcgen_cur_pc_updt_vld_not_by_inst
                            || pcgen_cur_pc_updt_vld_normal;

//-----------------------------------------------------
//            implement of current pc flop
//-----------------------------------------------------
//  &Force("bus", "sysio_iu_rst_addr", 31, 0); @358
always @(posedge curpc_10_0_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pcgen_cur_pc[10:0] <= 11'b0;
  else if(vector_pcgen_reset_vld)
    pcgen_cur_pc[10:0] <= sysio_iu_rst_addr[11:1];
  else
    pcgen_cur_pc[10:0] <= pcgen_cur_pc_next_val[10:0];
end

always @(posedge curpc_30_11_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pcgen_cur_pc[30:11] <= 20'b0;
  else if(vector_pcgen_reset_vld)
    pcgen_cur_pc[30:11] <= sysio_iu_rst_addr[31:12];
  else
    pcgen_cur_pc[30:11] <= pcgen_cur_pc_next_val[30:11];
end

//output for branch source
assign pcgen_xx_cur_pc[30:0] = pcgen_cur_pc[30:0];

//-----------------------------------------------------
//                    Increase PC
//-----------------------------------------------------
//assign pcgen_increase_pc[30:0] = pcgen_cur_pc[30:0] + pcgen_inc_offset[1:0];
assign pcgen_increase_pc[30:0] = branch_pcgen_add_pc[30:0];
//                                 + {decd_xx_inst_32bit, !decd_xx_inst_32bit};
//when bctm check fail, the curpc is not updated, and in next cycle,
//the curpc+1 need to be written to R15
//assign pcgen_inc_offset[1] = decd_xx_inst_32bit;
//assign pcgen_inc_offset[0] = !decd_xx_inst_32bit;

//output for branch_source 
//assign pcgen_branch_inc_pc[30:0] = pcgen_increase_pc[30:0];

assign pcgen_vector_expt_taken = (cur_state==IDLE);
//-----------------------------------------------------
//            PC Check of Security Extension
//-----------------------------------------------------
// &ModuleEnd; @425
endmodule


