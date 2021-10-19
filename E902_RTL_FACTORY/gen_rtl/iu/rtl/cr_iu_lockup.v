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
module cr_iu_lockup(
  cache_iu_lockup_ack,
  cp0_iu_in_expt,
  cp0_iu_in_nmi,
  cp0_iu_mret,
  cpurst_b,
  ifu_iu_lockup_ack,
  iu_cache_lockup_req,
  iu_cp0_lockup_clr,
  iu_cp0_lockup_vld,
  iu_ifu_lockup_mask,
  iu_ifu_lockup_on,
  iu_ifu_lockup_req,
  iu_sysio_lockup_on,
  lockup_retire_dbg_vld,
  lockup_retire_mask,
  lockup_retire_nmi_vld,
  misc_clk,
  retire_lockup_dbg_on,
  retire_lockup_dbg_vld,
  retire_lockup_expt_vld,
  retire_lockup_inst_retire,
  retire_lockup_nmi_vld,
  retire_lockup_retire_pc
);

// &Ports; @24
input           cache_iu_lockup_ack;      
input           cp0_iu_in_expt;           
input           cp0_iu_in_nmi;            
input           cp0_iu_mret;              
input           cpurst_b;                 
input           ifu_iu_lockup_ack;        
input           misc_clk;                 
input           retire_lockup_dbg_on;     
input           retire_lockup_dbg_vld;    
input           retire_lockup_expt_vld;   
input           retire_lockup_inst_retire; 
input           retire_lockup_nmi_vld;    
input   [31:0]  retire_lockup_retire_pc;  
output          iu_cache_lockup_req;      
output          iu_cp0_lockup_clr;        
output          iu_cp0_lockup_vld;        
output          iu_ifu_lockup_mask;       
output          iu_ifu_lockup_on;         
output          iu_ifu_lockup_req;        
output          iu_sysio_lockup_on;       
output          lockup_retire_dbg_vld;    
output          lockup_retire_mask;       
output          lockup_retire_nmi_vld;    

// &Regs; @25
reg     [2 :0]  lockup_cur_st;            
reg     [2 :0]  lockup_nxt_st;            

// &Wires; @26
wire            cache_iu_lockup_ack;      
wire            cp0_iu_in_expt;           
wire            cp0_iu_in_nmi;            
wire            cp0_iu_mret;              
wire            cpurst_b;                 
wire            ifu_iu_lockup_ack;        
wire            iu_cache_lockup_req;      
wire            iu_cp0_lockup_clr;        
wire            iu_cp0_lockup_vld;        
wire            iu_ifu_lockup_mask;       
wire            iu_ifu_lockup_on;         
wire            iu_ifu_lockup_req;        
wire            iu_sysio_lockup_on;       
wire            lock_up_ack;              
wire            lock_up_vld;              
wire            lockup_retire_dbg_vld;    
wire            lockup_retire_mask;       
wire            lockup_retire_nmi_vld;    
wire            misc_clk;                 
wire            retire_lockup_dbg_on;     
wire            retire_lockup_dbg_vld;    
wire            retire_lockup_expt_vld;   
wire            retire_lockup_inst_retire; 
wire            retire_lockup_nmi_vld;    
wire    [31:0]  retire_lockup_retire_pc;  


// lock up module
// 1. Lock up valid when expt vld in a expt handler, ecall and ebreak excluded
// 2. Lock up will wait IFU empty and mask IFU fetch
// 3. Lock up can react debug and nmi

assign lock_up_vld = (cp0_iu_in_expt || cp0_iu_in_nmi) && retire_lockup_expt_vld;
// Lock up state machine
parameter IDLE  = 3'b000;
parameter WFLU  = 3'b001;
parameter LKUP  = 3'b010;
parameter LKNMI = 3'b011;
parameter LKDBG = 3'b111;

always @ (posedge misc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    lockup_cur_st[2:0] <= IDLE;
  else
    lockup_cur_st[2:0] <= lockup_nxt_st[2:0];
end

// &CombBeg; @49
always @( retire_lockup_dbg_vld
       or lock_up_vld
       or lock_up_ack
       or retire_lockup_retire_pc[31:0]
       or retire_lockup_dbg_on
       or retire_lockup_nmi_vld
       or cp0_iu_in_nmi
       or lockup_cur_st[2:0]
       or cp0_iu_mret
       or retire_lockup_inst_retire)
begin
case(lockup_cur_st[2:0])
  IDLE:
  begin
    if(lock_up_vld)
      lockup_nxt_st[2:0] = WFLU;
    else
      lockup_nxt_st[2:0] = IDLE;
  end
  WFLU:
  begin
    if(lock_up_ack)
      lockup_nxt_st[2:0] = LKUP;
    else
      lockup_nxt_st[2:0] = WFLU;
  end
  LKUP:
  begin
    if(retire_lockup_dbg_vld)
      lockup_nxt_st[2:0] = LKDBG;
    else if(retire_lockup_nmi_vld && !cp0_iu_in_nmi)
      lockup_nxt_st[2:0] = LKNMI;
    else
      lockup_nxt_st[2:0] = LKUP;
  end
  LKNMI:
  begin
    if(cp0_iu_mret || lock_up_vld)
      lockup_nxt_st[2:0] = WFLU;
    else
      lockup_nxt_st[2:0] = LKNMI;
  end
  LKDBG:
  begin
    if(retire_lockup_inst_retire && !retire_lockup_dbg_on)
      if(retire_lockup_retire_pc[31:0] == 32'hEFFFFFFC)
        lockup_nxt_st[2:0] = WFLU;
      else
        lockup_nxt_st[2:0] = IDLE;
    else
      lockup_nxt_st[2:0] = LKDBG;
  end
  default:
  begin
    lockup_nxt_st[2:0] = IDLE;
  end
endcase
// &CombEnd; @96
end

assign lock_up_ack         = ifu_iu_lockup_ack && cache_iu_lockup_ack;
assign iu_ifu_lockup_req   = lockup_cur_st[2:0] == WFLU;
assign iu_cache_lockup_req = lockup_cur_st[2:0] == WFLU;
assign iu_ifu_lockup_on    = lockup_cur_st[2:0] == LKUP;
assign iu_sysio_lockup_on  = lockup_cur_st[2:0] == LKUP;

assign lockup_retire_mask    = lock_up_vld;
assign lockup_retire_nmi_vld = lockup_cur_st[2:0] == LKUP && retire_lockup_nmi_vld;
assign lockup_retire_dbg_vld = lockup_cur_st[2:0] == LKUP && retire_lockup_dbg_vld;

assign iu_cp0_lockup_vld     = lockup_cur_st[2:0] == WFLU && lock_up_ack;
assign iu_cp0_lockup_clr     = retire_lockup_inst_retire && !retire_lockup_dbg_on
                            && retire_lockup_retire_pc[31:0] != 32'hEFFFFFFC
                            && lockup_cur_st[2:0] == LKDBG;

assign iu_ifu_lockup_mask   = lockup_cur_st[2:0] == WFLU || lockup_cur_st[2:0] == LKUP;

// &ModuleEnd; @115
endmodule


