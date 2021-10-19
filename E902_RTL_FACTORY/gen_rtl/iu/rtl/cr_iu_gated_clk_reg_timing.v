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
module cr_iu_gated_clk_reg_timing(
  cp0_yy_clk_en,
  forever_cpuclk,
  pad_yy_gate_clk_en_b,
  write_data,
  x_randclk_reg_mod_en_w32,
  x_reg_dout,
  x_write_en
);

// &Ports; @24
input           cp0_yy_clk_en;           
input           forever_cpuclk;          
input           pad_yy_gate_clk_en_b;    
input   [31:0]  write_data;              
input           x_randclk_reg_mod_en_w32; 
input           x_write_en;              
output  [31:0]  x_reg_dout;              

// &Regs; @25
reg     [31:0]  x_reg_dout;              

// &Wires; @26
wire            cp0_yy_clk_en;           
wire            forever_cpuclk;          
wire            pad_yy_gate_clk_en_b;    
wire            reg_clk_en;              
wire            reg_cpuclk;              
wire    [31:0]  write_data;              
wire    [31:0]  write_in_data;           
wire            write_in_en;             
wire            x_randclk_reg_mod_en_w32; 
wire            x_write_en;              


//==============================================================================
//                      register with only 1 write port
//==============================================================================
assign reg_clk_en = write_in_en;
// &Instance("gated_clk_cell", "x_reg_gated_clk"); @32
gated_clk_cell  x_reg_gated_clk (
  .clk_in                   (forever_cpuclk          ),
  .clk_out                  (reg_cpuclk              ),
  .external_en              (1'b0                    ),
  .global_en                (cp0_yy_clk_en           ),
  .local_en                 (reg_clk_en              ),
  .module_en                (x_randclk_reg_mod_en_w32),
  .pad_yy_gate_clk_en_b     (pad_yy_gate_clk_en_b    )
);

// &Connect(.clk_in      (forever_cpuclk), @33
//          .external_en (1'b0), @34
//          .global_en   (cp0_yy_clk_en), @35
//          .module_en   (x_randclk_reg_mod_en_w32), @36
//          .local_en    (reg_clk_en), @37
//          .i_tst_en    (i_tst_en), @38
//          .clk_out     (reg_cpuclk)); @39

//==========================================================
//                    Write Port
//==========================================================
assign write_in_en = x_write_en;
assign write_in_data[31:0] = write_data[31:0];

// &Force("output", "x_reg_dout"); @54

always @(posedge reg_cpuclk)
begin
  if(write_in_en)
    x_reg_dout[31:0] <= write_in_data[31:0];
  else
    x_reg_dout[31:0] <= x_reg_dout[31:0];
end

// &Force("output", "x_reg_verify"); @66

// &Force("output", "x_reg_dout_pol"); @79

// &ModuleEnd; @90
endmodule


