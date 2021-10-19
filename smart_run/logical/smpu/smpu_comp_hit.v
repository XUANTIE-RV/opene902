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
module smpu_comp_hit(
  biu_pad_haddr,
  biu_pad_hprot,
  smpu_entry,
  smpu_entry0,
  smpu_hit,
  smpu_hsec
);

// &Ports; @20
input   [31:0]  biu_pad_haddr; 
input   [3 :0]  biu_pad_hprot; 
input   [31:0]  smpu_entry;   
input   [31:0]  smpu_entry0;  
output          smpu_hit;     
output          smpu_hsec;    

// &Regs; @21
reg     [22:0]  addr_mask;    

// &Wires; @22
wire            addr_match;   
wire    [31:0]  biu_pad_haddr; 
wire    [3 :0]  biu_pad_hprot; 
wire    [31:0]  smpu_entry;   
wire    [31:0]  smpu_entry0;  
wire            smpu_hit;     
wire            smpu_hsec;    



// &Force("bus", "biu_pad_haddr", 31, 0); @25
// &Force("bus", "biu_pad_hprot", 3, 0); @26

assign smpu_hit =1'b0;
// &Force("nonport", "addr_match"); @32

assign addr_match = {(smpu_entry[0] & !biu_pad_hprot[2]), 
                     (addr_mask[22:0] & biu_pad_haddr[31:9])}
                 ==  { 1'b1, smpu_entry[31:9]};

assign smpu_hsec  = {(smpu_entry0[0] & biu_pad_hprot[2]), 
                     (addr_mask[22:0] & biu_pad_haddr[31:9])}
                 ==  { 1'b1, smpu_entry0[31:9]};

//Generate the address mask for the addr 
// &CombBeg; @44
always @( smpu_entry[4:1])
begin
  case(smpu_entry[4:1])
    4'b0111 : addr_mask[22:0] = 23'h7f_ffff;
    4'b1000 : addr_mask[22:0] = 23'h7f_fffe;
    4'b1001 : addr_mask[22:0] = 23'h7f_fffc;
    default : addr_mask[22:0] = 23'h00_0000;
  endcase
// &CombEnd; @51
end


// &ModuleEnd; @54
endmodule


