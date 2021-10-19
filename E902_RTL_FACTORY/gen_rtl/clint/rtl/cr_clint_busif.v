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
module cr_clint_busif(
  busif_regs_msip_sel,
  busif_regs_mtimecmp_hi_sel,
  busif_regs_mtimecmp_lo_sel,
  busif_regs_wdata,
  busif_regs_write_vld,
  clint_tcipif_cmplt,
  clint_tcipif_rdata,
  msip_value,
  mtime_hi_value,
  mtime_lo_value,
  mtimecmp_hi_value,
  mtimecmp_lo_value,
  tcipif_clint_addr,
  tcipif_clint_sel,
  tcipif_clint_wdata,
  tcipif_clint_write
);

// &Ports; @23
input   [31:0]  msip_value;                
input   [31:0]  mtime_hi_value;            
input   [31:0]  mtime_lo_value;            
input   [31:0]  mtimecmp_hi_value;         
input   [31:0]  mtimecmp_lo_value;         
input   [15:0]  tcipif_clint_addr;         
input           tcipif_clint_sel;          
input   [31:0]  tcipif_clint_wdata;        
input           tcipif_clint_write;        
output          busif_regs_msip_sel;       
output          busif_regs_mtimecmp_hi_sel; 
output          busif_regs_mtimecmp_lo_sel; 
output  [31:0]  busif_regs_wdata;          
output          busif_regs_write_vld;      
output          clint_tcipif_cmplt;        
output  [31:0]  clint_tcipif_rdata;        

// &Regs; @24

// &Wires; @25
wire            busif_read_vld;            
wire            busif_regs_msip_sel;       
wire            busif_regs_mtimecmp_hi_sel; 
wire            busif_regs_mtimecmp_lo_sel; 
wire    [31:0]  busif_regs_wdata;          
wire            busif_regs_write_vld;      
wire            clint_tcipif_cmplt;        
wire    [31:0]  clint_tcipif_rdata;        
wire            msip_sel;                  
wire    [31:0]  msip_value;                
wire            mtime_hi_sel;              
wire    [31:0]  mtime_hi_value;            
wire            mtime_lo_sel;              
wire    [31:0]  mtime_lo_value;            
wire            mtimecmp_hi_sel;           
wire    [31:0]  mtimecmp_hi_value;         
wire            mtimecmp_lo_sel;           
wire    [31:0]  mtimecmp_lo_value;         
wire    [15:0]  tcipif_clint_addr;         
wire            tcipif_clint_sel;          
wire    [31:0]  tcipif_clint_wdata;        
wire            tcipif_clint_write;        


parameter MSIP       = 16'h0000;

parameter MTIMECMPLO = 16'h4000;
parameter MTIMECMPHI = 16'h4004;

parameter MTIMELO    = 16'hbff8;
parameter MTIMEHI    = 16'hbffc;

assign msip_sel        = tcipif_clint_addr[15:0] == MSIP;
assign mtimecmp_lo_sel = tcipif_clint_addr[15:0] == MTIMECMPLO;
assign mtimecmp_hi_sel = tcipif_clint_addr[15:0] == MTIMECMPHI;
assign mtime_lo_sel    = tcipif_clint_addr[15:0] == MTIMELO;
assign mtime_hi_sel    = tcipif_clint_addr[15:0] == MTIMEHI;

assign busif_regs_msip_sel        = msip_sel;
assign busif_regs_mtimecmp_lo_sel = mtimecmp_lo_sel;
assign busif_regs_mtimecmp_hi_sel = mtimecmp_hi_sel;

assign clint_tcipif_cmplt = tcipif_clint_sel;

assign busif_regs_write_vld = tcipif_clint_sel && tcipif_clint_write;
assign busif_read_vld     = tcipif_clint_sel && !tcipif_clint_write;

assign clint_tcipif_rdata[31:0] = ({32{msip_sel}}        & msip_value[31:0]
                                 | {32{mtimecmp_lo_sel}} & mtimecmp_lo_value[31:0]
                                 | {32{mtimecmp_hi_sel}} & mtimecmp_hi_value[31:0]
                                 | {32{mtime_lo_sel}}    & mtime_lo_value[31:0]
                                 | {32{mtime_hi_sel}}    & mtime_hi_value[31:0])
                                 & {32{busif_read_vld}};

assign busif_regs_wdata[31:0] = tcipif_clint_wdata[31:0];

// &ModuleEnd; @59
endmodule


