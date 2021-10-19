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
module cr_ifu_ibusif(
  bmu_xx_ibus_acc_err,
  bmu_xx_ibus_data,
  bmu_xx_ibus_grnt,
  bmu_xx_ibus_trans_cmplt,
  cp0_ifu_in_lpmd,
  cp0_ifu_lpmd_req,
  cp0_ifu_rst_inv_done,
  cp0_ifu_srst_mask,
  cp0_ifu_srst_req,
  cp0_yy_clk_en,
  cp0_yy_machine_mode_aft_dbg,
  cpurst_b,
  forever_cpuclk,
  ibuf_ibusif_inst_fetch,
  ibusif_ibuf_no_trans,
  ibusif_ifctrl_inst_mad32_high,
  ibusif_ifctrl_inst_no_bypass,
  ibusif_top_clk_en,
  ibusif_xx_16bit_inst,
  ibusif_xx_acc_err,
  ibusif_xx_data,
  ibusif_xx_ibus_idle,
  ibusif_xx_trans_cmplt,
  ibusif_xx_unalign_fetch,
  ifu_bmu_addr,
  ifu_bmu_idle,
  ifu_bmu_prot,
  ifu_bmu_req,
  ifu_bmu_wfd1,
  ifu_cp0_lpmd_ack,
  ifu_cp0_rst_inv_req,
  ifu_cp0_srst_ack,
  ifu_iu_ibus_idle,
  ifu_iu_lockup_ack,
  ifu_iu_vector_ibus_in_idle,
  ifu_iu_xx_ibus_data,
  ifu_misc_clk,
  iu_ifu_addr,
  iu_ifu_data_fetch,
  iu_ifu_data_fetch_for_data,
  iu_ifu_inst_fetch,
  iu_ifu_inst_fetch_for_data,
  iu_ifu_inst_fetch_mask,
  iu_ifu_lockup_mask,
  iu_ifu_lockup_on,
  iu_ifu_lockup_req,
  iu_ifu_reset_vld,
  iu_ifu_security_violation,
  iu_yy_xx_dbgon,
  pad_yy_gate_clk_en_b,
  pmp_ifu_acc_scu,
  sysio_ifu_rst_addr,
  sysmap_ifu_acc_ca
);

// &Ports; @24
input           bmu_xx_ibus_acc_err;          
input   [31:0]  bmu_xx_ibus_data;             
input           bmu_xx_ibus_grnt;             
input           bmu_xx_ibus_trans_cmplt;      
input           cp0_ifu_in_lpmd;              
input           cp0_ifu_lpmd_req;             
input           cp0_ifu_rst_inv_done;         
input           cp0_ifu_srst_mask;            
input           cp0_ifu_srst_req;             
input           cp0_yy_clk_en;                
input           cp0_yy_machine_mode_aft_dbg;  
input           cpurst_b;                     
input           forever_cpuclk;               
input           ibuf_ibusif_inst_fetch;       
input           ifu_misc_clk;                 
input   [30:0]  iu_ifu_addr;                  
input           iu_ifu_data_fetch;            
input           iu_ifu_data_fetch_for_data;   
input           iu_ifu_inst_fetch;            
input           iu_ifu_inst_fetch_for_data;   
input           iu_ifu_inst_fetch_mask;       
input           iu_ifu_lockup_mask;           
input           iu_ifu_lockup_on;             
input           iu_ifu_lockup_req;            
input           iu_ifu_reset_vld;             
input           iu_ifu_security_violation;    
input           iu_yy_xx_dbgon;               
input           pad_yy_gate_clk_en_b;         
input           pmp_ifu_acc_scu;              
input   [31:0]  sysio_ifu_rst_addr;           
input           sysmap_ifu_acc_ca;            
output          ibusif_ibuf_no_trans;         
output          ibusif_ifctrl_inst_mad32_high; 
output          ibusif_ifctrl_inst_no_bypass; 
output          ibusif_top_clk_en;            
output          ibusif_xx_16bit_inst;         
output          ibusif_xx_acc_err;            
output  [31:0]  ibusif_xx_data;               
output          ibusif_xx_ibus_idle;          
output          ibusif_xx_trans_cmplt;        
output          ibusif_xx_unalign_fetch;      
output  [31:0]  ifu_bmu_addr;                 
output          ifu_bmu_idle;                 
output  [3 :0]  ifu_bmu_prot;                 
output          ifu_bmu_req;                  
output          ifu_bmu_wfd1;                 
output          ifu_cp0_lpmd_ack;             
output          ifu_cp0_rst_inv_req;          
output          ifu_cp0_srst_ack;             
output          ifu_iu_ibus_idle;             
output          ifu_iu_lockup_ack;            
output          ifu_iu_vector_ibus_in_idle;   
output  [31:0]  ifu_iu_xx_ibus_data;          

// &Regs; @25
reg             abort_cur_st;                 
reg             abort_nxt_st;                 
reg     [29:0]  addr_cnt;                     
reg     [2 :0]  cur_st;                       
reg     [3 :0]  ibus_prot_reg;                
reg     [2 :0]  nxt_st;                       
reg             unalign_fetch_reg;            

// &Wires; @26
wire            addr_cnt_high_icg_en;         
wire            addr_cnt_high_upd_clk;        
wire            addr_cnt_high_upd_en;         
wire            addr_cnt_high_upd_en_local;   
wire            addr_cnt_low_icg_en;          
wire            addr_cnt_low_upd_clk;         
wire            addr_cnt_low_upd_en;          
wire            addr_cnt_upd_en;              
wire            bmu_xx_ibus_acc_err;          
wire    [31:0]  bmu_xx_ibus_data;             
wire    [31:0]  bmu_xx_ibus_data_aft_pol;     
wire            bmu_xx_ibus_grnt;             
wire            bmu_xx_ibus_trans_cmplt;      
wire            change_flow_vld;              
wire            cp0_ifu_in_lpmd;              
wire            cp0_ifu_lpmd_req;             
wire            cp0_ifu_rst_inv_done;         
wire            cp0_ifu_srst_mask;            
wire            cp0_ifu_srst_req;             
wire            cp0_yy_clk_en;                
wire            cp0_yy_machine_mode_aft_dbg;  
wire            cpurst_b;                     
wire            flop_out_bus;                 
wire            forever_cpuclk;               
wire            ibuf_ibusif_inst_fetch;       
wire            ibus_abort_trig;              
wire            ibus_acc_err;                 
wire    [30:0]  ibus_addr;                    
wire            ibus_busy;                    
wire    [31:0]  ibus_data;                    
wire            ibus_inst_fetch_cmplt;        
wire            ibus_inst_mad;                
wire            ibus_inst_mad32_high;         
wire            ibus_inst_no_bypass;          
wire            ibus_inst_req;                
wire            ibus_no_outstanding;          
wire    [30:0]  ibus_nonseq_addr;             
wire    [3 :0]  ibus_prot;                    
wire            ibus_prot_buf;                
wire            ibus_prot_buf_sel;            
wire            ibus_req;                     
wire    [30:0]  ibus_seq_addr;                
wire            ibus_trans_abort;             
wire            ibusif_ibuf_no_trans;         
wire            ibusif_ifctrl_inst_mad32_high; 
wire            ibusif_ifctrl_inst_no_bypass; 
wire            ibusif_top_clk_en;            
wire            ibusif_xx_16bit_inst;         
wire            ibusif_xx_acc_err;            
wire    [31:0]  ibusif_xx_data;               
wire            ibusif_xx_ibus_idle;          
wire            ibusif_xx_trans_cmplt;        
wire            ibusif_xx_unalign_fetch;      
wire    [31:0]  ifu_bmu_addr;                 
wire            ifu_bmu_idle;                 
wire    [3 :0]  ifu_bmu_prot;                 
wire            ifu_bmu_req;                  
wire            ifu_bmu_wfd1;                 
wire            ifu_cp0_lpmd_ack;             
wire            ifu_cp0_rst_inv_req;          
wire            ifu_cp0_srst_ack;             
wire            ifu_iu_ibus_idle;             
wire            ifu_iu_lockup_ack;            
wire            ifu_iu_vector_ibus_in_idle;   
wire    [31:0]  ifu_iu_xx_ibus_data;          
wire            ifu_misc_clk;                 
wire    [29:0]  inc_addr;                     
wire            inst_chgflw_for_data;         
wire            internal_inst_fetch;          
wire            internal_inst_fetch_pre;      
wire    [30:0]  iu_ifu_addr;                  
wire            iu_ifu_data_fetch;            
wire            iu_ifu_data_fetch_for_data;   
wire            iu_ifu_inst_fetch;            
wire            iu_ifu_inst_fetch_for_data;   
wire            iu_ifu_inst_fetch_mask;       
wire            iu_ifu_lockup_mask;           
wire            iu_ifu_lockup_on;             
wire            iu_ifu_lockup_req;            
wire            iu_ifu_reset_vld;             
wire            iu_ifu_security_violation;    
wire            iu_yy_xx_dbgon;               
wire            lpmd_mask;                    
wire            pad_yy_gate_clk_en_b;         
wire            pmp_ifu_acc_scu;              
wire            sm_upd_clk;                   
wire            sm_upd_en;                    
wire    [31:0]  sysio_ifu_rst_addr;           
wire            sysmap_ifu_acc_ca;            



//==========================================================
//               Parameter Definition
//==========================================================
parameter IDLE     = 3'b001,
          WFG1     = 3'b010,
          WFD1     = 3'b011,
          WFD1WFG2 = 3'b000,
          WFD1WFD2 = 3'b110,
          RESET    = 3'b100;

parameter ABORT_IDLE = 1'b0,
          ABORT_VLD  = 1'b1;

//==============================================================================
//                            Gated Clock
//==============================================================================
//Depending on principle of locality ,the program will execute in certain pc range,
//so the changing frequency of high bit of addr_cnt[29:0] will be rather small. As
//a result ,we separate addr_cnt[29:0] into two part to reduce power
assign addr_cnt_low_icg_en = addr_cnt_low_upd_en || iu_ifu_reset_vld;
// &Instance("gated_clk_cell", "x_ibus_addr_cnt_low_clkhdr"); @49
gated_clk_cell  x_ibus_addr_cnt_low_clkhdr (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (addr_cnt_low_upd_clk),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (addr_cnt_low_icg_en ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in(forever_cpuclk), @50
//          .external_en(1'b0), @51
//          .global_en(cp0_yy_clk_en), @52
//          .module_en(1'b0), @53
//          .local_en(addr_cnt_low_icg_en), @54
//          .clk_out(addr_cnt_low_upd_clk) @55
//         ); @56
assign addr_cnt_high_icg_en = addr_cnt_high_upd_en || iu_ifu_reset_vld;
// &Instance("gated_clk_cell", "x_ibus_addr_cnt_high_clkhdr"); @60
gated_clk_cell  x_ibus_addr_cnt_high_clkhdr (
  .clk_in                (forever_cpuclk       ),
  .clk_out               (addr_cnt_high_upd_clk),
  .external_en           (1'b0                 ),
  .global_en             (cp0_yy_clk_en        ),
  .local_en              (addr_cnt_high_icg_en ),
  .module_en             (1'b0                 ),
  .pad_yy_gate_clk_en_b  (pad_yy_gate_clk_en_b )
);

// &Connect(.clk_in(forever_cpuclk), @61
//          .external_en(1'b0), @62
//          .global_en(cp0_yy_clk_en), @63
//          .module_en(1'b0), @64
//          .local_en(addr_cnt_high_icg_en), @65
//          .clk_out(addr_cnt_high_upd_clk) @66
//         ); @67

// &Instance("gated_clk_cell", "x_sm_upd_clkhdr"); @70
gated_clk_cell  x_sm_upd_clkhdr (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (sm_upd_clk          ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (sm_upd_en           ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in(forever_cpuclk), @71
//          .external_en(1'b0), @72
//          .global_en(cp0_yy_clk_en), @73
//          .module_en(1'b0), @74
//          .local_en(sm_upd_en), @75
//          .clk_out(sm_upd_clk) @76
//         ); @77
assign sm_upd_en = ibus_req || iu_ifu_inst_fetch_for_data ||
                   bmu_xx_ibus_trans_cmplt || 
                   (cur_st != IDLE);

////////////////////////////////////////////////////////////////////////////////
//                              Data Path                                     //
////////////////////////////////////////////////////////////////////////////////
//==============================================================================
//               Address MUX of Instruction Fetch
//==============================================================================
//The PC load has two sources
//1.the sequential source from IFU itself
//2.the non-sequential source from IU, whihc may be the change flow address
//  or the mid-address of JSRI, LRW and VEC SM
assign ibus_seq_addr[30:0] = {addr_cnt[29:0], 1'b0};

assign ibus_nonseq_addr[30:0] = iu_ifu_addr[30:0];

assign ibus_addr[30:0] = (iu_ifu_inst_fetch_for_data
                          || iu_ifu_data_fetch_for_data)
                                      ? ibus_nonseq_addr[30:0]
                                      : ibus_seq_addr[30:0];

//==============================================================================
//               The Address Counter
//==============================================================================
//the addr_cnt needs to hold the address to ibus, when grnt signal is asserted,
//the counter can be updated, so the next cycle a back to back request can be
//sent
// //&Force("output", "addr_cnt_high_upd_en"); @107
assign change_flow_vld = iu_ifu_inst_fetch;
assign addr_cnt_upd_en = change_flow_vld || (!iu_ifu_data_fetch_for_data && bmu_xx_ibus_grnt);
assign addr_cnt_high_upd_en = change_flow_vld ||
                              bmu_xx_ibus_grnt && (addr_cnt[10] ^ inc_addr[10]);

assign addr_cnt_low_upd_en  = addr_cnt_upd_en;

// &Force("bus", "sysio_ifu_rst_addr", 31, 0); @115
always @(posedge addr_cnt_low_upd_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    addr_cnt[9:0] <= 10'b0;
  else if(iu_ifu_reset_vld)
    addr_cnt[9:0] <= sysio_ifu_rst_addr[11:2];
  else if(addr_cnt_low_upd_en)
    addr_cnt[9:0] <= inc_addr[9:0];
end

assign addr_cnt_high_upd_en_local = 1'b0;
always @(posedge addr_cnt_high_upd_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    addr_cnt[29:10] <= 20'b0;
  else if(iu_ifu_reset_vld)
    addr_cnt[29:10] <= sysio_ifu_rst_addr[31:12];
  else if(addr_cnt_high_upd_en)
    addr_cnt[29:10] <= inc_addr[29:10];
end

assign inc_addr[29:0] = ibus_addr[30:1] + {29'b0, bmu_xx_ibus_grnt};

//==============================================================================
//               The Relust from I-BUS
//==============================================================================
//the data from ibus come with the buspol info
assign bmu_xx_ibus_data_aft_pol[31:0] = bmu_xx_ibus_data[31:0];

assign ibus_data[31:0] = {bmu_xx_ibus_data_aft_pol[31:16], unalign_fetch_reg ?
                          bmu_xx_ibus_data_aft_pol[31:16] :
                          bmu_xx_ibus_data_aft_pol[15:0]}; 

////////////////////////////////////////////////////////////////////////////////
//                              Control Logic                                 //
////////////////////////////////////////////////////////////////////////////////

//==============================================================================
//               I-BUS Fetch Mode: Align or Unalign (for inst fetch only)
//==============================================================================
//When the requset address is not word aligned, only half of
//the word fed back will be creat into instruction buffer.
always @(posedge sm_upd_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    unalign_fetch_reg <= 1'b0;
  else if(change_flow_vld)
    unalign_fetch_reg <= ibus_addr[0];
  else if(ibus_inst_fetch_cmplt)
    unalign_fetch_reg <= 1'b0;
end    

assign ibus_prot[3:0] = {sysmap_ifu_acc_ca,
                         pmp_ifu_acc_scu,
                         cp0_yy_machine_mode_aft_dbg,
                         1'b0};

// for bus protocol, the request should remain the same when wait for grant
always @(posedge sm_upd_clk)
begin
  if(ibus_prot_buf)
    ibus_prot_reg[3:0] <= ibus_prot[3:0];
end

//==============================================================================
//               The Internal Instruction Request
//==============================================================================
//the insternal inst fetch req has two sources:
//1.the sequentail req from inst_buf
//2.the change flow req from IU
//when the lpmd req is asserted from cp0, the internal req will not be asserted
//the req can not be sent when in dbg mode
assign inst_chgflw_for_data = iu_ifu_inst_fetch_for_data;
assign internal_inst_fetch_pre = ibuf_ibusif_inst_fetch 
                                    && !inst_chgflw_for_data
                                    && !addr_cnt_high_upd_en_local
                              || iu_ifu_inst_fetch;

assign internal_inst_fetch = internal_inst_fetch_pre &&
                             !lpmd_mask &&
                             !iu_yy_xx_dbgon &&
                             !iu_ifu_lockup_on &&
                             !iu_ifu_inst_fetch_mask &&
                             !iu_ifu_security_violation;

assign lpmd_mask = cp0_ifu_in_lpmd || cp0_ifu_lpmd_req || cp0_ifu_srst_req || cp0_ifu_srst_mask || iu_ifu_lockup_req;

//==============================================================================
//               The IBUS State Machine
//==============================================================================
//==========================================================
//               Main State Machine 
//==========================================================
assign flop_out_bus = 1'b0;

always @(posedge sm_upd_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cur_st[2:0] <= RESET;
  else
    cur_st[2:0]  <= nxt_st[2:0];
end


// &CombBeg; @252
always @( internal_inst_fetch
       or bmu_xx_ibus_trans_cmplt
       or bmu_xx_ibus_grnt
       or flop_out_bus
       or cp0_ifu_rst_inv_done
       or cur_st)
begin
case(cur_st)
RESET:
begin
  if(cp0_ifu_rst_inv_done)
    nxt_st = IDLE;
  else
    nxt_st = RESET;
end
IDLE:
begin
  if(internal_inst_fetch)
    begin
      if(bmu_xx_ibus_grnt)
        nxt_st = WFD1;
      else
        nxt_st = WFG1;
    end
  else
    nxt_st = IDLE;
end
WFG1:
begin
  if(bmu_xx_ibus_grnt)
    nxt_st = WFD1;
  else
    nxt_st = WFG1;
end
WFD1:
begin
  if(bmu_xx_ibus_trans_cmplt)
    begin
      if(internal_inst_fetch)
        begin
          if(bmu_xx_ibus_grnt)
            nxt_st = WFD1;
          else
            nxt_st = WFG1;
        end
      else
        nxt_st = IDLE;
    end
  else if(internal_inst_fetch && flop_out_bus)
    begin //flop out bus can grant 2 outstanding inst fetch
      if(bmu_xx_ibus_grnt)
        nxt_st = WFD1WFD2;
      else
        nxt_st = WFD1WFG2;
    end
  else if(internal_inst_fetch)
    nxt_st = WFD1WFG2;
  else
    nxt_st = WFD1;
end
WFD1WFG2:
begin
  if(bmu_xx_ibus_trans_cmplt)
    begin
      if(bmu_xx_ibus_grnt)
        nxt_st = WFD1;
      else
        nxt_st = WFG1;
    end
  else
    begin
      if(bmu_xx_ibus_grnt && flop_out_bus)
        nxt_st = WFD1WFD2;
      else
        nxt_st = WFD1WFG2;
    end
end
WFD1WFD2:
begin
  if(bmu_xx_ibus_trans_cmplt)
    nxt_st = WFD1;
  else
    nxt_st = WFD1WFD2;
end
default:
begin
  nxt_st = IDLE;
end
endcase
// &CombEnd; @335
end

assign ibus_busy = !cur_st[0];

assign ibus_inst_fetch_cmplt = ((cur_st == WFD1) 
                             || (cur_st == WFD1WFG2)
                             || (cur_st == WFD1WFD2)
                               )  && bmu_xx_ibus_trans_cmplt
                                  && !ibus_trans_abort;
assign ibus_acc_err = ((cur_st == WFD1)
                    || (cur_st == WFD1WFG2)
                    || (cur_st == WFD1WFD2)
                      )  &&  bmu_xx_ibus_acc_err;
assign ibus_inst_req = (cur_st == IDLE)
                         && internal_inst_fetch
                    || (cur_st == WFG1)
                    || (cur_st == WFD1)
                         && internal_inst_fetch
                    || (cur_st == WFD1WFG2);
                    
assign ibus_abort_trig = (cur_st == WFD1)
                           && !bmu_xx_ibus_trans_cmplt
//                           && internal_inst_fetch
                           && change_flow_vld; 

assign ibus_no_outstanding = (cur_st == IDLE)
                          || (cur_st == WFG1)
                          || (cur_st == WFD1)
                               && bmu_xx_ibus_trans_cmplt
                          || (cur_st == WFD1WFG2)
                               && bmu_xx_ibus_trans_cmplt;

assign ibus_prot_buf = ((cur_st == IDLE) || (cur_st == WFD1))
                    && ((nxt_st == WFG1) || (nxt_st == WFD1WFG2));

assign ibus_prot_buf_sel = (cur_st == WFG1) || (cur_st == WFD1WFG2);

assign ibus_req = ibus_inst_req || iu_ifu_data_fetch;


//the abort SM
always @(posedge ifu_misc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    abort_cur_st <= ABORT_IDLE;
  else
    abort_cur_st <= abort_nxt_st;
end

// &CombBeg; @384
always @( abort_cur_st
       or bmu_xx_ibus_trans_cmplt
       or ibus_abort_trig)
begin
case(abort_cur_st)
ABORT_IDLE:
begin
  abort_nxt_st = ABORT_IDLE;
  if(ibus_abort_trig)
    abort_nxt_st = ABORT_VLD;
end
ABORT_VLD:
begin
  abort_nxt_st = ABORT_VLD;
  if(bmu_xx_ibus_trans_cmplt)
    abort_nxt_st = ABORT_IDLE;
end
default:
begin
  abort_nxt_st = ABORT_IDLE;
end
endcase
// &CombEnd; @403
end

assign ibus_trans_abort = (abort_cur_st == ABORT_VLD);

assign ibusif_top_clk_en = ibus_abort_trig || ibus_trans_abort;

//==============================================================================
//               Pre-decode of inst from IBUS
//==============================================================================
// when the data from ibus is MULT(when no multiplier) or DIV or branch/jump, 
// the inst can not be bypassed
assign ibus_inst_no_bypass = ibus_inst_mad;
//mad cannot be bypassed in IF stage
//assign ibus_inst_mad = ibus_data[6:0] == 7'b0110011 && ibus_data[25];
//assign ibus_inst_mad32_high = ibus_data[9];
assign ibus_inst_mad = 1'b0;
assign ibus_inst_mad32_high = 1'b0;
//when ibuf only has high half of 32bit inst, but the inst is mad, bypass not
//happen

////////////////////////////////////////////////////////////////////////////////
//                              Interface                                     //
////////////////////////////////////////////////////////////////////////////////
//==========================================================
//               Interface to BMU 
//==========================================================
assign ifu_bmu_req = ibus_req;
assign ifu_bmu_idle = ibus_no_outstanding;
//when data fetch for expt, the ibus SM is in IDLE, acc deny need to cmplt
assign ifu_bmu_wfd1 = (cur_st == WFD1) || (cur_st == IDLE);
assign ifu_bmu_addr[31:0] = {ibus_addr[30:1], 2'b0};
assign ifu_bmu_prot[3:0] = ibus_prot_buf_sel ? ibus_prot_reg[3:0]
                                             : ibus_prot[3:0];

//==========================================================
//               Interface to IF ctrl 
//==========================================================
assign ibusif_ifctrl_inst_no_bypass = ibus_inst_no_bypass;
assign ibusif_ifctrl_inst_mad32_high = ibus_inst_mad32_high;
//assign ibufif_ifctrl_unalign_16bit_inst = !(ibus_data[31:30] == 2'b11);

//==========================================================
//               Interface to inst buffer
//==========================================================
assign ibusif_ibuf_no_trans = (cur_st == IDLE);

//==========================================================
//               Interface to Multi Modules
//==========================================================
assign ibusif_xx_ibus_idle = !ibus_busy;
assign ibusif_xx_data[31:0] = ibus_data[31:0];
assign ibusif_xx_acc_err = ibus_acc_err && !iu_yy_xx_dbgon;
assign ibusif_xx_unalign_fetch = unalign_fetch_reg;
//the cmplt signal is not useful when in dbg mode
assign ibusif_xx_trans_cmplt = ibus_inst_fetch_cmplt
                           && !iu_ifu_inst_fetch_mask //when expt no inst to ifu is valid
                           && !iu_ifu_lockup_mask //when expt no inst to ifu is valid
                           && !iu_yy_xx_dbgon;
assign ibusif_xx_16bit_inst = !(ibus_data[1:0] == 2'b11);

//==========================================================
//               Interface to IU
//==========================================================
//assign ifu_iu_ibus_idle = cur_st == IDLE;
assign ifu_iu_ibus_idle = !ibus_busy;
assign ifu_iu_vector_ibus_in_idle = (cur_st == IDLE);
assign ifu_iu_xx_ibus_data[31:0]  = bmu_xx_ibus_data_aft_pol[31:0];
//assign ifu_iu_xx_ibus_acc_err  = ibus_acc_err;
//==========================================================
//               Interface to CP0
//==========================================================
assign ifu_cp0_lpmd_ack = cp0_ifu_lpmd_req && (cur_st == IDLE);
assign ifu_cp0_srst_ack = cp0_ifu_srst_req && (cur_st == IDLE);
assign ifu_iu_lockup_ack = iu_ifu_lockup_req && (cur_st == IDLE);
assign ifu_cp0_rst_inv_req = cur_st == RESET;

// &ModuleEnd; @494
endmodule


