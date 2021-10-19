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

// &ModuleBeg; @26
module cr_clic_arb(
  arb_ctrl_int_hv,
  arb_ctrl_int_id,
  arb_ctrl_int_il,
  arb_ctrl_int_mode,
  cpurst_b,
  ctrl_xx_int_lv_or_mask,
  kid_arb_int_all_vec,
  kid_arb_int_hv,
  kid_arb_int_req,
  out_clk,
  out_clk_en
);

// &Ports; @27
input            cpurst_b;              
input   [2  :0]  ctrl_xx_int_lv_or_mask; 
input   [319:0]  kid_arb_int_all_vec;   
input   [79 :0]  kid_arb_int_hv;        
input   [79 :0]  kid_arb_int_req;       
input            out_clk;               
output           arb_ctrl_int_hv;       
output  [11 :0]  arb_ctrl_int_id;       
output  [7  :0]  arb_ctrl_int_il;       
output           arb_ctrl_int_mode;     
output           out_clk_en;            

// &Regs; @28
reg              arb_final_int_req_flop; 

// &Wires; @29
wire             arb_ctrl_int_hv;       
wire    [11 :0]  arb_ctrl_int_id;       
wire    [7  :0]  arb_ctrl_int_il;       
wire             arb_ctrl_int_mode;     
wire    [3  :0]  arb_final_int_all;     
wire             arb_final_int_hv;      
wire    [11 :0]  arb_final_int_id;      
wire    [2  :0]  arb_final_int_lv;      
wire             arb_final_int_mode;    
wire             arb_final_int_req;     
wire             arb_final_int_req_updt; 
wire             cpurst_b;              
wire    [2  :0]  ctrl_xx_int_lv_or_mask; 
wire    [79 :0]  kid_arb_int_hv;        
wire    [79 :0]  kid_arb_int_req;       
wire    [79 :0]  kid_final_sel_onehot;  
wire             out_clk;               
wire             out_clk_en;            


parameter CLICINTNUM     = `CLIC_INTNUM;
parameter CLICINTCTLBITS = `CLIC_INTCTLBITS;
parameter ID_WIDTH       = 12;

// &Force("input", "kid_arb_int_all_vec"); @35
// &Force("bus", "kid_arb_int_all_vec", (CLICINTCTLBITS+1)*(CLICINTNUM)-1, 0); @36
// &Force("bus", "kid_arb_int_hv", CLICINTNUM-1, 0); @37
// &Force("bus", "kid_arb_int_req", CLICINTNUM-1, 0); @38

//==========================================================
//                       Arbiter
//==========================================================
// &Force("nonport", "kid_final_sel_onehot"); @43
//csky vperl_off
cr_clic_arb_kernel #((CLICINTCTLBITS+1), CLICINTNUM) x_cr_clic_arb_kernel (
  .prio_in_vec    (kid_arb_int_all_vec),
  .sel_out_onehot (kid_final_sel_onehot)
);
//csky vperl_on

assign arb_final_int_hv  = |(kid_arb_int_hv[CLICINTNUM-1:0]  & kid_final_sel_onehot[CLICINTNUM-1:0]);
assign arb_final_int_req = |(kid_arb_int_req[CLICINTNUM-1:0] & kid_final_sel_onehot[CLICINTNUM-1:0]);

// &Force("nonport", "arb_final_int_all"); @54
//csky vperl_off
cr_clic_sel #((CLICINTCTLBITS+1), CLICINTNUM) x_cr_clic_sel_level_all (
  .data_in        (kid_arb_int_all_vec),
  .sel_in_onehot  (kid_final_sel_onehot),
  .data_out       (arb_final_int_all)
);
//csky vperl_on

// &Force("nonport", "id_vec"); @63
// &Force("nonport", "arb_final_int_id"); @64

//csky vperl_off
wire [ID_WIDTH*CLICINTNUM-1:0] id_vec;

genvar i;
generate
  for (i = 0; i < CLICINTNUM; i = i+1)
  begin: GEN_ID
    assign id_vec[ID_WIDTH*i+:ID_WIDTH] = $unsigned(i) & {ID_WIDTH{1'b1}};
  end
endgenerate

cr_clic_sel #(ID_WIDTH, CLICINTNUM) x_cr_clic_sel_id_vec (
  .data_in        (id_vec),
  .sel_in_onehot  (kid_final_sel_onehot),
  .data_out       (arb_final_int_id)
);
//csky vperl_on

assign arb_final_int_mode = arb_final_int_all[CLICINTCTLBITS];
assign arb_final_int_lv[CLICINTCTLBITS-1:0] = arb_final_int_all[CLICINTCTLBITS-1:0]
                                         | ctrl_xx_int_lv_or_mask[CLICINTCTLBITS-1:0]
                                         & {CLICINTCTLBITS{arb_final_int_req}};


//==========================================================
//                     Output Signal
//==========================================================
assign arb_ctrl_int_hv               = arb_final_int_hv;
assign arb_ctrl_int_id[ID_WIDTH-1:0] = arb_final_int_id[ID_WIDTH-1:0];
assign arb_ctrl_int_mode             = arb_final_int_mode;
assign arb_ctrl_int_il[7:0]          = {arb_final_int_lv[CLICINTCTLBITS-1:0],
                                        {(8-CLICINTCTLBITS){arb_final_int_req}}};

//==========================================================
//                     Gate Clk Cell
//==========================================================
assign arb_final_int_req_updt = arb_final_int_req_flop ^ arb_final_int_req;

always @ (posedge out_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    arb_final_int_req_flop <= 1'b0;
  else if (arb_final_int_req_updt)
    arb_final_int_req_flop <= arb_final_int_req;
end

assign out_clk_en = arb_final_int_req_updt
                 || arb_final_int_req;


// &ModuleEnd; @116
endmodule


