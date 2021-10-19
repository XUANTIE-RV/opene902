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
module err_gen(
  haddr_s3,
  hburst_s3,
  hmastlock,
  hprot_s3,
  hrdata_s3,
  hready_s3,
  hresp_s3,
  hsel_s3,
  hsize_s3,
  htrans_s3,
  hwdata_s3,
  hwrite_s3,
  pad_cpu_rst_b,
  pll_core_cpuclk
);

// &Ports; @23
input   [31:0]  haddr_s3;       
input   [2 :0]  hburst_s3;      
input           hmastlock;      
input   [3 :0]  hprot_s3;       
input           hsel_s3;        
input   [2 :0]  hsize_s3;       
input   [1 :0]  htrans_s3;      
input   [31:0]  hwdata_s3;      
input           hwrite_s3;      
input           pad_cpu_rst_b;  
input           pll_core_cpuclk; 
output  [31:0]  hrdata_s3;      
output          hready_s3;      
output  [1 :0]  hresp_s3;       

// &Regs; @24
reg             hready_s3;      

// &Wires; @25
wire    [31:0]  hrdata_s3;      
wire    [1 :0]  hresp_s3;       
wire            hsel_s3;        
wire            pad_cpu_rst_b;  
wire            pll_core_cpuclk; 

// //&Force("input","pll_core_cpuclk"); @26
// //&Force("input","pad_cpu_rst_b"); @27
// &Force("input","hsel_s3"); @28
// &Force("input","haddr_s3"); @29
// &Force("bus", "haddr_s3", 31,0); @30
// &Force("input","hburst_s3"); @31
// &Force("bus", "hburst_s3", 2,0); @32
// &Force("input","hmastlock"); @33
// &Force("input","hprot_s3"); @34
// &Force("bus", "hprot_s3", 3,0); @35
// &Force("input","hsize_s3"); @36
// &Force("bus", "hsize_s3", 2,0); @37
// &Force("input","htrans_s3"); @38
// &Force("bus", "htrans_s3", 1,0); @39
// &Force("input","hwdata_s3"); @40
// &Force("input","hwrite_s3"); @41
// &Force("input","hsel_s3"); @42
// &Force("output","hready_s3"); @43
//assign hready_s3 = 1'b1;
assign hresp_s3[1:0]  =  2'b01 ;

always @(posedge pll_core_cpuclk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
    begin
      hready_s3 <= 1'b0;
    end
  else if(hsel_s3)
    begin
      hready_s3 <= 1'b0;
    end
  else
    begin
      hready_s3 <= 1'b1;     
    end
end

// &Force("bus", "hwdata_s3", 31,0); @63
assign hrdata_s3[31:0] = 32'b0;

// &ModuleEnd; @66
endmodule


