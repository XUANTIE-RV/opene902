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
module cr_clic_busif(
  busif_ctrl_cliccfg_sel,
  busif_ctrl_clicinfo_sel,
  busif_ctrl_mintthresh_sel,
  busif_kid_clicintattr_sel,
  busif_kid_clicintctl_sel,
  busif_kid_clicintie_sel,
  busif_kid_clicintip_sel,
  busif_kid_wdata,
  busif_xx_write_vld,
  clic_tcipif_cmplt,
  clic_tcipif_rdata,
  ctrl_busif_cliccfg_val,
  ctrl_busif_clicinfo_val,
  ctrl_busif_mintthresh_val,
  kid_busif_rdata_vec,
  tcipif_clic_addr,
  tcipif_clic_sel,
  tcipif_clic_size,
  tcipif_clic_wdata,
  tcipif_clic_write
);

// &Ports; @24
input   [31  :0]  ctrl_busif_cliccfg_val;   
input   [31  :0]  ctrl_busif_clicinfo_val;  
input   [31  :0]  ctrl_busif_mintthresh_val; 
input   [2559:0]  kid_busif_rdata_vec;      
input   [15  :0]  tcipif_clic_addr;         
input             tcipif_clic_sel;          
input   [1   :0]  tcipif_clic_size;         
input   [31  :0]  tcipif_clic_wdata;        
input             tcipif_clic_write;        
output            busif_ctrl_cliccfg_sel;   
output            busif_ctrl_clicinfo_sel;  
output            busif_ctrl_mintthresh_sel; 
output  [79  :0]  busif_kid_clicintattr_sel; 
output  [79  :0]  busif_kid_clicintctl_sel; 
output  [79  :0]  busif_kid_clicintie_sel;  
output  [79  :0]  busif_kid_clicintip_sel;  
output  [31  :0]  busif_kid_wdata;          
output            busif_xx_write_vld;       
output            clic_tcipif_cmplt;        
output  [31  :0]  clic_tcipif_rdata;        

// &Regs; @25
reg     [3   :0]  busif_kid_reg_sel;        

// &Wires; @26
wire              busif_ctrl_cliccfg_sel;   
wire              busif_ctrl_clicinfo_sel;  
wire              busif_ctrl_mintthresh_sel; 
wire    [79  :0]  busif_kid_sel;            
wire    [31  :0]  busif_kid_wdata;          
wire              busif_read_vld;           
wire              busif_xx_write_vld;       
wire              clic_tcipif_cmplt;        
wire    [31  :0]  clic_tcipif_rdata;        
wire              cliccfg_sel;              
wire              clicinfo_sel;             
wire    [31  :0]  ctrl_busif_cliccfg_val;   
wire    [31  :0]  ctrl_busif_clicinfo_val;  
wire    [31  :0]  ctrl_busif_mintthresh_val; 
wire    [31  :0]  kid_busif_rdata;          
wire              mintthresh_sel;           
wire    [15  :0]  tcipif_clic_addr;         
wire              tcipif_clic_sel;          
wire    [1   :0]  tcipif_clic_size;         
wire    [31  :0]  tcipif_clic_wdata;        
wire              tcipif_clic_write;        


parameter CLICINTNUM = `CLIC_INTNUM;

parameter CLICCFG_BASE    = 16'h0000;
parameter CLICINFO_BASE   = 16'h0004;
parameter MINTTHRESH_BASE = 16'h0008;

parameter CLICKID_BASE    = 16'h1000;

assign cliccfg_sel    = tcipif_clic_addr[15:0] == CLICCFG_BASE;
assign clicinfo_sel   = tcipif_clic_addr[15:0] == CLICINFO_BASE;
assign mintthresh_sel = tcipif_clic_addr[15:0] == MINTTHRESH_BASE;
assign busif_ctrl_cliccfg_sel    = cliccfg_sel;
assign busif_ctrl_clicinfo_sel   = clicinfo_sel;
assign busif_ctrl_mintthresh_sel = mintthresh_sel;

assign clic_tcipif_cmplt = tcipif_clic_sel;
assign busif_kid_wdata[31:0] = tcipif_clic_wdata[31:0];

// &CombBeg; @46
always @( tcipif_clic_size[1:0]
       or tcipif_clic_addr[1:0])
begin
  case({tcipif_clic_addr[1:0], tcipif_clic_size[1:0]})
    4'b00_00: busif_kid_reg_sel[3:0] = 4'b0001; // Byte
    4'b01_00: busif_kid_reg_sel[3:0] = 4'b0010;
    4'b10_00: busif_kid_reg_sel[3:0] = 4'b0100;
    4'b11_00: busif_kid_reg_sel[3:0] = 4'b1000; // Half word
    4'b00_01: busif_kid_reg_sel[3:0] = 4'b0011;
    4'b10_01: busif_kid_reg_sel[3:0] = 4'b1100;
    4'b00_10: busif_kid_reg_sel[3:0] = 4'b1111;
    default:  busif_kid_reg_sel[3:0] = 4'b0000;
  endcase
// &CombEnd; @57
end
// &Force("nonport", "busif_kid_reg_sel"); @58
// &Force("nonport", "busif_kid_sel"); @59

// &Force("output", "busif_kid_clicintip_sel"); @61
// &Force("output", "busif_kid_clicintie_sel"); @62
// &Force("output", "busif_kid_clicintattr_sel"); @63
// &Force("output", "busif_kid_clicintctl_sel"); @64
// &Force("bus", "busif_kid_clicintip_sel", CLICINTNUM-1, 0); @65
// &Force("bus", "busif_kid_clicintie_sel", CLICINTNUM-1, 0); @66
// &Force("bus", "busif_kid_clicintattr_sel", CLICINTNUM-1, 0); @67
// &Force("bus", "busif_kid_clicintctl_sel", CLICINTNUM-1, 0); @68

//csky vperl_off
wire [CLICINTNUM-1:0] busif_kid_clicintip_sel;
wire [CLICINTNUM-1:0] busif_kid_clicintie_sel;
wire [CLICINTNUM-1:0] busif_kid_clicintattr_sel;
wire [CLICINTNUM-1:0] busif_kid_clicintctl_sel;

genvar i;
generate
for (i = 0; i < CLICINTNUM; i = i+1)
begin: BUSIF_KID
  assign busif_kid_sel[i] = (tcipif_clic_addr[15:2] - CLICKID_BASE[15:2]) == i;
  assign busif_kid_clicintip_sel[i]   = busif_kid_sel[i] && busif_kid_reg_sel[0];
  assign busif_kid_clicintie_sel[i]   = busif_kid_sel[i] && busif_kid_reg_sel[1];
  assign busif_kid_clicintattr_sel[i] = busif_kid_sel[i] && busif_kid_reg_sel[2];
  assign busif_kid_clicintctl_sel[i]  = busif_kid_sel[i] && busif_kid_reg_sel[3];
end
endgenerate
//csky vperl_on

assign busif_xx_write_vld = tcipif_clic_sel && tcipif_clic_write;
assign busif_read_vld     = tcipif_clic_sel && !tcipif_clic_write;
//==========================================================
//                      Read Sel
//==========================================================
// &Force("input", "kid_busif_rdata_vec"); @94
// &Force("bus", "kid_busif_rdata_vec", (CLICINTNUM)*32-1, 0); @95
// &Force("nonport", "kid_busif_rdata"); @96
//csky vperl_off
cr_clic_sel #(32, CLICINTNUM) x_cr_clic_kid_rdata_sel(
  .data_in         (kid_busif_rdata_vec),
  .sel_in_onehot   (busif_kid_sel),
  .data_out        (kid_busif_rdata)
);
//csky vperl_on

assign clic_tcipif_rdata[31:0] = {{32{cliccfg_sel}}    & ctrl_busif_cliccfg_val[31:0]
                                | {32{clicinfo_sel}}   & ctrl_busif_clicinfo_val[31:0]
                                | {32{mintthresh_sel}} & ctrl_busif_mintthresh_val[31:0]
                                | {32{|busif_kid_sel[CLICINTNUM-1:0]}} & kid_busif_rdata[31:0]}
                                & {32{busif_read_vld}};

// &ModuleEnd; @111
endmodule


