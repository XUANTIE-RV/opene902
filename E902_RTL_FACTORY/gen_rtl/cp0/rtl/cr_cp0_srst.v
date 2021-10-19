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

// &ModuleBeg; @24
module cr_cp0_srst(
  cache_cp0_srst_ack,
  cp0_cache_srst_req,
  cp0_ifu_srst_mask,
  cp0_ifu_srst_req,
  cp0_sysio_srst,
  cpurst_b,
  ifu_cp0_srst_ack,
  iu_cp0_ex_sel,
  iu_yy_xx_flush,
  srst_iui_stall,
  srst_iui_stall_noinput,
  srst_sm_clk,
  srst_sm_clk_en,
  status_srst_req_valid,
  status_srst_req_valid_noinput,
  status_srst_value
);

// &Ports; @25
input          cache_cp0_srst_ack;           
input          cpurst_b;                     
input          ifu_cp0_srst_ack;             
input          iu_cp0_ex_sel;                
input          iu_yy_xx_flush;               
input          srst_sm_clk;                  
input          status_srst_req_valid;        
input          status_srst_req_valid_noinput; 
input   [1:0]  status_srst_value;            
output         cp0_cache_srst_req;           
output         cp0_ifu_srst_mask;            
output         cp0_ifu_srst_req;             
output  [1:0]  cp0_sysio_srst;               
output         srst_iui_stall;               
output         srst_iui_stall_noinput;       
output         srst_sm_clk_en;               

// &Regs; @26
reg     [1:0]  cur_state;                    
reg     [1:0]  next_state;                   

// &Wires; @27
wire           cache_cp0_srst_ack;           
wire           cp0_cache_srst_req;           
wire           cp0_ifu_srst_mask;            
wire           cp0_ifu_srst_req;             
wire    [1:0]  cp0_sysio_srst;               
wire           cpurst_b;                     
wire           ifu_cp0_srst_ack;             
wire           iu_cp0_ex_sel;                
wire           iu_yy_xx_flush;               
wire           srst_ack;                     
wire           srst_cmplt;                   
wire           srst_in_wait_state;           
wire           srst_iui_stall;               
wire           srst_iui_stall_noinput;       
wire           srst_sm_clk;                  
wire           srst_sm_clk_en;               
wire           status_srst_req_valid;        
wire           status_srst_req_valid_noinput; 
wire    [1:0]  status_srst_value;            


parameter IDLE   = 2'b00;
parameter WFACK  = 2'b01;
parameter WFCPLT = 2'b10;
parameter WFRST  = 2'b11;

//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign srst_sm_clk_en = iu_cp0_ex_sel || (cur_state != IDLE); 

//-----------------------------------------------------
// Request the BIU to enter low power mode and do
// not accept any more transaction from IFU or LSU
//-----------------------------------------------------

//-------------------FSM of srst req logic-----------------
// State Description:
// IDLE     : no srst instruction (wait,stop,doze)
// WFACK    : request sysio and wait for sysio ack
//           the srst request        
//-----------------------------------------------------

always @(posedge srst_sm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cur_state[1:0] <= IDLE;
  else if(iu_yy_xx_flush)
    cur_state[1:0] <= IDLE;
  else
    cur_state[1:0] <= next_state[1:0];
end

// &CombBeg; @61
always @( cur_state
       or status_srst_req_valid
       or srst_ack)
begin
  case(cur_state)
  IDLE   : if(status_srst_req_valid)
             next_state = WFACK;
           else
             next_state = IDLE;
  WFACK  : if(srst_ack)
             next_state = WFCPLT;
           else
             next_state = WFACK;
  WFCPLT :   next_state = WFRST;
  WFRST  :   next_state = WFRST;
  default:   next_state = IDLE;
  endcase
// &CombEnd; @75
end

assign srst_in_wait_state = (cur_state == WFACK);
assign srst_cmplt         = (cur_state == WFCPLT);

//-------------------control signal by srst FSM-------------
assign srst_iui_stall = (cur_state == IDLE) && status_srst_req_valid
                     || (cur_state != IDLE);
assign srst_iui_stall_noinput = (cur_state == IDLE) && status_srst_req_valid_noinput
                     || (cur_state != IDLE);

assign cp0_ifu_srst_req = srst_in_wait_state;
assign cp0_cache_srst_req = srst_in_wait_state;

//-----------------------------------------------------
//               srst request ack 
//-----------------------------------------------------
assign srst_ack = ifu_cp0_srst_ack && cache_cp0_srst_ack;

assign cp0_sysio_srst[1:0] = {2{srst_cmplt}} & status_srst_value[1:0];

assign cp0_ifu_srst_mask = (cur_state == WFCPLT) || (cur_state == WFRST);

// &ModuleEnd; @98
endmodule


