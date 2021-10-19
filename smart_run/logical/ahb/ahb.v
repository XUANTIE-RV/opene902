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

//SYS MEM
`define S1_BASE_START 32'h60000000
`define S1_BASE_END   32'h600fffff
//APB
`define S2_BASE_START 32'h40000000
`define S2_BASE_END   32'h4fffffff
//IMEM
`define S4_BASE_START 32'h00000000
`define S4_BASE_END   32'h0007ffff
//DMEM
`define S5_BASE_START 32'h20000000
`define S5_BASE_END   32'h207fffff

// &Depend("environment.h"); @35
// &ModuleBeg; @36
module ahb(
  biu_pad_haddr,
  biu_pad_hburst,
  biu_pad_hprot,
  biu_pad_hsize,
  biu_pad_htrans,
  biu_pad_hwdata,
  biu_pad_hwrite,
  haddr_s1,
  haddr_s2,
  haddr_s3,
  haddr_s5,
  hburst_s1,
  hburst_s3,
  hburst_s5,
  hmastlock,
  hprot_s1,
  hprot_s3,
  hprot_s5,
  hrdata_s1,
  hrdata_s2,
  hrdata_s3,
  hrdata_s5,
  hready_s1,
  hready_s2,
  hready_s3,
  hready_s5,
  hresp_s1,
  hresp_s2,
  hresp_s3,
  hresp_s5,
  hsel_s1,
  hsel_s2,
  hsel_s3,
  hsel_s5,
  hsize_s1,
  hsize_s3,
  hsize_s5,
  htrans_s1,
  htrans_s3,
  htrans_s5,
  hwdata_s1,
  hwdata_s2,
  hwdata_s3,
  hwdata_s5,
  hwrite_s1,
  hwrite_s2,
  hwrite_s3,
  hwrite_s5,
  pad_biu_hrdata,
  pad_biu_hready,
  pad_biu_hresp,
  pad_cpu_rst_b,
  pll_core_cpuclk,
  smpu_deny
);

// &Ports; @37
input   [31:0]  biu_pad_haddr;  
input   [2 :0]  biu_pad_hburst; 
input   [3 :0]  biu_pad_hprot;  
input   [2 :0]  biu_pad_hsize;  
input   [1 :0]  biu_pad_htrans; 
input   [31:0]  biu_pad_hwdata; 
input           biu_pad_hwrite; 
input   [31:0]  hrdata_s1;      
input   [31:0]  hrdata_s2;      
input   [31:0]  hrdata_s3;      
input   [31:0]  hrdata_s5;      
input           hready_s1;      
input           hready_s2;      
input           hready_s3;      
input           hready_s5;      
input   [1 :0]  hresp_s1;       
input   [1 :0]  hresp_s2;       
input   [1 :0]  hresp_s3;       
input   [1 :0]  hresp_s5;       
input           pad_cpu_rst_b;  
input           pll_core_cpuclk; 
input           smpu_deny;      
output  [31:0]  haddr_s1;       
output  [31:0]  haddr_s2;       
output  [31:0]  haddr_s3;       
output  [31:0]  haddr_s5;       
output  [2 :0]  hburst_s1;      
output  [2 :0]  hburst_s3;      
output  [2 :0]  hburst_s5;      
output          hmastlock;      
output  [3 :0]  hprot_s1;       
output  [3 :0]  hprot_s3;       
output  [3 :0]  hprot_s5;       
output          hsel_s1;        
output          hsel_s2;        
output          hsel_s3;        
output          hsel_s5;        
output  [2 :0]  hsize_s1;       
output  [2 :0]  hsize_s3;       
output  [2 :0]  hsize_s5;       
output  [1 :0]  htrans_s1;      
output  [1 :0]  htrans_s3;      
output  [1 :0]  htrans_s5;      
output  [31:0]  hwdata_s1;      
output  [31:0]  hwdata_s2;      
output  [31:0]  hwdata_s3;      
output  [31:0]  hwdata_s5;      
output          hwrite_s1;      
output          hwrite_s2;      
output          hwrite_s3;      
output          hwrite_s5;      
output  [31:0]  pad_biu_hrdata; 
output          pad_biu_hready; 
output  [1 :0]  pad_biu_hresp;  

// &Regs; @38
reg             busy_s1;        
reg             busy_s2;        
reg             busy_s3;        
reg             busy_s4;        
reg             busy_s5;        
reg     [31:0]  pad_biu_hrdata; 
reg             pad_biu_hready; 
reg     [1 :0]  pad_biu_hresp;  

// &Wires; @39
wire            arb_block;      
wire    [31:0]  biu_pad_haddr;  
wire    [2 :0]  biu_pad_hburst; 
wire    [3 :0]  biu_pad_hprot;  
wire    [2 :0]  biu_pad_hsize;  
wire    [1 :0]  biu_pad_htrans; 
wire    [31:0]  biu_pad_hwdata; 
wire            biu_pad_hwrite; 
wire    [31:0]  haddr_s1;       
wire    [31:0]  haddr_s2;       
wire    [31:0]  haddr_s3;       
wire    [31:0]  haddr_s5;       
wire    [2 :0]  hburst_s1;      
wire    [2 :0]  hburst_s2;      
wire    [2 :0]  hburst_s3;      
wire    [2 :0]  hburst_s5;      
wire            hmastlock;      
wire    [3 :0]  hprot_s1;       
wire    [3 :0]  hprot_s2;       
wire    [3 :0]  hprot_s3;       
wire    [3 :0]  hprot_s5;       
wire    [31:0]  hrdata_s1;      
wire    [31:0]  hrdata_s2;      
wire    [31:0]  hrdata_s3;      
wire    [31:0]  hrdata_s4;      
wire    [31:0]  hrdata_s5;      
wire            hready_s1;      
wire            hready_s2;      
wire            hready_s3;      
wire            hready_s4;      
wire            hready_s5;      
wire    [1 :0]  hresp_s1;       
wire    [1 :0]  hresp_s2;       
wire    [1 :0]  hresp_s3;       
wire    [1 :0]  hresp_s4;       
wire    [1 :0]  hresp_s5;       
wire            hsel_s1;        
wire            hsel_s2;        
wire            hsel_s3;        
wire            hsel_s4;        
wire            hsel_s5;        
wire    [2 :0]  hsize_s1;       
wire    [2 :0]  hsize_s2;       
wire    [2 :0]  hsize_s3;       
wire    [2 :0]  hsize_s5;       
wire    [1 :0]  htrans_s1;      
wire    [1 :0]  htrans_s2;      
wire    [1 :0]  htrans_s3;      
wire    [1 :0]  htrans_s5;      
wire    [31:0]  hwdata_s1;      
wire    [31:0]  hwdata_s2;      
wire    [31:0]  hwdata_s3;      
wire    [31:0]  hwdata_s5;      
wire            hwrite_s1;      
wire            hwrite_s2;      
wire            hwrite_s3;      
wire            hwrite_s5;      
wire            pad_cpu_rst_b;  
wire            pll_core_cpuclk; 
wire            pre_busy_s1;    
wire            pre_busy_s2;    
wire            pre_busy_s3;    
wire            pre_busy_s4;    
wire            pre_busy_s5;    
wire            smpu_deny;      




// Support AHB LITE
assign    hmastlock            =    1'b0; 
// &Force("input","biu_pad_hbusreq"); @48

assign    haddr_s1[31:0]       =    biu_pad_haddr[31:0];  
assign    hburst_s1[2:0]       =    biu_pad_hburst[2:0]; 
assign    hprot_s1[3:0]        =    biu_pad_hprot[3:0];  
assign    hsize_s1[2:0]        =    biu_pad_hsize[2:0];  
assign    htrans_s1[1:0]       =    biu_pad_htrans[1:0]; 
assign    hwrite_s1            =    biu_pad_hwrite; 
assign    hwdata_s1[31:0]      =    biu_pad_hwdata[31:0]; 

assign    haddr_s2[31:0]       =    biu_pad_haddr[31:0];  
assign    hburst_s2[2:0]       =    biu_pad_hburst[2:0]; 
assign    hprot_s2[3:0]        =    biu_pad_hprot[3:0];  
assign    hsize_s2[2:0]        =    biu_pad_hsize[2:0];  
assign    htrans_s2[1:0]       =    biu_pad_htrans[1:0]; 
assign    hwrite_s2            =    biu_pad_hwrite; 
assign    hwdata_s2[31:0]      =    biu_pad_hwdata[31:0]; 
// &Force("nonport","hburst_s2"); @68
// &Force("nonport","hsize_s2"); @69
// &Force("nonport","htrans_s2"); @70
// &Force("nonport","hprot_s2"); @71
// &Force("bus","biu_pad_hprot",3,0); @72

assign    haddr_s3[31:0]       =    biu_pad_haddr[31:0];  
assign    hburst_s3[2:0]       =    biu_pad_hburst[2:0]; 
assign    hprot_s3[3:0]        =    biu_pad_hprot[3:0];  
assign    hsize_s3[2:0]        =    biu_pad_hsize[2:0];  
assign    htrans_s3[1:0]       =    biu_pad_htrans[1:0]; 
assign    hwrite_s3            =    biu_pad_hwrite; 
assign    hwdata_s3[31:0]      =    biu_pad_hwdata[31:0]; 

assign    hready_s4            =    1'b0;
assign    hrdata_s4[31:0]      =    32'b0;
assign    hresp_s4[1:0]        =    2'b0;

// &Force("output","hsel_s4"); @95

assign    haddr_s5[31:0]       =    biu_pad_haddr[31:0];  
assign    hburst_s5[2:0]       =    biu_pad_hburst[2:0]; 
assign    hprot_s5[3:0]        =    biu_pad_hprot[3:0];  
assign    hsize_s5[2:0]        =    biu_pad_hsize[2:0];  
assign    htrans_s5[1:0]       =    biu_pad_htrans[1:0]; 
assign    hwrite_s5            =    biu_pad_hwrite; 
assign    hwdata_s5[31:0]      =    biu_pad_hwdata[31:0]; 
// &Force("output","hsel_s5"); @113


// &Force("output","hsel_s1"); @117
// &Force("output","hsel_s2"); @118
// &Force("output","hsel_s3"); @119

assign    hsel_s1 = (biu_pad_htrans[1]==1'b1) && (biu_pad_haddr >= `S1_BASE_START) && (biu_pad_haddr <= `S1_BASE_END) 
                  && !arb_block && !smpu_deny;
assign    hsel_s2 = (biu_pad_htrans[1]==1'b1) && (biu_pad_haddr >= `S2_BASE_START) && (biu_pad_haddr <= `S2_BASE_END) 
                  && !arb_block && !smpu_deny;
assign    hsel_s3 = (biu_pad_htrans[1]==1'b1) && (!hsel_s1 && !hsel_s2 && !hsel_s4 && !hsel_s5 
                 || smpu_deny) && !arb_block;

assign    hsel_s4 = 0;

assign    hsel_s5 = (biu_pad_htrans[1]==1'b1) && (biu_pad_haddr >= `S5_BASE_START) && (biu_pad_haddr <= `S5_BASE_END) 
                  && !arb_block && !smpu_deny;


assign    pre_busy_s1 = hsel_s1 || busy_s1 && !hready_s1;
assign    pre_busy_s2 = hsel_s2 || busy_s2 && !hready_s2;
assign    pre_busy_s3 = hsel_s3 || busy_s3 && !hready_s3;
assign    pre_busy_s4 = 1'b0;

assign    pre_busy_s5 = hsel_s5 || busy_s5 && !hready_s5;
always @(posedge pll_core_cpuclk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)begin
  busy_s1 <= 1'b0;
  busy_s2 <= 1'b0;
  busy_s3 <= 1'b0;
  busy_s4 <= 1'b0;
  busy_s5 <= 1'b0;
  end
  else begin
  busy_s1 <= pre_busy_s1;
  busy_s2 <= pre_busy_s2;
  busy_s3 <= pre_busy_s3;
  busy_s4 <= pre_busy_s4;
  busy_s5 <= pre_busy_s5;
  end
end

assign arb_block = busy_s1 && !hready_s1 ||
                   busy_s2 && !hready_s2 ||
                   busy_s3 && !hready_s3 ||
                   busy_s4 && !hready_s4 ||
                   busy_s5 && !hready_s5;

//arbitration state machine
// &CombBeg; @182
always @( hresp_s3[1:0]
       or hready_s5
       or hresp_s1[1:0]
       or busy_s3
       or busy_s4
       or hresp_s5[1:0]
       or hrdata_s3[31:0]
       or hready_s3
       or busy_s2
       or hrdata_s2[31:0]
       or hrdata_s1[31:0]
       or hresp_s4[1:0]
       or busy_s5
       or hready_s2
       or busy_s1
       or hrdata_s4[31:0]
       or hready_s4
       or hrdata_s5[31:0]
       or hresp_s2[1:0]
       or hready_s1)
begin
  case({busy_s1,busy_s2,busy_s3,busy_s4,busy_s5})
    5'b10000:
    begin
      pad_biu_hrdata[31:0] = hrdata_s1[31:0];
      pad_biu_hready       = hready_s1;
      pad_biu_hresp[1:0]   = hresp_s1[1:0];
    end
    5'b01000:
    begin
      pad_biu_hrdata[31:0] = hrdata_s2[31:0];
      pad_biu_hready       = hready_s2;
      pad_biu_hresp[1:0]   = hresp_s2[1:0];
    end
    5'b00100:
    begin 
      pad_biu_hrdata[31:0] = hrdata_s3[31:0];
      pad_biu_hready       = hready_s3;
      pad_biu_hresp[1:0]   = hresp_s3[1:0];
    end
    5'b00010:
    begin 
      pad_biu_hrdata[31:0] = hrdata_s4[31:0];
      pad_biu_hready       = hready_s4;
      pad_biu_hresp[1:0]   = hresp_s4[1:0];
    end
    5'b00001:
    begin 
      pad_biu_hrdata[31:0] = hrdata_s5[31:0];
      pad_biu_hready       = hready_s5;
      pad_biu_hresp[1:0]   = hresp_s5[1:0];
    end
    default:
    begin
      pad_biu_hrdata[31:0] = 32'b0;
      pad_biu_hready       = 1'b1;
      pad_biu_hresp[1:0]   = 2'b0;
    end
  endcase
// &CombEnd; @221
end
// &ModuleEnd; @222
endmodule


