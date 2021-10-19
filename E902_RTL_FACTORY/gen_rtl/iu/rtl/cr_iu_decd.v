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
module cr_iu_decd(
  branch_pcgen_add_pc,
  cp0_iu_cskyisaee,
  cp0_yy_priv_mode,
  decd_alu_dst_vld,
  decd_alu_func,
  decd_alu_rs2_imm_vld,
  decd_alu_sub_func,
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
  decd_ctrl_alu_sel,
  decd_ctrl_branch_sel,
  decd_ctrl_cp0_sel,
  decd_ctrl_expt_bkpt,
  decd_ctrl_expt_ecall,
  decd_ctrl_expt_inv,
  decd_ctrl_expt_wsc,
  decd_ctrl_lsu_sel,
  decd_ctrl_mad_sel,
  decd_mad_inst_div,
  decd_mad_inst_divu,
  decd_mad_inst_mul,
  decd_mad_inst_mulh,
  decd_mad_inst_mulhsu,
  decd_mad_inst_mulhu,
  decd_mad_inst_rem,
  decd_mad_inst_remu,
  decd_oper_alu_imm,
  decd_oper_branch_imm,
  decd_oper_cp0_imm,
  decd_oper_lsu_imm,
  decd_retire_cp0_inst,
  decd_retire_inst_mret,
  decd_special_fencei,
  decd_special_icall,
  decd_special_icpa,
  decd_wb_tval,
  decd_xx_inst_32bit,
  decd_xx_unit_special_sel,
  hs_split_iu_ctrl_inst_vld,
  hs_split_iu_dp_inst_op,
  ifu_had_chg_flw_inst,
  ifu_had_match_pc,
  ifu_iu_ex_expt_cur,
  ifu_iu_ex_expt_vld,
  ifu_iu_ex_inst,
  ifu_iu_ex_inst_bkpt,
  ifu_iu_ex_prvlg_expt_vld,
  ifu_iu_ex_rd_reg,
  ifu_iu_ex_rs1_reg,
  ifu_iu_ex_rs2_reg,
  iu_cp0_ex_csrrc,
  iu_cp0_ex_csrrci,
  iu_cp0_ex_csrrs,
  iu_cp0_ex_csrrsi,
  iu_cp0_ex_csrrw,
  iu_cp0_ex_csrrwi,
  iu_cp0_ex_func3,
  iu_cp0_ex_mret,
  iu_cp0_ex_rd_reg,
  iu_cp0_ex_rs1_reg,
  iu_cp0_ex_wfi,
  iu_ifu_lsu_inst,
  iu_lsu_ex_byte,
  iu_lsu_ex_half,
  iu_lsu_ex_store,
  iu_lsu_ex_uns,
  lsu_iu_wfd,
  pcgen_xx_cur_pc
);

// &Ports; @27
input   [30:0]  branch_pcgen_add_pc;        
input           cp0_iu_cskyisaee;           
input   [1 :0]  cp0_yy_priv_mode;           
input           hs_split_iu_ctrl_inst_vld;  
input   [31:0]  hs_split_iu_dp_inst_op;     
input           ifu_iu_ex_expt_cur;         
input           ifu_iu_ex_expt_vld;         
input   [31:0]  ifu_iu_ex_inst;             
input           ifu_iu_ex_inst_bkpt;        
input           ifu_iu_ex_prvlg_expt_vld;   
input           lsu_iu_wfd;                 
input   [30:0]  pcgen_xx_cur_pc;            
output          decd_alu_dst_vld;           
output  [2 :0]  decd_alu_func;              
output          decd_alu_rs2_imm_vld;       
output  [3 :0]  decd_alu_sub_func;          
output          decd_branch_auipc;          
output          decd_branch_beq;            
output          decd_branch_bge;            
output          decd_branch_bgeu;           
output          decd_branch_blt;            
output          decd_branch_bltu;           
output          decd_branch_bne;            
output          decd_branch_cbeqz;          
output          decd_branch_cbnez;          
output          decd_branch_cj;             
output          decd_branch_cjal;           
output          decd_branch_cjalr;          
output          decd_branch_cjr;            
output          decd_branch_jal;            
output          decd_branch_jalr;           
output          decd_ctrl_alu_sel;          
output          decd_ctrl_branch_sel;       
output          decd_ctrl_cp0_sel;          
output          decd_ctrl_expt_bkpt;        
output          decd_ctrl_expt_ecall;       
output          decd_ctrl_expt_inv;         
output          decd_ctrl_expt_wsc;         
output          decd_ctrl_lsu_sel;          
output          decd_ctrl_mad_sel;          
output          decd_mad_inst_div;          
output          decd_mad_inst_divu;         
output          decd_mad_inst_mul;          
output          decd_mad_inst_mulh;         
output          decd_mad_inst_mulhsu;       
output          decd_mad_inst_mulhu;        
output          decd_mad_inst_rem;          
output          decd_mad_inst_remu;         
output  [31:0]  decd_oper_alu_imm;          
output  [31:0]  decd_oper_branch_imm;       
output  [11:0]  decd_oper_cp0_imm;          
output  [31:0]  decd_oper_lsu_imm;          
output          decd_retire_cp0_inst;       
output          decd_retire_inst_mret;      
output          decd_special_fencei;        
output          decd_special_icall;         
output          decd_special_icpa;          
output  [31:0]  decd_wb_tval;               
output          decd_xx_inst_32bit;         
output          decd_xx_unit_special_sel;   
output          ifu_had_chg_flw_inst;       
output  [31:0]  ifu_had_match_pc;           
output  [4 :0]  ifu_iu_ex_rd_reg;           
output  [4 :0]  ifu_iu_ex_rs1_reg;          
output  [4 :0]  ifu_iu_ex_rs2_reg;          
output          iu_cp0_ex_csrrc;            
output          iu_cp0_ex_csrrci;           
output          iu_cp0_ex_csrrs;            
output          iu_cp0_ex_csrrsi;           
output          iu_cp0_ex_csrrw;            
output          iu_cp0_ex_csrrwi;           
output  [2 :0]  iu_cp0_ex_func3;            
output          iu_cp0_ex_mret;             
output  [4 :0]  iu_cp0_ex_rd_reg;           
output  [4 :0]  iu_cp0_ex_rs1_reg;          
output          iu_cp0_ex_wfi;              
output          iu_ifu_lsu_inst;            
output          iu_lsu_ex_byte;             
output          iu_lsu_ex_half;             
output          iu_lsu_ex_store;            
output          iu_lsu_ex_uns;              

// &Regs; @28
reg             decd_dst_vld;               
reg     [2 :0]  decd_func;                  
reg             decd_ill_expt16;            
reg             decd_ill_expt32;            
reg             decd_rs2_imm_vld;           
reg     [3 :0]  decd_sub_func;              
reg     [4 :0]  rd_16;                      
reg     [4 :0]  rs1_16;                     
reg     [4 :0]  rs2_16;                     

// &Wires; @29
wire    [31:0]  alu_imm;                    
wire            auipc_imm_vld;              
wire    [31:0]  branch_imm;                 
wire    [30:0]  branch_pcgen_add_pc;        
wire    [31:0]  btype_imm;                  
wire            btype_imm_vld;              
wire    [31:0]  cbtype_imm;                 
wire            cbtype_imm_vld;             
wire    [31:0]  ciatype_imm;                
wire            ciatype_imm_vld;            
wire    [31:0]  ciltype_imm;                
wire            ciltype_imm_vld;            
wire    [31:0]  cistype_imm;                
wire            cistype_imm_vld;            
wire    [31:0]  citype_imm;                 
wire            citype_imm_vld;             
wire    [31:0]  ciwtype_imm;                
wire            ciwtype_imm_vld;            
wire    [31:0]  cjtype_imm;                 
wire            cjtype_imm_vld;             
wire    [31:0]  cltype_imm;                 
wire            cltype_imm_vld;             
wire            cp0_iu_cskyisaee;           
wire    [1 :0]  cp0_yy_priv_mode;           
wire    [31:0]  csstype_imm;                
wire            csstype_imm_vld;            
wire            decd_alu_dst_vld;           
wire    [2 :0]  decd_alu_func;              
wire            decd_alu_rs2_imm_vld;       
wire            decd_alu_sel;               
wire    [3 :0]  decd_alu_sub_func;          
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
wire            decd_branch_inst;           
wire            decd_branch_jal;            
wire            decd_branch_jalr;           
wire            decd_branch_sel;            
wire            decd_ctrl_alu_sel;          
wire            decd_ctrl_branch_sel;       
wire            decd_ctrl_cp0_sel;          
wire            decd_ctrl_expt_bkpt;        
wire            decd_ctrl_expt_ecall;       
wire            decd_ctrl_expt_inv;         
wire            decd_ctrl_expt_wsc;         
wire            decd_ctrl_lsu_sel;          
wire            decd_ctrl_mad_sel;          
wire    [2 :0]  decd_func3;                 
wire    [1 :0]  decd_func7;                 
wire            decd_ill_expt;              
wire            decd_ill_reg_32;            
wire    [31:0]  decd_imm;                   
wire    [31:0]  decd_inst;                  
wire            decd_inst_32bit;            
wire            decd_inst_auipc;            
wire            decd_inst_beq;              
wire            decd_inst_bge;              
wire            decd_inst_bgeu;             
wire            decd_inst_bkpt;             
wire            decd_inst_blt;              
wire            decd_inst_bltu;             
wire            decd_inst_bne;              
wire            decd_inst_cbeqz;            
wire            decd_inst_cbnez;            
wire            decd_inst_cj;               
wire            decd_inst_cjal;             
wire            decd_inst_cjalr;            
wire            decd_inst_cjr;              
wire            decd_inst_clw;              
wire            decd_inst_clwsp;            
wire            decd_inst_csrrc;            
wire            decd_inst_csrrci;           
wire            decd_inst_csrrs;            
wire            decd_inst_csrrsi;           
wire            decd_inst_csrrw;            
wire            decd_inst_csrrwi;           
wire            decd_inst_csw;              
wire            decd_inst_cswsp;            
wire            decd_inst_ecall;            
wire            decd_inst_expt;             
wire            decd_inst_fence;            
wire            decd_inst_fencei;           
wire            decd_inst_icall;            
wire            decd_inst_icpa;             
wire            decd_inst_jal;              
wire            decd_inst_jalr;             
wire            decd_inst_lb;               
wire            decd_inst_lbu;              
wire            decd_inst_lh;               
wire            decd_inst_lhu;              
wire            decd_inst_lw;               
wire            decd_inst_mret;             
wire            decd_inst_mret_nor;         
wire            decd_inst_nop;              
wire            decd_inst_sb;               
wire            decd_inst_sh;               
wire            decd_inst_sw;               
wire            decd_inst_wfi;              
wire            decd_lsu_byte;              
wire            decd_lsu_half;              
wire            decd_lsu_sel;               
wire            decd_lsu_store;             
wire            decd_lsu_uns;               
wire            decd_mad_inst_div;          
wire            decd_mad_inst_divu;         
wire            decd_mad_inst_mul;          
wire            decd_mad_inst_mulh;         
wire            decd_mad_inst_mulhsu;       
wire            decd_mad_inst_mulhu;        
wire            decd_mad_inst_rem;          
wire            decd_mad_inst_remu;         
wire            decd_mad_sel;               
wire    [6 :0]  decd_op;                    
wire    [31:0]  decd_oper_alu_imm;          
wire    [31:0]  decd_oper_branch_imm;       
wire    [11:0]  decd_oper_cp0_imm;          
wire    [31:0]  decd_oper_lsu_imm;          
wire    [4 :0]  decd_rd;                    
wire            decd_retire_cp0_inst;       
wire            decd_retire_inst_mret;      
wire    [4 :0]  decd_rs1;                   
wire    [4 :0]  decd_rs2;                   
wire            decd_special_fencei;        
wire            decd_special_icall;         
wire            decd_special_icpa;          
wire            decd_special_sel;           
wire            decd_sys;                   
wire    [31:0]  decd_wb_tval;               
wire            decd_xx_inst_32bit;         
wire            decd_xx_unit_special_sel;   
wire            hs_split_iu_ctrl_inst_vld;  
wire    [31:0]  hs_split_iu_dp_inst_op;     
wire            ifu_had_chg_flw_inst;       
wire    [31:0]  ifu_had_match_pc;           
wire            ifu_iu_ex_expt_cur;         
wire            ifu_iu_ex_expt_vld;         
wire            ifu_iu_ex_hs_split_expt_vld; 
wire    [31:0]  ifu_iu_ex_inst;             
wire            ifu_iu_ex_inst_bkpt;        
wire            ifu_iu_ex_prvlg_expt_vld;   
wire    [4 :0]  ifu_iu_ex_rd_reg;           
wire    [4 :0]  ifu_iu_ex_rs1_reg;          
wire    [4 :0]  ifu_iu_ex_rs2_reg;          
wire    [31:0]  itype_imm;                  
wire            itype_imm_vld;              
wire            iu_cp0_ex_csrrc;            
wire            iu_cp0_ex_csrrci;           
wire            iu_cp0_ex_csrrs;            
wire            iu_cp0_ex_csrrsi;           
wire            iu_cp0_ex_csrrw;            
wire            iu_cp0_ex_csrrwi;           
wire    [2 :0]  iu_cp0_ex_func3;            
wire            iu_cp0_ex_mret;             
wire    [4 :0]  iu_cp0_ex_rd_reg;           
wire    [4 :0]  iu_cp0_ex_rs1_reg;          
wire            iu_cp0_ex_wfi;              
wire            iu_ifu_lsu_inst;            
wire            iu_lsu_ex_byte;             
wire            iu_lsu_ex_half;             
wire            iu_lsu_ex_store;            
wire            iu_lsu_ex_uns;              
wire            jalr_imm_vld;               
wire    [31:0]  jtype_imm;                  
wire            jtype_imm_vld;              
wire            load_imm_vld;               
wire    [31:0]  lsu_imm;                    
wire            lsu_iu_wfd;                 
wire    [30:0]  pcgen_xx_cur_pc;            
wire            rd_update_32;               
wire            rs1_update_32;              
wire            rs2_update_32;              
wire    [31:0]  stype_imm;                  
wire            stype_imm_vld;              
wire    [31:0]  tval_pc;                    
wire            tval_sel_pc;                
wire    [31:0]  utype_imm;                  
wire            utype_imm_vld;              


//==========================================================
//                Define the operand type
//==========================================================

//--------------------parameter width define---------------
//following defines data width of decoded information
parameter FUNC_WIDTH            = 3;
parameter SUB_FUNC_WIDTH        = 4;

//--------------------ALU FUNC define---------------
//value definition of decd_func in ALU
parameter ADDER                  = 3'b001;
parameter LOGIC                  = 3'b010;
parameter SHIFT                  = 3'b100;
//--------------------ADDER SUB_FUNC define---------------
parameter ADD                    = 4'b0001;
parameter LTU                    = 4'b0010;
parameter SLT                    = 4'b0100;
parameter SUB                    = 4'b1000;
//--------------------LOGIC SUB_FUNC define---------------
parameter MOV                    = 4'b0001;
parameter AND                    = 4'b0010;
parameter OR                     = 4'b0100;
parameter XOR                    = 4'b1000;
//--------------------SHIFT SUB_FUNC define---------------
parameter SRA                    = 4'b0001;
parameter SLL                    = 4'b0010;
parameter SRL                    = 4'b0100;
//==========================================================
//                      Decoder Input
//==========================================================
assign decd_inst[31:0] = hs_split_iu_ctrl_inst_vld ? hs_split_iu_dp_inst_op[31:0] 
                                                   : ifu_iu_ex_inst[31:0];
assign decd_inst_32bit = decd_inst[1] && decd_inst[0];
assign decd_op[6:0]    = {decd_inst[6:5], decd_inst_32bit ? decd_inst[4:2] : decd_inst[15:13], decd_inst[1:0]};
assign decd_func3[2:0] = decd_inst_32bit ? decd_inst[14:12] : decd_inst[12:10];
assign decd_func7[1:0] = {decd_inst[30], decd_inst[25]};

// &CombBeg; @70
always @( decd_inst[15:13]
       or decd_inst[1:0]
       or decd_inst[11:7])
begin
  casez({decd_inst[15:13], decd_inst[1:0]})
  //casez({decd_op[4:0]})
    5'b01101, // C.ADDI16SP; note: C.LUI included
    5'b00000, // C.ADDI4SPN
    5'b?1010: // C.LWSP C.SWSP
      rs1_16[4:0] = 5'b00010;
    5'b?1000, // C.LW C.SW
    5'b11?01, // C.BEQZ C.BNEZ
    5'b10001: // C.SRLI C.SRAI C.ANDI C.AND C.OR C.XOR C.SUB
      rs1_16[4:0] = {2'b01, decd_inst[9:7]};
    5'b00001, // C.ADDI 
    5'b?0010: // C.JR C.JALR C.SLLI C.ADD; C.MOV included
      rs1_16[4:0] = decd_inst[11:7];
    default: 
    begin
      rs1_16[4:0] = {1'b0, decd_inst[10:7]};
    end
  endcase
// &CombEnd; @89
end

// &CombBeg; @91
always @( decd_inst[15:13]
       or decd_inst[6:0])
begin
  casez({decd_inst[15:13], decd_inst[1:0]})
  //casez({decd_op[4:0]})
    5'b11010, // C.SWSP
    5'b10010: // C.MV C.ADD; note: C.JR and C.JALR included 
      rs2_16[4:0] = decd_inst[6:2];
    5'b11000: // C.SW
      rs2_16[4:0] = {2'b01, decd_inst[4:2]};
    5'b10001: // C.AND C.OR C.XOR C.SUB C.SRLI C.SRAI C.ANDI
      rs2_16[4:0] = {2'b01, decd_inst[4:2]};
    default: 
      rs2_16[4:0] = {2'b01, decd_inst[4:2]};
    endcase
// &CombEnd; @104
end

// &CombBeg; @106
always @( decd_inst[15:13]
       or decd_inst[11:0])
begin
  casez({decd_inst[15:13], decd_inst[1:0]})
  //casez({decd_op[4:0]})
    5'b01010, // C.LWSP
    5'b01001, // C.LI
    5'b01101, // C.LUI C.ADDI16SP
    5'b00001, // C.ADDI
    5'b00010: // C.SLLI
      rd_16[4:0] = decd_inst[11:7];
    5'b10010: // C.MV C.ADD; C.JALR; note: C.JR included 
      rd_16[4:0] = decd_inst[6:2] == 5'b0 ? 5'b1 : decd_inst[11:7];
    5'b00101: // C.JAL
      rd_16[4:0] = 5'b1;
    5'b10001: // C.AND C.OR C.XOR C.SUB C.SRLI C.SRAI C.ANDI
      rd_16[4:0] = {2'b01, decd_inst[9:7]};
    5'b01000, // C.LW
    5'b00000: // C.ADDI4SPN
      rd_16[4:0] = {2'b01, decd_inst[4:2]};
    default : 
      rd_16[4:0] = {2'b01, decd_inst[9:7]};
  endcase
// &CombEnd; @127
end

assign decd_rs1[4:0] = decd_inst_32bit ? decd_inst[19:15] : rs1_16[4:0];
assign decd_rs2[4:0] = decd_inst_32bit ? decd_inst[24:20] : rs2_16[4:0];
assign decd_rd[4:0]  = decd_inst_32bit ? decd_inst[11:7]  : rd_16[4:0];

//==========================================================
//               IMM
//==========================================================
// I-Type: Load Arth-Imm CSR JALR
assign load_imm_vld    = decd_inst[6:0] == 7'b0000011;
assign itype_imm_vld   = decd_inst[6:0] == 7'b0010011 ||
                         decd_inst[6:0] == 7'b1110011;
assign jalr_imm_vld    = decd_inst[6:0] == 7'b1100111;
assign itype_imm[31:0] = {{21{decd_inst[31]}}, decd_inst[30:20]};
// S-Type: Store
assign stype_imm_vld   = decd_inst[6:0] == 7'b0100011; 
assign stype_imm[31:0] = {{21{decd_inst[31]}}, decd_inst[30:25], decd_inst[11:7]}; 
// B-Type: BEQ BNE BLT BGE BLTU BGEU
// only branch forward need update imm
assign btype_imm_vld   = decd_inst[6:0] == 7'b1100011;
assign btype_imm[31:0] = {{20{decd_inst[31]}}, decd_inst[7], decd_inst[30:25], decd_inst[11:8], 1'b0};
// U-Type: LUI AUIPC
assign utype_imm_vld   = decd_inst[6:0] == 7'b0110111;
assign auipc_imm_vld   = decd_inst[6:0] == 7'b0010111;
assign utype_imm[31:0] = {decd_inst[31:12], 12'b0};
// J-Type: JAL
assign jtype_imm_vld   = decd_inst[6:0] == 7'b1101111;
assign jtype_imm[31:0] = {{12{decd_inst[31]}}, decd_inst[19:12], decd_inst[20], decd_inst[30:21], 1'b0};

// imm for 16-bit insts
// CI-Type: C.LI C.ADDI C.SLLI C.SRAI C.SRLI C.ANDI
assign citype_imm_vld   = {decd_inst[15:13], decd_inst[1:0]} == 5'b01001 ||
                          {decd_inst[15:13], decd_inst[1:0]} == 5'b00001 ||
                          {decd_inst[15:13], decd_inst[1:0]} == 5'b00010 ||
                          {decd_inst[15:13], decd_inst[1:0]} == 5'b10001 && decd_inst[11:10] != 2'b11;
assign citype_imm[31:0] = {{27{decd_inst[12]}}, decd_inst[6:2]};
// CIS-Type: C.LWSP
assign cistype_imm_vld   = {decd_inst[15:13], decd_inst[1:0]} == 5'b01010;
assign cistype_imm[31:0] = {24'b0, decd_inst[3:2], decd_inst[12], decd_inst[6:4], 2'b0};
// CIL-Type: C.LUI
assign ciltype_imm_vld   = {decd_inst[15:13], decd_inst[1:0]} == 5'b01101 &&
                            decd_inst[10:7] != 4'b10;
assign ciltype_imm[31:0] = {{15{decd_inst[12]}}, decd_inst[6:2], 12'b0};
// CIA-Type: C.ADDI16SP
assign ciatype_imm_vld   = {decd_inst[15:13], decd_inst[1:0]} == 5'b01101 &&
                            decd_inst[10:7] == 4'b10;
assign ciatype_imm[31:0] = {{23{decd_inst[12]}}, decd_inst[4:3], decd_inst[5], decd_inst[2], decd_inst[6], 4'b0};
// CIW-Type: C.ADDI4SPN
assign ciwtype_imm_vld   = !decd_inst_32bit && {decd_inst[15:13], decd_inst[1:0]} == 5'b00000;
assign ciwtype_imm[31:0] = {22'b0, decd_inst[10:7], decd_inst[12:11], decd_inst[5], decd_inst[6], 2'b0};

// CL-Type: C.LW C.SW
assign cltype_imm_vld   = {decd_inst[15:13], decd_inst[1:0]} == 5'b01000 ||
                          {decd_inst[15:13], decd_inst[1:0]} == 5'b11000;
assign cltype_imm[31:0] = {25'b0, decd_inst[5], decd_inst[12:10], decd_inst[6], 2'b0};

// CSS-Type: C.SWSP
assign csstype_imm_vld   = {decd_inst[15:13], decd_inst[1:0]} == 5'b11010;
assign csstype_imm[31:0] = {24'b0, decd_inst[8:7], decd_inst[12:9], 2'b0};

// CB-Type: C.BEQZ C.BNEZ
assign cbtype_imm_vld   = {decd_inst[15:13], decd_inst[1:0]} == 5'b11001 ||
                          {decd_inst[15:13], decd_inst[1:0]} == 5'b11101;
assign cbtype_imm[31:0] = {{24{decd_inst[12]}}, decd_inst[6:5], decd_inst[2], decd_inst[11:10], decd_inst[4:3], 1'b0}; 
// CJ-Type: C.J C.JAL
assign cjtype_imm_vld   = {decd_inst[14:13], decd_inst[1:0]} == 4'b0101;
assign cjtype_imm[31:0] = {{21{decd_inst[12]}}, decd_inst[8], decd_inst[10:9], decd_inst[6], decd_inst[7], decd_inst[2], decd_inst[11], decd_inst[5:3], 1'b0};

// distribute imm
assign decd_imm[31:0]   = citype_imm[31:0];
assign alu_imm[31:0]    = {32{  itype_imm_vld}} &   itype_imm[31:0] |
                          {32{  utype_imm_vld}} &   utype_imm[31:0] |
                          {32{  auipc_imm_vld}} &   utype_imm[31:0] |
                          {32{ citype_imm_vld}} &  citype_imm[31:0] |
                          {32{ciltype_imm_vld}} & ciltype_imm[31:0] |
                          {32{ciatype_imm_vld}} & ciatype_imm[31:0] |
                          {32{ciwtype_imm_vld}} & ciwtype_imm[31:0];

assign branch_imm[31:0] = //{32{   jalr_imm_vld}} &   itype_imm[31:0] |
                          {32{  btype_imm_vld}} &   btype_imm[31:0] |
//                          {32{  jtype_imm_vld}} &   jtype_imm[31:0] |
//                          {32{  auipc_imm_vld}} &   utype_imm[31:0] |
//                          {32{ cjtype_imm_vld}} &  cjtype_imm[31:0] |
                          {32{ cbtype_imm_vld}} &  cbtype_imm[31:0];

assign lsu_imm[31:0]    = {32{  load_imm_vld}}  &   itype_imm[31:0] |
                          {32{   jalr_imm_vld}} &   itype_imm[31:0] |
                          {32{  jtype_imm_vld}} &   jtype_imm[31:0] |
                          {32{ cjtype_imm_vld}} &  cjtype_imm[31:0] |
                          {32{ stype_imm_vld}}  &   stype_imm[31:0] |
                          {32{cistype_imm_vld}} & cistype_imm[31:0] |
                          {32{ cltype_imm_vld}} &  cltype_imm[31:0] |
                          {32{csstype_imm_vld}} & csstype_imm[31:0];

assign decd_oper_alu_imm[31:0] = alu_imm[31:0] | lsu_imm[31:0];
assign decd_oper_lsu_imm[31:0] = 32'b0;
assign decd_oper_cp0_imm[11:0] = itype_imm[11:0];
assign decd_oper_branch_imm[31:0] = branch_imm[31:0];

assign ifu_iu_ex_rs1_reg[4:0] = {1'b0,decd_rs1[3:0]};
assign ifu_iu_ex_rs2_reg[4:0] = {1'b0,decd_rs2[3:0]};
assign ifu_iu_ex_rd_reg[4:0]  = {1'b0, decd_rd[3:0]};

assign iu_ifu_lsu_inst = (decd_inst_clwsp || decd_inst_cswsp 
                      || decd_inst_clw   || decd_inst_csw
                      || decd_op[6:0] == 7'b0000011
                      || decd_op[6:0] == 7'b0100011) && !lsu_iu_wfd;
assign decd_xx_inst_32bit = decd_inst_32bit;

//==========================================================
//               ILLEGAL INST
//==========================================================
// the illegal inst
// RV32C Insts
// &CombBeg; @252
always @( citype_imm[5:0]
       or rs2_16[4]
       or ciatype_imm[9:4]
       or decd_inst[6]
       or decd_op[4:0]
       or decd_inst[11]
       or decd_func3[2:0]
       or ciwtype_imm[9:2]
       or rd_16[4:0]
       or ciltype_imm[17:12])
begin
  casez({decd_func3[2:0], decd_op[4:0]})
    // 8-bits instructions decode logic
    8'b???01001:  // C.LI 
    begin
      decd_ill_expt16 = rd_16[4:0] == 5'b0   // for some insts, rd  can not be 0
                     || rd_16[4];
    end
    8'b???00001:  // C.ADDI C.NOP
      decd_ill_expt16 = rd_16[4:0] != 5'b0 &&  citype_imm[5:0] == 6'b0  // for some insts, imm can not be 0
                     || rd_16[4:0] == 5'b0 &&  citype_imm[5:0] != 6'b0
                     || rd_16[4];
    8'b?0?10001:  // C.SRLI C.SRAI
    begin
      decd_ill_expt16 = citype_imm[5:0] == 6'b0; // for some insts, imm can not be 0
    end
    8'b???00000:  // C.ADDI4SPN
    begin
      decd_ill_expt16 = ciwtype_imm[9:2] == 8'b0; // for some insts, imm can not be 0
    end
    8'b???01010,  // C.LWSP
    8'b???00010:  // C.SLLI
    begin
      decd_ill_expt16 = rd_16[4:0] == 5'b0 && citype_imm[5:0] == 6'b0
                     || rd_16[4]; 
    end
    8'b???01101:  // C.LUI C.ADDI16SP 
    begin
      decd_ill_expt16 = rd_16[4:0] == 5'b0 
                     || rd_16[4:0] != 5'b10 && ciltype_imm[17:12] == 6'b0 
                     || rd_16[4:0] == 5'b10 && ciatype_imm[9:4] == 6'b0
                     || rd_16[4]; 
    end
    8'b???11010:  // C.SWSP
      decd_ill_expt16 = rs2_16[4];
    8'b???10010:  // C.JR C.JALR C.MV C.ADD C.EBREAK
      decd_ill_expt16 = decd_inst[11] || decd_inst[6];
    8'b???01000,  // C.LW
    8'b???11000,  // C.SW
    8'b???10101,  // C.J
    8'b???00101,  // C.JAL
    8'b???11001,  // C.BEQZ
    8'b???11101,  // C.BNEZ
    8'b?1010001,  // C.ANDI
    8'b?1110001:  // C.AND C.OR C.XOR C.SUB
    begin  
      decd_ill_expt16 = 1'b0;      //initial invalid instruction exception
    end
    default:begin                //invalid instruction
      decd_ill_expt16 = 1'b1;      //invalid instruction exception
    end
  endcase
// &CombEnd; @304
end

// RV32EM Insts
// &CombBeg; @307
always @( decd_inst[31:20]
       or decd_op[6:2]
       or decd_inst[11:7]
       or cp0_iu_cskyisaee
       or cp0_yy_priv_mode[1:0]
       or decd_func3[2:0])
begin
  casez({decd_inst[31:25], decd_func3[2:0], decd_op[6:2]})
    // 15-bits instructions decode logic
    15'b010000000001100,  // SUB 
    15'b010000010101100,  // SRA
    15'b000000????01100,  // R-Type

    15'b????????0?00000,  // 
    15'b???????01000000,  // I-Type Load

    15'b000000000100100,  // SLLI
    15'b0?0000010100100,  // SRLI SRAI
    15'b????????1100100,  // I-Type 
    15'b?????????000100,  // I-Type 

    15'b???????00011001,  // JALR

    15'b?????????111100,  // 
    15'b????????1011100,  // CSR Type

    15'b???????00?01000,  // 
    15'b???????01001000,  // S-Type 

    15'b???????00?11000,  // 
    15'b???????1??11000,  // B-Type 

    15'b??????????01101,  // LUI

    15'b??????????00101,  // AUIPC

    15'b??????????11011,  // J-Type

    15'b???????00?00011:  // FENCE FENCE.I
    begin  
      decd_ill_expt32 = 1'b0; // initial invalid instruction exception
    end
    15'b???????00000010:  // Cache Ops
    begin
      decd_ill_expt32 = !(decd_inst[11:7] == 5'b0 && decd_inst[31:26] == 6'b0
                       && cp0_iu_cskyisaee); // initial invalid instruction exception
    end
    15'b000000000011100:  // ECALL EBREAK
    begin  
      decd_ill_expt32 = decd_inst[24:21] != 4'b0; 
    end
    15'b001100000011100:  // MRET
    begin  
      decd_ill_expt32 = decd_inst[24:20] != 5'b00010 || !(cp0_yy_priv_mode[1:0] == 2'b11); 
    end
    15'b000100000011100:  // WFI
    begin  
      decd_ill_expt32 = decd_inst[24:20] != 5'b00101 || !(cp0_yy_priv_mode[1:0] == 2'b11); 
    end
    default:
    begin               
      decd_ill_expt32 = 1'b1; // all other insts are illegal
    end
  endcase
// &CombEnd; @365
end

//assign csr_imm_type = decd_inst[6:2] == 5'b11100 && decd_inst[14];
assign rs1_update_32 = decd_inst_32bit &&
                     !(decd_op[6:2] == 5'b11100 && decd_func3[2]) && // CSRW Imm inst
                       decd_op[6:2] != 5'b01101 && // LUI 
                       decd_op[6:2] != 5'b00101 && // AUIPC
                       decd_op[6:2] != 5'b11011;   // JAL
                       
assign rs2_update_32 = decd_inst_32bit && (
                       decd_op[6:2] == 5'b01100 || // R-Type
                       decd_op[6:2] == 5'b01000 || // S-Type
                       decd_op[6:2] == 5'b11000 || // B-Type
                       decd_op[6:2] == 5'b11100 && decd_func3[2:0] == 3'b0);
assign rd_update_32  = decd_inst_32bit &&
                       decd_op[6:2] != 5'b01000 && // S-Type
                       decd_op[6:2] != 5'b11000;   // B-Type
assign decd_ill_reg_32 = rs1_update_32 && decd_rs1[4]
                    || rs2_update_32 && decd_rs2[4] && !hs_split_iu_ctrl_inst_vld
                    || rd_update_32 && decd_rd[4] && !hs_split_iu_ctrl_inst_vld;
assign decd_ill_expt = decd_inst_32bit ? decd_ill_expt32 || decd_ill_reg_32
                                       : decd_ill_expt16;

//when nie nir, the inst is always 16-bit, to maintain the correct PC
//==========================================================
//                      Main  Decoder
//==========================================================
//main decoder produces operation information, operand 
//information and ALU/ALU oper prepare information,
//all values are defined by parameter.
//details defintions of operation plz refer to 902_IU_spec
//details defintions of operands plz refer to parameter define
//decode info for program signature

// decoder for ALU
// &CombBeg; @411
always @( decd_op[6:0]
       or decd_rd[4:0]
       or decd_func3[2:0]
       or decd_func7[1:0])
begin
  //initialize decoded information value
  //operation information: execution unit selection, main function
  //and sub functions
  //decd_func[FUNC_WIDTH-1:0]         = {FUNC_WIDTH{1'b0}};
  //decd_sub_func[SUB_FUNC_WIDTH-1:0] = {SUB_FUNC_WIDTH{1'b0}};
  //decd_rs2_imm_vld                  = 1'b0;
  //decd_dst_vld                      = 1'b0;
  decd_func[FUNC_WIDTH-1:0]         = ADDER;
  decd_sub_func[SUB_FUNC_WIDTH-1:0] = ADD;
  decd_rs2_imm_vld                  = 1'b0;
  decd_dst_vld                      = 1'b1;
  casez({decd_func7[1:0], decd_func3[2:0], decd_op[6:0]})
    //---------------------------------------------------
    // ADDER 5 RV32C insts 11 RV32E insts
    12'b???????00001: // C.ADDI
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = ADD;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b???????01101: // C.ADDI16SP C.LUI
    begin  
      decd_func[FUNC_WIDTH-1:0]         = decd_rd[4:0] == 5'h2 ? ADDER : LOGIC;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = ADD;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b???????00000: // C.ADDI4SPN; ALU Unit selected only rd = x2
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = ADD;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b??1????10010: // C.ADD     ; ALU Unit selected only rs2 != x0
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = ADD;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    12'b??0110010001: // C.SUB
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = SUB;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    12'b??0000010011: // ADDI
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = ADD;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b??0100010011: // SLTI 
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = SLT;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b??0110010011: // SLTIU 
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = LTU;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b000000110011: // ADD
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = ADD;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    12'b010??0110011: // MULT
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = ADD;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b0;
    end
    12'b011??0110011: // DIV
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = LTU;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b0;
    end
    12'b1?0000110011: // SUB
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = SUB;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    12'b?00100110011: // SLT
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = SLT;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    12'b?00110110011: // SLTU
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = LTU;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    12'b??10?1100011: // BLT BGE
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = SLT;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b0;
    end
    12'b??11?1100011: // BLTU BGEU
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = LTU;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b0;
    end
    12'b?????0010111: // AUIPC
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = ADD;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b?????1100111: // JALR
    begin  
      decd_func[FUNC_WIDTH-1:0]         = ADDER;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = ADD;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b0;
    end
    //---------------------------------------------------
    // LOGIC 6 RV32C insts 7 RV32E insts
    12'b???????01001: // C.LI
    begin  
      decd_func[FUNC_WIDTH-1:0]         = LOGIC;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = MOV;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b??0????10010: // C.MV; ALU Unit selected only rs2 != x0
    begin  
      decd_func[FUNC_WIDTH-1:0]         = LOGIC;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = MOV;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    12'b???10??10001: // C.ANDI
    begin  
      decd_func[FUNC_WIDTH-1:0]         = LOGIC;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = AND;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b???111110001: // C.AND 
    begin  
      decd_func[FUNC_WIDTH-1:0]         = LOGIC;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = AND;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    12'b???111010001: // C.OR
    begin  
      decd_func[FUNC_WIDTH-1:0]         = LOGIC;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = OR;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    12'b???110110001: // C.XOR
    begin  
      decd_func[FUNC_WIDTH-1:0]         = LOGIC;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = XOR;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    12'b?????0110111: // LUI
    begin  
      decd_func[FUNC_WIDTH-1:0]         = LOGIC;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = MOV;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b??1110010011: // ANDI 
    begin  
      decd_func[FUNC_WIDTH-1:0]         = LOGIC;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = AND;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b??1100010011: // ORI
    begin  
      decd_func[FUNC_WIDTH-1:0]         = LOGIC;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = OR;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b??1000010011: // XORI
    begin  
      decd_func[FUNC_WIDTH-1:0]         = LOGIC;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = XOR;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b?01110110011: // AND 
    begin  
      decd_func[FUNC_WIDTH-1:0]         = LOGIC;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = AND;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    12'b?01100110011: // OR
    begin  
      decd_func[FUNC_WIDTH-1:0]         = LOGIC;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = OR;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    12'b?01000110011: // XOR
    begin  
      decd_func[FUNC_WIDTH-1:0]         = LOGIC;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = XOR;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    //---------------------------------------------------
    // SHIFT 3 RV32C insts 6 RV32E insts
    12'b???????00010: // C.SLLI
    begin  
      decd_func[FUNC_WIDTH-1:0]         = SHIFT;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = SLL;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b???00??10001: // C.SRLI
    begin  
      decd_func[FUNC_WIDTH-1:0]         = SHIFT;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = SRL;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b???01??10001: // C.SRAI
    begin  
      decd_func[FUNC_WIDTH-1:0]         = SHIFT;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = SRA;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b??0010010011: // SLLI
    begin  
      decd_func[FUNC_WIDTH-1:0]         = SHIFT;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = SLL;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b0?1010010011: // SRLI
    begin  
      decd_func[FUNC_WIDTH-1:0]         = SHIFT;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = SRL;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b1?1010010011: // SRAI
    begin  
      decd_func[FUNC_WIDTH-1:0]         = SHIFT;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = SRA;
      decd_rs2_imm_vld                  = 1'b1;
      decd_dst_vld                      = 1'b1;
    end
    12'b?00010110011: // SLL
    begin  
      decd_func[FUNC_WIDTH-1:0]         = SHIFT;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = SLL;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    12'b001010110011: // SRL
    begin  
      decd_func[FUNC_WIDTH-1:0]         = SHIFT;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = SRL;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    12'b1?1010110011: // SRA
    begin  
      decd_func[FUNC_WIDTH-1:0]         = SHIFT;
      decd_sub_func[SUB_FUNC_WIDTH-1:0] = SRA;
      decd_rs2_imm_vld                  = 1'b0;
      decd_dst_vld                      = 1'b1;
    end
    //---------------------------------------------------
  endcase
// &CombEnd; @714
end

// decoder for MAD
assign decd_mad_sel         = decd_op[6:0] == 7'b0110011 && decd_func7[0] &&
                              !decd_inst_expt;
assign decd_mad_inst_mul    = decd_mad_sel && decd_func3[2:0] == 3'b000; 
assign decd_mad_inst_mulh   = decd_mad_sel && decd_func3[2:0] == 3'b001; 
assign decd_mad_inst_mulhsu = decd_mad_sel && decd_func3[2:0] == 3'b010; 
assign decd_mad_inst_mulhu  = decd_mad_sel && decd_func3[2:0] == 3'b011; 
assign decd_mad_inst_div    = decd_mad_sel && decd_func3[2:0] == 3'b100; 
assign decd_mad_inst_divu   = decd_mad_sel && decd_func3[2:0] == 3'b101; 
assign decd_mad_inst_rem    = decd_mad_sel && decd_func3[2:0] == 3'b110; 
assign decd_mad_inst_remu   = decd_mad_sel && decd_func3[2:0] == 3'b111; 

// decoder for LSU
assign decd_lsu_sel   = (decd_inst_clwsp || decd_inst_cswsp || decd_inst_clw   
                      || decd_inst_csw   || decd_inst_lb    || decd_inst_lh
                      || decd_inst_lbu   || decd_inst_lhu   || decd_inst_lw
                      || decd_inst_sb    || decd_inst_sh    || decd_inst_sw)
                      && !decd_inst_expt;

assign decd_inst_clwsp = decd_op[4:0] == 5'b01010;
assign decd_inst_cswsp = decd_op[4:0] == 5'b11010;
assign decd_inst_clw   = decd_op[4:0] == 5'b01000;
assign decd_inst_csw   = decd_op[4:0] == 5'b11000;

assign decd_inst_lb    = decd_op[6:0] == 7'b0000011 && decd_func3[2:0] == 3'b000; 
assign decd_inst_lh    = decd_op[6:0] == 7'b0000011 && decd_func3[2:0] == 3'b001; 
assign decd_inst_lw    = decd_op[6:0] == 7'b0000011 && decd_func3[2:0] == 3'b010; 
assign decd_inst_lbu   = decd_op[6:0] == 7'b0000011 && decd_func3[2:0] == 3'b100; 
assign decd_inst_lhu   = decd_op[6:0] == 7'b0000011 && decd_func3[2:0] == 3'b101; 

assign decd_inst_sb    = decd_op[6:0] == 7'b0100011 && decd_func3[2:0] == 3'b000; 
assign decd_inst_sh    = decd_op[6:0] == 7'b0100011 && decd_func3[2:0] == 3'b001; 
assign decd_inst_sw    = decd_op[6:0] == 7'b0100011 && decd_func3[2:0] == 3'b010; 

assign decd_lsu_store  = decd_inst_cswsp || decd_inst_csw || decd_inst_sb
                      || decd_inst_sh    || decd_inst_sw;
assign decd_lsu_byte   = decd_inst_lb    || decd_inst_lbu || decd_inst_sb;
assign decd_lsu_half   = decd_inst_lh    || decd_inst_lhu || decd_inst_sh;
assign decd_lsu_uns    = decd_inst_lbu   || decd_inst_lhu;

assign decd_inst_fence  = decd_op[6:0] == 7'b0001111 && !decd_func3[0];
assign decd_inst_fencei = decd_op[6:0] == 7'b0001111 &&  decd_func3[0];

// decoder for CP0
assign decd_sys         = decd_op[6:0] == 7'b1110011 
                      && !decd_inst_expt;
assign decd_inst_ecall  = decd_sys && decd_func3[2:0] == 3'b000 && decd_rs2[1:0] == 2'b0;
assign decd_inst_mret   = decd_sys && decd_func3[2:0] == 3'b000 && decd_rs2[1];
assign decd_inst_mret_nor= decd_inst_mret && (cp0_yy_priv_mode[1:0] == 2'b11);
assign decd_inst_wfi    = decd_sys && decd_func3[2:0] == 3'b000 && decd_rs2[2];
assign decd_inst_csrrw  = decd_sys && decd_func3[2:0] == 3'b001;
assign decd_inst_csrrs  = decd_sys && decd_func3[2:0] == 3'b010;
assign decd_inst_csrrc  = decd_sys && decd_func3[2:0] == 3'b011;
assign decd_inst_csrrwi = decd_sys && decd_func3[2:0] == 3'b101;
assign decd_inst_csrrsi = decd_sys && decd_func3[2:0] == 3'b110;
assign decd_inst_csrrci = decd_sys && decd_func3[2:0] == 3'b111;
assign decd_retire_inst_mret =   1'b0;
assign decd_ctrl_expt_wsc       = 1'b0;
//assign decd_ctrl_mret_expt = decd_inst_mret && (cp0_yy_priv_mode[1:0] != 2'b11);
// &Force("output","decd_ctrl_expt_wsc"); @781
// //&Force("output","decd_ctrl_mret_expt"); @782
// decoder for BRANCH
assign decd_branch_inst = decd_inst_cj    || decd_inst_cjal  || decd_inst_cjr 
                      || decd_inst_cjalr || decd_inst_cbeqz || decd_inst_cbnez
//                      || decd_inst_auipc || decd_inst_jal   || decd_inst_jalr
                      || decd_inst_jal   || decd_inst_jalr
                      || decd_inst_beq   || decd_inst_bne   || decd_inst_blt
                      || decd_inst_bge   || decd_inst_bltu  || decd_inst_bgeu;
assign decd_branch_sel = decd_branch_inst && !decd_inst_expt;

assign decd_inst_cj    = decd_op[4:0] == 5'b10101;
assign decd_inst_cjal  = decd_op[4:0] == 5'b00101;
assign decd_inst_cjr   = decd_op[4:0] == 5'b10010 && !decd_func3[2] && decd_rs2[4:0] == 5'b0;
assign decd_inst_cjalr = decd_op[4:0] == 5'b10010 &&  decd_func3[2] && decd_rs2[4:0] == 5'b0;

assign decd_inst_cbeqz = decd_op[4:0] == 5'b11001;
assign decd_inst_cbnez = decd_op[4:0] == 5'b11101;

assign decd_inst_auipc = decd_op[6:0] == 7'b0010111;
assign decd_inst_jal   = decd_op[6:0] == 7'b1101111;
assign decd_inst_jalr  = decd_op[6:0] == 7'b1100111;

assign decd_inst_beq   = decd_op[6:0] == 7'b1100011 && decd_func3[2:0] == 3'b000; 
assign decd_inst_bne   = decd_op[6:0] == 7'b1100011 && decd_func3[2:0] == 3'b001; 
assign decd_inst_blt   = decd_op[6:0] == 7'b1100011 && decd_func3[2:0] == 3'b100; 
assign decd_inst_bge   = decd_op[6:0] == 7'b1100011 && decd_func3[2:0] == 3'b101; 
assign decd_inst_bltu  = decd_op[6:0] == 7'b1100011 && decd_func3[2:0] == 3'b110; 
assign decd_inst_bgeu  = decd_op[6:0] == 7'b1100011 && decd_func3[2:0] == 3'b111; 

// decoder for SPECIAL
// //&Force("bus", "ifu_iu_ex_imm", 31, 0); @812
assign decd_inst_icall = 1'b0;
assign decd_inst_icpa  = 1'b0;
assign decd_inst_nop   = decd_op[4:0] == 5'b1 && decd_rd[4:0] == 5'b0 &&
                         decd_imm[5:0] == 6'b0;
assign decd_inst_bkpt  = decd_inst[15:0] == 16'h9002      // C.EBREAK 
                      || decd_inst[31:0] == 32'h0010_0073 // EBREAK
                      || (ifu_iu_ex_inst_bkpt && !hs_split_iu_ctrl_inst_vld);
assign decd_inst_expt  = decd_ill_expt || decd_inst_bkpt;
assign ifu_iu_ex_hs_split_expt_vld = ifu_iu_ex_expt_vld && !hs_split_iu_ctrl_inst_vld || decd_inst_bkpt;
assign decd_special_sel = decd_ill_expt || ifu_iu_ex_hs_split_expt_vld
                       || ifu_iu_ex_prvlg_expt_vld
                       || decd_inst_ecall    || decd_inst_nop
                       || decd_inst_fence    || decd_inst_fencei
                       || decd_inst_icall    || decd_inst_icpa
                       || decd_ctrl_expt_wsc;
assign decd_special_fencei = decd_inst_fencei;
assign decd_special_icall = decd_inst_icall;
assign decd_special_icpa  = decd_inst_icpa;

assign tval_sel_pc = (ifu_iu_ex_inst_bkpt || ifu_iu_ex_expt_vld) 
                  && !hs_split_iu_ctrl_inst_vld;
// &Force("bus", "branch_pcgen_add_pc", 30, 0); @839
assign tval_pc[31:0] = ifu_iu_ex_expt_cur ?  {pcgen_xx_cur_pc[30:0], 1'b0}: {branch_pcgen_add_pc[30:1], 2'b0};
assign decd_wb_tval[31:0] = {32{tval_sel_pc}} & tval_pc[31:0] |
                            {32{decd_ill_expt}} & decd_inst[31:0] & {{16{decd_inst_32bit}},16'hffff};

//==========================================================
//                decoder post process
//==========================================================
assign decd_retire_cp0_inst                  = decd_sys;

//==========================================================
//     Rename output decoded information for IU modules
//==========================================================
// alu
assign decd_alu_sel     = !(decd_mad_sel || decd_lsu_sel || decd_sys 
                         || decd_branch_sel || decd_special_sel);
assign decd_alu_func[FUNC_WIDTH-1:0]         = decd_func[FUNC_WIDTH-1:0];
assign decd_alu_sub_func[SUB_FUNC_WIDTH-1:0] = decd_sub_func[SUB_FUNC_WIDTH-1:0];
assign decd_alu_dst_vld                      = decd_dst_vld;
assign decd_alu_rs2_imm_vld                  = decd_rs2_imm_vld;

// branch
assign decd_branch_cj    = decd_inst_cj;
assign decd_branch_cjal  = decd_inst_cjal;
assign decd_branch_cjr   = decd_inst_cjr;
assign decd_branch_cjalr = decd_inst_cjalr;
assign decd_branch_cbeqz = decd_inst_cbeqz;
assign decd_branch_cbnez = decd_inst_cbnez;
assign decd_branch_auipc = decd_inst_auipc;
assign decd_branch_jal   = decd_inst_jal;
assign decd_branch_jalr  = decd_inst_jalr;
assign decd_branch_beq   = decd_inst_beq;
assign decd_branch_bne   = decd_inst_bne;
assign decd_branch_blt   = decd_inst_blt;
assign decd_branch_bge   = decd_inst_bge;
assign decd_branch_bltu  = decd_inst_bltu;
assign decd_branch_bgeu  = decd_inst_bgeu;

// special
assign decd_xx_unit_special_sel = decd_special_sel;

// ctrl
assign decd_ctrl_alu_sel        = decd_alu_sel;
assign decd_ctrl_branch_sel     = decd_branch_sel;
assign decd_ctrl_mad_sel        = decd_mad_sel;
assign decd_ctrl_lsu_sel        = decd_lsu_sel;
assign decd_ctrl_cp0_sel        = decd_sys;
assign decd_ctrl_expt_inv       = decd_ill_expt;
assign decd_ctrl_expt_bkpt      = decd_inst_bkpt;
assign decd_ctrl_expt_ecall     = decd_inst_ecall;

//==========================================================
//     Rename output decoded information for LSU
//==========================================================
assign iu_lsu_ex_store  = decd_lsu_store;
assign iu_lsu_ex_byte   = decd_lsu_byte;
assign iu_lsu_ex_half   = decd_lsu_half;
assign iu_lsu_ex_uns    = decd_lsu_uns;

//==========================================================
//     Rename output decoded information for CP0
//==========================================================
assign iu_cp0_ex_mret   = decd_inst_mret_nor;   
assign iu_cp0_ex_wfi    = decd_inst_wfi;  
assign iu_cp0_ex_csrrw  = decd_inst_csrrw;
assign iu_cp0_ex_csrrs  = decd_inst_csrrs;
assign iu_cp0_ex_csrrc  = decd_inst_csrrc;
assign iu_cp0_ex_csrrwi = decd_inst_csrrwi;
assign iu_cp0_ex_csrrsi = decd_inst_csrrsi;
assign iu_cp0_ex_csrrci = decd_inst_csrrci;
assign iu_cp0_ex_rs1_reg[4:0] = decd_rs1[4:0];
assign iu_cp0_ex_rd_reg[4:0]  = decd_rd[4:0];
assign iu_cp0_ex_func3[2:0]  = decd_func3[2:0];

assign ifu_had_chg_flw_inst = decd_branch_inst;
assign ifu_had_match_pc[31:0] = {pcgen_xx_cur_pc[30:0], 1'b0};
// &ModuleEnd; @917
endmodule


