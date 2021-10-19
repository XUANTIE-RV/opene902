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

// &ModuleBeg; @27
module cr_iu_alu(
  alu_branch_adder_rst,
  alu_branch_rst_sign,
  alu_branch_rst_unsign,
  alu_branch_xor_rst,
  alu_mad_adder_of,
  alu_mad_adder_rst,
  alu_mad_rst_cout,
  alu_rbus_data,
  alu_rbus_data_vld,
  alu_rbus_req,
  branch_alu_adder_cmp,
  branch_alu_adder_sel,
  branch_alu_logic_nz,
  branch_alu_logic_sel,
  branch_alu_pc_sel,
  ctrl_alu_ex_sel,
  ctrl_alu_mad_oper_mux_en,
  ctrl_alu_oper_mux_en,
  ctrl_mad_ex_data_sel,
  decd_alu_dst_vld,
  decd_alu_func,
  decd_alu_rs2_imm_vld,
  decd_alu_sub_func,
  ifu_iu_ex_cnt,
  iu_lsu_adder_rst,
  lsu_iu_alu_sel,
  lsu_iu_mad_buf,
  mad_alu_data_vld,
  mad_alu_div_rs2,
  mad_alu_div_shift,
  mad_alu_fst_add,
  mad_alu_imm_vld,
  mad_alu_rs1,
  mad_alu_rs1_cst_0,
  mad_alu_rs1_vld,
  mad_alu_rs2_cst_0,
  mad_alu_rst,
  mad_alu_rst_vld,
  oper_alu_rs1_reg,
  oper_alu_rs2_imm,
  oper_alu_rs2_reg,
  pcgen_xx_cur_pc
);

// &Ports; @28
input           branch_alu_adder_cmp;         
input           branch_alu_adder_sel;         
input           branch_alu_logic_nz;          
input           branch_alu_logic_sel;         
input           branch_alu_pc_sel;            
input           ctrl_alu_ex_sel;              
input           ctrl_alu_mad_oper_mux_en;     
input           ctrl_alu_oper_mux_en;         
input           ctrl_mad_ex_data_sel;         
input           decd_alu_dst_vld;             
input   [2 :0]  decd_alu_func;                
input           decd_alu_rs2_imm_vld;         
input   [3 :0]  decd_alu_sub_func;            
input   [4 :0]  ifu_iu_ex_cnt;                
input           lsu_iu_alu_sel;               
input   [31:0]  lsu_iu_mad_buf;               
input           mad_alu_data_vld;             
input   [31:0]  mad_alu_div_rs2;              
input           mad_alu_div_shift;            
input           mad_alu_fst_add;              
input           mad_alu_imm_vld;              
input   [31:0]  mad_alu_rs1;                  
input           mad_alu_rs1_cst_0;            
input           mad_alu_rs1_vld;              
input           mad_alu_rs2_cst_0;            
input   [31:0]  mad_alu_rst;                  
input           mad_alu_rst_vld;              
input   [31:0]  oper_alu_rs1_reg;             
input   [31:0]  oper_alu_rs2_imm;             
input   [31:0]  oper_alu_rs2_reg;             
input   [30:0]  pcgen_xx_cur_pc;              
output  [31:0]  alu_branch_adder_rst;         
output          alu_branch_rst_sign;          
output          alu_branch_rst_unsign;        
output  [31:0]  alu_branch_xor_rst;           
output          alu_mad_adder_of;             
output  [31:0]  alu_mad_adder_rst;            
output          alu_mad_rst_cout;             
output  [31:0]  alu_rbus_data;                
output          alu_rbus_data_vld;            
output          alu_rbus_req;                 
output  [31:0]  iu_lsu_adder_rst;             

// &Regs; @29
reg     [31:0]  alu_shifter_right_rst;        

// &Wires; @30
wire    [1 :0]  alu_adder_c_sel;              
wire            alu_adder_reverse;            
wire    [31:0]  alu_adder_rs1;                
wire    [31:0]  alu_adder_rs2;                
wire    [31:0]  alu_adder_rs2_pre_val;        
wire            alu_adder_rst_cmp_signed_lt;  
wire            alu_adder_rst_cmp_unsigned_lt; 
wire            alu_adder_rst_cout;           
wire    [31:0]  alu_adder_rst_out;            
wire            alu_adder_sel;                
wire    [31:0]  alu_adder_shared_rst_out;     
wire    [31:0]  alu_branch_adder_rst;         
wire            alu_branch_rst_sign;          
wire            alu_branch_rst_unsign;        
wire    [31:0]  alu_branch_xor_rst;           
wire            alu_dst_vld;                  
wire    [2 :0]  alu_func;                     
wire    [31:0]  alu_logic_rs1;                
wire    [31:0]  alu_logic_rs2;                
wire    [31:0]  alu_logic_rst_out;            
wire    [31:0]  alu_logic_rst_out_and;        
wire    [31:0]  alu_logic_rst_out_mov;        
wire    [31:0]  alu_logic_rst_out_or;         
wire    [31:0]  alu_logic_rst_out_xor;        
wire    [3 :0]  alu_logic_rst_sel;            
wire            alu_logic_sel;                
wire            alu_mad_adder_of;             
wire    [31:0]  alu_mad_adder_rst;            
wire            alu_mad_rst_cout;             
wire    [31:0]  alu_mux_rs1;                  
wire    [31:0]  alu_mux_rs2;                  
wire    [31:0]  alu_prepare_rs1;              
wire            alu_prepare_rs1_sel;          
wire    [31:0]  alu_prepare_rs2;              
wire            alu_prepare_rs2_sel;          
wire    [31:0]  alu_rbus_data;                
wire            alu_rbus_data_vld;            
wire            alu_rbus_req;                 
wire    [31:0]  alu_rs1;                      
wire            alu_rs1_pre_cst_0;            
wire    [31:0]  alu_rs2;                      
wire            alu_rs2_imm_sel;              
wire            alu_rs2_pre_cst_0;            
wire            alu_sel;                      
wire            alu_shared_adder_cout;        
wire    [31:0]  alu_shared_adder_rs1;         
wire    [31:0]  alu_shared_adder_rs2;         
wire    [31:0]  alu_shared_adder_rst;         
wire            alu_shared_adder_srcc;        
wire            alu_shifter_right_in;         
wire    [31:0]  alu_shifter_right_in_mask;    
wire    [31:0]  alu_shifter_rs1;              
wire    [31:0]  alu_shifter_rs1_pre;          
wire    [31:0]  alu_shifter_rs1_reverse;      
wire    [4 :0]  alu_shifter_rs2;              
wire    [31:0]  alu_shifter_rst_left_out;     
wire    [31:0]  alu_shifter_rst_out;          
wire    [31:0]  alu_shifter_rst_right_out;    
wire            alu_shifter_rst_sel;          
wire            alu_shifter_sel;              
wire            alu_shifter_shift_dr;         
wire            alu_shifter_shift_in;         
wire    [3 :0]  alu_sub_func;                 
wire            branch_alu_adder_cmp;         
wire            branch_alu_adder_sel;         
wire            branch_alu_logic_nz;          
wire            branch_alu_logic_sel;         
wire            branch_alu_pc_sel;            
wire            ctrl_alu_ex_sel;              
wire            ctrl_alu_mad_oper_mux_en;     
wire            ctrl_alu_oper_mux_en;         
wire            ctrl_mad_ex_data_sel;         
wire            decd_alu_dst_vld;             
wire    [2 :0]  decd_alu_func;                
wire            decd_alu_rs2_imm_vld;         
wire    [3 :0]  decd_alu_sub_func;            
wire    [4 :0]  ifu_iu_ex_cnt;                
wire    [31:0]  iu_lsu_adder_rst;             
wire            logic_rs1_sel;                
wire            lsu_iu_alu_sel;               
wire    [31:0]  lsu_iu_mad_buf;               
wire            mad_alu_data_vld;             
wire    [31:0]  mad_alu_div_rs2;              
wire            mad_alu_div_shift;            
wire            mad_alu_fst_add;              
wire            mad_alu_imm_vld;              
wire    [31:0]  mad_alu_rs1;                  
wire            mad_alu_rs1_cst_0;            
wire            mad_alu_rs1_vld;              
wire            mad_alu_rs2_cst_0;            
wire    [31:0]  mad_alu_rst;                  
wire            mad_alu_rst_vld;              
wire    [31:0]  oper_alu_rs1_reg;             
wire    [31:0]  oper_alu_rs2_imm;             
wire    [31:0]  oper_alu_rs2_reg;             
wire    [30:0]  pcgen_xx_cur_pc;              


//==============================================================================
//                          Operand Prepare Logic
//==============================================================================

//==========================================================
//            Register and Immediate Selection
//==========================================================
//the source 0 is always from source register
assign alu_mux_rs1[31:0] = mad_alu_rs1_vld ? mad_alu_rs1[31:0] 
                         : branch_alu_pc_sel ?{pcgen_xx_cur_pc[30:0], 1'b0}
                         : oper_alu_rs1_reg[31:0];
//the source 1 may from immediate when alu except ff1 of MAD
assign alu_rs2_imm_sel   = decd_alu_rs2_imm_vld || mad_alu_imm_vld
                            || lsu_iu_alu_sel || branch_alu_pc_sel;
assign alu_mux_rs2[31:0] = alu_rs2_imm_sel ? mad_alu_imm_vld ? lsu_iu_mad_buf[31:0] 
                                                             : oper_alu_rs2_imm[31:0]
                                           : oper_alu_rs2_reg[31:0];

//==========================================================
//              Operand Mux of Prepare Logic
//==========================================================
// &Force("input", "mad_alu_rs1_cst_0"); @54
assign alu_prepare_rs1_sel   = ctrl_alu_oper_mux_en || ctrl_alu_mad_oper_mux_en
                            || mad_alu_rs1_cst_0 || branch_alu_adder_sel
                            || lsu_iu_alu_sel || branch_alu_logic_sel;
assign alu_prepare_rs2_sel   = alu_prepare_rs1_sel || branch_alu_adder_sel
                            || lsu_iu_alu_sel || branch_alu_logic_sel;
assign alu_prepare_rs1[31:0] = {32{alu_prepare_rs1_sel}} & alu_mux_rs1[31:0];
assign alu_prepare_rs2[31:0] = {32{alu_prepare_rs2_sel}} & alu_mux_rs2[31:0];

//==========================================================
//                    DEST VLD prepare
//==========================================================
assign alu_dst_vld = decd_alu_dst_vld;

//==========================================================
//                    RS1   prepare
//==========================================================
assign alu_rs1_pre_cst_0 = mad_alu_rs1_cst_0;
//ALU source 1 prepare
assign alu_rs1[31:0]     = {32{~alu_rs1_pre_cst_0}} & alu_prepare_rs1[31:0];

//==========================================================
//                    RS2   prepare
//==========================================================
assign alu_rs2_pre_cst_0 = mad_alu_rs2_cst_0;
assign alu_rs2[31:0]     = {32{~alu_rs2_pre_cst_0}} & alu_prepare_rs2[31:0];

//==============================================================================
// ALU func and sub_func
//==============================================================================
assign alu_func[2:0]     = decd_alu_func[2:0];
assign alu_sub_func[3:0] = decd_alu_sub_func[3:0];

//==============================================================================
// Rename Input Signals
//==============================================================================
assign alu_sel         = ctrl_alu_ex_sel;
assign alu_adder_sel   = ctrl_alu_oper_mux_en && alu_func[0] 
                      || ctrl_alu_mad_oper_mux_en
                      || branch_alu_adder_sel 
                      || lsu_iu_alu_sel;
assign alu_logic_sel   = ctrl_alu_oper_mux_en && alu_func[1]
                      || branch_alu_logic_nz;
assign alu_shifter_sel = ctrl_alu_oper_mux_en && alu_func[2]
                      || ctrl_alu_mad_oper_mux_en && mad_alu_div_shift;
assign alu_shifter_rst_sel = ctrl_alu_oper_mux_en && alu_func[2];

//==============================================================================
// Adder
//==============================================================================
// &Force("bus","alu_sub_func",3,0); @116
assign alu_adder_c_sel[1:0] = {2{alu_adder_sel}} & alu_sub_func[2:1];

//================================================
// Adder Operand Mux
//================================================
//operand MUX to 0 if not selected, reducing power
assign alu_adder_rs1[31:0]         = {32{alu_adder_sel}} & alu_rs1[31:0];
assign alu_adder_rs2_pre_val[31:0] = {32{alu_adder_sel}} & (mad_alu_div_shift ?
                                               alu_shifter_rst_left_out[31:0]:
                                                                alu_rs2[31:0]);
//================================================
// Adder Operand Prepare
//================================================
assign alu_adder_reverse = !alu_sub_func[0] && !mad_alu_fst_add && !lsu_iu_alu_sel
                        || branch_alu_adder_cmp;
assign alu_adder_rs2[31:0] = alu_adder_reverse ? ~alu_adder_rs2_pre_val[31:0] 
                                               :  alu_adder_rs2_pre_val[31:0];

//================================================
// Implement of IU Shared Adder
//================================================
//operand mux between alu branch and lsu
assign alu_shared_adder_rs1[31:0] = alu_adder_rs1[31:0];
assign alu_shared_adder_rs2[31:0] = alu_adder_rs2[31:0];
assign alu_shared_adder_srcc      = alu_adder_reverse;

//implement of shared adder
assign {alu_shared_adder_cout,alu_shared_adder_rst[31:0]} =
       {1'b0, alu_shared_adder_rs1[31:0]} + {1'b0, alu_shared_adder_rs2[31:0]}
       + {32'b0, alu_shared_adder_srcc};
//out put rename
assign alu_adder_rst_out[31:0]    = alu_shared_adder_rst[31:0];

assign alu_adder_rst_cmp_unsigned_lt = !alu_shared_adder_cout;
//signed less than zero:
//if sign bit is same, see to result MSB
//otherwise see to source sign bits
assign alu_adder_rst_cmp_signed_lt = (alu_adder_rs1[31] & alu_adder_rs2[31])
                                  | ((alu_adder_rs1[31] ^ alu_adder_rs2[31])
                                        & alu_adder_rst_out[31]);

assign alu_adder_rst_cout = alu_adder_c_sel[0] && alu_adder_rst_cmp_unsigned_lt
                         || alu_adder_c_sel[1] && alu_adder_rst_cmp_signed_lt;

//==============================================================================
// Logic
//==============================================================================
//result selection bwtween MOV, AND, OR and XOR
assign alu_logic_rst_sel[3:0] = {4{alu_logic_sel}} & alu_sub_func[3:0];

//================================================
// Logic Operand Mux
//================================================
//operand MUX to 0 if not selected, reducing power
assign logic_rs1_sel = alu_logic_sel
                    || branch_alu_logic_sel;
assign alu_logic_rs1[31:0] = {32{logic_rs1_sel}} & alu_rs1[31:0];
assign alu_logic_rs2[31:0] = {32{alu_logic_sel}} & alu_rs2[31:0];

//================================================
// Logic Operation
//================================================
assign alu_logic_rst_out_mov[31:0] = alu_logic_rs2[31:0];
assign alu_logic_rst_out_and[31:0] = alu_logic_rs1[31:0] & alu_logic_rs2[31:0];
assign alu_logic_rst_out_or[31:0]  = alu_logic_rs1[31:0] | alu_logic_rs2[31:0];
assign alu_logic_rst_out_xor[31:0] = alu_logic_rs1[31:0] ^ alu_logic_rs2[31:0];

//================================================
// Logic result select
//================================================
assign alu_logic_rst_out[31:0] =
       {32{alu_logic_rst_sel[0]}} & alu_logic_rst_out_mov[31:0]
     | {32{alu_logic_rst_sel[1]}} & alu_logic_rst_out_and[31:0]
     | {32{alu_logic_rst_sel[2]}} & alu_logic_rst_out_or[31:0]
     | {32{alu_logic_rst_sel[3]}} & alu_logic_rst_out_xor[31:0];

//==============================================================================
// Shifter
//==============================================================================

//=========================================================
// Rename Input Signals
//=========================================================
//shift direction: 0 for left, 1 for right
assign alu_shifter_shift_dr    = alu_shifter_sel && !alu_sub_func[1];
//shift in bit: 0 for zero, 1 for sign bits
assign alu_shifter_shift_in    = alu_shifter_sel && alu_sub_func[0];

//operand MUX to 0 if not selected, reducing power
assign alu_shifter_rs1_pre[31:0] = {32{alu_shifter_sel}} & (mad_alu_div_shift ?
                                                            mad_alu_div_rs2[31:0] :
                                                            alu_rs1[31:0]);
assign alu_shifter_rs2[4:0]      =  {5{alu_shifter_sel}} & (mad_alu_div_shift ?
                                                           (ifu_iu_ex_cnt[4:0]): 
                                                            alu_rs2[4:0]);

//==========================================================
// SHIFTER RS1 Prepare
//==========================================================
assign alu_shifter_rs1_reverse[31:0] = {alu_shifter_rs1_pre[0],  alu_shifter_rs1_pre[1],
                                        alu_shifter_rs1_pre[2],  alu_shifter_rs1_pre[3],
                                        alu_shifter_rs1_pre[4],  alu_shifter_rs1_pre[5],
                                        alu_shifter_rs1_pre[6],  alu_shifter_rs1_pre[7],
                                        alu_shifter_rs1_pre[8],  alu_shifter_rs1_pre[9],
                                        alu_shifter_rs1_pre[10], alu_shifter_rs1_pre[11],
                                        alu_shifter_rs1_pre[12], alu_shifter_rs1_pre[13],
                                        alu_shifter_rs1_pre[14], alu_shifter_rs1_pre[15],
                                        alu_shifter_rs1_pre[16], alu_shifter_rs1_pre[17],
                                        alu_shifter_rs1_pre[18], alu_shifter_rs1_pre[19],
                                        alu_shifter_rs1_pre[20], alu_shifter_rs1_pre[21],
                                        alu_shifter_rs1_pre[22], alu_shifter_rs1_pre[23],
                                        alu_shifter_rs1_pre[24], alu_shifter_rs1_pre[25],
                                        alu_shifter_rs1_pre[26], alu_shifter_rs1_pre[27],
                                        alu_shifter_rs1_pre[28], alu_shifter_rs1_pre[29],
                                        alu_shifter_rs1_pre[30], alu_shifter_rs1_pre[31]
                                        };

assign alu_shifter_rs1[31:0] = alu_shifter_shift_dr ? alu_shifter_rs1_pre[31:0]
                                                    : alu_shifter_rs1_reverse[31:0];

//==========================================================
// Prepare Shift In Bits
//==========================================================
//when left shift, the shift in bit is zer0
assign alu_shifter_right_in = alu_shifter_shift_in & alu_shifter_rs1_pre[31];
assign alu_shifter_right_in_mask[31:0] = {32{alu_shifter_right_in}};

//==========================================================
// Implement of Right Shifter
//==========================================================
// &CombBeg; @252
always @( alu_shifter_right_in_mask[30:0]
       or alu_shifter_rs2[4:0]
       or alu_shifter_rs1[31:0])
begin
  case(alu_shifter_rs2[4:0])
  5'b00000:
     alu_shifter_right_rst[31:0] = alu_shifter_rs1[31:0];
  5'b00001:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[0], alu_shifter_rs1[31:1]};
  5'b00010:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[1:0], alu_shifter_rs1[31:2]};
  5'b00011:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[2:0], alu_shifter_rs1[31:3]};
  5'b00100:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[3:0], alu_shifter_rs1[31:4]};
  5'b00101:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[4:0], alu_shifter_rs1[31:5]};
  5'b00110:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[5:0], alu_shifter_rs1[31:6]};
  5'b00111:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[6:0], alu_shifter_rs1[31:7]};
  5'b01000:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[7:0], alu_shifter_rs1[31:8]};
  5'b01001:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[8:0], alu_shifter_rs1[31:9]};
  5'b01010:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[9:0], alu_shifter_rs1[31:10]};
  5'b01011:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[10:0], alu_shifter_rs1[31:11]};
  5'b01100:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[11:0], alu_shifter_rs1[31:12]};
  5'b01101:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[12:0], alu_shifter_rs1[31:13]};
  5'b01110:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[13:0], alu_shifter_rs1[31:14]};
  5'b01111:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[14:0], alu_shifter_rs1[31:15]};
  5'b10000:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[15:0], alu_shifter_rs1[31:16]};
  5'b10001:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[16:0], alu_shifter_rs1[31:17]};
  5'b10010:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[17:0], alu_shifter_rs1[31:18]};
  5'b10011:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[18:0], alu_shifter_rs1[31:19]};
  5'b10100:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[19:0], alu_shifter_rs1[31:20]};
  5'b10101:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[20:0], alu_shifter_rs1[31:21]};
  5'b10110:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[21:0], alu_shifter_rs1[31:22]};
  5'b10111:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[22:0], alu_shifter_rs1[31:23]};
  5'b11000:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[23:0], alu_shifter_rs1[31:24]};
  5'b11001:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[24:0], alu_shifter_rs1[31:25]};
  5'b11010:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[25:0], alu_shifter_rs1[31:26]};
  5'b11011:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[26:0], alu_shifter_rs1[31:27]};
  5'b11100:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[27:0], alu_shifter_rs1[31:28]};
  5'b11101:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[28:0], alu_shifter_rs1[31:29]};
  5'b11110:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[29:0], alu_shifter_rs1[31:30]};
  5'b11111:
     alu_shifter_right_rst[31:0]
                      = {alu_shifter_right_in_mask[30:0], alu_shifter_rs1[31]};
  default:
     alu_shifter_right_rst[31:0]
                      = 32'bx;
  endcase
// &CombEnd; @353
end

//==========================================================
// Right Shifter result to c
//==========================================================
assign alu_shifter_rst_right_out[31:0] = alu_shifter_right_rst[31:0];

assign alu_shifter_rst_left_out[31:0] =
                                {alu_shifter_rst_right_out[0], alu_shifter_rst_right_out[1],
                                 alu_shifter_rst_right_out[2], alu_shifter_rst_right_out[3],
                                 alu_shifter_rst_right_out[4], alu_shifter_rst_right_out[5],
                                 alu_shifter_rst_right_out[6], alu_shifter_rst_right_out[7],
                                 alu_shifter_rst_right_out[8], alu_shifter_rst_right_out[9],
                                 alu_shifter_rst_right_out[10],alu_shifter_rst_right_out[11],
                                 alu_shifter_rst_right_out[12],alu_shifter_rst_right_out[13],
                                 alu_shifter_rst_right_out[14],alu_shifter_rst_right_out[15],
                                 alu_shifter_rst_right_out[16],alu_shifter_rst_right_out[17],
                                 alu_shifter_rst_right_out[18],alu_shifter_rst_right_out[19],
                                 alu_shifter_rst_right_out[20],alu_shifter_rst_right_out[21],
                                 alu_shifter_rst_right_out[22],alu_shifter_rst_right_out[23],
                                 alu_shifter_rst_right_out[24],alu_shifter_rst_right_out[25],
                                 alu_shifter_rst_right_out[26],alu_shifter_rst_right_out[27],
                                 alu_shifter_rst_right_out[28],alu_shifter_rst_right_out[29],
                                 alu_shifter_rst_right_out[30],alu_shifter_rst_right_out[31]
                                };

//==========================================================
// Shifter result request
//==========================================================
assign alu_shifter_rst_out[31:0] = alu_shifter_shift_dr
                                 ? alu_shifter_rst_right_out[31:0]
                                 : alu_shifter_rst_left_out[31:0];

//==============================================================================
// Share the Adder data path with MAD summation
//==============================================================================
assign alu_adder_shared_rst_out[31:0] = mad_alu_rst_vld ? mad_alu_rst[31:0]
                                      : (alu_sub_func[2] || alu_sub_func[1]) 
                                      ? {31'b0, alu_adder_rst_cout}
                                      : alu_adder_rst_out[31:0];

//==============================================================================
// ALU to MAD
assign alu_mad_adder_rst[31:0]    = alu_shared_adder_rst[31:0];
assign alu_mad_rst_cout           = alu_adder_rst_cout;
// overflow infor for mult high
assign alu_mad_adder_of           = alu_shared_adder_cout;

//==============================================================================
// ALU to branch
assign alu_branch_rst_sign   = alu_adder_rst_cmp_signed_lt;
assign alu_branch_rst_unsign = alu_adder_rst_cmp_unsigned_lt;
assign alu_branch_xor_rst[31:0] = alu_logic_rst_out_xor[31:0];
assign alu_branch_adder_rst[31:0] = {alu_adder_rst_out[31:1], 1'b0};

assign iu_lsu_adder_rst[31:0] = alu_shared_adder_rst[31:0];

//==============================================================================
// ALU result request
//==============================================================================
//result bus request
assign alu_rbus_req = alu_sel;
//data valid
assign alu_rbus_data_vld = (ctrl_mad_ex_data_sel)
                           ? mad_alu_data_vld
                           : alu_dst_vld;
//data
// &Force("nonport", "alu_shifter_rst_sel"); @431
assign alu_rbus_data[31:0] = {32{alu_adder_sel}}   & alu_adder_shared_rst_out[31:0]
                           | {32{alu_logic_sel}}   & alu_logic_rst_out[31:0]
                           | {32{alu_shifter_rst_sel}} & alu_shifter_rst_out[31:0];

// &ModuleEnd; @441
endmodule


