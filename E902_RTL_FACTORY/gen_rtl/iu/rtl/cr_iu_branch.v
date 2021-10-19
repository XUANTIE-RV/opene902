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

// &ModuleBeg; @25
module cr_iu_branch(
  alu_branch_adder_rst,
  alu_branch_rst_sign,
  alu_branch_rst_unsign,
  alu_branch_xor_rst,
  branch_alu_adder_cmp,
  branch_alu_adder_sel,
  branch_alu_logic_nz,
  branch_alu_logic_sel,
  branch_alu_pc_sel,
  branch_ctrl_stall,
  branch_pcgen_add_pc,
  branch_pcgen_br_chgflw_vld,
  branch_pcgen_br_chgflw_vld_for_data,
  branch_pcgen_br_pc_chgflw_vld,
  branch_pcgen_branch_chgflw_vld_for_data,
  branch_pcgen_jmp_chgflw_vld_for_data,
  branch_pcgen_reg_pc,
  branch_rbus_data,
  branch_rbus_data_vld,
  branch_rbus_req,
  branch_wb_cmp,
  branch_wb_jmp_reg,
  ctrl_branch_ex_data_sel,
  ctrl_branch_ex_sel,
  decd_branch_auipc,
  decd_branch_beq,
  decd_branch_bge,
  decd_branch_bgeu,
  decd_branch_blt,
  decd_branch_bltu,
  decd_branch_bne,
  decd_branch_cbeqz,
  decd_branch_cbnez,
  decd_branch_cj,
  decd_branch_cjal,
  decd_branch_cjalr,
  decd_branch_cjr,
  decd_branch_jal,
  decd_branch_jalr,
  decd_xx_inst_32bit,
  iu_had_chgflw_dst_pc,
  iu_had_chgflw_vld,
  oper_branch_rs1_reg,
  oper_branch_rs2_imm,
  oper_branch_rs2_reg,
  pcgen_xx_cur_pc,
  pcgen_xx_ibus_idle,
  retire_branch_stall,
  wb_branch_dep_ld,
  wb_ctrl_stall_without_hready
);

// &Ports; @26
input   [31:0]  alu_branch_adder_rst;                   
input           alu_branch_rst_sign;                    
input           alu_branch_rst_unsign;                  
input   [31:0]  alu_branch_xor_rst;                     
input           ctrl_branch_ex_data_sel;                
input           ctrl_branch_ex_sel;                     
input           decd_branch_auipc;                      
input           decd_branch_beq;                        
input           decd_branch_bge;                        
input           decd_branch_bgeu;                       
input           decd_branch_blt;                        
input           decd_branch_bltu;                       
input           decd_branch_bne;                        
input           decd_branch_cbeqz;                      
input           decd_branch_cbnez;                      
input           decd_branch_cj;                         
input           decd_branch_cjal;                       
input           decd_branch_cjalr;                      
input           decd_branch_cjr;                        
input           decd_branch_jal;                        
input           decd_branch_jalr;                       
input           decd_xx_inst_32bit;                     
input   [31:0]  oper_branch_rs1_reg;                    
input   [31:0]  oper_branch_rs2_imm;                    
input   [31:0]  oper_branch_rs2_reg;                    
input   [30:0]  pcgen_xx_cur_pc;                        
input           pcgen_xx_ibus_idle;                     
input           retire_branch_stall;                    
input           wb_branch_dep_ld;                       
input           wb_ctrl_stall_without_hready;           
output          branch_alu_adder_cmp;                   
output          branch_alu_adder_sel;                   
output          branch_alu_logic_nz;                    
output          branch_alu_logic_sel;                   
output          branch_alu_pc_sel;                      
output          branch_ctrl_stall;                      
output  [30:0]  branch_pcgen_add_pc;                    
output          branch_pcgen_br_chgflw_vld;             
output          branch_pcgen_br_chgflw_vld_for_data;    
output          branch_pcgen_br_pc_chgflw_vld;          
output          branch_pcgen_branch_chgflw_vld_for_data; 
output          branch_pcgen_jmp_chgflw_vld_for_data;   
output  [30:0]  branch_pcgen_reg_pc;                    
output  [31:0]  branch_rbus_data;                       
output          branch_rbus_data_vld;                   
output          branch_rbus_req;                        
output          branch_wb_cmp;                          
output          branch_wb_jmp_reg;                      
output  [31:0]  iu_had_chgflw_dst_pc;                   
output          iu_had_chgflw_vld;                      

// &Regs; @27

// &Wires; @28
wire    [31:0]  adder_pc;                               
wire    [31:0]  adder_src0;                             
wire    [31:0]  adder_src1;                             
wire    [31:0]  alu_branch_adder_rst;                   
wire            alu_branch_rst_sign;                    
wire            alu_branch_rst_unsign;                  
wire    [31:0]  alu_branch_xor_rst;                     
wire            branch_alu_adder_cmp;                   
wire            branch_alu_adder_sel;                   
wire            branch_alu_logic_nz;                    
wire            branch_alu_logic_sel;                   
wire            branch_alu_pc_sel;                      
wire            branch_br;                              
wire            branch_br_chgflw;                       
wire            branch_br_cmp;                          
wire            branch_br_cmpu;                         
wire            branch_br_eql;                          
wire            branch_br_xor;                          
wire            branch_cmp_result;                      
wire            branch_ctrl_stall;                      
wire            branch_eql_result;                      
wire    [31:0]  branch_imm;                             
wire            branch_jmp;                             
wire            branch_jmp_pc;                          
wire            branch_jmp_reg;                         
wire            branch_link;                            
wire    [30:0]  branch_pcgen_add_pc;                    
wire            branch_pcgen_br_chgflw_vld;             
wire            branch_pcgen_br_chgflw_vld_for_data;    
wire            branch_pcgen_br_pc_chgflw_vld;          
wire            branch_pcgen_branch_chgflw_vld_for_data; 
wire            branch_pcgen_jmp_chgflw_vld_for_data;   
wire    [30:0]  branch_pcgen_reg_pc;                    
wire    [31:0]  branch_rbus_data;                       
wire            branch_rbus_data_vld;                   
wire            branch_rbus_req;                        
wire    [31:0]  branch_rs1;                             
wire            branch_stall;                           
wire            branch_taken;                           
wire            branch_wb_cmp;                          
wire            branch_wb_jmp_reg;                      
wire            ctrl_branch_ex_data_sel;                
wire            ctrl_branch_ex_sel;                     
wire            decd_branch_auipc;                      
wire            decd_branch_beq;                        
wire            decd_branch_bge;                        
wire            decd_branch_bgeu;                       
wire            decd_branch_blt;                        
wire            decd_branch_bltu;                       
wire            decd_branch_bne;                        
wire            decd_branch_cbeqz;                      
wire            decd_branch_cbnez;                      
wire            decd_branch_cj;                         
wire            decd_branch_cjal;                       
wire            decd_branch_cjalr;                      
wire            decd_branch_cjr;                        
wire            decd_branch_jal;                        
wire            decd_branch_jalr;                       
wire            decd_xx_inst_32bit;                     
wire    [31:0]  inc_offset;                             
wire            inst_auipc;                             
wire            inst_beq;                               
wire            inst_bge;                               
wire            inst_bgeu;                              
wire            inst_blt;                               
wire            inst_bltu;                              
wire            inst_bne;                               
wire            inst_cbeqz;                             
wire            inst_cbnez;                             
wire            inst_cj;                                
wire            inst_cjal;                              
wire            inst_cjalr;                             
wire            inst_cjr;                               
wire            inst_jal;                               
wire            inst_jalr;                              
wire    [31:0]  iu_had_chgflw_dst_pc;                   
wire            iu_had_chgflw_vld;                      
wire    [31:0]  oper_branch_rs1_reg;                    
wire    [31:0]  oper_branch_rs2_imm;                    
wire    [30:0]  pcgen_xx_cur_pc;                        
wire            pcgen_xx_ibus_idle;                     
wire            retire_branch_stall;                    
wire    [31:0]  target_pc;                              
wire            wb_branch_dep_ld;                       
wire            wb_ctrl_stall_without_hready;           


//==============================================================================
//                      Operands and Operation Prepare
//==============================================================================

//-----------------------------------------------------
// Rename Input Signals
//-----------------------------------------------------
assign inst_cj    = decd_branch_cj;
assign inst_cjal  = decd_branch_cjal;
assign inst_cjr   = decd_branch_cjr;
assign inst_cjalr = decd_branch_cjalr;
assign inst_cbeqz = decd_branch_cbeqz;
assign inst_cbnez = decd_branch_cbnez;
assign inst_auipc = decd_branch_auipc;
assign inst_jal   = decd_branch_jal;
assign inst_jalr  = decd_branch_jalr;
assign inst_beq   = decd_branch_beq;
assign inst_bne   = decd_branch_bne;
assign inst_blt   = decd_branch_blt;
assign inst_bge   = decd_branch_bge;
assign inst_bltu  = decd_branch_bltu;
assign inst_bgeu  = decd_branch_bgeu;

//-----------------------------------------------------
// Function Prepare
//-----------------------------------------------------
assign branch_jmp_pc  = inst_cj   || inst_cjal  || inst_jal;
assign branch_jmp_reg = inst_cjr  || inst_cjalr || inst_jalr;
assign branch_br_cmp  = inst_blt  || inst_bge;
assign branch_br_cmpu = inst_bltu || inst_bgeu;
assign branch_br_xor  = inst_beq  || inst_bne;

assign branch_jmp     = branch_jmp_pc || inst_jalr;
assign branch_link    = inst_cjal || inst_cjalr || inst_jal || inst_jalr;

//-----------------------------------------------------
// Operands Prepare
//-----------------------------------------------------
assign branch_rs1[31:0] = {32{ctrl_branch_ex_data_sel}} & oper_branch_rs1_reg[31:0];
//assign branch_rs1[31:0] = {32{branch_jmp_reg}} & oper_branch_rs1_reg[31:0];
assign branch_imm[31:0] = oper_branch_rs2_imm[31:0];
//-----------------------------------------------------
// Compute
//-----------------------------------------------------
// adder
assign adder_src0[31:0] = {pcgen_xx_cur_pc[30:0], 1'b0};
assign adder_src1[31:0] = (ctrl_branch_ex_data_sel && branch_taken) ? 
                           branch_imm[31:0] : inc_offset[31:0];
assign inc_offset[31:0] = {29'b0, decd_xx_inst_32bit, !decd_xx_inst_32bit, 1'b0};
assign adder_pc[31:0]   = adder_src0[31:0] + adder_src1[31:0];

assign branch_taken = (inst_beq || inst_cbeqz) && !branch_eql_result
                   || (inst_bne || inst_cbnez) &&  branch_eql_result
                   || (inst_bge || inst_bgeu)  && !branch_cmp_result
                   || (inst_blt || inst_bltu)  &&  branch_cmp_result;

//take direct branchs updata pc valid signal
//br, bsr, jmp, jsr, and taken br, bf
assign branch_br_chgflw  = (branch_taken || branch_jmp_pc || branch_jmp_reg)
                                  && !(wb_branch_dep_ld && branch_link);

//when branch disable, the branch dbg_disable info is depend
//on the target addr
assign branch_stall      = retire_branch_stall //for dbg disable
                        || wb_branch_dep_ld && branch_link
                        || (branch_br_chgflw && !pcgen_xx_ibus_idle);
assign branch_ctrl_stall = ctrl_branch_ex_data_sel && branch_stall;

//-----------------------------------------------------
// result bus request
//-----------------------------------------------------
// branch complete when receiving direct branches, and
// indirect branches complete when mpu access dent or
// transcmplt
assign branch_rbus_req = ctrl_branch_ex_sel && !branch_stall;// && aranch_br

//-----------------------------------------------------
// result bus request data and data valid
//-----------------------------------------------------
//lrw and subroutine call need write back
assign branch_rbus_data_vld   = branch_link;// || inst_auipc;
//assign branch_rbus_data[31:0] = {32{branch_link}} & alu_branch_adder_rst[31:0]
assign branch_rbus_data[31:0] = {32{branch_link}} & {adder_pc[31:1], 1'b0}
                              ;//| {32{inst_auipc}} & target_pc[31:0];

assign branch_br_eql     = inst_beq  || inst_bne || inst_cbeqz || inst_cbnez;
assign branch_br         = branch_br_cmp || branch_br_cmpu || branch_br_eql;
assign branch_wb_cmp     = ctrl_branch_ex_data_sel && branch_br;
assign branch_wb_jmp_reg = ctrl_branch_ex_data_sel && branch_jmp_reg;
//-----------------------------------------------------
// Indicate jump register to set stall signal
//-----------------------------------------------------
// &Force("input","oper_branch_rs2_reg"); @157
// &Force("bus","oper_branch_rs2_reg",31,0); @158
assign branch_alu_adder_sel = ctrl_branch_ex_data_sel && (branch_br_cmp ||
                                                          branch_br_cmpu ||
                                                          branch_jmp_reg ||
                                                          branch_jmp_pc);
assign branch_alu_adder_cmp = ctrl_branch_ex_data_sel && (branch_br_cmp ||
                                                          branch_br_cmpu);
assign branch_alu_logic_sel = inst_beq || inst_bne || inst_cbeqz || inst_cbnez;
assign branch_alu_logic_nz = branch_br_xor;

assign branch_alu_pc_sel = inst_auipc || branch_jmp_pc;

assign branch_eql_result = |alu_branch_xor_rst[31:0];
assign branch_cmp_result = branch_br_cmp ? alu_branch_rst_sign
                                         : alu_branch_rst_unsign;

assign target_pc[31:0]  = (branch_jmp_pc || branch_jmp_reg) ? alu_branch_adder_rst[31:0]
                         : {adder_pc[31:1], 1'b0};

//==========================================================
//          Interface with ibus and IFU change flow
//==========================================================
//-----------------------------------------------------
// direct branch change flow
//-----------------------------------------------------
//branch unit request when receiving jsr and jmp except jmp r15
// &Force("output","branch_pcgen_br_pc_chgflw_vld"); @185
assign branch_pcgen_br_chgflw_vld             = ctrl_branch_ex_data_sel && branch_br_chgflw
                                             && !wb_ctrl_stall_without_hready
                                             && pcgen_xx_ibus_idle;
assign branch_pcgen_br_chgflw_vld_for_data    = ctrl_branch_ex_data_sel && branch_br_chgflw
                                             && pcgen_xx_ibus_idle;
//all direct branch should update pc
assign branch_pcgen_br_pc_chgflw_vld          = ctrl_branch_ex_sel && branch_br_chgflw
                                             && !branch_stall;
assign branch_pcgen_branch_chgflw_vld_for_data = ctrl_branch_ex_data_sel
                                              && (branch_taken || branch_jmp);
assign branch_pcgen_jmp_chgflw_vld_for_data    = ctrl_branch_ex_data_sel
                                              && (inst_cjr || inst_cjalr); 

//-----------------------------------------------------
// direct branch change flow
//-----------------------------------------------------
//the change flow address is from register or offset summation
// &Force("output","branch_pcgen_reg_pc"); @203
// &Force("output","branch_pcgen_add_pc"); @204
// &Force("bus","lsu_iu_branch_rst", 31, 0); @205
assign branch_pcgen_reg_pc[30:0] = branch_rs1[31:1];
assign branch_pcgen_add_pc[30:0] = target_pc[31:1];

assign iu_had_chgflw_vld = branch_pcgen_br_pc_chgflw_vld;
assign iu_had_chgflw_dst_pc[31:0] = branch_jmp_reg ? {branch_pcgen_reg_pc[30:0], 1'b0}
                                                   : {branch_pcgen_add_pc[30:0], 1'b0};
// &ModuleEnd; @214
endmodule


