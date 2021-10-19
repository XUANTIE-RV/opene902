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
module cr_tcipif_dummy_bus(
  bmu_tcipif_ibus_acc_deny,
  bmu_tcipif_ibus_addr,
  bmu_tcipif_ibus_req,
  bmu_tcipif_ibus_write,
  cpurst_b,
  forever_cpuclk,
  pad_yy_gate_clk_en_b,
  tcipif_bmu_ibus_acc_err,
  tcipif_bmu_ibus_data,
  tcipif_bmu_ibus_data_vld,
  tcipif_bmu_ibus_grnt,
  tcipif_bmu_ibus_trans_cmplt
);

// &Ports; @23
input           bmu_tcipif_ibus_acc_deny;   
input   [31:0]  bmu_tcipif_ibus_addr;       
input           bmu_tcipif_ibus_req;        
input           bmu_tcipif_ibus_write;      
input           cpurst_b;                   
input           forever_cpuclk;             
input           pad_yy_gate_clk_en_b;       
output          tcipif_bmu_ibus_acc_err;    
output  [31:0]  tcipif_bmu_ibus_data;       
output          tcipif_bmu_ibus_data_vld;   
output          tcipif_bmu_ibus_grnt;       
output          tcipif_bmu_ibus_trans_cmplt; 

// &Regs; @24
reg             bus_next_state;             
reg             bus_state;                  

// &Wires; @25
wire            bmu_tcipif_ibus_acc_deny;   
wire            bmu_tcipif_ibus_req;        
wire            cpurst_b;                   
wire            forever_cpuclk;             
wire            ibus_acc_err;               
wire            ibus_busy;                  
wire            ibus_req;                   
wire            pad_yy_gate_clk_en_b;       
wire            sel_cpuclk;                 
wire            tcipif_bmu_ibus_acc_err;    
wire    [31:0]  tcipif_bmu_ibus_data;       
wire            tcipif_bmu_ibus_data_vld;   
wire            tcipif_bmu_ibus_grnt;       
wire            tcipif_bmu_ibus_trans_cmplt; 


//==========================================================
//  ACK to IBUS
//==========================================================
// &Force("input","bmu_tcipif_ibus_addr"); @30
// &Force("input","bmu_tcipif_ibus_write"); @31

// &Force("bus","bmu_tcipif_ibus_addr",31,0); @33

assign tcipif_bmu_ibus_grnt = bmu_tcipif_ibus_req;
assign ibus_req = bmu_tcipif_ibus_req && !bmu_tcipif_ibus_acc_deny;

parameter IDLE  = 1'b0,
          ERROR = 1'b1;

// &Instance("gated_clk_cell", "x_tcipif_ibus_sel_clk"); @41
gated_clk_cell  x_tcipif_ibus_sel_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (sel_cpuclk          ),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (bmu_tcipif_ibus_req ),
  .module_en            (ibus_busy           ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in      (forever_cpuclk     ), @42
//          .external_en (1'b0               ), @43
//          .global_en   (1'b1               ), @44
//          .module_en   (ibus_busy          ), @45
//          .local_en    (bmu_tcipif_ibus_req), @46
//          .clk_out     (sel_cpuclk         ) @47
//         ); @48
assign ibus_busy  = (bus_state != IDLE);

always@(posedge sel_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bus_state <= IDLE;
  else
    bus_state <= bus_next_state;
end

// &CombBeg; @59
always @( bus_state
       or ibus_req)
begin
case(bus_state)
  IDLE:
    if(ibus_req)
      bus_next_state = ERROR;
    else
      bus_next_state = IDLE;
  ERROR:
    if(ibus_req)
      bus_next_state = ERROR;
    else
      bus_next_state = IDLE;
  default:
    bus_next_state = IDLE;
endcase
// &CombEnd; @74
end

assign ibus_acc_err = (bus_state == ERROR);

assign tcipif_bmu_ibus_trans_cmplt = ibus_acc_err;
assign tcipif_bmu_ibus_acc_err     = ibus_acc_err;
assign tcipif_bmu_ibus_data_vld    = 1'b0;
assign tcipif_bmu_ibus_data[31:0]  = 32'b0;
// &ModuleEnd; @85
endmodule



