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
module cr_clic_kid(
  busif_kid_clicintattr_sel,
  busif_kid_clicintctl_sel,
  busif_kid_clicintie_sel,
  busif_kid_clicintip_sel,
  busif_kid_wdata,
  busif_xx_write_vld,
  clicintattr_clk,
  clicintctl_clk,
  clicintie_clk,
  clicintip_clk,
  cpu_clic_mode,
  cpurst_b,
  ctrl_kid_ack_int,
  kid_arb_int_all,
  kid_arb_int_hv,
  kid_arb_int_req,
  kid_busif_rdata,
  kid_ctrl_clicintattr_en,
  kid_ctrl_clicintctl_en,
  kid_ctrl_clicintie_en,
  kid_ctrl_clicintip_en,
  kid_ctrl_sample_en,
  kid_int_vld,
  sample_clk
);

// &Ports; @23
input           busif_kid_clicintattr_sel; 
input           busif_kid_clicintctl_sel; 
input           busif_kid_clicintie_sel;  
input           busif_kid_clicintip_sel;  
input   [31:0]  busif_kid_wdata;          
input           busif_xx_write_vld;       
input           clicintattr_clk;          
input           clicintctl_clk;           
input           clicintie_clk;            
input           clicintip_clk;            
input   [1 :0]  cpu_clic_mode;            
input           cpurst_b;                 
input           ctrl_kid_ack_int;         
input           kid_int_vld;              
input           sample_clk;               
output  [3 :0]  kid_arb_int_all;          
output          kid_arb_int_hv;           
output          kid_arb_int_req;          
output  [31:0]  kid_busif_rdata;          
output          kid_ctrl_clicintattr_en;  
output          kid_ctrl_clicintctl_en;   
output          kid_ctrl_clicintie_en;    
output          kid_ctrl_clicintip_en;    
output          kid_ctrl_sample_en;       

// &Regs; @24
reg             clicintattr_shv;          
reg     [1 :0]  clicintattr_trig;         
reg             int_enable;               
reg             int_pending;              
reg             int_pending_updt_val;     
reg     [2 :0]  int_prio;                 
reg             int_vld_ff;               

// &Wires; @25
wire            busif_kid_clicintattr_sel; 
wire            busif_kid_clicintctl_sel; 
wire            busif_kid_clicintie_sel;  
wire            busif_kid_clicintip_sel;  
wire    [31:0]  busif_kid_wdata;          
wire            busif_xx_write_vld;       
wire            clicintattr_clk;          
wire    [1 :0]  clicintattr_mode;         
wire    [7 :0]  clicintattr_reg;          
wire    [7 :0]  clicintattr_updt_val;     
wire            clicintattr_updt_vld;     
wire            clicintctl_clk;           
wire    [7 :0]  clicintctl_reg;           
wire    [7 :0]  clicintctl_updt_val;      
wire            clicintctl_updt_vld;      
wire            clicintie_clk;            
wire    [7 :0]  clicintie_reg;            
wire            clicintie_updt_vld;       
wire            clicintip_clk;            
wire    [7 :0]  clicintip_reg;            
wire    [1 :0]  cpu_clic_mode;            
wire            cpurst_b;                 
wire            ctrl_kid_ack_int;         
wire            int_enable_updt_val;      
wire            int_level;                
wire            int_neg_pulse;            
wire            int_pending_clear;        
wire            int_pending_set;          
wire            int_pending_updt_val_raw; 
wire            int_pending_updt_vld;     
wire            int_pos_pulse;            
wire            int_pulse;                
wire            int_vld;                  
wire    [3 :0]  kid_arb_int_all;          
wire            kid_arb_int_hv;           
wire            kid_arb_int_req;          
wire    [31:0]  kid_busif_rdata;          
wire            kid_ctrl_clicintattr_en;  
wire            kid_ctrl_clicintctl_en;   
wire            kid_ctrl_clicintie_en;    
wire            kid_ctrl_clicintip_en;    
wire            kid_ctrl_sample_en;       
wire            kid_int_mode;             
wire            kid_int_vld;              
wire            kid_mode_vld;             
wire            kid_write_vld;            
wire            sample_clk;               
wire            sw_clear_pending;         
wire            sw_set_pending;           


parameter CLICINTCTLBITS = `CLIC_INTCTLBITS;

parameter INT_MODE_U     = 1'b0;
parameter INT_MODE_M     = 1'b1;
parameter CPU_MODE_U     = 2'b00;
parameter CPU_MODE_M     = 2'b11;

//==========================================================
//                    Rename Input
//==========================================================
assign int_pending_updt_val_raw  = busif_kid_wdata[0];
assign int_enable_updt_val       = busif_kid_wdata[8];
assign clicintattr_updt_val[7:0] = busif_kid_wdata[23:16];
assign clicintctl_updt_val[7:0]  = busif_kid_wdata[31:24];

assign int_vld = kid_int_vld;


//==========================================================
//                    kid mode Vld
//==========================================================
// if cpu mode is M, all is vld.
// if cpu mode is U, only U mode int is vld.
assign kid_mode_vld = cpu_clic_mode[1:0] == CPU_MODE_M
                   || cpu_clic_mode[1:0] == CPU_MODE_U && kid_int_mode == INT_MODE_U;

//==========================================================
//                     Write Vld
//==========================================================
assign kid_write_vld  = busif_xx_write_vld && kid_mode_vld;
assign sw_set_pending       = kid_write_vld && busif_kid_clicintip_sel && int_pending_updt_val_raw;
assign sw_clear_pending     = kid_write_vld && busif_kid_clicintip_sel && !int_pending_updt_val_raw;
assign clicintie_updt_vld   = kid_write_vld && busif_kid_clicintie_sel;
assign clicintattr_updt_vld = kid_write_vld && busif_kid_clicintattr_sel;
assign clicintctl_updt_vld  = kid_write_vld && busif_kid_clicintctl_sel;

//------------------------------------------------
//                  Interrupt Sample
//------------------------------------------------
assign kid_ctrl_sample_en = int_vld ^ int_vld_ff;

always@(posedge sample_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    int_vld_ff <= 1'b0;
  else
    int_vld_ff <= int_vld;
end

assign int_level = int_vld;
assign int_pos_pulse = int_vld && !int_vld_ff;
assign int_neg_pulse = !int_vld && int_vld_ff;

//===========================================================
//     interrupt control/status register
//===========================================================

//------------------------------------------------
//  security bit
//------------------------------------------------
// assign op_en = 1'b1;
// // &Force("input","ctl_xx_prot_sec"); @106
// // &Force("input","int_sec_updt_val"); @107

//==========================================================
//                       CLICINTIP
//==========================================================
assign int_pulse = clicintattr_trig[1:0] == 2'b01 && int_pos_pulse
                || clicintattr_trig[1:0] == 2'b11 && int_neg_pulse;

assign int_pending_set   = int_pulse || sw_set_pending;
assign int_pending_clear = ctrl_kid_ack_int || sw_clear_pending;

assign int_pending_updt_vld = int_pending_set || int_pending_clear;

// assign kid_ctrl_clicintip_en = !int_pending & int_pending_set ||
//                                 int_pending & int_pending_clear & !int_pending_set;
assign kid_ctrl_clicintip_en = int_pending_updt_vld
                            || !clicintattr_trig[0] && (int_vld_ff ^ int_vld);


// &CombBeg; @127
always @( int_pending_clear
       or int_pending
       or int_pending_set)
begin
if (int_pending_set)
  int_pending_updt_val = 1'b1;
else if (int_pending_clear)
  int_pending_updt_val = 1'b0;
else
  int_pending_updt_val = int_pending;
// &CombEnd; @134
end

always@(posedge clicintip_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    int_pending <= 1'b0;
  else if (!clicintattr_trig[0])
    int_pending <= int_level;
  else if (int_pending_updt_vld)
    int_pending <= int_pending_updt_val;
  else
    int_pending <= int_pending;
end
assign clicintip_reg[7:0] = {7'b0, int_pending};
//==========================================================
//                       CLICINTIE
//==========================================================
// assign int_enable_updt_vld = op_en && clicintie_updt_vld;
assign kid_ctrl_clicintie_en = clicintie_updt_vld;

always@(posedge clicintie_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    int_enable <= 1'b0;
  else if(clicintie_updt_vld)
    int_enable <= int_enable_updt_val;
  else
    int_enable <= int_enable;
end
assign clicintie_reg[7:0] = {7'b0, int_enable};
//==========================================================
//                      CLICINTATTR
//==========================================================
assign kid_ctrl_clicintattr_en = clicintattr_updt_vld;

always @ (posedge clicintattr_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    clicintattr_trig[1:0] <= 2'b0;
    clicintattr_shv       <= 1'b0;
  end
  else if (clicintattr_updt_vld) begin
    clicintattr_trig[1:0] <= clicintattr_updt_val[2:1];
    clicintattr_shv       <= clicintattr_updt_val[0];
  end
  else begin
    clicintattr_trig[1:0] <= clicintattr_trig[1:0];
    clicintattr_shv       <= clicintattr_shv;
  end
end
assign clicintattr_mode[1:0] = 2'b11;
assign kid_int_mode = 1'b1;

assign clicintattr_reg[7:0] = {clicintattr_mode[1:0],
                               3'b0,
                               clicintattr_trig[1:0],
                               clicintattr_shv};


//==========================================================
//                      CLICINTCTL
//==========================================================
assign kid_ctrl_clicintctl_en = clicintctl_updt_vld;

always@(posedge clicintctl_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    int_prio[CLICINTCTLBITS-1:0] <= {CLICINTCTLBITS{1'b0}};
  else if(clicintctl_updt_vld)
    int_prio[CLICINTCTLBITS-1:0] <= clicintctl_updt_val[7:8-CLICINTCTLBITS];
end

assign clicintctl_reg[7:0] = {int_prio[CLICINTCTLBITS-1:0],
                              {(8-CLICINTCTLBITS){1'b1}}};


//==========================================================
//                       Read Data
//==========================================================
assign kid_busif_rdata[31:0] = {({8{busif_kid_clicintctl_sel}}  & clicintctl_reg[7:0]),
                                ({8{busif_kid_clicintattr_sel}} & clicintattr_reg[7:0]),
                                ({8{busif_kid_clicintie_sel}}   & clicintie_reg[7:0]),
                                ({8{busif_kid_clicintip_sel}}   & clicintip_reg[7:0])}
                             & {32{kid_mode_vld}};


//==========================================================
//     OUTPUT
//==========================================================
// TO arbiter
//------------------------------------------------

assign kid_arb_int_req       = int_enable & int_pending;
// &Force("output", "kid_arb_int_req"); @227
assign kid_arb_int_hv        = clicintattr_shv;
// int_all has three field:
//   [CLICINTCTLBITS]: mode
//   [CLICINTCTLBITS-1: CLICINTCTLBITS-1-nlbits]: int level
//   [CLICINTCTLBITS-2-nlbits]: prio level
assign kid_arb_int_all[CLICINTCTLBITS:0] = {kid_int_mode,
                                           int_prio[CLICINTCTLBITS-1:0]}
                                        & {(CLICINTCTLBITS+1){kid_arb_int_req}};
// assign kid_arb_int_sec    = 1'b0;



// &ModuleEnd; @244
endmodule


