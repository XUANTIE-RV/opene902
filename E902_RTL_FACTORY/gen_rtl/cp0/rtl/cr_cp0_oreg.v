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
module cr_cp0_oreg(
  cp0_had_cpuid_idx0,
  cp0_ifu_rst_inv_done,
  cp0_iu_cache_inv_done,
  cp0_iu_epc_for_chgflw,
  cp0_iu_meie,
  cp0_iu_vbr,
  cp0_iu_vec_mode,
  cp0_pmp_csr_sel,
  cp0_pmp_csr_wen,
  cp0_pmp_updt_data,
  cp0_vector_vec_err_vbr,
  cp0_yy_be_v1,
  cp0_yy_be_v2,
  cpurst_b,
  forever_cpuclk,
  had_iu_force_dbg_en,
  ifu_cp0_rst_inv_req,
  iu_cp0_ecall,
  iu_cp0_epc,
  iu_cp0_epc_update,
  iu_cp0_ex_data_sel,
  iu_cp0_ex_sel,
  iu_cp0_expt_tval,
  iu_cp0_expt_vld,
  iu_cp0_int_vld,
  iu_cp0_lockup_clr,
  iu_cp0_lockup_vld,
  iu_cp0_mtval_updt_vld,
  iu_cp0_nmi_vld,
  iu_cp0_nt_int_pending_vld,
  iu_cp0_syc_rst_b,
  iu_yy_xx_dbgon,
  iu_yy_xx_int_hv,
  iu_yy_xx_int_pending_hv,
  iu_yy_xx_int_pending_id,
  iu_yy_xx_int_pending_il,
  iu_yy_xx_int_pending_priv,
  iui_oreg_csr_acc,
  iui_oreg_expt,
  iui_oreg_imm,
  iui_oreg_inst_csr,
  iui_oreg_inst_mret,
  iui_oreg_nmi_mret,
  iui_oreg_rs1,
  iui_oreg_rs1_raw,
  iui_oreg_tval,
  marchid_value,
  mclicbase_value,
  mcpuid_value,
  mcycle_value,
  mcycleh_value,
  mepc_value,
  mexstatus_local_en,
  mexstatus_sel,
  mhartid_value,
  mhcr_value,
  mie_value,
  mimpid_value,
  minstret_value,
  minstreth_value,
  mip_value,
  misa_value,
  mnmicause_local_en,
  mnmipc_value,
  mnxti_value,
  mnxti_vld_int_pending,
  mraddr_value,
  mscratch_value,
  mscratchcsw_value,
  mscratchcswl_value,
  mtval_value,
  mtvec_value,
  mtvt_value,
  mvendorid_value,
  oreg_clk,
  oreg_clk_en,
  oreg_iui_priv_mode,
  oreg_iui_wr_rdonly,
  oreg_status_mode,
  status_oreg_intr,
  status_oreg_mil,
  status_oreg_mpil,
  status_oreg_mpp,
  status_oreg_mxstatus_t,
  status_oreg_pm,
  status_oreg_vector,
  sysio_cp0_bigend,
  sysio_cp0_clkratio,
  sysio_cp0_endian_v2,
  sysio_cp0_rst_addr,
  tcip_cp0_clic_base,
  vector_cp0_vec_err,
  vector_cp0_vec_err_epc,
  vector_cp0_vec_succeed
);

// &Ports; @26
input           cpurst_b;                 
input           forever_cpuclk;           
input           had_iu_force_dbg_en;      
input           ifu_cp0_rst_inv_req;      
input           iu_cp0_ecall;             
input   [30:0]  iu_cp0_epc;               
input           iu_cp0_epc_update;        
input           iu_cp0_ex_data_sel;       
input           iu_cp0_ex_sel;            
input   [31:0]  iu_cp0_expt_tval;         
input           iu_cp0_expt_vld;          
input           iu_cp0_int_vld;           
input           iu_cp0_lockup_clr;        
input           iu_cp0_lockup_vld;        
input           iu_cp0_mtval_updt_vld;    
input           iu_cp0_nmi_vld;           
input           iu_cp0_nt_int_pending_vld; 
input           iu_cp0_syc_rst_b;         
input           iu_yy_xx_dbgon;           
input           iu_yy_xx_int_hv;          
input           iu_yy_xx_int_pending_hv;  
input   [9 :0]  iu_yy_xx_int_pending_id;  
input   [7 :0]  iu_yy_xx_int_pending_il;  
input   [1 :0]  iu_yy_xx_int_pending_priv; 
input           iui_oreg_csr_acc;         
input           iui_oreg_expt;            
input   [11:0]  iui_oreg_imm;             
input           iui_oreg_inst_csr;        
input           iui_oreg_inst_mret;       
input           iui_oreg_nmi_mret;        
input   [31:0]  iui_oreg_rs1;             
input   [31:0]  iui_oreg_rs1_raw;         
input   [31:0]  iui_oreg_tval;            
input           oreg_clk;                 
input   [1 :0]  oreg_iui_priv_mode;       
input           status_oreg_intr;         
input   [7 :0]  status_oreg_mil;          
input   [7 :0]  status_oreg_mpil;         
input   [1 :0]  status_oreg_mpp;          
input           status_oreg_mxstatus_t;   
input   [1 :0]  status_oreg_pm;           
input   [9 :0]  status_oreg_vector;       
input           sysio_cp0_bigend;         
input   [2 :0]  sysio_cp0_clkratio;       
input           sysio_cp0_endian_v2;      
input   [31:0]  sysio_cp0_rst_addr;       
input   [31:0]  tcip_cp0_clic_base;       
input           vector_cp0_vec_err;       
input   [29:0]  vector_cp0_vec_err_epc;   
input           vector_cp0_vec_succeed;   
output  [31:0]  cp0_had_cpuid_idx0;       
output          cp0_ifu_rst_inv_done;     
output          cp0_iu_cache_inv_done;    
output  [30:0]  cp0_iu_epc_for_chgflw;    
output          cp0_iu_meie;              
output  [29:0]  cp0_iu_vbr;               
output  [1 :0]  cp0_iu_vec_mode;          
output  [11:0]  cp0_pmp_csr_sel;          
output          cp0_pmp_csr_wen;          
output  [31:0]  cp0_pmp_updt_data;        
output  [29:0]  cp0_vector_vec_err_vbr;   
output          cp0_yy_be_v1;             
output          cp0_yy_be_v2;             
output  [31:0]  marchid_value;            
output  [31:0]  mclicbase_value;          
output  [31:0]  mcpuid_value;             
output  [31:0]  mcycle_value;             
output  [31:0]  mcycleh_value;            
output  [31:0]  mepc_value;               
output          mexstatus_local_en;       
output          mexstatus_sel;            
output  [31:0]  mhartid_value;            
output  [31:0]  mhcr_value;               
output  [31:0]  mie_value;                
output  [31:0]  mimpid_value;             
output  [31:0]  minstret_value;           
output  [31:0]  minstreth_value;          
output  [31:0]  mip_value;                
output  [31:0]  misa_value;               
output          mnmicause_local_en;       
output  [31:0]  mnmipc_value;             
output  [31:0]  mnxti_value;              
output          mnxti_vld_int_pending;    
output  [31:0]  mraddr_value;             
output  [31:0]  mscratch_value;           
output  [31:0]  mscratchcsw_value;        
output  [31:0]  mscratchcswl_value;       
output  [31:0]  mtval_value;              
output  [31:0]  mtvec_value;              
output  [31:0]  mtvt_value;               
output  [31:0]  mvendorid_value;          
output          oreg_clk_en;              
output          oreg_iui_wr_rdonly;       
output  [1 :0]  oreg_status_mode;         

// &Regs; @27
reg     [29:0]  cp0_iu_vbr;               
reg     [31:0]  cpuid_value;              
reg     [1 :0]  index;                    
reg             int_hv;                   
reg     [63:0]  mcycle_reg;               
reg     [31:0]  mscratch_reg;             
reg     [31:0]  mtval_value;              
reg     [29:0]  nt_base;                  
reg             nt_meie;                  
reg     [30:0]  nt_mepc;                  
reg     [30:0]  nt_mnmipc;                
reg     [25:0]  nt_mtvt;                  

// &Wires; @28
wire    [29:0]  base;                     
wire    [2 :0]  clk_ratio;                
wire    [31:0]  cp0_had_cpuid_idx0;       
wire            cp0_ifu_rst_inv_done;     
wire            cp0_iu_cache_inv_done;    
wire    [30:0]  cp0_iu_epc_for_chgflw;    
wire            cp0_iu_meie;              
wire    [1 :0]  cp0_iu_vec_mode;          
wire    [11:0]  cp0_pmp_csr_sel;          
wire            cp0_pmp_csr_wen;          
wire    [31:0]  cp0_pmp_updt_data;        
wire    [29:0]  cp0_vector_vec_err_vbr;   
wire            cp0_yy_be_v1;             
wire            cp0_yy_be_v2;             
wire    [31:0]  cpuid_index0_value;       
wire    [31:0]  cpuid_index1_value;       
wire    [31:0]  cpuid_index2_value;       
wire            cpurst_b;                 
wire            csr_wen;                  
wire            expt_int_epc_update_vld;  
wire            forever_cpuclk;           
wire            had_iu_force_dbg_en;      
wire    [29:0]  hv_base;                  
wire            ie;                       
wire            index_max;                
wire    [1 :0]  index_next_val;           
wire            intr;                     
wire            inv_sm_clk_en;            
wire            iu_cp0_ecall;             
wire    [30:0]  iu_cp0_epc;               
wire            iu_cp0_epc_update;        
wire            iu_cp0_ex_data_sel;       
wire            iu_cp0_ex_sel;            
wire    [31:0]  iu_cp0_expt_tval;         
wire            iu_cp0_expt_vld;          
wire            iu_cp0_int_vld;           
wire            iu_cp0_lockup_clr;        
wire            iu_cp0_lockup_vld;        
wire            iu_cp0_mtval_updt_vld;    
wire            iu_cp0_nmi_vld;           
wire            iu_cp0_nt_int_pending_vld; 
wire            iu_cp0_syc_rst_b;         
wire            iu_yy_xx_dbgon;           
wire            iu_yy_xx_int_hv;          
wire            iu_yy_xx_int_pending_hv;  
wire    [9 :0]  iu_yy_xx_int_pending_id;  
wire    [7 :0]  iu_yy_xx_int_pending_il;  
wire    [1 :0]  iu_yy_xx_int_pending_priv; 
wire            iui_oreg_csr_acc;         
wire            iui_oreg_expt;            
wire    [11:0]  iui_oreg_imm;             
wire            iui_oreg_inst_csr;        
wire            iui_oreg_inst_mret;       
wire            iui_oreg_nmi_mret;        
wire    [31:0]  iui_oreg_rs1;             
wire    [31:0]  iui_oreg_rs1_raw;         
wire    [31:0]  iui_oreg_tval;            
wire            marchid_local_en;         
wire    [31:0]  marchid_value;            
wire    [31:0]  mclicbase_value;          
wire            mcpuid_local_en;          
wire    [31:0]  mcpuid_value;             
wire            mcpuid_wen;               
wire            mcycle_local_en;          
wire    [31:0]  mcycle_value;             
wire            mcycleh_local_en;         
wire    [31:0]  mcycleh_value;            
wire            meie;                     
wire            mepc_local_en;            
wire    [31:0]  mepc_value;               
wire    [30:0]  mepc_value_31;            
wire            mexstatus_local_en;       
wire            mexstatus_sel;            
wire            mhartid_local_en;         
wire    [31:0]  mhartid_value;            
wire    [31:0]  mhcr_value;               
wire            mie_local_en;             
wire    [31:0]  mie_value;                
wire    [7 :0]  mil;                      
wire            mimpid_local_en;          
wire    [31:0]  mimpid_value;             
wire    [31:0]  minstret_value;           
wire    [31:0]  minstreth_value;          
wire    [31:0]  mip_value;                
wire            misa_m;                   
wire            misa_user_mode;           
wire    [31:0]  misa_value;               
wire            mnmicause_local_en;       
wire    [31:0]  mnmipc_value;             
wire    [31:0]  mnxti_value;              
wire            mnxti_vld_int_pending;    
wire    [1 :0]  mode;                     
wire    [7 :0]  mpil;                     
wire    [1 :0]  mpp;                      
wire    [31:0]  mraddr_value;             
wire            mscratch_local_en;        
wire    [31:0]  mscratch_value;           
wire            mscratchcsw_local_en;     
wire            mscratchcsw_swap_en;      
wire    [31:0]  mscratchcsw_value;        
wire            mscratchcswl_local_en;    
wire            mscratchcswl_swap_en;     
wire    [31:0]  mscratchcswl_value;       
wire    [31:0]  mtval_expt_update;        
wire            mtval_local_en;           
wire            mtvec_local_en;           
wire    [31:0]  mtvec_value;              
wire            mtvt_local_en;            
wire    [31:0]  mtvt_value;               
wire    [25:0]  mtvt_value_26;            
wire            mvendorid_local_en;       
wire    [31:0]  mvendorid_value;          
wire            mxstatus_t;               
wire            nmi_epc_update_vld;       
wire    [29:0]  nt_base_pre;              
wire            nt_meip;                  
wire            nt_mepc_local_en;         
wire            nt_mie_local_en;          
wire            nt_mnmipc_local_en;       
wire    [1 :0]  nt_mode;                  
wire            nt_mtvec_local_en;        
wire            nt_mtvt_local_en;         
wire            oreg_clk;                 
wire            oreg_clk_en;              
wire    [1 :0]  oreg_iui_priv_mode;       
wire            oreg_iui_wr_rdonly;       
wire    [1 :0]  oreg_status_mode;         
wire            pad_cpu_secu_dbg_en;      
wire    [1 :0]  pm;                       
wire            status_oreg_intr;         
wire    [7 :0]  status_oreg_mil;          
wire    [7 :0]  status_oreg_mpil;         
wire    [1 :0]  status_oreg_mpp;          
wire            status_oreg_mxstatus_t;   
wire    [1 :0]  status_oreg_pm;           
wire    [9 :0]  status_oreg_vector;       
wire    [2 :0]  sysio_cp0_clkratio;       
wire    [31:0]  sysio_cp0_rst_addr;       
wire            t_nt_mie_local_en;        
wire            t_nt_mip_local_en;        
wire            t_ntmepc_local_en;        
wire            t_ntmtvec_local_en;       
wire            t_ntmtvt_local_en;        
wire    [31:0]  tcip_cp0_clic_base;       
wire    [29:0]  vec_adder_base;           
wire    [29:0]  vec_adder_vbr;            
wire    [9 :0]  vec_adder_vec;            
wire    [9 :0]  vector;                   
wire            vector_cp0_vec_err;       
wire    [29:0]  vector_cp0_vec_err_epc;   
wire            vector_cp0_vec_succeed;   
wire            vld_int_pending;          


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

parameter MHCR      = 12'h7C1;

parameter MCPUID    = 12'hFC0;
parameter MTVT      = 12'h307;
parameter MNXTI     = 12'h345;
parameter MINTSTATUS   = 12'h346;
parameter MSCRATCHCSW  = 12'h348;
parameter MSCRATCHCSWL = 12'h349;
parameter MCLICBASE    = 12'h350;

parameter MRADDR    = 12'h7E0;
parameter MEXSTATUS = 12'h7E1;
parameter MNMICAUSE = 12'h7E2;
parameter MNMIPC    = 12'h7E3;

//==========================================================
//                 Instance of Gated Cell  
//==========================================================
//oreg share the same clock with psr
assign oreg_clk_en = csr_wen 
                     || iu_cp0_expt_vld
                     || iui_oreg_inst_mret 
                     || iu_cp0_epc_update 
                     || vector_cp0_vec_succeed 
                     || vector_cp0_vec_err 
                     || iu_cp0_mtval_updt_vld
                     || pad_cpu_secu_dbg_en
                     || had_iu_force_dbg_en
                     || inv_sm_clk_en
                     || iu_cp0_lockup_clr
                     || iu_cp0_lockup_vld;
//==========================================================
//   Generate endian mode and dcache enable to LSU
//==========================================================


// &Force("bus","iui_oreg_rs1",31,0); @109
// &Force("bus","had_cp0_psr_data",31,0); @110
// &Force("bus","iu_yy_xx_expt_vec",7,0); @111
assign csr_wen = iui_oreg_inst_csr && iu_cp0_syc_rst_b && ((oreg_iui_priv_mode[1:0] == 2'b11) || iu_yy_xx_dbgon);
assign nt_mtvec_local_en  = !mxstatus_t  && mtvec_local_en   || t_ntmtvec_local_en;
assign nt_mepc_local_en   = !mxstatus_t  && mepc_local_en    || t_ntmepc_local_en;
assign nt_mie_local_en    = !mxstatus_t  && mie_local_en     || t_nt_mie_local_en;
assign mie_local_en       = csr_wen && iui_oreg_imm[11:0] == MIE;       
assign mtvec_local_en     = csr_wen && iui_oreg_imm[11:0] == MTVEC;     
assign mepc_local_en      = csr_wen && iui_oreg_imm[11:0] == MEPC;      
// &Force("nonport", "t_nt_mip_local_en"); @119
assign mvendorid_local_en = csr_wen && iui_oreg_imm[11:0] == MVENDORID; 
assign marchid_local_en   = csr_wen && iui_oreg_imm[11:0] == MARCHID;   
assign mimpid_local_en    = csr_wen && iui_oreg_imm[11:0] == MIMPID;    
assign mhartid_local_en   = csr_wen && iui_oreg_imm[11:0] == MHARTID;   
assign mcpuid_local_en    = iui_oreg_imm[11:0] == MCPUID;
assign mexstatus_local_en = csr_wen && iui_oreg_imm[11:0] == MEXSTATUS;   
assign mexstatus_sel      = iu_cp0_ex_data_sel && iui_oreg_imm[11:0] == MEXSTATUS;
assign mtval_local_en     = csr_wen && iui_oreg_imm[11:0] == MTVAL;     
assign mscratch_local_en  = csr_wen && iui_oreg_imm[11:0] == MSCRATCH;  
assign mcycle_local_en    = csr_wen && iui_oreg_imm[11:0] == MCYCLE;  
assign mcycleh_local_en   = csr_wen && iui_oreg_imm[11:0] == MCYCLEH;  
assign mtvt_local_en      = csr_wen && iui_oreg_imm[11:0] == MTVT;
assign nt_mtvt_local_en   = mtvt_local_en && !mxstatus_t || t_ntmtvt_local_en;
assign mscratchcsw_local_en  = csr_wen && iui_oreg_imm[11:0] == MSCRATCHCSW;
assign mscratchcswl_local_en = csr_wen && iui_oreg_imm[11:0] == MSCRATCHCSWL;
assign t_ntmtvec_local_en     = 1'b0;
assign t_ntmepc_local_en      = 1'b0;
assign t_nt_mie_local_en      = 1'b0;
assign t_nt_mip_local_en      = 1'b0;

assign nt_mnmipc_local_en    = csr_wen && iui_oreg_imm[11:0] == MNMIPC;
assign mnmicause_local_en = csr_wen && iui_oreg_imm[11:0] == MNMICAUSE;

//assign t_ntmcause_local_en    = 1'b0;
assign t_ntmtvt_local_en      = 1'b0;
assign oreg_iui_wr_rdonly = //misa_local_en || mip_local_en || mcycle_local_en
                         //|| minstret_local_en || mcycleh_local_en 
                         //|| minstreth_local_en || 
                            mvendorid_local_en 
                         || marchid_local_en || mimpid_local_en || mhartid_local_en;


//==========================================================
//               Define the MISA register
//==========================================================
assign misa_value[31:0] = 
// [31:30]          [20]             [12]          [4]         [2]
//  RV32              U               M             E           C
  {2'b1, 9'b0, misa_user_mode, 7'b0, misa_m, 7'b0, 1'b1, 1'b0, 1'b1, 2'b0};
assign misa_user_mode = 1'b1;   
assign misa_m         = 1'b1;   



//==========================================================
//               Define the MTVEC register
//==========================================================
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    nt_base[29:0] <= 30'b0;
  else if(nt_mtvec_local_en)
    nt_base[29:0] <= nt_base_pre[29:0];
  else
    nt_base[29:0] <= nt_base[29:0];
end
assign nt_base_pre[29:0] = mode[1] ? {iui_oreg_rs1[31:6],nt_base[3:0]} : iui_oreg_rs1[31:2];
// &Force("output","nt_mtvec_value"); @236
assign nt_mode = 2'b11;
assign base[29:0]        = {nt_base[29:4], 4'b0};

assign mtvec_value[31:0] = {nt_base[29:0], mode[1:0]};
assign mode[1:0]         = nt_mode[1:0];
//==========================================================
//               Define the MEPC register
//==========================================================
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    nt_mepc[30:0] <= 31'b0;
  else if(expt_int_epc_update_vld)
    nt_mepc[30:0] <= iu_cp0_epc[30:0];
  else if(vector_cp0_vec_err&& !mxstatus_t)
    nt_mepc[30:0] <= {vector_cp0_vec_err_epc[29:0],1'b0};
  else if (iu_cp0_expt_vld && iui_oreg_nmi_mret)
    nt_mepc[30:0] <= nt_mepc[30:0];
  else if (iui_oreg_nmi_mret)
    nt_mepc[30:0] <= nt_mnmipc[30:0];
  else if(nt_mepc_local_en&& !mxstatus_t)
    nt_mepc[30:0] <= iui_oreg_rs1[31:1];
  else
    nt_mepc[30:0] <= nt_mepc[30:0];
end
assign mepc_value[31:0] = {nt_mepc[30:0], 1'b0};
assign mepc_value_31[30:0] = nt_mepc[30:0];
assign expt_int_epc_update_vld  = ((iu_cp0_expt_vld && !iui_oreg_inst_mret) 
                                  || iu_cp0_epc_update) && !mxstatus_t;


always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    nt_mnmipc[30:0] <= 31'b0;
  else if(nt_mepc_local_en&& !mxstatus_t && nmi_epc_update_vld)
    nt_mnmipc[30:0] <= iui_oreg_rs1[31:1];
  else if(nmi_epc_update_vld)
    nt_mnmipc[30:0] <= nt_mepc[30:0];
  else if (nt_mnmipc_local_en && !mxstatus_t)
    nt_mnmipc[30:0] <= iui_oreg_rs1[31:1];
  else
    nt_mnmipc[30:0] <= nt_mnmipc[30:0];
end
assign mnmipc_value[31:0] = {nt_mnmipc[30:0], 1'b0};
assign nmi_epc_update_vld = iu_cp0_nmi_vld && !iui_oreg_inst_mret;
//==========================================================
//               Define the MSCRATCH register
//==========================================================
// &Force("output", "mscratch_value"); @346
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mscratch_reg[31:0] <= 32'b0;
  else if(mscratch_local_en)
    mscratch_reg[31:0] <= iui_oreg_rs1[31:0];
  else if(mscratchcsw_swap_en || mscratchcswl_swap_en)
    mscratch_reg[31:0] <= iui_oreg_rs1[31:0];
  else
    mscratch_reg[31:0] <= mscratch_reg[31:0];
end
assign mscratch_value[31:0] = mscratch_reg[31:0];

//==========================================================
//               Define the MTVT register in CLIC mode
//==========================================================
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    nt_mtvt[25:0] <= 26'b0;
  else if(nt_mtvt_local_en)
    nt_mtvt[25:0] <= iui_oreg_rs1[31:6];
  else
    nt_mtvt[25:0] <= nt_mtvt[25:0];
end
// &Force("nonport","hv_base"); @395
assign mtvt_value[31:0]  = {nt_mtvt[25:0],6'b0};
assign mtvt_value_26[25:0]        = nt_mtvt[25:0];
assign mnxti_value[31:0] = (mode[1:0] == 2'b11) ? vld_int_pending ?  {hv_base[29:0],2'b0} : 32'b0 : 32'b0;
assign vld_int_pending   = (iu_yy_xx_int_pending_il[7:0] > mpil[7:0]) 
                            && (iu_yy_xx_int_pending_priv[1:0] == 2'b11) 
                            && !iu_yy_xx_int_pending_hv;
assign mnxti_vld_int_pending = vld_int_pending && !iu_cp0_nmi_vld; //write csr inst will definitly write the mie
assign mpil[7:0]             = status_oreg_mpil[7:0];
assign mil[7:0]              = status_oreg_mil[7:0];
assign pm[1:0]               = status_oreg_pm[1:0];
assign mpp[1:0]              = status_oreg_mpp[1:0];
assign mscratchcsw_swap_en = mscratchcsw_local_en && mpp[1:0] != pm[1:0];
assign mscratchcsw_value[31:0] = mscratchcsw_swap_en ? mscratch_reg[31:0]
                                                     : iui_oreg_rs1_raw[31:0];

assign mscratchcswl_swap_en = mscratchcswl_local_en && ((mil[7:0] == 8'b0) ^ (mpil[7:0] == 8'b0));
assign mscratchcswl_value[31:0] = mscratchcswl_swap_en ? mscratch_reg[31:0]
                                                       : iui_oreg_rs1_raw[31:0];
assign mclicbase_value[31:0] = tcip_cp0_clic_base[31:0];
//==========================================================
//               Define the MTVAL register
//==========================================================
// &Force("input", "iu_cp0_expt_tval"); @422
// &Force("input", "iu_cp0_ecall"); @423
// &Force("input", "iu_cp0_mtval_updt_vld"); @424
// &Force("input", "iui_oreg_expt"); @425
// &Force("input", "iui_oreg_tval"); @426
// &Force("bus", "iu_cp0_expt_tval",31,0); @427
// &Force("bus", "iui_oreg_tval",31,0); @428
// &Force("output", "mtval_value"); @431
assign mtval_expt_update[31:0] = (iu_cp0_int_vld || iu_cp0_ecall && iu_cp0_ex_sel) ? 
                                  32'b0 : iui_oreg_expt ? iui_oreg_tval[31:0]
                                                       : iu_cp0_expt_tval[31:0];
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mtval_value[31:0] <= 32'b0;
  else if(iu_cp0_mtval_updt_vld)
    mtval_value[31:0] <= mtval_expt_update[31:0];
  else if(mtval_local_en)
    mtval_value[31:0] <= iui_oreg_rs1[31:0];
  else
    mtval_value[31:0] <= mtval_value[31:0];
end
//==========================================================
//               Define the MIE register
//==========================================================
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    nt_meie <= 1'b0;
  else if(nt_mie_local_en)
    nt_meie <= (mode[1] == 1'b0) ? iui_oreg_rs1[11] : nt_meie;
  else
    nt_meie <= nt_meie;
end
assign mie_value[31:0]    = mode[1] ? 32'b0 : {20'b0, nt_meie, 3'b0, 1'b0 , 3'b0, 1'b0, 3'b0};
assign meie               = nt_meie;
//always @(posedge oreg_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    nt_meip <= 1'b0;
//  else if(mode[1] == 1'b0)
//    nt_meip <= iu_cp0_nt_int_pending_vld;
//end
assign nt_meip = iu_cp0_nt_int_pending_vld && (mode[1] == 1'b0);

assign mip_value[31:0]    = mode[1] ? 32'b0 : {20'b0, nt_meip, 3'b0, 1'b0 , 3'b0, 1'b0, 3'b0};

//always @(posedge oreg_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    mtie <= 1'b0;
//  else if(mie_local_en)
//    mtie <= iui_oreg_rs1[7];
//  else
//    mtie <= mtie;
//end
//
//always @(posedge oreg_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    msie <= 1'b0;
//  else if(mie_local_en)
//    msie <= iui_oreg_rs1[3];
//  else
//    msie <= msie;
//end
//assign mie_value[31:0]  = {20'b0, meie, 3'b0, 1'b0 , 3'b0, 1'b0, 3'b0};

//==========================================================
//               Define the MIP register
//==========================================================
//always @(posedge oreg_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    meip <= 1'b0;
//  else if(iu_cp0_int_pending)
//    meip <= 1'b1;
//  else if(iu_cp0_int_vld)
//    meip <= 1'b0;
//  else
//    meip <= meip;
//end
//always @(posedge oreg_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    mtip <= 1'b0;
//  else if(iu_cp0_int_pending) // todo
//    mtip <= 1'b1;
//  else
//    mtip <= mtip;
//end
//always @(posedge oreg_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//    msip <= 1'b0;
//  else if(iu_cp0_int_pending)
//    msip <= 1'b1;
//  else
//    msip <= msip;
//end
////assign mip_value[31:0] = {20'b0, meip, 3'b0, mtip, 3'b0, msip, 3'b0};
//// currently only meip is useful
//assign mip_value[31:0] = {20'b0, meip, 3'b0, 1'b0, 3'b0, 1'b0, 3'b0};
//==========================================================
//               Machine SP define
//               
//=========================================================
//assign cp0_iu_nt_user_sp_we = 1'b0;
//assign cp0_iu_reg_write_data[31:0] = 32'b0;
//==========================================================
//               Define CSKY TEE registers
//               Define the MEBR register
//=========================================================
// &Force("output","mebr_value"); @612
assign pad_cpu_secu_dbg_en = 1'b0;

//==========================================================
//               Define the MCYLE register
//==========================================================
always @(posedge forever_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mcycle_reg[63:0] <= 64'b0;
  else if(mcycle_local_en)
    mcycle_reg[63:0] <= {mcycle_reg[63:32], iui_oreg_rs1[31:0]};
  else if(mcycleh_local_en)
    mcycle_reg[63:0] <= {iui_oreg_rs1[31:0], mcycle_reg[31:0]};
  else
    mcycle_reg[63:0] <= mcycle_reg[63:0] + 1'b1;
end
assign mcycle_value[31:0]  = mcycle_reg[31:0];
assign mcycleh_value[31:0] = mcycle_reg[63:32];

//==========================================================
//               Define the MINSTRET register
//==========================================================
assign minstret_value[31:0]  = 32'b0;
assign minstreth_value[31:0] = 32'b0;

//==========================================================
//               Define the ID Registers
//==========================================================

assign mvendorid_value[31:0] = 32'h5B7; 
assign mimpid_value[31:0]    = 32'b0; 
assign mhartid_value[31:0]   = 32'b0; 

//==========================================================
//               Define the MARCHID register
//==========================================================
assign marchid_value[31:0] = 32'b0;

//==========================================================
//               Define the MRADDR register
//==========================================================
assign mraddr_value[31:0] = sysio_cp0_rst_addr[31:0];

//==========================================================
//               Define the cpuid register
//==========================================================

//----------------------------------------------------------
//                    Index Register
//----------------------------------------------------------
assign index_max = (index[1:0] == 2'd2);
assign index_next_val[1:0] = (index_max) ? 2'd0
                                         : index[1:0] + 2'd1;
assign mcpuid_wen = iui_oreg_csr_acc && iu_cp0_syc_rst_b && ((oreg_iui_priv_mode[1:0] == 2'b11) || iu_yy_xx_dbgon);

always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    begin
      index[1:0] <= 2'b0;
    end
  else if (mcpuid_wen && mcpuid_local_en)
    begin
      index[1:0] <= index_next_val[1:0];
    end
  else
    begin
      index[1:0] <= index[1:0];
    end
end

//----------------------------------------------------------
//                Implement of cpuid register
//----------------------------------------------------------
// &CombBeg; @720
always @( cpuid_index1_value[31:0]
       or cpuid_index0_value[31:0]
       or index[1:0]
       or cpuid_index2_value[31:0])
begin
  case(index[1:0])
  2'b00   : cpuid_value[31:0] = cpuid_index0_value[31:0];
  2'b01   : cpuid_value[31:0] = cpuid_index1_value[31:0];
  2'b10   : cpuid_value[31:0] = cpuid_index2_value[31:0];
  default : cpuid_value[31:0] = 32'bx;
  endcase
// &CombEnd; @727
end

//---------------------------------------------------------
//                    Index 0
//---------------------------------------------------------
    assign cpuid_index0_value[31:28] = 4'b0000;

//------------------------------------------------
//                     Arch  
//------------------------------------------------
    assign cpuid_index0_value[27:26] = 2'b10; // CSKY V3 instruction set

//------------------------------------------------
//                     Family
//------------------------------------------------
    assign cpuid_index0_value[25:22] = 4'b0000; // E Series

//------------------------------------------------
//                     Class 
//------------------------------------------------
    assign cpuid_index0_value[21:18] = 4'b0001; // E902

//------------------------------------------------
//                     Model 
//------------------------------------------------
    assign cpuid_index0_value[17:10] = 8'b0; 
  
    assign cpuid_index0_value[9] = 1'b0;

    assign cpuid_index0_value[8] = 1'b0; 

//------------------------------------------------
//                   ISA Revision
//------------------------------------------------
    assign cpuid_index0_value[7:3] = 5'b00001; 

//------------------------------------------------
//                     Version
//------------------------------------------------
    assign cpuid_index0_value[2:0] = 3'b101; //CPID Rev.5

//---------------------------------------------------------
//                    Index 1
//---------------------------------------------------------
    assign cpuid_index1_value[31:28] = 4'b0001;

//------------------------------------------------
//                    Revision
//------------------------------------------------
    assign cpuid_index1_value[27:24] = `REVISION;

//------------------------------------------------
//                  Sub Revision
//------------------------------------------------
    assign cpuid_index1_value[23:18] = `SUB_VERSION;

//------------------------------------------------
//                     Patch
//------------------------------------------------
    assign cpuid_index1_value[17:12] = `PATCH;


//------------------------------------------------
//                     PRODUCT ID 
//------------------------------------------------
    assign cpuid_index1_value[11:0] = `PRODUCT_ID; 

//------------------------------------------------
//                    Index 2
//------------------------------------------------
    assign cpuid_index2_value[31:28] = 4'b0010;

//------------------------------------------------
//                    IBUS
//------------------------------------------------
    assign cpuid_index2_value[27:26] = 2'b01;

//------------------------------------------------
//                    DBUS
//------------------------------------------------
    assign cpuid_index2_value[25:24] = 2'b00;

//------------------------------------------------
//                    SBUS
//------------------------------------------------
    assign cpuid_index2_value[23:21] = 3'b001;

//------------------------------------------------
//                    Reserved
//------------------------------------------------
    assign cpuid_index2_value[20:16] = 5'b0;

//------------------------------------------------
//                    INTC
//------------------------------------------------
    assign cpuid_index2_value[15:12] = 4'b1111;

//------------------------------------------------
//                  DCACHE 
//------------------------------------------------
    assign cpuid_index2_value[11:9] = 3'b0;

//------------------------------------------------
//                  ICACHE
//------------------------------------------------
    assign cpuid_index2_value[8:6] = 3'b0;

//------------------------------------------------
//                   PMP zone size
//------------------------------------------------
    assign cpuid_index2_value[5:3] = 3'b111; // 4B

//------------------------------------------------
//                   MGU zone num
//------------------------------------------------
    assign cpuid_index2_value[2:0] = 3'b011;
assign mcpuid_value[31:0] = cpuid_value[31:0];
// &Force("bus", "iui_regs_wdata", 31, 0); @892

//==========================================================
//               Define the MHCR register
//  Machine Hardwire Control Register
//  32-bit Machine Mode Read/Write
//  the definiton for MHSR register is listed as follows
//==========================================================
assign clk_ratio[2:0] = sysio_cp0_clkratio[2:0];

assign ie = 1'b0;

assign mhcr_value[31:0] = {13'b0, clk_ratio[2:0], 15'b0, ie};

// &CombBeg; @937
// &CombEnd; @958
// &Force("bus", "iu_cp0_rs1", 31, 0); @965
// &Force("input","ifu_cp0_rst_inv_req"); @971
assign cp0_ifu_rst_inv_done     = 1'b1;
assign cp0_iu_cache_inv_done    = 1'b1;
assign inv_sm_clk_en            = 1'b0;

//==========================================================
//               Output to lpmd
//==========================================================
// &Force("nonport","meie"); @983
assign cp0_iu_meie = meie;
//==========================================================
//               Output to IU
//==========================================================
assign vector[9:0]                 = status_oreg_vector[9:0];
assign intr                        = status_oreg_intr;
// &Force("output","cp0_iu_vbr"); @993
//=======================
//// clic int hv flop
////
//=======================
//the other signals: id, il will be floped by mcause and int status
//th hv should also be floped,
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    int_hv <= 1'b0;
  else if(iu_cp0_expt_vld)
    int_hv <= iu_yy_xx_int_hv;
  else 
    int_hv <= int_hv;
end

// &CombBeg; @1010
always @( intr
       or vec_adder_vbr[29:0]
       or base[29:0]
       or mode[1:0]
       or int_hv)
begin
case({intr,mode[1:0]})
3'b100:cp0_iu_vbr[29:0] = base[29:0];
3'b101:cp0_iu_vbr[29:0] = vec_adder_vbr[29:0];
3'b111:cp0_iu_vbr[29:0] = int_hv ? vec_adder_vbr[29:0] : {base[29:4],4'b0};
// 3'b111:cp0_iu_vbr[29:0] = vec_adder_vbr[29:0];
3'b000:cp0_iu_vbr[29:0] = base[29:0];
3'b001:cp0_iu_vbr[29:0] = base[29:0];
// 3'b010:cp0_iu_vbr[29:0] = {base[29:4],4'b0};
3'b011:cp0_iu_vbr[29:0] = {base[29:4],4'b0};
default: cp0_iu_vbr[29:0] = {30{1'bx}};
endcase
// &CombEnd; @1022
end
assign vec_adder_base[29:0]        = mode[1] ? {mtvt_value_26[25:0],4'b0} : base[29:0];
assign vec_adder_vec[9:0]          = mode[1] ? vld_int_pending ? iu_yy_xx_int_pending_id[9:0] : vector[9:0] 
                                             : {6'b0,vector[3:0]};
assign vec_adder_vbr[29:0]         = vec_adder_base[29:0] + {20'b0, vec_adder_vec[9:0]};
assign hv_base[29:0]               = vec_adder_vbr[29:0];
assign cp0_vector_vec_err_vbr[29:0] = {base[29:4],4'b0};
assign cp0_iu_epc_for_chgflw[30:0] = mepc_value_31[30:0]; 
// all interrups are external now
//assign cp0_iu_ie_for_int           = iui_oreg_inst_mret ? mpie && meie 
//                                                        : mie && meie;
assign oreg_status_mode[1:0]       = mode[1:0];

assign cp0_iu_vec_mode[1:0]        = mode[1:0];
assign mxstatus_t                  = status_oreg_mxstatus_t;
//==========================================================
//               Output to PMP
//==========================================================
assign cp0_pmp_csr_wen         = csr_wen;
assign cp0_pmp_csr_sel[11:0]   = iui_oreg_imm[11:0];
assign cp0_pmp_updt_data[31:0] = iui_oreg_rs1[31:0];


//==========================================================
//               Output to HAD
//==========================================================
assign cp0_had_cpuid_idx0[31:0] = cpuid_index0_value[31:0];
//assign cp0_had_psr_data[31:0]      = 32'b0;
//assign cp0_had_spsr_data[31:0]     = 32'b0;

//==========================================================
//               Output to Pad
//================secu_mode_aft_dbg================================
// assign cp0_pad_psr[31:0]           = mstatus_value[31:0];

//assign cp0_yy_supv_mode_aft_dbg    = 1'b0;
//assign iu_cp0_int_pending = 1'b0;
// &Force("input", "sysio_cp0_bigend"); @1069
// &Force("input", "sysio_cp0_clkratio"); @1070
// &Force("bus", "sysio_cp0_clkratio", 2, 0); @1071
// &Force("input", "sysio_cp0_endian_v2"); @1072
assign cp0_yy_be_v1 = 1'b0; 
assign cp0_yy_be_v2 = 1'b0; 

// &ModuleEnd; @1076
endmodule


