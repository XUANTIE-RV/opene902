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
module cr_clic_ctrl(
  arb_ctrl_int_hv,
  arb_ctrl_int_id,
  arb_ctrl_int_il,
  arb_ctrl_int_mode,
  busif_ctrl_cliccfg_sel,
  busif_ctrl_clicinfo_sel,
  busif_ctrl_mintthresh_sel,
  busif_kid_wdata,
  busif_xx_write_vld,
  clic_cpu_int_hv,
  clic_cpu_int_id,
  clic_cpu_int_il,
  clic_cpu_int_priv,
  clicreg_clk,
  cpu_clic_curid,
  cpu_clic_int_exit,
  cpu_clic_mode,
  cpurst_b,
  ctrl_busif_cliccfg_val,
  ctrl_busif_clicinfo_val,
  ctrl_busif_mintthresh_val,
  ctrl_clicintattr_en,
  ctrl_clicintctl_en,
  ctrl_clicintie_en,
  ctrl_clicintip_en,
  ctrl_clicreg_en,
  ctrl_kid_ack_int,
  ctrl_sample_en,
  ctrl_xx_int_lv_or_mask,
  kid_ctrl_clicintattr_en,
  kid_ctrl_clicintctl_en,
  kid_ctrl_clicintie_en,
  kid_ctrl_clicintip_en,
  kid_ctrl_sample_en,
  out_clk
);

// &Ports; @23
input           arb_ctrl_int_hv;          
input   [11:0]  arb_ctrl_int_id;          
input   [7 :0]  arb_ctrl_int_il;          
input           arb_ctrl_int_mode;        
input           busif_ctrl_cliccfg_sel;   
input           busif_ctrl_clicinfo_sel;  
input           busif_ctrl_mintthresh_sel; 
input   [31:0]  busif_kid_wdata;          
input           busif_xx_write_vld;       
input           clicreg_clk;              
input   [11:0]  cpu_clic_curid;           
input           cpu_clic_int_exit;        
input   [1 :0]  cpu_clic_mode;            
input           cpurst_b;                 
input   [79:0]  kid_ctrl_clicintattr_en;  
input   [79:0]  kid_ctrl_clicintctl_en;   
input   [79:0]  kid_ctrl_clicintie_en;    
input   [79:0]  kid_ctrl_clicintip_en;    
input   [79:0]  kid_ctrl_sample_en;       
input           out_clk;                  
output          clic_cpu_int_hv;          
output  [11:0]  clic_cpu_int_id;          
output  [7 :0]  clic_cpu_int_il;          
output  [1 :0]  clic_cpu_int_priv;        
output  [31:0]  ctrl_busif_cliccfg_val;   
output  [31:0]  ctrl_busif_clicinfo_val;  
output  [31:0]  ctrl_busif_mintthresh_val; 
output          ctrl_clicintattr_en;      
output          ctrl_clicintctl_en;       
output          ctrl_clicintie_en;        
output          ctrl_clicintip_en;        
output          ctrl_clicreg_en;          
output  [79:0]  ctrl_kid_ack_int;         
output          ctrl_sample_en;           
output  [2 :0]  ctrl_xx_int_lv_or_mask;   

// &Regs; @24
reg             clic_cpu_int_hv;          
reg     [11:0]  clic_cpu_int_id;          
reg     [7 :0]  clic_cpu_int_il;          
reg     [1 :0]  clic_cpu_int_priv;        
reg     [3 :0]  cliccfg_nlbits;           
reg     [7 :0]  mintthresh_mth;           
reg     [7 :0]  mintthresh_uth;           

// &Wires; @25
wire            arb_ctrl_int_hv;          
wire    [11:0]  arb_ctrl_int_id;          
wire    [7 :0]  arb_ctrl_int_il;          
wire            arb_ctrl_int_mode;        
wire            busif_ctrl_cliccfg_sel;   
wire            busif_ctrl_mintthresh_sel; 
wire    [31:0]  busif_kid_wdata;          
wire            busif_xx_write_vld;       
wire    [1 :0]  cliccfg_nmbits;           
wire            cliccfg_nmbits_0;         
wire            cliccfg_nvbits;           
wire    [31:0]  cliccfg_reg;              
wire    [7 :0]  cliccfg_updt_val;         
wire    [3 :0]  clicinfo_arch_ver;        
wire    [3 :0]  clicinfo_clicintctlbits;  
wire    [3 :0]  clicinfo_impl_ver;        
wire    [12:0]  clicinfo_num_int;         
wire    [31:0]  clicinfo_reg;             
wire            clicreg_clk;              
wire    [1 :0]  cpu_clic_mode;            
wire            cpurst_b;                 
wire    [31:0]  ctrl_busif_cliccfg_val;   
wire    [31:0]  ctrl_busif_clicinfo_val;  
wire    [31:0]  ctrl_busif_mintthresh_val; 
wire            ctrl_cliccfg_updt_vld;    
wire            ctrl_clicintattr_en;      
wire            ctrl_clicintctl_en;       
wire            ctrl_clicintie_en;        
wire            ctrl_clicintip_en;        
wire            ctrl_clicreg_en;          
wire            ctrl_int_gt_thresh;       
wire            ctrl_mintthresh_updt_vld; 
wire            ctrl_mode_vld;            
wire            ctrl_sample_en;           
wire    [7 :0]  ctrl_thresh;              
wire            ctrl_write_vld;           
wire    [79:0]  kid_ctrl_clicintattr_en;  
wire    [79:0]  kid_ctrl_clicintctl_en;   
wire    [79:0]  kid_ctrl_clicintie_en;    
wire    [79:0]  kid_ctrl_clicintip_en;    
wire    [79:0]  kid_ctrl_sample_en;       
wire    [7 :0]  mintthresh_hth;           
wire    [31:0]  mintthresh_reg;           
wire    [7 :0]  mintthresh_sth;           
wire    [31:0]  mintthresh_updt_val;      
wire            out_clk;                  


parameter CLICINTNUM = `CLIC_INTNUM;
parameter CLICINTCTLBITS = `CLIC_INTCTLBITS;
parameter ID_WIDTH = 12;

parameter INT_MODE_U     = 1'b0;
parameter INT_MODE_M     = 1'b1;
parameter CPU_MODE_U     = 2'b00;
parameter CPU_MODE_M     = 2'b11;

//==========================================================
//                    Rename Input
//==========================================================
assign cliccfg_updt_val[7:0]     = busif_kid_wdata[7:0];
// assign clicinfo_updt_val[31:0]   = busif_kid_wdata[31:0];
assign mintthresh_updt_val[31:0] = busif_kid_wdata[31:0];


//==========================================================
//                    Write Vld
//==========================================================
assign ctrl_mode_vld = cpu_clic_mode[1:0] == CPU_MODE_M;
assign ctrl_write_vld = busif_xx_write_vld && ctrl_mode_vld;
assign ctrl_cliccfg_updt_vld    = ctrl_write_vld && busif_ctrl_cliccfg_sel;
// &Force("input", "busif_ctrl_clicinfo_sel"); @50
// assign ctrl_clicinfo_updt_vld   = ctrl_write_vld && busif_ctrl_clicinfo_sel;
assign ctrl_mintthresh_updt_vld = ctrl_write_vld && busif_ctrl_mintthresh_sel;

//==========================================================
//                     CLICCFG
//==========================================================
always @ (posedge clicreg_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    cliccfg_nlbits[3:0] <= 4'b0;
  end
  else if (ctrl_cliccfg_updt_vld) begin
    cliccfg_nlbits[3:0] <= cliccfg_updt_val[4] ? 4'd8 : cliccfg_updt_val[4:1];  // if nlbits > 8, it will be 8.
  end
  else begin
    cliccfg_nlbits[3:0] <= cliccfg_nlbits[3:0];
  end
end

// cliccfg_nmbits only can be 0/1 so [1] is not use.
assign cliccfg_nmbits_0 = 1'b0;
assign cliccfg_nmbits[1:0] = {1'b0, cliccfg_nmbits_0};
assign cliccfg_nvbits      = 1'b1;
assign cliccfg_reg[31:0]    = {25'b0,
                               cliccfg_nmbits[1:0],
                               cliccfg_nlbits[3:0],
                               cliccfg_nvbits};


//==========================================================
//                     CLICINFO
//==========================================================
//csky vperl_off
assign clicinfo_clicintctlbits[3:0] = $unsigned(CLICINTCTLBITS) & 4'hf;
assign clicinfo_arch_ver[3:0] = 4'b0;
assign clicinfo_impl_ver[3:0] = 4'b0;
assign clicinfo_num_int[12:0] = $unsigned(CLICINTNUM) & 13'h1fff;
//csky vperl_on
// &Force("nonport", "clicinfo_clicintctlbits"); @89
// &Force("nonport", "clicinfo_arch_ver"); @90
// &Force("nonport", "clicinfo_impl_ver"); @91
// &Force("nonport", "clicinfo_num_int"); @92

assign clicinfo_reg[31:0] = {7'b0,
                             clicinfo_clicintctlbits[3:0],
                             clicinfo_arch_ver[3:0],
                             clicinfo_impl_ver[3:0],
                             clicinfo_num_int[12:0]};


//==========================================================
//                     MINTTHRESH
//==========================================================
always @ (posedge clicreg_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    mintthresh_mth[7:0] <= 8'b0;
    // mintthresh_hth[7:0] <= 8'b0;
    // mintthresh_sth[7:0] <= 8'b0;
    mintthresh_uth[7:0] <= 8'b0;
  end
  else if (ctrl_mintthresh_updt_vld) begin
    mintthresh_mth[7:0] <= mintthresh_updt_val[31:24];
    // mintthresh_hth[7:0] <= mintthresh_updt_val[23:16];
    // mintthresh_sth[7:0] <= mintthresh_updt_val[15:8];
    mintthresh_uth[7:0] <= mintthresh_updt_val[7:0];
  end
  else begin
    mintthresh_mth[7:0] <= mintthresh_mth[7:0];
    // mintthresh_hth[7:0] <= mintthresh_hth[7:0];
    // mintthresh_sth[7:0] <= mintthresh_sth[7:0];
    mintthresh_uth[7:0] <= mintthresh_uth[7:0];
  end
end

assign mintthresh_hth[7:0] = 8'b0;
assign mintthresh_sth[7:0] = 8'b0;

assign mintthresh_reg[31:0] = {mintthresh_mth[7:0],
                               mintthresh_hth[7:0],
                               mintthresh_sth[7:0],
                               mintthresh_uth[7:0]};


//==========================================================
//                        CPU Ack
//==========================================================
// &Force("output", "ctrl_kid_ack_int"); @138
// &Force("bus", "ctrl_kid_ack_int", CLICINTNUM-1, 0); @139
// &Force("input", "cpu_clic_curid"); @140
// &Force("bus", "cpu_clic_curid", ID_WIDTH-1, 0); @141
// &Force("input", "cpu_clic_int_exit"); @142

//csky vperl_off
wire [CLICINTNUM-1:0]   ctrl_kid_ack_sel;
wire [CLICINTNUM-1:0]   ctrl_kid_ack_int;
wire [ID_WIDTH-1:0]     cpu_clic_curid;
wire                    cpu_clic_int_exit;

genvar i;
generate
for (i = 0; i < CLICINTNUM; i = i+1)
begin: KID_ACK
  assign ctrl_kid_ack_sel[i] = cpu_clic_curid[ID_WIDTH-1:0] == ($unsigned(i) & {ID_WIDTH{1'b1}});
  assign ctrl_kid_ack_int[i] = ctrl_kid_ack_sel[i] && cpu_clic_int_exit;
end
endgenerate
//csky vperl_on

//==========================================================
//                   For Gate Clk Cell
//==========================================================
assign ctrl_sample_en      = |kid_ctrl_sample_en[CLICINTNUM-1:0];
assign ctrl_clicintip_en   = |kid_ctrl_clicintip_en[CLICINTNUM-1:0];
assign ctrl_clicintie_en   = |kid_ctrl_clicintie_en[CLICINTNUM-1:0];
assign ctrl_clicintattr_en = |kid_ctrl_clicintattr_en[CLICINTNUM-1:0];
assign ctrl_clicintctl_en  = |kid_ctrl_clicintctl_en[CLICINTNUM-1:0];

assign ctrl_clicreg_en     = ctrl_mintthresh_updt_vld || ctrl_cliccfg_updt_vld;
//==========================================================
//                      To busif
//==========================================================
// &Force("output", "ctrl_xx_int_lv_or_mask"); &Force("bus", "ctrl_xx_int_lv_or_mask", CLICINTCTLBITS-1, 0); @173
//csky vperl_off
wire [CLICINTCTLBITS-1:0] ctrl_xx_int_lv_or_mask;

generate
for (i = 0; i < CLICINTCTLBITS; i = i+1)
begin: LEVEL_MASK
  assign ctrl_xx_int_lv_or_mask[CLICINTCTLBITS-1-i] = !(($unsigned(i) & {4'hf}) < cliccfg_nlbits[3:0]);
end
endgenerate
//csky vperl_on

//==========================================================
//                      To busif
//==========================================================
assign ctrl_busif_cliccfg_val[31:0]    = cliccfg_reg    & {32{ctrl_mode_vld}};
assign ctrl_busif_clicinfo_val[31:0]   = clicinfo_reg   & {32{ctrl_mode_vld}};
assign ctrl_busif_mintthresh_val[31:0] = mintthresh_reg & {32{ctrl_mode_vld}};

//==========================================================
//                  Final judge mintthresh
//==========================================================
assign ctrl_thresh[7:0] = arb_ctrl_int_mode == INT_MODE_M ? mintthresh_mth[7:0]
                                                          : mintthresh_uth[7:0];
assign ctrl_int_gt_thresh = ctrl_thresh[7:0] < arb_ctrl_int_il[7:0];

always @ (posedge out_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    clic_cpu_int_hv               <= 1'b0;
    clic_cpu_int_id[ID_WIDTH-1:0] <= {ID_WIDTH{1'b0}};
    clic_cpu_int_priv[1:0]        <= 2'b0;
    clic_cpu_int_il[7:0]          <= 8'b0;
  end
  else begin
    clic_cpu_int_hv               <= arb_ctrl_int_hv;
    clic_cpu_int_id[ID_WIDTH-1:0] <= arb_ctrl_int_id[ID_WIDTH-1:0];
    clic_cpu_int_priv[1:0]        <= {2{arb_ctrl_int_mode}};
    clic_cpu_int_il[7:0]          <= {8{ctrl_int_gt_thresh}} & arb_ctrl_int_il[7:0];
  end
end

// &ModuleEnd; @215
endmodule


