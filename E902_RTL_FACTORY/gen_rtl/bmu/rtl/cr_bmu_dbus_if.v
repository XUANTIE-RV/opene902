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
module cr_bmu_dbus_if(
  biu_bmu_dbus_acc_err,
  biu_bmu_dbus_data,
  biu_bmu_dbus_data_vld,
  biu_bmu_dbus_grnt,
  biu_bmu_dbus_trans_cmplt,
  bmu_biu_dbus_acc_deny,
  bmu_biu_dbus_addr,
  bmu_biu_dbus_chk_fail,
  bmu_biu_dbus_prot,
  bmu_biu_dbus_req,
  bmu_biu_dbus_req_without_cmplt,
  bmu_biu_dbus_size,
  bmu_biu_dbus_wdata,
  bmu_biu_dbus_write,
  bmu_iahbl_dbus_acc_deny,
  bmu_iahbl_dbus_addr,
  bmu_iahbl_dbus_chk_fail,
  bmu_iahbl_dbus_prot,
  bmu_iahbl_dbus_req,
  bmu_iahbl_dbus_req_without_cmplt,
  bmu_iahbl_dbus_size,
  bmu_iahbl_dbus_wdata,
  bmu_iahbl_dbus_write,
  bmu_lsu_acc_err,
  bmu_lsu_bstack_chk_fail,
  bmu_lsu_data,
  bmu_lsu_data_vld,
  bmu_lsu_grnt,
  bmu_lsu_trans_cmplt,
  bmu_tcipif_dbus_acc_deny,
  bmu_tcipif_dbus_addr,
  bmu_tcipif_dbus_chk_fail,
  bmu_tcipif_dbus_req,
  bmu_tcipif_dbus_size,
  bmu_tcipif_dbus_supv_mode,
  bmu_tcipif_dbus_wdata,
  bmu_tcipif_dbus_write,
  cp0_yy_machine_mode_aft_dbg,
  cpurst_b,
  dbus_deny_clk_en,
  deny_clk,
  iahbl_bmu_dbus_acc_err,
  iahbl_bmu_dbus_data,
  iahbl_bmu_dbus_data_vld,
  iahbl_bmu_dbus_grnt,
  iahbl_bmu_dbus_trans_cmplt,
  lsu_bmu_addr,
  lsu_bmu_addr_check_fail,
  lsu_bmu_idle,
  lsu_bmu_prot,
  lsu_bmu_req,
  lsu_bmu_req_without_cmplt,
  lsu_bmu_sg_chk_fail,
  lsu_bmu_size,
  lsu_bmu_store_error,
  lsu_bmu_wdata,
  lsu_bmu_wfd1,
  lsu_bmu_write,
  pad_bmu_iahbl_base,
  pad_bmu_iahbl_mask,
  pmp_bmu_dbus_acc_deny,
  tcipif_bmu_dbus_acc_err,
  tcipif_bmu_dbus_data,
  tcipif_bmu_dbus_data_vld,
  tcipif_bmu_dbus_grnt,
  tcipif_bmu_dbus_trans_cmplt
);

// &Ports; @25
input           biu_bmu_dbus_acc_err;            
input   [31:0]  biu_bmu_dbus_data;               
input           biu_bmu_dbus_data_vld;           
input           biu_bmu_dbus_grnt;               
input           biu_bmu_dbus_trans_cmplt;        
input           cp0_yy_machine_mode_aft_dbg;     
input           cpurst_b;                        
input           deny_clk;                        
input           iahbl_bmu_dbus_acc_err;          
input   [31:0]  iahbl_bmu_dbus_data;             
input           iahbl_bmu_dbus_data_vld;         
input           iahbl_bmu_dbus_grnt;             
input           iahbl_bmu_dbus_trans_cmplt;      
input   [31:0]  lsu_bmu_addr;                    
input           lsu_bmu_addr_check_fail;         
input           lsu_bmu_idle;                    
input   [3 :0]  lsu_bmu_prot;                    
input           lsu_bmu_req;                     
input           lsu_bmu_req_without_cmplt;       
input           lsu_bmu_sg_chk_fail;             
input   [1 :0]  lsu_bmu_size;                    
input           lsu_bmu_store_error;             
input   [31:0]  lsu_bmu_wdata;                   
input           lsu_bmu_wfd1;                    
input           lsu_bmu_write;                   
input   [11:0]  pad_bmu_iahbl_base;              
input   [11:0]  pad_bmu_iahbl_mask;              
input           pmp_bmu_dbus_acc_deny;           
input           tcipif_bmu_dbus_acc_err;         
input   [31:0]  tcipif_bmu_dbus_data;            
input           tcipif_bmu_dbus_data_vld;        
input           tcipif_bmu_dbus_grnt;            
input           tcipif_bmu_dbus_trans_cmplt;     
output          bmu_biu_dbus_acc_deny;           
output  [31:0]  bmu_biu_dbus_addr;               
output          bmu_biu_dbus_chk_fail;           
output  [3 :0]  bmu_biu_dbus_prot;               
output          bmu_biu_dbus_req;                
output          bmu_biu_dbus_req_without_cmplt;  
output  [1 :0]  bmu_biu_dbus_size;               
output  [31:0]  bmu_biu_dbus_wdata;              
output          bmu_biu_dbus_write;              
output          bmu_iahbl_dbus_acc_deny;         
output  [31:0]  bmu_iahbl_dbus_addr;             
output          bmu_iahbl_dbus_chk_fail;         
output  [3 :0]  bmu_iahbl_dbus_prot;             
output          bmu_iahbl_dbus_req;              
output          bmu_iahbl_dbus_req_without_cmplt; 
output  [1 :0]  bmu_iahbl_dbus_size;             
output  [31:0]  bmu_iahbl_dbus_wdata;            
output          bmu_iahbl_dbus_write;            
output          bmu_lsu_acc_err;                 
output          bmu_lsu_bstack_chk_fail;         
output  [31:0]  bmu_lsu_data;                    
output          bmu_lsu_data_vld;                
output          bmu_lsu_grnt;                    
output          bmu_lsu_trans_cmplt;             
output          bmu_tcipif_dbus_acc_deny;        
output  [31:0]  bmu_tcipif_dbus_addr;            
output          bmu_tcipif_dbus_chk_fail;        
output          bmu_tcipif_dbus_req;             
output  [1 :0]  bmu_tcipif_dbus_size;            
output          bmu_tcipif_dbus_supv_mode;       
output  [31:0]  bmu_tcipif_dbus_wdata;           
output          bmu_tcipif_dbus_write;           
output          dbus_deny_clk_en;                

// &Regs; @26
reg     [2 :0]  cross_cur_st;                    
reg     [2 :0]  cross_nxt_st;                    
reg     [1 :0]  cur_state;                       
reg             iahbl_norm_hit_ff;               
reg     [1 :0]  next_state;                      
reg     [2 :0]  req_bus;                         

// &Wires; @27
wire            acc_deny;                        
wire            acc_err_for_deny;                
wire            biu_bmu_dbus_acc_err;            
wire    [31:0]  biu_bmu_dbus_data;               
wire            biu_bmu_dbus_data_vld;           
wire            biu_bmu_dbus_grnt;               
wire            biu_bmu_dbus_trans_cmplt;        
wire            biu_data_vld;                    
wire            bmu_biu_dbus_acc_deny;           
wire    [31:0]  bmu_biu_dbus_addr;               
wire            bmu_biu_dbus_chk_fail;           
wire    [3 :0]  bmu_biu_dbus_prot;               
wire            bmu_biu_dbus_req;                
wire            bmu_biu_dbus_req_without_cmplt;  
wire    [1 :0]  bmu_biu_dbus_size;               
wire    [31:0]  bmu_biu_dbus_wdata;              
wire            bmu_biu_dbus_write;              
wire            bmu_iahbl_dbus_acc_deny;         
wire    [31:0]  bmu_iahbl_dbus_addr;             
wire            bmu_iahbl_dbus_chk_fail;         
wire    [3 :0]  bmu_iahbl_dbus_prot;             
wire            bmu_iahbl_dbus_req;              
wire            bmu_iahbl_dbus_req_without_cmplt; 
wire    [1 :0]  bmu_iahbl_dbus_size;             
wire    [31:0]  bmu_iahbl_dbus_wdata;            
wire            bmu_iahbl_dbus_write;            
wire            bmu_lsu_acc_err;                 
wire            bmu_lsu_bstack_chk_fail;         
wire    [31:0]  bmu_lsu_data;                    
wire            bmu_lsu_data_vld;                
wire            bmu_lsu_grnt;                    
wire            bmu_lsu_trans_cmplt;             
wire            bmu_tcipif_dbus_acc_deny;        
wire    [31:0]  bmu_tcipif_dbus_addr;            
wire            bmu_tcipif_dbus_chk_fail;        
wire            bmu_tcipif_dbus_req;             
wire    [1 :0]  bmu_tcipif_dbus_size;            
wire            bmu_tcipif_dbus_supv_mode;       
wire    [31:0]  bmu_tcipif_dbus_wdata;           
wire            bmu_tcipif_dbus_write;           
wire            bstck_chk_fail;                  
wire            cp0_yy_machine_mode_aft_dbg;     
wire            cpurst_b;                        
wire            cross_fsm_upd;                   
wire            cross_iahbl;                     
wire            cross_idle;                      
wire            cross_sahbl;                     
wire            cross_tcip;                      
wire            dahbl_bmu_dbus_acc_err;          
wire    [31:0]  dahbl_bmu_dbus_data;             
wire            dahbl_bmu_dbus_data_vld;         
wire            dahbl_bmu_dbus_grnt;             
wire            dahbl_bmu_dbus_trans_cmplt;      
wire            dahbl_data_vld;                  
wire            dahbl_hit;                       
wire            dahbl_hit_ff;                    
wire            dahbl_hit_upd;                   
wire            dahbl_req;                       
wire            dbus_deny_clk_en;                
wire            dbus_grnt;                       
wire            deny_clk;                        
wire            iahbl_bmu_dbus_acc_err;          
wire    [31:0]  iahbl_bmu_dbus_data;             
wire            iahbl_bmu_dbus_data_vld;         
wire            iahbl_bmu_dbus_grnt;             
wire            iahbl_bmu_dbus_trans_cmplt;      
wire            iahbl_data_vld;                  
wire            iahbl_hit;                       
wire            iahbl_hit_ff;                    
wire            iahbl_hit_upd;                   
wire            iahbl_lrw_hit;                   
wire            iahbl_lrw_hit_ff;                
wire            iahbl_lrw_hit_upd;               
wire            iahbl_norm_hit_upd;              
wire            iahbl_req;                       
wire            iahbl_vld;                       
wire    [31:0]  lsu_bmu_addr;                    
wire            lsu_bmu_addr_check_fail;         
wire            lsu_bmu_idle;                    
wire    [3 :0]  lsu_bmu_prot;                    
wire            lsu_bmu_req;                     
wire            lsu_bmu_req_without_cmplt;       
wire            lsu_bmu_sg_chk_fail;             
wire    [1 :0]  lsu_bmu_size;                    
wire            lsu_bmu_store_error;             
wire    [31:0]  lsu_bmu_wdata;                   
wire            lsu_bmu_wfd1;                    
wire            lsu_bmu_write;                   
wire            lsu_inst_lrw;                    
wire            lsu_inst_norm;                   
wire    [11:0]  pad_bmu_iahbl_base;              
wire    [11:0]  pad_bmu_iahbl_mask;              
wire            pmp_bmu_dbus_acc_deny;           
wire            sahbl_req;                       
wire            sahbl_vld;                       
wire            tcip_req;                        
wire            tcip_vld;                        
wire    [15:0]  tcipif_addr_low;                 
wire            tcipif_bmu_dbus_acc_err;         
wire    [31:0]  tcipif_bmu_dbus_data;            
wire            tcipif_bmu_dbus_data_vld;        
wire            tcipif_bmu_dbus_grnt;            
wire            tcipif_bmu_dbus_trans_cmplt;     
wire            tcipif_data_vld;                 
wire            tcipif_hit;                      


//parameter DAHBL_BASE  = 3'b001;
parameter TCIPIF_BASE = 4'b1110;

assign acc_deny =  pmp_bmu_dbus_acc_deny 
                || lsu_bmu_sg_chk_fail
                || lsu_bmu_store_error;
//==========================================================
//      compare base address with ahbl base addr
//==========================================================
assign lsu_inst_norm = lsu_bmu_req & lsu_bmu_prot[0] & !tcipif_hit;
assign lsu_inst_lrw  = lsu_bmu_req & !lsu_bmu_prot[0];

assign dahbl_hit     = 1'b0;
assign dahbl_hit_ff  = 1'b0;
assign dahbl_hit_upd = 1'b0;

assign iahbl_hit = ((lsu_bmu_addr[31:20] & pad_bmu_iahbl_mask[11:0]) == pad_bmu_iahbl_base[11:0]);
assign iahbl_lrw_hit = iahbl_hit;

assign iahbl_norm_hit_upd = (iahbl_norm_hit_ff ^ iahbl_hit) & lsu_inst_norm;
always @(posedge deny_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    iahbl_norm_hit_ff <= 1'b0;
  else if(iahbl_norm_hit_upd)
    iahbl_norm_hit_ff <= iahbl_hit;
  else
    iahbl_norm_hit_ff <= iahbl_norm_hit_ff;
end

assign iahbl_lrw_hit_upd = (iahbl_lrw_hit_ff ^ iahbl_lrw_hit) & lsu_inst_lrw;
//always @(posedge deny_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    iahbl_lrw_hit_ff <= 1'b1;
//  else if(iahbl_lrw_hit_upd)
//    iahbl_lrw_hit_ff <= iahbl_lrw_hit;
//  else
//    iahbl_lrw_hit_ff <= iahbl_lrw_hit_ff;
//end
assign iahbl_lrw_hit_ff = 1'b1;
assign iahbl_hit_ff  = !lsu_bmu_prot[0] ? iahbl_lrw_hit_ff : iahbl_norm_hit_ff;
assign iahbl_hit_upd = iahbl_norm_hit_upd || iahbl_lrw_hit_upd;

//==========================================================
//                    cross bus req judgement & mask
//==========================================================
// cross FSM: Cross IDLE, SysAHBL, TCIP, IAHBL, DAHBL
parameter CIDLE = 3'b000;
parameter SAHBL = 3'b001;
parameter CTCIP = 3'b010;
parameter IAHBL = 3'b011;
parameter DAHBL = 3'b100;

always @(posedge deny_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cross_cur_st[2:0] <= CIDLE;
  else
    cross_cur_st[2:0] <= cross_nxt_st[2:0];
end

assign sahbl_req = lsu_bmu_req && !iahbl_hit && !dahbl_hit && !tcipif_hit;
assign iahbl_req = lsu_bmu_req &&  iahbl_hit;
assign dahbl_req = lsu_bmu_req &&  dahbl_hit;
assign tcip_req  = lsu_bmu_req && tcipif_hit;
assign cross_fsm_upd = cross_nxt_st[2:0] != cross_cur_st[2:0];

// &CombBeg; @139
always @( sahbl_req
       or iahbl_req
       or dahbl_req
       or tcip_req)
begin
case({sahbl_req, tcip_req, iahbl_req, dahbl_req})
  4'b1000:
    req_bus[2:0] = SAHBL;
  4'b0100:
    req_bus[2:0] = CTCIP;
  4'b0010:
    req_bus[2:0] = IAHBL;
  4'b0001:
    req_bus[2:0] = DAHBL;
  default:
    req_bus[2:0] = CIDLE;
endcase
// &CombEnd; @152
end

// &CombBeg; @154
always @( sahbl_req
       or lsu_bmu_idle
       or req_bus
       or dahbl_req
       or iahbl_req
       or tcip_req
       or cross_cur_st)
begin
case(cross_cur_st)
  CIDLE:
  begin
    case({sahbl_req, tcip_req, iahbl_req, dahbl_req})
      4'b1000:
        cross_nxt_st = SAHBL;
      4'b0100:
        cross_nxt_st = CTCIP;
      4'b0010:
        cross_nxt_st = IAHBL;
      4'b0001:
        cross_nxt_st = DAHBL;
      default:
        cross_nxt_st = CIDLE;
    endcase
  end
  SAHBL:
  begin
    if(lsu_bmu_idle)
      cross_nxt_st = req_bus;
    else
      cross_nxt_st = SAHBL;
  end
  CTCIP:
  begin
    if(lsu_bmu_idle)
      cross_nxt_st = req_bus;
    else
      cross_nxt_st = CTCIP;
  end
  IAHBL:
  begin
    if(lsu_bmu_idle)
      cross_nxt_st = req_bus;
    else
      cross_nxt_st = IAHBL;
  end
  DAHBL:
  begin
    if(lsu_bmu_idle)
      cross_nxt_st = req_bus;
    else
      cross_nxt_st = DAHBL;
  end
  default:
  begin
    cross_nxt_st = CIDLE;
  end
endcase
// &CombEnd; @204
end

assign cross_idle  = cross_cur_st == CIDLE;
assign cross_sahbl = cross_cur_st == SAHBL;

assign sahbl_vld = cross_idle || cross_sahbl;
assign cross_tcip  = cross_cur_st == CTCIP;
assign tcip_vld    = cross_idle || cross_tcip;
assign cross_iahbl = cross_cur_st == IAHBL;
assign iahbl_vld   = cross_idle || cross_iahbl;

//==========================================================
//                    request to AHBLite Interface
//==========================================================
// &Force("input","lsu_bmu_wdata"); @226
// &Force("bus","lsu_bmu_wdata",31,0); @227
// &Force("input","lsu_bmu_wdata_pol"); @229

//interface to DLITE
assign dahbl_bmu_dbus_acc_err     = 1'b0;
assign dahbl_bmu_dbus_data[31:0]  = 32'b0;
assign dahbl_bmu_dbus_data_vld    = 1'b0;
assign dahbl_bmu_dbus_grnt        = 1'b0;
assign dahbl_bmu_dbus_trans_cmplt = 1'b0;

//interface to ILTE
assign bmu_iahbl_dbus_req         = lsu_bmu_req & iahbl_hit & iahbl_hit_ff
                                  & iahbl_vld;
assign bmu_iahbl_dbus_req_without_cmplt = lsu_bmu_req_without_cmplt
                                          & iahbl_hit_ff & iahbl_vld;
assign bmu_iahbl_dbus_acc_deny    = acc_deny;
assign bmu_iahbl_dbus_chk_fail    = lsu_bmu_addr_check_fail;
assign bmu_iahbl_dbus_write       = lsu_bmu_write;
assign bmu_iahbl_dbus_size[1:0]   = lsu_bmu_size[1:0];

assign bmu_iahbl_dbus_wdata[31:0] = lsu_bmu_wdata[31:0];
assign bmu_iahbl_dbus_addr[31:0]  = lsu_bmu_addr[31:0];
assign bmu_iahbl_dbus_prot[3:0]   = lsu_bmu_prot[3:0]; 

//==========================================================
//                    request to system register file
//==========================================================
assign tcipif_hit = (lsu_bmu_addr[31:28] == TCIPIF_BASE);
assign bmu_tcipif_dbus_req         = lsu_bmu_req & tcipif_hit & tcip_vld;
assign bmu_tcipif_dbus_acc_deny    = acc_deny;
assign bmu_tcipif_dbus_chk_fail    = lsu_bmu_addr_check_fail;
assign bmu_tcipif_dbus_write       = lsu_bmu_write;
assign bmu_tcipif_dbus_size[1:0]   = lsu_bmu_size[1:0];
assign bmu_tcipif_dbus_supv_mode   = cp0_yy_machine_mode_aft_dbg;
assign bmu_tcipif_dbus_wdata[31:0] = lsu_bmu_wdata[31:0];
assign tcipif_addr_low[15:0]       = {16{tcipif_hit}}
                                     & lsu_bmu_addr[15:0];
assign bmu_tcipif_dbus_addr[31:0]  = {lsu_bmu_addr[31:16],
                                      tcipif_addr_low[15:0]};

//==========================================================
//                    request to system bus
//==========================================================
assign bmu_biu_dbus_req         = lsu_bmu_req & ~iahbl_hit & ~dahbl_hit
                               & ~iahbl_hit_ff & ~dahbl_hit_ff
                               & ~tcipif_hit & sahbl_vld;
assign bmu_biu_dbus_req_without_cmplt = lsu_bmu_req_without_cmplt 
                                     & ~iahbl_hit_ff & ~dahbl_hit_ff 
                                     & sahbl_vld;
assign bmu_biu_dbus_acc_deny    = acc_deny;
assign bmu_biu_dbus_chk_fail    = lsu_bmu_addr_check_fail;
assign bmu_biu_dbus_write       = lsu_bmu_write;
assign bmu_biu_dbus_size[1:0]   = lsu_bmu_size[1:0];

assign bmu_biu_dbus_wdata[31:0] = lsu_bmu_wdata[31:0];

assign bmu_biu_dbus_addr[31:0]  = lsu_bmu_addr[31:0];
assign bmu_biu_dbus_prot[3:0]   = lsu_bmu_prot[3:0]; 


//==========================================================
//                BMU ACK to LSU
//==========================================================
assign dbus_grnt        = dahbl_bmu_dbus_grnt  |
                          iahbl_bmu_dbus_grnt  |
                          tcipif_bmu_dbus_grnt |
                          biu_bmu_dbus_grnt;
assign bmu_lsu_grnt = dbus_grnt;

//the deny info
//the check fail info
parameter IDLE        = 2'b00;
parameter BSTACK_FAIL = 2'b01;
parameter DENY        = 2'b10;
assign dbus_deny_clk_en = (cur_state != IDLE)
                       || lsu_bmu_addr_check_fail
                       || acc_deny 
                       || iahbl_hit_upd
                       || dahbl_hit_upd
                       || cross_fsm_upd;

//            &Force("nonport","dbus_deny_clk_en"); @410
always @(posedge deny_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cur_state[1:0] <= IDLE;
  else
    cur_state[1:0] <= next_state[1:0];
end

// &CombBeg; @424
always @( cur_state
       or dbus_grnt
       or acc_deny
       or lsu_bmu_wfd1
       or lsu_bmu_addr_check_fail)
begin
  case(cur_state)
  IDLE        : if(dbus_grnt && lsu_bmu_addr_check_fail)
                  next_state = BSTACK_FAIL;
                else if(dbus_grnt && acc_deny)
                  next_state = DENY;
                else
                  next_state = IDLE;
  BSTACK_FAIL : if(lsu_bmu_wfd1)  
                  next_state = IDLE;
                else
                  next_state = BSTACK_FAIL;
  DENY        : if(lsu_bmu_wfd1)  
                  next_state = IDLE;
                else
                  next_state = DENY;
  default     :   next_state = IDLE;
  endcase
// &CombEnd; @442
end

assign bstck_chk_fail   = (cur_state == BSTACK_FAIL) && lsu_bmu_wfd1;
assign acc_err_for_deny = (cur_state == DENY) && lsu_bmu_wfd1;


// &Force("output","bmu_lsu_trans_cmplt"); @448
assign bmu_lsu_trans_cmplt = dahbl_bmu_dbus_trans_cmplt  |
                             iahbl_bmu_dbus_trans_cmplt  |
                             tcipif_bmu_dbus_trans_cmplt |
                             biu_bmu_dbus_trans_cmplt    |
                             acc_err_for_deny |
                             bstck_chk_fail;

assign bmu_lsu_data_vld    = dahbl_bmu_dbus_data_vld  |
                             iahbl_bmu_dbus_data_vld  |
                             tcipif_bmu_dbus_data_vld |
                             biu_bmu_dbus_data_vld;

assign dahbl_data_vld = dahbl_bmu_dbus_data_vld;
assign iahbl_data_vld = iahbl_bmu_dbus_data_vld;
assign biu_data_vld   = biu_bmu_dbus_data_vld;
assign tcipif_data_vld = tcipif_bmu_dbus_data_vld;

assign bmu_lsu_data[31:0]  = ({32{dahbl_data_vld}}  & dahbl_bmu_dbus_data[31:0])  |
                             ({32{iahbl_data_vld}}  & iahbl_bmu_dbus_data[31:0])  |
                             ({32{tcipif_data_vld}} & tcipif_bmu_dbus_data[31:0]) |
                             ({32{biu_data_vld}}    & biu_bmu_dbus_data[31:0]);


assign bmu_lsu_acc_err     = dahbl_bmu_dbus_acc_err  |
                             iahbl_bmu_dbus_acc_err  |
                             tcipif_bmu_dbus_acc_err |
                             biu_bmu_dbus_acc_err    |
                             acc_err_for_deny;

assign bmu_lsu_bstack_chk_fail = bstck_chk_fail;


// &ModuleEnd; @487
endmodule


