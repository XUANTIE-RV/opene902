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

// &ModuleBeg; @24
module cr_cp0_iui(
  cp0_iu_data,
  cp0_iu_data_vld,
  cp0_iu_dbg_disable_for_tee,
  cp0_iu_expt_vec,
  cp0_iu_expt_vld,
  cp0_iu_flush,
  cp0_iu_flush_chgflw_vld,
  cp0_iu_inst_mret,
  cp0_iu_req,
  cp0_iu_rte_chgflw_vld,
  cp0_iu_rte_chgflw_vld_for_data,
  cp0_iu_stall,
  cp0_iu_stall_noinput,
  inst_lpmd,
  iu_cp0_ex_csrrc,
  iu_cp0_ex_csrrci,
  iu_cp0_ex_csrrs,
  iu_cp0_ex_csrrsi,
  iu_cp0_ex_csrrw,
  iu_cp0_ex_csrrwi,
  iu_cp0_ex_data_sel,
  iu_cp0_ex_func3,
  iu_cp0_ex_mret,
  iu_cp0_ex_rd_reg,
  iu_cp0_ex_rs1_reg,
  iu_cp0_ex_sel,
  iu_cp0_ex_wfi,
  iu_cp0_imm,
  iu_cp0_oper_mux_en,
  iu_cp0_rs1,
  iu_cp0_syc_rst_b,
  iu_yy_xx_dbgon,
  iui_lpmd_inst_lpmd_for_data,
  iui_oreg_csr_acc,
  iui_oreg_expt,
  iui_oreg_imm,
  iui_oreg_inst_csr,
  iui_oreg_inst_mret,
  iui_oreg_nmi_mret,
  iui_oreg_rd_x0,
  iui_oreg_rs1,
  iui_oreg_rs1_raw,
  iui_oreg_rs1_x0,
  iui_oreg_tval,
  lpmd_iui_stall,
  marchid_value,
  mcause_value,
  mclicbase_value,
  mcpuid_value,
  mcycle_value,
  mcycleh_value,
  mepc_value,
  mexstatus_value,
  mhartid_value,
  mhcr_value,
  mie_value,
  mimpid_value,
  minstret_value,
  minstreth_value,
  mintstatus_value,
  mip_value,
  misa_value,
  mnmicause_value,
  mnmipc_value,
  mnxti_value,
  mraddr_value,
  mscratch_value,
  mscratchcsw_value,
  mscratchcswl_value,
  mstatus_value,
  mtval_value,
  mtvec_value,
  mtvt_value,
  mvendorid_value,
  mxstatus_value,
  oreg_iui_priv_mode,
  oreg_iui_wr_rdonly,
  pmp_cp0_data,
  srst_iui_stall,
  srst_iui_stall_noinput,
  status_xx_nmi
);

// &Ports; @25
input           iu_cp0_ex_csrrc;               
input           iu_cp0_ex_csrrci;              
input           iu_cp0_ex_csrrs;               
input           iu_cp0_ex_csrrsi;              
input           iu_cp0_ex_csrrw;               
input           iu_cp0_ex_csrrwi;              
input           iu_cp0_ex_data_sel;            
input   [2 :0]  iu_cp0_ex_func3;               
input           iu_cp0_ex_mret;                
input   [4 :0]  iu_cp0_ex_rd_reg;              
input   [4 :0]  iu_cp0_ex_rs1_reg;             
input           iu_cp0_ex_sel;                 
input           iu_cp0_ex_wfi;                 
input   [11:0]  iu_cp0_imm;                    
input           iu_cp0_oper_mux_en;            
input   [31:0]  iu_cp0_rs1;                    
input           iu_cp0_syc_rst_b;              
input           iu_yy_xx_dbgon;                
input           lpmd_iui_stall;                
input   [31:0]  marchid_value;                 
input   [31:0]  mcause_value;                  
input   [31:0]  mclicbase_value;               
input   [31:0]  mcpuid_value;                  
input   [31:0]  mcycle_value;                  
input   [31:0]  mcycleh_value;                 
input   [31:0]  mepc_value;                    
input   [31:0]  mexstatus_value;               
input   [31:0]  mhartid_value;                 
input   [31:0]  mhcr_value;                    
input   [31:0]  mie_value;                     
input   [31:0]  mimpid_value;                  
input   [31:0]  minstret_value;                
input   [31:0]  minstreth_value;               
input   [31:0]  mintstatus_value;              
input   [31:0]  mip_value;                     
input   [31:0]  misa_value;                    
input   [31:0]  mnmicause_value;               
input   [31:0]  mnmipc_value;                  
input   [31:0]  mnxti_value;                   
input   [31:0]  mraddr_value;                  
input   [31:0]  mscratch_value;                
input   [31:0]  mscratchcsw_value;             
input   [31:0]  mscratchcswl_value;            
input   [31:0]  mstatus_value;                 
input   [31:0]  mtval_value;                   
input   [31:0]  mtvec_value;                   
input   [31:0]  mtvt_value;                    
input   [31:0]  mvendorid_value;               
input   [31:0]  mxstatus_value;                
input   [1 :0]  oreg_iui_priv_mode;            
input           oreg_iui_wr_rdonly;            
input   [31:0]  pmp_cp0_data;                  
input           srst_iui_stall;                
input           srst_iui_stall_noinput;        
input           status_xx_nmi;                 
output  [31:0]  cp0_iu_data;                   
output          cp0_iu_data_vld;               
output          cp0_iu_dbg_disable_for_tee;    
output  [4 :0]  cp0_iu_expt_vec;               
output          cp0_iu_expt_vld;               
output          cp0_iu_flush;                  
output          cp0_iu_flush_chgflw_vld;       
output          cp0_iu_inst_mret;              
output          cp0_iu_req;                    
output          cp0_iu_rte_chgflw_vld;         
output          cp0_iu_rte_chgflw_vld_for_data; 
output          cp0_iu_stall;                  
output          cp0_iu_stall_noinput;          
output          inst_lpmd;                     
output          iui_lpmd_inst_lpmd_for_data;   
output          iui_oreg_csr_acc;              
output          iui_oreg_expt;                 
output  [11:0]  iui_oreg_imm;                  
output          iui_oreg_inst_csr;             
output          iui_oreg_inst_mret;            
output          iui_oreg_nmi_mret;             
output          iui_oreg_rd_x0;                
output  [31:0]  iui_oreg_rs1;                  
output  [31:0]  iui_oreg_rs1_raw;              
output          iui_oreg_rs1_x0;               
output  [31:0]  iui_oreg_tval;                 

// &Regs; @26
reg     [31:0]  data_out;                      
reg             imm_inv;                       

// &Wires; @27
wire            cp0_csr_flush;                 
wire            cp0_expt_vld;                  
wire            cp0_inst_cmplt;                
wire    [31:0]  cp0_iu_data;                   
wire            cp0_iu_data_vld;               
wire            cp0_iu_dbg_disable_for_tee;    
wire    [4 :0]  cp0_iu_expt_vec;               
wire            cp0_iu_expt_vld;               
wire            cp0_iu_flush;                  
wire            cp0_iu_flush_chgflw_vld;       
wire            cp0_iu_inst_mret;              
wire            cp0_iu_req;                    
wire            cp0_iu_rte_chgflw_vld;         
wire            cp0_iu_rte_chgflw_vld_for_data; 
wire            cp0_iu_stall;                  
wire            cp0_iu_stall_noinput;          
wire            cp0_mret_flush;                
wire            cp0_select;                    
wire            csr_imm_inv;                   
wire    [31:0]  csrrc_rs1;                     
wire    [31:0]  csrrci_rs1;                    
wire    [31:0]  csrrs_rs1;                     
wire    [31:0]  csrrsi_rs1;                    
wire    [31:0]  csrrw_rs1;                     
wire    [31:0]  csrrwi_rs1;                    
wire            imm_vld;                       
wire            inst_csr;                      
wire            inst_csrrc;                    
wire            inst_csrrci;                   
wire            inst_csrrs;                    
wire            inst_csrrsi;                   
wire            inst_csrrw;                    
wire            inst_csrrwi;                   
wire            inst_csrsc;                    
wire            inst_lpmd;                     
wire            inst_mret;                     
wire            inst_no_violation;             
wire            inst_vld;                      
wire            inst_wfi;                      
wire            iu_cp0_ex_csrrc;               
wire            iu_cp0_ex_csrrci;              
wire            iu_cp0_ex_csrrs;               
wire            iu_cp0_ex_csrrsi;              
wire            iu_cp0_ex_csrrw;               
wire            iu_cp0_ex_csrrwi;              
wire            iu_cp0_ex_data_sel;            
wire    [2 :0]  iu_cp0_ex_func3;               
wire            iu_cp0_ex_mret;                
wire    [4 :0]  iu_cp0_ex_rd_reg;              
wire    [4 :0]  iu_cp0_ex_rs1_reg;             
wire            iu_cp0_ex_sel;                 
wire            iu_cp0_ex_wfi;                 
wire    [11:0]  iu_cp0_imm;                    
wire            iu_cp0_oper_mux_en;            
wire    [31:0]  iu_cp0_rs1;                    
wire            iu_cp0_syc_rst_b;              
wire            iu_yy_xx_dbgon;                
wire            iui_csr_cmplt;                 
wire    [11:0]  iui_imm;                       
wire            iui_lpmd_inst_lpmd_for_data;   
wire            iui_oreg_csr_acc;              
wire            iui_oreg_expt;                 
wire    [11:0]  iui_oreg_imm;                  
wire            iui_oreg_inst_csr;             
wire            iui_oreg_inst_mret;            
wire            iui_oreg_nmi_mret;             
wire            iui_oreg_rd_x0;                
wire    [31:0]  iui_oreg_rs1;                  
wire    [31:0]  iui_oreg_rs1_raw;              
wire            iui_oreg_rs1_x0;               
wire    [31:0]  iui_oreg_tval;                 
wire    [31:0]  iui_rs1;                       
wire    [31:0]  iui_uimm;                      
wire            lpmd_iui_stall;                
wire    [31:0]  marchid_value;                 
wire    [31:0]  mcause_value;                  
wire    [31:0]  mclicbase_value;               
wire    [31:0]  mcpuid_value;                  
wire    [31:0]  mcycle_value;                  
wire    [31:0]  mcycleh_value;                 
wire    [31:0]  mepc_value;                    
wire    [31:0]  mexstatus_value;               
wire    [31:0]  mhartid_value;                 
wire    [31:0]  mhcr_value;                    
wire    [31:0]  mie_value;                     
wire    [31:0]  mimpid_value;                  
wire    [31:0]  minstret_value;                
wire    [31:0]  minstreth_value;               
wire    [31:0]  mintstatus_value;              
wire    [31:0]  mip_value;                     
wire    [31:0]  misa_value;                    
wire    [31:0]  mnmicause_value;               
wire    [31:0]  mnmipc_value;                  
wire    [31:0]  mnxti_value;                   
wire    [31:0]  mraddr_value;                  
wire    [31:0]  mscratch_value;                
wire    [31:0]  mscratchcsw_value;             
wire    [31:0]  mscratchcswl_value;            
wire    [31:0]  mstatus_value;                 
wire    [31:0]  mtval_value;                   
wire    [31:0]  mtvec_value;                   
wire    [31:0]  mtvt_value;                    
wire    [31:0]  mvendorid_value;               
wire    [31:0]  mxstatus_value;                
wire            no_expt_vld;                   
wire    [1 :0]  oreg_iui_priv_mode;            
wire            oreg_iui_wr_rdonly;            
wire    [31:0]  pmp_cp0_data;                  
wire            rs1_vld;                       
wire            srst_iui_stall;                
wire            srst_iui_stall_noinput;        
wire            status_xx_nmi;                 
wire            wsc_inv;                       


//==========================================================
//                Define the CSR ADDR
//==========================================================
parameter MSTATUS   = 12'h300;
parameter MISA      = 12'h301;
parameter MIE       = 12'h304;
parameter MTVEC     = 12'h305;
parameter MSCRATCH  = 12'h340;
parameter MEPC      = 12'h341;
parameter MCAUSE    = 12'h342;
parameter MTVAL     = 12'h343;
parameter MIP       = 12'h344;
parameter MCYCLE    = 12'hB00;
parameter MINSTRET  = 12'hB02;
parameter MCYCLEH   = 12'hB80; // RV32I only?
parameter MINSTRETH = 12'hB82; // RV32I only?
parameter MVENDORID = 12'hF11;
parameter MARCHID   = 12'hF12;
parameter MIMPID    = 12'hF13;
parameter MHARTID   = 12'hF14;
parameter MCPUID    = 12'hFC0;
parameter MXSTATUS  = 12'h7c0;
parameter MHCR      = 12'h7C1;
parameter PMPCFG0   = 12'h3A0;
parameter PMPCFG1   = 12'h3A1;
parameter PMPCFG2   = 12'h3A2;
parameter PMPCFG3   = 12'h3A3;
parameter PMPADDR0  = 12'h3B0;
parameter PMPADDR1  = 12'h3B1;
parameter PMPADDR2  = 12'h3B2;
parameter PMPADDR3  = 12'h3B3;
parameter PMPADDR4  = 12'h3B4;
parameter PMPADDR5  = 12'h3B5;
parameter PMPADDR6  = 12'h3B6;
parameter PMPADDR7  = 12'h3B7;
parameter PMPADDR8  = 12'h3B8;
parameter PMPADDR9  = 12'h3B9;
parameter PMPADDR10 = 12'h3BA;
parameter PMPADDR11 = 12'h3BB;
parameter PMPADDR12 = 12'h3BC;
parameter PMPADDR13 = 12'h3BD;
parameter PMPADDR14 = 12'h3BE;
parameter PMPADDR15 = 12'h3BF;
parameter PMPTEECFG = 12'hBEF;
parameter MTVT      = 12'h307;
parameter MNXTI     = 12'h345;
parameter MINTSTATUS = 12'h346;
parameter MSCRATCHCSW  = 12'h348;
parameter MSCRATCHCSWL = 12'h349;
parameter MCLICBASE    = 12'h350;
parameter MRADDR    = 12'h7E0;
parameter MEXSTATUS = 12'h7E1;
parameter MNMICAUSE = 12'h7E2;
parameter MNMIPC    = 12'h7E3;

//==========================================================
//            Handling the CP0 select signal
//==========================================================
assign cp0_select   = iu_cp0_ex_sel;

//==========================================================
//              CP0 operand mux
//==========================================================
assign rs1_vld       = iu_cp0_oper_mux_en && iu_cp0_syc_rst_b;
assign imm_vld       = iu_cp0_oper_mux_en;
assign iui_rs1[31:0] = {32{rs1_vld}} & iu_cp0_rs1[31:0];
assign iui_imm[11:0] = {12{imm_vld}} & iu_cp0_imm[11:0];
assign iui_uimm[4:0] = { 5{imm_vld}} & iu_cp0_ex_rs1_reg[4:0];
assign iui_uimm[31:5] = 27'b0;
assign iui_oreg_rs1_x0 = (inst_csrrs || inst_csrrc || inst_csrrsi || inst_csrrci) && (iu_cp0_ex_rs1_reg[4:0] == 5'b0);
assign iui_oreg_rd_x0  = iu_cp0_ex_rd_reg[4:0] == 5'b0;
//==========================================================
//                Qualify CP0 instructions
//==========================================================
assign inst_no_violation = 1'b1;
assign inst_vld    = cp0_select && inst_no_violation;
//instruction valid are selected when psr_s is high or debug mode
assign inst_mret   = inst_vld && iu_cp0_ex_mret && !iu_yy_xx_dbgon;   
assign inst_wfi    = inst_vld && iu_cp0_ex_wfi;  
assign inst_csrrw  = inst_vld && iu_cp0_ex_csrrw;
assign inst_csrrs  = inst_vld && iu_cp0_ex_csrrs;
assign inst_csrrc  = inst_vld && iu_cp0_ex_csrrc;
assign inst_csrrwi = inst_vld && iu_cp0_ex_csrrwi;
assign inst_csrrsi = inst_vld && iu_cp0_ex_csrrsi;
assign inst_csrrci = inst_vld && iu_cp0_ex_csrrci;

assign inst_csr    = inst_csrrw  || inst_csrrs  || inst_csrrc
                  || inst_csrrwi || inst_csrrsi || inst_csrrci;
assign inst_csrsc  = inst_csrrs  || inst_csrrc  || inst_csrrsi || inst_csrrci;

assign no_expt_vld = inst_csrsc && iui_uimm[4:0] == 5'b0;
assign cp0_expt_vld = oreg_iui_wr_rdonly && !no_expt_vld || csr_imm_inv;
//assign iui_oreg_mret_for_data = iu_cp0_ex_data_sel && iu_cp0_ex_mret;

// oreg signals
assign csrrw_rs1[31:0]  = iui_rs1[31:0];
assign csrrs_rs1[31:0]  = data_out[31:0] |   iui_rs1[31:0];
assign csrrc_rs1[31:0]  = data_out[31:0] & (~iui_rs1[31:0]);
assign csrrwi_rs1[31:0] = iui_uimm[31:0];
assign csrrsi_rs1[31:0] = data_out[31:0] |   iui_uimm[31:0];
assign csrrci_rs1[31:0] = data_out[31:0] & (~iui_uimm[31:0]);

assign iui_oreg_rs1[31:0] = {32{iu_cp0_ex_csrrw}}  & csrrw_rs1[31:0]
                          | {32{iu_cp0_ex_csrrs}}  & csrrs_rs1[31:0]
                          | {32{iu_cp0_ex_csrrc}}  & csrrc_rs1[31:0]
                          | {32{iu_cp0_ex_csrrwi}} & csrrwi_rs1[31:0]
                          | {32{iu_cp0_ex_csrrsi}} & csrrsi_rs1[31:0]
                          | {32{iu_cp0_ex_csrrci}} & csrrci_rs1[31:0];
assign iui_oreg_rs1_raw[31:0] = csrrw_rs1[31:0];

assign iui_oreg_imm[11:0] = iui_imm[11:0];
assign iui_oreg_inst_csr  = cp0_select && inst_csr && !no_expt_vld;
assign iui_oreg_inst_mret = cp0_select && inst_mret;
assign iui_oreg_nmi_mret  = cp0_select && inst_mret && status_xx_nmi;
assign iui_oreg_csr_acc   = cp0_select && inst_csr;

assign iui_oreg_expt = cp0_expt_vld;
assign iui_oreg_tval[31:0] = {iui_imm[11:0], iu_cp0_ex_rs1_reg[4:0], iu_cp0_ex_func3[2:0], iu_cp0_ex_rd_reg[4:0], 7'b1110011};

//low power instruction
// &Force("output","inst_lpmd"); @189
assign inst_lpmd   = inst_wfi;
assign iui_lpmd_inst_lpmd_for_data = inst_no_violation && iu_cp0_ex_wfi;

assign cp0_iu_stall = (lpmd_iui_stall || srst_iui_stall) && iu_cp0_ex_data_sel;
assign cp0_iu_stall_noinput = (lpmd_iui_stall || srst_iui_stall_noinput) && iu_cp0_ex_data_sel;

//==========================================================
//              Handling the CP0 Complete Signal
//==========================================================
//all cp0 instruction can be completed when there is no operation
//in BIU and can enter into low power mode
assign cp0_inst_cmplt  = cp0_select && !(lpmd_iui_stall || srst_iui_stall);
assign cp0_iu_req      = cp0_inst_cmplt;
assign cp0_iu_expt_vld = cp0_select && cp0_expt_vld;

assign cp0_iu_expt_vec[4:0] = 5'b10;

assign cp0_iu_inst_mret = cp0_select && inst_mret;

//==========================================================
//               Generate Data from CP0 to IU
//==========================================================
// &CombBeg; @212
always @( mnmicause_value[31:0]
       or mcycleh_value[31:0]
       or mtval_value[31:0]
       or mie_value[31:0]
       or mcpuid_value[31:0]
       or mstatus_value[31:0]
       or mhcr_value[31:0]
       or mcycle_value[31:0]
       or mraddr_value[31:0]
       or iui_imm[11:0]
       or mscratch_value[31:0]
       or mimpid_value[31:0]
       or mip_value[31:0]
       or mcause_value[31:0]
       or mintstatus_value[31:0]
       or mtvt_value[31:0]
       or mscratchcswl_value[31:0]
       or mvendorid_value[31:0]
       or pmp_cp0_data[31:0]
       or mepc_value[31:0]
       or minstreth_value[31:0]
       or marchid_value[31:0]
       or mxstatus_value[31:0]
       or mexstatus_value[31:0]
       or mscratchcsw_value[31:0]
       or mtvec_value[31:0]
       or mnmipc_value[31:0]
       or mclicbase_value[31:0]
       or misa_value[31:0]
       or mhartid_value[31:0]
       or minstret_value[31:0])
begin
  case(iui_imm[11:0])
    MSTATUS   : data_out[31:0] = mstatus_value[31:0];
    MISA      : data_out[31:0] = misa_value[31:0];   
    MIE       : data_out[31:0] = mie_value[31:0];   
    MTVEC     : data_out[31:0] = mtvec_value[31:0];   
    MSCRATCH  : data_out[31:0] = mscratch_value[31:0];
    MEPC      : data_out[31:0] = mepc_value[31:0];
    MCAUSE    : data_out[31:0] = mcause_value[31:0];
    MTVAL     : data_out[31:0] = mtval_value[31:0];
    MIP       : data_out[31:0] = mip_value[31:0];
    MCYCLE    : data_out[31:0] = mcycle_value[31:0];
    MINSTRET  : data_out[31:0] = minstret_value[31:0];
    MCYCLEH   : data_out[31:0] = mcycleh_value[31:0];
    MINSTRETH : data_out[31:0] = minstreth_value[31:0];
    MVENDORID : data_out[31:0] = mvendorid_value[31:0];
    MARCHID   : data_out[31:0] = marchid_value[31:0];
    MIMPID    : data_out[31:0] = mimpid_value[31:0];
    MHARTID   : data_out[31:0] = mhartid_value[31:0];
    MCPUID    : data_out[31:0] = mcpuid_value[31:0];
    MHCR      : data_out[31:0] = mhcr_value[31:0];
    MRADDR    : data_out[31:0] = mraddr_value[31:0];
    MEXSTATUS : data_out[31:0] = mexstatus_value[31:0];
    PMPCFG0   : data_out[31:0] = pmp_cp0_data[31:0];
    PMPCFG1   : data_out[31:0] = pmp_cp0_data[31:0];
    PMPCFG2   : data_out[31:0] = pmp_cp0_data[31:0];
    PMPCFG3   : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR0  : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR1  : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR2  : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR3  : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR4  : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR5  : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR6  : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR7  : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR8  : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR9  : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR10 : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR11 : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR12 : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR13 : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR14 : data_out[31:0] = pmp_cp0_data[31:0];
    PMPADDR15 : data_out[31:0] = pmp_cp0_data[31:0];
    MTVT      : data_out[31:0] = mtvt_value[31:0];
    MNXTI     : data_out[31:0] = mstatus_value[31:0];
    MINTSTATUS: data_out[31:0] = mintstatus_value[31:0];
    MSCRATCHCSW:  data_out[31:0] = mscratchcsw_value[31:0];
    MSCRATCHCSWL: data_out[31:0] = mscratchcswl_value[31:0];
    MCLICBASE:    data_out[31:0] = mclicbase_value[31:0];
    MXSTATUS    : data_out[31:0] = mxstatus_value[31:0];
    MNMICAUSE  : data_out[31:0] = mnmicause_value[31:0];
    MNMIPC     : data_out[31:0] = mnmipc_value[31:0];
    default   : data_out[31:0] = 32'b0;  
  endcase
// &CombEnd; @302
end

// &CombBeg; @304
always @( iui_imm[11:0])
begin
  case(iui_imm[11:0])
    MSTATUS   : imm_inv = 1'b0; 
    MISA      : imm_inv = 1'b0; 
    MIE       : imm_inv = 1'b0; 
    MTVEC     : imm_inv = 1'b0; 
    MSCRATCH  : imm_inv = 1'b0; 
    MEPC      : imm_inv = 1'b0; 
    MCAUSE    : imm_inv = 1'b0; 
    MTVAL     : imm_inv = 1'b0; 
    MIP       : imm_inv = 1'b0; 
    MCYCLE    : imm_inv = 1'b0; 
    MINSTRET  : imm_inv = 1'b0; 
    MCYCLEH   : imm_inv = 1'b0; 
    MINSTRETH : imm_inv = 1'b0; 
    MVENDORID : imm_inv = 1'b0; 
    MARCHID   : imm_inv = 1'b0; 
    MIMPID    : imm_inv = 1'b0; 
    MHARTID   : imm_inv = 1'b0;
    MCPUID    : imm_inv = 1'b0;
    MHCR      : imm_inv = 1'b0;
    MRADDR    : imm_inv = 1'b0;
    MEXSTATUS : imm_inv = 1'b0;
    PMPCFG0   : imm_inv = 1'b0;
    PMPCFG1   : imm_inv = 1'b0;
    PMPCFG2   : imm_inv = 1'b0;
    PMPCFG3   : imm_inv = 1'b0;
    PMPADDR0  : imm_inv = 1'b0;
    PMPADDR1  : imm_inv = 1'b0;
    PMPADDR2  : imm_inv = 1'b0;
    PMPADDR3  : imm_inv = 1'b0;
    PMPADDR4  : imm_inv = 1'b0;
    PMPADDR5  : imm_inv = 1'b0;
    PMPADDR6  : imm_inv = 1'b0;
    PMPADDR7  : imm_inv = 1'b0;
    PMPADDR8  : imm_inv = 1'b0;
    PMPADDR9  : imm_inv = 1'b0;
    PMPADDR10 : imm_inv = 1'b0;
    PMPADDR11 : imm_inv = 1'b0;
    PMPADDR12 : imm_inv = 1'b0;
    PMPADDR13 : imm_inv = 1'b0;
    PMPADDR14 : imm_inv = 1'b0;
    PMPADDR15 : imm_inv = 1'b0;
    PMPTEECFG : imm_inv = 1'b0;
    MTVT        : imm_inv = 1'b0;
    MNXTI       : imm_inv = 1'b0;
    MINTSTATUS  : imm_inv = 1'b0;
    MSCRATCHCSW : imm_inv = 1'b0;
    MSCRATCHCSWL: imm_inv = 1'b0;
    MCLICBASE   : imm_inv = 1'b0;
    MNMICAUSE  : imm_inv = 1'b0;
    MNMIPC     : imm_inv = 1'b0;
    default   : imm_inv = 1'b1; 
  endcase
// &CombEnd; @399
end
assign csr_imm_inv = wsc_inv || (inst_csr && (imm_inv || ((oreg_iui_priv_mode[1:0] < 2'b11) && !iu_yy_xx_dbgon)));
assign wsc_inv = 1'b0;
//==========================================================
//           Debug Level Control to IU 
//==========================================================
assign cp0_iu_dbg_disable_for_tee = 1'b0;

//==========================================================
//           Generate data valid signal to IU 
//==========================================================
//if there is a mfcr instruction, data valid 
assign cp0_iu_data_vld = (inst_csrsc || iu_cp0_ex_rd_reg[4:0] != 5'b0) &&
                         !cp0_expt_vld;

assign cp0_iu_data[31:0] = iui_imm[11:0] == MNXTI ? mnxti_value[31:0]
                                                  : data_out[31:0];

//==========================================================
//                 generate cp0 flush                   
//==========================================================
//cp0 will generate flush if
//1.mret
//2.CSR write: 
assign cp0_mret_flush  = inst_mret;
assign cp0_csr_flush   = inst_csr;

assign cp0_iu_flush = cp0_mret_flush || cp0_csr_flush;
//==========================================================
//                 CP0 change flow
//==========================================================
//cpu need to fetch instruction after flush, so cp0 flush 
//needs to change flow
assign cp0_iu_rte_chgflw_vld            = inst_mret;
assign cp0_iu_rte_chgflw_vld_for_data   = iu_cp0_ex_data_sel && iu_cp0_ex_mret;

assign iui_csr_cmplt          = inst_csr;
assign cp0_iu_flush_chgflw_vld = iui_csr_cmplt;



// &ModuleEnd; @500
endmodule


