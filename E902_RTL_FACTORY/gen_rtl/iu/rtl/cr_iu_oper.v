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
module cr_iu_oper(
  cp0_yy_clk_en,
  ctrl_oper_lsu_data_sel,
  decd_oper_alu_imm,
  decd_oper_branch_imm,
  decd_oper_cp0_imm,
  decd_oper_lsu_imm,
  forever_cpuclk,
  had_idu_wbbr_data,
  had_idu_wbbr_vld,
  hs_split_iu_nsinst_gpr_rst_b,
  ifu_iu_ex_rs1_reg,
  ifu_iu_ex_rs2_reg,
  iu_cp0_imm,
  iu_cp0_rs1,
  iu_lsu_base,
  iu_lsu_data,
  iu_lsu_offset,
  iu_lsu_rs2,
  iu_yy_xx_reg_rst_b,
  oper_alu_rs1_reg,
  oper_alu_rs2_imm,
  oper_alu_rs2_reg,
  oper_branch_rs1_reg,
  oper_branch_rs2_imm,
  oper_branch_rs2_reg,
  oper_mad_rs1,
  oper_mad_rs2,
  oper_wb_rs1_equal_to_dst,
  oper_wb_rs2_equal_to_dst,
  pad_yy_gate_clk_en_b,
  randclk_oper_gpr_mod_en_w32,
  wb_oper_fwd_data_no_load,
  wb_oper_fwd_en,
  wb_oper_write_data,
  wb_oper_write_en,
  wb_oper_write_idx,
  wb_oper_write_idx_for_dep
);

// &Ports; @26
input           cp0_yy_clk_en;                  
input           ctrl_oper_lsu_data_sel;         
input   [31:0]  decd_oper_alu_imm;              
input   [31:0]  decd_oper_branch_imm;           
input   [11:0]  decd_oper_cp0_imm;              
input   [31:0]  decd_oper_lsu_imm;              
input           forever_cpuclk;                 
input   [31:0]  had_idu_wbbr_data;              
input           had_idu_wbbr_vld;               
input           hs_split_iu_nsinst_gpr_rst_b;   
input   [4 :0]  ifu_iu_ex_rs1_reg;              
input   [4 :0]  ifu_iu_ex_rs2_reg;              
input           iu_yy_xx_reg_rst_b;             
input           pad_yy_gate_clk_en_b;           
input   [20:0]  randclk_oper_gpr_mod_en_w32;    
input   [31:0]  wb_oper_fwd_data_no_load;       
input           wb_oper_fwd_en;                 
input   [31:0]  wb_oper_write_data;             
input           wb_oper_write_en;               
input   [4 :0]  wb_oper_write_idx;              
input   [4 :0]  wb_oper_write_idx_for_dep;      
output  [11:0]  iu_cp0_imm;                     
output  [31:0]  iu_cp0_rs1;                     
output  [31:0]  iu_lsu_base;                    
output  [31:0]  iu_lsu_data;                    
output  [31:0]  iu_lsu_offset;                  
output  [31:0]  iu_lsu_rs2;                     
output  [31:0]  oper_alu_rs1_reg;               
output  [31:0]  oper_alu_rs2_imm;               
output  [31:0]  oper_alu_rs2_reg;               
output  [31:0]  oper_branch_rs1_reg;            
output  [31:0]  oper_branch_rs2_imm;            
output  [31:0]  oper_branch_rs2_reg;            
output  [31:0]  oper_mad_rs1;                   
output  [31:0]  oper_mad_rs2;                   
output          oper_wb_rs1_equal_to_dst;       
output          oper_wb_rs2_equal_to_dst;       

// &Regs; @27

// &Wires; @28
wire            cp0_yy_clk_en;                  
wire            ctrl_oper_lsu_data_sel;         
wire    [31:0]  decd_oper_alu_imm;              
wire    [31:0]  decd_oper_branch_imm;           
wire    [11:0]  decd_oper_cp0_imm;              
wire    [31:0]  decd_oper_lsu_imm;              
wire            forever_cpuclk;                 
wire    [31:0]  had_idu_wbbr_data;              
wire            had_idu_wbbr_vld;               
wire            hs_split_iu_nsinst_gpr_rst_b;   
wire    [4 :0]  ifu_iu_ex_rs1_reg;              
wire    [4 :0]  ifu_iu_ex_rs2_reg;              
wire    [11:0]  iu_cp0_imm;                     
wire    [31:0]  iu_cp0_rs1;                     
wire    [31:0]  iu_lsu_base;                    
wire    [31:0]  iu_lsu_data;                    
wire    [31:0]  iu_lsu_offset;                  
wire    [31:0]  iu_lsu_rs2;                     
wire            iu_yy_xx_reg_rst_b;             
wire    [31:0]  oper_alu_rs1_reg;               
wire    [31:0]  oper_alu_rs2_imm;               
wire    [31:0]  oper_alu_rs2_reg;               
wire    [31:0]  oper_branch_rs1_reg;            
wire    [31:0]  oper_branch_rs2_imm;            
wire    [31:0]  oper_branch_rs2_reg;            
wire    [31:0]  oper_imm_for_alu;               
wire    [31:0]  oper_imm_for_branch;            
wire    [11:0]  oper_imm_for_cp0;               
wire    [31:0]  oper_imm_for_lsu;               
wire    [31:0]  oper_mad_rs1;                   
wire    [31:0]  oper_mad_rs2;                   
wire            oper_rs1_bsp_dep_vld;           
wire            oper_rs1_dep_vld;               
wire            oper_rs1_dep_vld_aft_bsp;       
wire            oper_rs1_equal_to_dst;          
wire    [31:0]  oper_rs1_gpr_data;              
wire    [31:0]  oper_rs1_gpr_reg;               
wire    [31:0]  oper_rs1_reg_no_load;           
wire    [31:0]  oper_rs1_reg_no_load_before_pol; 
wire            oper_rs2_dep_vld;               
wire            oper_rs2_equal_to_dst;          
wire    [31:0]  oper_rs2_gpr_data;              
wire    [31:0]  oper_rs2_gpr_reg;               
wire    [31:0]  oper_rs2_reg_before_pol;        
wire    [31:0]  oper_rs2_reg_no_load;           
wire    [31:0]  oper_rs2_reg_no_load_before_pol; 
wire            oper_wb_rs1_equal_to_dst;       
wire            oper_wb_rs2_equal_to_dst;       
wire            pad_yy_gate_clk_en_b;           
wire    [20:0]  randclk_oper_gpr_mod_en_w32;    
wire    [31:0]  wb_data_no_load_aft_bsp_fwd;    
wire    [31:0]  wb_oper_fwd_data_no_load;       
wire            wb_oper_fwd_en;                 
wire    [31:0]  wb_oper_write_data;             
wire            wb_oper_write_en;               
wire    [4 :0]  wb_oper_write_idx;              
wire    [4 :0]  wb_oper_write_idx_for_dep;      


//==============================================================================
//             General Purpose Register (GPR)
//==============================================================================
// &Force("input", "cp0_iu_af"); @34
// &Instance("cr_iu_oper_gpr", "x_cr_iu_oper_gpr"); @36
cr_iu_oper_gpr  x_cr_iu_oper_gpr (
  .cp0_yy_clk_en                     (cp0_yy_clk_en                    ),
  .forever_cpuclk                    (forever_cpuclk                   ),
  .hs_split_iu_nsinst_gpr_rst_b      (hs_split_iu_nsinst_gpr_rst_b     ),
  .inst_read_data0                   (oper_rs1_gpr_data[31:0]          ),
  .inst_read_data1                   (oper_rs2_gpr_data[31:0]          ),
  .inst_read_index0                  (ifu_iu_ex_rs1_reg[4:0]           ),
  .inst_read_index1                  (ifu_iu_ex_rs2_reg[4:0]           ),
  .inst_wen                          (wb_oper_write_en                 ),
  .inst_write_data                   (wb_oper_write_data[31:0]         ),
  .inst_write_index                  (wb_oper_write_idx[4:0]           ),
  .iu_yy_xx_reg_rst_b                (iu_yy_xx_reg_rst_b               ),
  .pad_yy_gate_clk_en_b              (pad_yy_gate_clk_en_b             ),
  .randclk_oper_gpr_mod_en_w32       (randclk_oper_gpr_mod_en_w32      )
);

// &Connect(.inst_wen(wb_oper_write_en), @37
//          .inst_write_index(wb_oper_write_idx[4:0]), @38
//          .inst_write_data(wb_oper_write_data[31:0]), @39
//          .inst_write_data_pol(wb_oper_write_data_pol), @40
// //         .inst_write_data_byte_wen(wb_oper_write_byte_wen[3:0]), @41
//          .inst_read_index0(ifu_iu_ex_rs1_reg[4:0]), @42
//          .inst_read_index1(ifu_iu_ex_rs2_reg[4:0]), @43
//          .inst_read_data0(oper_rs1_gpr_data[31:0]), @44
//          .inst_read_data0_pol(oper_rs1_gpr_data_pol), @45
//          .inst_read_data1(oper_rs2_gpr_data[31:0]), @46
//          .inst_read_data1_pol(oper_rs2_gpr_data_pol), @47
//          .inst_read_check_fail0(oper_rs1_gpr_check_fail), @48
//          .inst_read_check_fail1(oper_rs2_gpr_check_fail), @49
//          .inst_read_check_fail_fix(oper_src_fix_gpr_check_fail), @50
//          .supv_mode(cp0_yy_supv_mode), @51
//          .wb_supv_mode(wb_oper_supv_mode), @52
// //         .cp0_reg_write_data(cp0_write_data[31:0]), @53
// //         .cp0_reg_write_data_pol(cp0_write_data_pol), @54
// //         .user_2_reg_dout(oper_user_reg2_dout[31:0]), @55
// //         .user_reg_2_dout_pol(oper_user_reg_2_dout_pol), @56
// //         .user_reg_1_dout(oper_wb_x1[31:0]), @57
//  //        .user_reg_15_dout_pol(oper_wb_r15_pol), @58
//          .user_reg_22_dout(oper_bkup_lr_reg[31:0]), @59
//          .user_reg_22_dout_pol(oper_bkup_lr_reg_pol), @60
//          .user_reg_23_dout(oper_bstack_fp_reg[31:0]), @61
//          .user_reg_23_dout_pol(oper_bstack_fp_reg_pol), @62
//          .user_reg_24_dout(oper_bstack_top_reg[31:0]), @63
//          .user_reg_24_dout_pol(oper_bstack_top_reg_pol), @64
//          .user_reg_25_we(lsu_iu_bsp_we), @65
//          .user_reg_25_write_data(oper_user_reg_25_write_data[31:0]), @66
//          .user_reg_25_write_data_pol(oper_user_reg_25_write_data_pol), @67
//          .user_reg_25_dout(oper_bstack_pointer[31:0]), @68
//          .user_reg_25_dout_pol(oper_bstack_pointer_pol), @69
//          .user_reg_30_dout(oper_user_reg_30_dout[31:0]), @70
//          .user_reg_30_dout_pol(oper_user_reg_30_dout_pol), @71
// //         .machine_reg_2_dout_pol(oper_machine_reg_2_dout_pol), @72
// //         .susp_reg_dout(oper_susp_reg_2_dout), @73
// //         .intsp_reg_14_dout(oper_intsp_reg14_dout[31:0]), @74
// //         .susp_reg_14_dout_pol(oper_susp_reg_14_dout_pol), @75
//          .reg_cpuclk(cpuclk) @76
//         ); @77
// &Connect(.user_2_reg_dout(oper_user_reg2_dout[31:0]), @79
//          .machine_2_reg_dout(oper_machine_reg_2_dout) @80
//         ); @81

// &Connect(.susp_reg_dout(oper_susp_reg_2_dout));  @85

// &Connect(.alter_mode(cp0_iu_af)); @89
// &Connect(.secu_mode(cp0_yy_secu_mode)); @92
// &Connect(.wb_secu_mode(wb_oper_secu_mode)); @93


//==========================================================
//             Input and Output of user SP(r14)
//==========================================================


//read data to CP0


//==========================================================
//             Output of Backup Link Reg(r22)
//==========================================================

//==========================================================
//          Input and Output of Btack Pointer(r25)
//==========================================================


//==========================================================
//               Operand read from GPR 
//==========================================================
//WBBR Operand Replacement of rs1
assign oper_rs1_gpr_reg[31:0] = (had_idu_wbbr_vld && !ctrl_oper_lsu_data_sel) ? 
                                                      had_idu_wbbr_data[31:0]
                                                    : oper_rs1_gpr_data[31:0];
assign oper_rs2_gpr_reg[31:0] = had_idu_wbbr_vld ? had_idu_wbbr_data[31:0]
                                                 : oper_rs2_gpr_data[31:0];


//==========================================================
//              GPR Check Fail
//==========================================================


//=============================================================================
//         Operand Prepare including Dependency Check and Forwarding
//=============================================================================
//Operand Prepare when LOAD_FAST_RETIRE
//==========================================================
//        The Dependency Valid Signal
//==========================================================
assign oper_rs1_equal_to_dst = (ifu_iu_ex_rs1_reg[4:0] == wb_oper_write_idx_for_dep[4:0])
                              && ifu_iu_ex_rs1_reg[4:0] != 5'b0;
assign oper_rs2_equal_to_dst = (ifu_iu_ex_rs2_reg[4:0] == wb_oper_write_idx_for_dep[4:0]) 
                              && ifu_iu_ex_rs2_reg[4:0] != 5'b0;
//output to write back stage
assign oper_wb_rs1_equal_to_dst = oper_rs1_equal_to_dst;
assign oper_wb_rs2_equal_to_dst = oper_rs2_equal_to_dst;

//the dependency ignores source valid, which is not decoded for cost reason
assign oper_rs1_dep_vld = wb_oper_fwd_en && oper_rs1_equal_to_dst;
assign oper_rs2_dep_vld = wb_oper_fwd_en && oper_rs2_equal_to_dst;

//when BCTM, r25 is wrriten invisiblely, the dependency needs to be checked
assign oper_rs1_bsp_dep_vld = 1'b0;


//==========================================================
//        Operand Forwarding
//==========================================================

//the SRC0 without LOAD data from WB
//1.when lrw, the rs1 is PC
//2.when normal inst, the rs1 is the write data from WB
// &Force("bus","pcgen_xx_cur_pc",30,0); @247
assign wb_data_no_load_aft_bsp_fwd[31:0] = //oper_lrw_ex_vld 
                                             //? {pcgen_xx_cur_pc[30:1],2'b0}
                                             //: wb_oper_fwd_data_no_load[31:0];
                                               wb_oper_fwd_data_no_load[31:0];



//==========================================================
//           Forwarding for ALU and MAD
//==========================================================
//note that move WBBR replacement before forward mux, to when
//WBBR replacing, need to select non forward path

assign oper_rs2_reg_before_pol[31:0] = (oper_rs2_dep_vld)
                                        ? wb_oper_write_data[31:0]
                                        : oper_rs2_gpr_reg[31:0];


//==========================================================
//        Forwarding for LSU/BR/CP0 and DUP ALU
//==========================================================
assign oper_rs1_dep_vld_aft_bsp = oper_rs1_dep_vld || oper_rs1_bsp_dep_vld;

assign oper_rs1_reg_no_load_before_pol[31:0] = 
                                        (oper_rs1_dep_vld_aft_bsp && !had_idu_wbbr_vld)
                                        ? wb_data_no_load_aft_bsp_fwd[31:0]
                                        : oper_rs1_gpr_reg[31:0];



assign oper_rs2_reg_no_load_before_pol[31:0] = 
                                        oper_rs2_dep_vld
                                        ? wb_oper_fwd_data_no_load[31:0]
                                        : oper_rs2_gpr_reg[31:0];





//==========================================================
//         Processing Data Path Polarity
//==========================================================
//no data path polarity

assign oper_rs1_reg_no_load[31:0] = oper_rs1_reg_no_load_before_pol[31:0];
assign oper_rs2_reg_no_load[31:0] = oper_rs2_reg_no_load_before_pol[31:0];



//==========================================================
//              Immediate Prepare              
//==========================================================
assign oper_imm_for_alu[31:0] = decd_oper_alu_imm[31:0];
assign oper_imm_for_lsu[31:0] = decd_oper_lsu_imm[31:0];
assign oper_imm_for_cp0[11:0] = decd_oper_cp0_imm[11:0];
assign oper_imm_for_branch[31:0] = decd_oper_branch_imm[31:0];

//=============================================================================
//                    Operands to all the Excution Units
//=============================================================================
//==========================================================
//                    Operands for ALU
//==========================================================
assign oper_alu_rs1_reg[31:0]     = oper_rs1_reg_no_load[31:0];
assign oper_alu_rs2_reg[31:0]     = oper_rs2_reg_no_load[31:0];
assign oper_alu_rs2_imm[31:0]     = oper_imm_for_alu[31:0];

// &Force("nonport","oper_rs2_reg_no_load"); @429


//==========================================================
//                    Operands for MAD
//==========================================================

assign oper_mad_rs1[31:0]         = oper_rs1_reg_no_load[31:0];
assign oper_mad_rs2[31:0]         = oper_rs2_reg_no_load[31:0];



//==========================================================
//                    Operands for BRANCH
//==========================================================
//register does not forward from load
assign oper_branch_rs1_reg[31:0]  = oper_rs1_reg_no_load[31:0];
assign oper_branch_rs2_reg[31:0]  = oper_rs2_reg_no_load[31:0];
assign oper_branch_rs2_imm[31:0]  = oper_imm_for_branch[31:0];


//==========================================================
//                    Operands for LSU
//==========================================================
//register does not forward from load
assign iu_lsu_offset[31:0]         = oper_imm_for_lsu[31:0];
assign iu_lsu_data[31:0]           = oper_rs2_reg_before_pol[31:0];
assign iu_lsu_base[31:0]           = oper_rs1_reg_no_load[31:0];
assign iu_lsu_rs2[31:0]            = oper_rs2_reg_no_load[31:0];



//==========================================================
//                    Operands for CP0
//==========================================================
assign iu_cp0_rs1[31:0]           = oper_rs1_reg_no_load[31:0];
assign iu_cp0_imm[11:0]           = oper_imm_for_cp0[11:0];

// &ModuleEnd; @505
endmodule


