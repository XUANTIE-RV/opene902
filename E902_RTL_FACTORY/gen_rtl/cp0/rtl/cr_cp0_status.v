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
module cr_cp0_status(
  clic_cpu_int_id,
  cp0_had_int_exit,
  cp0_had_mcause_data,
  cp0_iu_cskyisaee,
  cp0_iu_il,
  cp0_iu_in_expt,
  cp0_iu_in_nmi,
  cp0_iu_mie_for_int,
  cp0_iu_mret,
  cp0_iu_wfe_en,
  cp0_pad_mcause,
  cp0_pad_mintstatus,
  cp0_pad_mstatus,
  cp0_pmp_mstatus_mpp,
  cp0_pmp_mstatus_mprv,
  cp0_yy_machine_mode_aft_dbg,
  cp0_yy_priv_mode,
  cpu_clic_curid,
  cpu_clic_int_exit,
  cpurst_b,
  iu_cp0_expt_vld,
  iu_cp0_int_vld,
  iu_cp0_lockup_clr,
  iu_cp0_lockup_vld,
  iu_cp0_nmi_vld,
  iu_cp0_syc_rst_b,
  iu_yy_xx_dbgon,
  iu_yy_xx_expt_vec,
  iu_yy_xx_int_hv,
  iu_yy_xx_int_il,
  iu_yy_xx_int_pending_id,
  iu_yy_xx_int_pending_il,
  iui_oreg_imm,
  iui_oreg_inst_csr,
  iui_oreg_inst_mret,
  iui_oreg_nmi_mret,
  iui_oreg_rd_x0,
  iui_oreg_rs1,
  iui_oreg_rs1_raw,
  iui_oreg_rs1_x0,
  mcause_value,
  mexstatus_local_en,
  mexstatus_sel,
  mexstatus_value,
  mintstatus_value,
  mnmicause_local_en,
  mnmicause_value,
  mnxti_vld_int_pending,
  mstatus_value,
  mxstatus_value,
  oreg_clk,
  oreg_iui_priv_mode,
  oreg_status_mode,
  status_lpmd_lpmd,
  status_oreg_intr,
  status_oreg_mil,
  status_oreg_mpil,
  status_oreg_mpp,
  status_oreg_mxstatus_t,
  status_oreg_pm,
  status_oreg_vector,
  status_srst_req_valid,
  status_srst_req_valid_noinput,
  status_srst_value,
  status_xx_nmi,
  vector_cp0_vec_succeed
);

// &Ports; @26
input   [11:0]  clic_cpu_int_id;              
input           cpurst_b;                     
input           iu_cp0_expt_vld;              
input           iu_cp0_int_vld;               
input           iu_cp0_lockup_clr;            
input           iu_cp0_lockup_vld;            
input           iu_cp0_nmi_vld;               
input           iu_cp0_syc_rst_b;             
input           iu_yy_xx_dbgon;               
input   [9 :0]  iu_yy_xx_expt_vec;            
input           iu_yy_xx_int_hv;              
input   [7 :0]  iu_yy_xx_int_il;              
input   [9 :0]  iu_yy_xx_int_pending_id;      
input   [7 :0]  iu_yy_xx_int_pending_il;      
input   [11:0]  iui_oreg_imm;                 
input           iui_oreg_inst_csr;            
input           iui_oreg_inst_mret;           
input           iui_oreg_nmi_mret;            
input           iui_oreg_rd_x0;               
input   [31:0]  iui_oreg_rs1;                 
input   [31:0]  iui_oreg_rs1_raw;             
input           iui_oreg_rs1_x0;              
input           mexstatus_local_en;           
input           mexstatus_sel;                
input           mnmicause_local_en;           
input           mnxti_vld_int_pending;        
input           oreg_clk;                     
input   [1 :0]  oreg_status_mode;             
input           vector_cp0_vec_succeed;       
output          cp0_had_int_exit;             
output  [31:0]  cp0_had_mcause_data;          
output          cp0_iu_cskyisaee;             
output  [7 :0]  cp0_iu_il;                    
output          cp0_iu_in_expt;               
output          cp0_iu_in_nmi;                
output          cp0_iu_mie_for_int;           
output          cp0_iu_mret;                  
output          cp0_iu_wfe_en;                
output  [31:0]  cp0_pad_mcause;               
output  [31:0]  cp0_pad_mintstatus;           
output  [31:0]  cp0_pad_mstatus;              
output  [1 :0]  cp0_pmp_mstatus_mpp;          
output          cp0_pmp_mstatus_mprv;         
output          cp0_yy_machine_mode_aft_dbg;  
output  [1 :0]  cp0_yy_priv_mode;             
output  [11:0]  cpu_clic_curid;               
output          cpu_clic_int_exit;            
output  [31:0]  mcause_value;                 
output  [31:0]  mexstatus_value;              
output  [31:0]  mintstatus_value;             
output  [31:0]  mnmicause_value;              
output  [31:0]  mstatus_value;                
output  [31:0]  mxstatus_value;               
output  [1 :0]  oreg_iui_priv_mode;           
output  [1 :0]  status_lpmd_lpmd;             
output          status_oreg_intr;             
output  [7 :0]  status_oreg_mil;              
output  [7 :0]  status_oreg_mpil;             
output  [1 :0]  status_oreg_mpp;              
output          status_oreg_mxstatus_t;       
output  [1 :0]  status_oreg_pm;               
output  [9 :0]  status_oreg_vector;           
output          status_srst_req_valid;        
output          status_srst_req_valid_noinput; 
output  [1 :0]  status_srst_value;            
output          status_xx_nmi;                

// &Regs; @27
reg             intr;                         
reg             mexstatus_expt_vld;           
reg             mexstatus_lockup_vld;         
reg     [1 :0]  mexstatus_lpmd;               
reg             mexstatus_nmi_vld;            
reg     [1 :0]  mexstatus_reset_mode;         
reg             mexstatus_wfe_en;             
reg             mie;                          
reg     [7 :0]  mil;                          
reg             minhv;                        
reg             mpie;                         
reg     [7 :0]  mpil;                         
reg     [1 :0]  mpp;                          
reg             mprv;                         
reg             nmi_intr;                     
reg             nmi_mpie;                     
reg     [1 :0]  nmi_mpp;                      
reg     [9 :0]  nmi_vector;                   
reg     [1 :0]  pm;                           
reg     [9 :0]  vector;                       

// &Wires; @28
wire    [11:0]  clic_cpu_int_id;              
wire            cp0_had_int_exit;             
wire    [31:0]  cp0_had_mcause_data;          
wire            cp0_iu_cskyisaee;             
wire    [7 :0]  cp0_iu_il;                    
wire            cp0_iu_in_expt;               
wire            cp0_iu_in_nmi;                
wire            cp0_iu_mie_for_int;           
wire            cp0_iu_mret;                  
wire            cp0_iu_wfe_en;                
wire    [31:0]  cp0_pad_mcause;               
wire    [31:0]  cp0_pad_mintstatus;           
wire    [31:0]  cp0_pad_mstatus;              
wire    [1 :0]  cp0_pmp_mstatus_mpp;          
wire            cp0_pmp_mstatus_mprv;         
wire            cp0_yy_machine_mode_aft_dbg;  
wire    [1 :0]  cp0_yy_priv_mode;             
wire    [11:0]  cpu_clic_curid;               
wire            cpu_clic_int_exit;            
wire            cpurst_b;                     
wire            csr_wen;                      
wire            hw_vector_clic_on;            
wire            iu_cp0_expt_vld;              
wire            iu_cp0_int_vld;               
wire            iu_cp0_lockup_clr;            
wire            iu_cp0_lockup_vld;            
wire            iu_cp0_nmi_vld;               
wire            iu_cp0_syc_rst_b;             
wire            iu_yy_xx_dbgon;               
wire    [9 :0]  iu_yy_xx_expt_vec;            
wire            iu_yy_xx_int_hv;              
wire    [7 :0]  iu_yy_xx_int_il;              
wire    [9 :0]  iu_yy_xx_int_pending_id;      
wire    [7 :0]  iu_yy_xx_int_pending_il;      
wire    [11:0]  iui_oreg_imm;                 
wire            iui_oreg_inst_csr;            
wire            iui_oreg_inst_mret;           
wire            iui_oreg_nmi_mret;            
wire            iui_oreg_rd_x0;               
wire    [31:0]  iui_oreg_rs1;                 
wire    [31:0]  iui_oreg_rs1_raw;             
wire            iui_oreg_rs1_x0;              
wire    [1 :0]  lpmd_in;                      
wire            mcause_local_en;              
wire    [31:0]  mcause_value;                 
wire            mexstatus_local_en;           
wire            mexstatus_sel;                
wire    [31:0]  mexstatus_value;              
wire            mie_bypass;                   
wire    [7 :0]  mil_bypass;                   
wire    [31:0]  mintstatus_value;             
wire            mnmicause_local_en;           
wire    [31:0]  mnmicause_value;              
wire            mnxti_local_en;               
wire            mnxti_mstatus_local_en;       
wire            mnxti_vld_int_pending;        
wire    [1 :0]  mode;                         
wire            mstatus_local_en;             
wire    [31:0]  mstatus_value;                
wire            mxstatus_cskyisaee;           
wire            mxstatus_mspe;                
wire            mxstatus_t;                   
wire    [31:0]  mxstatus_value;               
wire            oreg_clk;                     
wire    [1 :0]  oreg_iui_priv_mode;           
wire    [1 :0]  oreg_status_mode;             
wire    [1 :0]  pm_bypass;                    
wire    [1 :0]  reset_mode_in;                
wire            status_in_nmi;                
wire    [1 :0]  status_lpmd_lpmd;             
wire            status_oreg_intr;             
wire    [7 :0]  status_oreg_mil;              
wire    [7 :0]  status_oreg_mpil;             
wire    [1 :0]  status_oreg_mpp;              
wire            status_oreg_mxstatus_t;       
wire    [1 :0]  status_oreg_pm;               
wire    [9 :0]  status_oreg_vector;           
wire            status_srst_req_valid;        
wire            status_srst_req_valid_noinput; 
wire    [1 :0]  status_srst_value;            
wire            status_xx_nmi;                
wire            vector_cp0_vec_succeed;       

parameter MSTATUS   = 12'h300;
parameter MCAUSE    = 12'h342;
parameter MNXTI     = 12'h345;
parameter MXSTATUS  = 12'h7c0;

assign csr_wen                = iui_oreg_inst_csr 
                                && iu_cp0_syc_rst_b 
                                && ((pm[1:0] == 2'b11) || iu_yy_xx_dbgon);

//===============
// csr write en 
//===============
assign mstatus_local_en       = (csr_wen && iui_oreg_imm[11:0] == MSTATUS) 
                                || (mnxti_mstatus_local_en);
assign mnxti_local_en         = mnxti_mstatus_local_en
                                && !iui_oreg_rd_x0;
assign mnxti_mstatus_local_en = csr_wen 
                                && (iui_oreg_imm[11:0] == MNXTI) 
                                && !iui_oreg_rs1_x0;
assign mode[1:0]              = oreg_status_mode[1:0];
assign mcause_local_en        = csr_wen && iui_oreg_imm[11:0] == MCAUSE;
// no further had update the status register when exit debug mode
//==========================================================
//               Define the MSTATUS register
//==========================================================
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mpie <= 1'b0;
  else if(mstatus_local_en && iu_cp0_int_vld)
    mpie <= iui_oreg_rs1[3];
  else if((mode[1]==1'b1) && mcause_local_en && iu_cp0_int_vld)
    mpie <=iui_oreg_rs1[27];
  else if(iui_oreg_inst_mret && iu_cp0_int_vld)
    mpie <= mpie;
  else if(iu_cp0_expt_vld)
    mpie <= mie;
  else if(iui_oreg_nmi_mret)
    mpie <= nmi_mpie;
  else if(iui_oreg_inst_mret)
    mpie <= 1'b1;
  else if(mstatus_local_en)
    mpie <= iui_oreg_rs1[7];
  else if((mode[1]==1'b1) && mcause_local_en)
    mpie <=iui_oreg_rs1[27];
  else
    mpie <= mpie;
end

always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    nmi_mpie <= 1'b0;
  else if((mode[1]==1'b1) && mnmicause_local_en && iu_cp0_nmi_vld)
    nmi_mpie <=iui_oreg_rs1[27];
  else if(iui_oreg_nmi_mret && iu_cp0_nmi_vld)
    nmi_mpie <= nmi_mpie;
  else if(iu_cp0_nmi_vld)
    nmi_mpie <= mpie;
  else if(iui_oreg_nmi_mret)
    nmi_mpie <= 1'b1;
  else if((mode[1]==1'b1) && mnmicause_local_en)
    nmi_mpie <=iui_oreg_rs1[27];
  else
    nmi_mpie <= nmi_mpie;
end
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mpp[1:0] <= 2'b11;
  else if(mstatus_local_en && iu_cp0_int_vld)
    mpp[1:0] <= pm[1:0];
  else if((mode[1]==1'b1) && mcause_local_en && iu_cp0_int_vld)
    mpp[1:0] <= {2{iui_oreg_rs1[28]}};
  else if(iui_oreg_inst_mret && iu_cp0_int_vld)
    mpp[1:0] <= mpp[1:0];
  else if(iu_cp0_expt_vld)
    mpp[1:0] <= pm[1:0];
  else if(iui_oreg_nmi_mret)
    mpp[1:0] <= nmi_mpp[1:0];
  else if(iui_oreg_inst_mret)
    mpp[1:0] <= 2'b00;
  else if(mstatus_local_en)
    mpp[1:0] <= {2{iui_oreg_rs1[11]}};
  else if((mode[1]==1'b1) && mcause_local_en)
    mpp[1:0] <= {2{iui_oreg_rs1[28]}};
  else
    mpp[1:0] <= mpp[1:0];
end

always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    nmi_mpp[1:0] <= 2'b11;
  else if((mode[1]==1'b1) && mnmicause_local_en && iu_cp0_nmi_vld)
    nmi_mpp[1:0] <= {2{iui_oreg_rs1[28]}};
  else if(iui_oreg_nmi_mret && iu_cp0_nmi_vld)
    nmi_mpp[1:0] <= nmi_mpp[1:0];
  else if(iu_cp0_nmi_vld)
    nmi_mpp[1:0] <= mpp[1:0];
  else if(iui_oreg_nmi_mret)
    nmi_mpp[1:0] <= 2'b00;
  else if((mode[1]==1'b1) && mnmicause_local_en)
    nmi_mpp[1:0] <= {2{iui_oreg_rs1[28]}};
  else
    nmi_mpp[1:0] <= nmi_mpp[1:0];
end
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mprv <= 1'b0;
  else if(mstatus_local_en)
    mprv <= iui_oreg_rs1[17];
  else
    mprv <= mprv;
end

always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pm[1:0] <= 2'b11;
  else if(iu_cp0_expt_vld)
    pm[1:0] <= 2'b11;
  else if(iui_oreg_inst_mret)
    pm[1:0] <= mpp[1:0];
  else
    pm[1:0] <= pm[1:0];
end
assign pm_bypass[1:0] = iui_oreg_inst_mret ? mpp[1:0]
                                           : pm[1:0];

always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mie <= 1'b0;
  else if(iu_cp0_expt_vld)
    mie <= 1'b0;
  else if(iui_oreg_inst_mret)
    mie <= mpie;
  else if(mstatus_local_en)
    mie <= iui_oreg_rs1[3];
  else
    mie <= mie;
end
assign mie_bypass = iui_oreg_inst_mret ? mpie
                                       : mie;
// &Force("output", "mstatus_value"); @193
assign mstatus_value[31:0]  = {13'b0,1'b0,mprv,4'b0,mpp[1:0],3'b0, mpie, 3'b0, mie, 3'b0};
//==========================================================
//               Define the MCAUSE register
//==========================================================
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    intr <= 1'b0;
   else if(iu_cp0_int_vld)
    intr <= 1'b1;
  else if(iu_cp0_expt_vld)
    intr <= 1'b0;
  else if(iui_oreg_nmi_mret)
    intr <= nmi_intr;
  else if(mcause_local_en)
    intr <= iui_oreg_rs1[31];
  else
    intr <= intr;
end

assign status_oreg_intr = intr;

// When NMI hit, intr backuped in nmi_intr.
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    nmi_intr <= 1'b0;
  else if(iu_cp0_nmi_vld)
    nmi_intr <= intr;
  else if(mnmicause_local_en)
    nmi_intr <= iui_oreg_rs1[31];
  else
    nmi_intr <= nmi_intr;
end

always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    vector[9:0] <= 10'b0;
  else if (iu_cp0_nmi_vld)
    vector[9:0] <= 10'd24;
  else if(iu_cp0_expt_vld)
    vector[9:0] <= {iu_yy_xx_expt_vec[9:0]};
  else if(iui_oreg_nmi_mret)
    vector[9:0] <= nmi_vector[9:0];
  else if(mcause_local_en)
    vector[9:0] <= (mode[1]==1'b1) ? iui_oreg_rs1[9:0] : {6'b0,iui_oreg_rs1[3:0]};
  else if(mnxti_local_en && mnxti_vld_int_pending)
    vector[9:0] <= iu_yy_xx_int_pending_id[9:0];
  else
    vector[9:0] <= vector[9:0];
end
assign status_oreg_vector[9:0] = (mode[1]==1'b1) ? vector[9:0] :{6'b0,vector[3:0]};

// When NMI hit, vector backuped in nmi_vector.
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    nmi_vector[9:0] <= 10'b0;
  else if(iu_cp0_nmi_vld)
    nmi_vector[9:0] <= vector[9:0];
  else if(mnmicause_local_en)
    nmi_vector[9:0] <= (mode[1]==1'b1) ? iui_oreg_rs1[9:0] : {6'b0,iui_oreg_rs1[3:0]};
  else
    nmi_vector[9:0] <= nmi_vector[9:0];
end
// &Force("bus", "iu_yy_xx_expt_vec", 9, 0); @262

always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    minhv <= 1'b0;
  else if(mode[1]==1'b0)//Orignal vec mode
    minhv <=1'b0;
  else if(mcause_local_en)
    minhv <= iui_oreg_rs1[30];
  else if(hw_vector_clic_on)//CLICmode
    minhv <= 1'b1;
  else if(vector_cp0_vec_succeed)
    minhv <= 1'b0;
end
assign hw_vector_clic_on = iu_yy_xx_int_hv && iu_cp0_int_vld;
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mpil[7:0] <= 8'b0;
  else if(mode[1]==1'b0)
    mpil[7:0] <= 8'b0;
  else if(iu_cp0_int_vld)
    mpil[7:0] <= mil_bypass[7:0];
  else if(mcause_local_en)
    mpil[7:0] <= iui_oreg_rs1[23:16];
  else
    mpil[7:0] <= mpil[7:0];
end
assign status_oreg_mpil[7:0] = mpil[7:0];
assign mcause_value[31:0]    = mode[1] ? {intr, minhv, mpp[1:0], mpie, 3'b0, 
                                          mpil[7:0], 6'b0, vector[9:0]}
                                       : {intr,27'b0,vector[3:0]};
assign mnmicause_value[31:0] = {nmi_intr, 1'b0, nmi_mpp[1:0], nmi_mpie, 3'b0,
                                8'b0, 6'b0, nmi_vector[9:0]};
// &Force("output", "mcause_value"); @315

always @(posedge oreg_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mil[7:0] <= 8'b0;
  else if(mode[1]==1'b0)
    mil[7:0] <= 8'b0;
   else if(iu_cp0_int_vld)
    mil[7:0] <= iu_yy_xx_int_il[7:0];
  else if(iui_oreg_inst_mret && intr)
    mil[7:0] <= mpil[7:0];
  else if(mnxti_local_en && mnxti_vld_int_pending)
    mil[7:0] <= iu_yy_xx_int_pending_il[7:0];
  else
    mil[7:0] <= mil[7:0];
end
assign mil_bypass[7:0] = iui_oreg_inst_mret && intr ? mpil[7:0]
                                                    : mil[7:0];
assign status_oreg_mil[7:0] = mil[7:0];
assign mintstatus_value[31:0] = {mil[7:0],24'b0};
// &Force("output","mintstatus_value"); @337
//===========================================
// interface to iu
//===========================================
assign cp0_iu_mie_for_int            = mie_bypass || (pm_bypass[1:0] != 2'b11);
assign cp0_iu_il[7:0]                = mil_bypass[7:0];
//===========================================
// interface to other module
//===========================================
assign status_oreg_pm[1:0]           = pm[1:0];
assign status_oreg_mpp[1:0]          = mpp[1:0];
assign cp0_yy_priv_mode[1:0]         = pm[1:0];
assign cp0_yy_machine_mode_aft_dbg   = pm[0];
assign cp0_pmp_mstatus_mpp[1:0]      = mpp[1:0];
assign cp0_pmp_mstatus_mprv          = mprv;
assign cp0_had_mcause_data[31:0]     = 32'b0;
//when TEE not implemented, this signal is not needed
assign cp0_had_int_exit              = 1'b0;
//===========================================
//  to pad
//===========================================
assign cp0_pad_mstatus[31:0]         = mstatus_value[31:0];
assign cp0_pad_mcause[31:0]          = mcause_value[31:0];
assign cp0_pad_mintstatus[31:0]      = mintstatus_value[31:0];
// to oreg 
assign status_oreg_mxstatus_t       = mxstatus_t;
assign oreg_iui_priv_mode[1:0]       = pm[1:0];
assign mxstatus_t                   = 1'b0;
assign cpu_clic_int_exit             = iu_cp0_int_vld ? iu_yy_xx_int_hv
                                                      : mnxti_local_en && mnxti_vld_int_pending;
assign cpu_clic_curid[11:0]         = clic_cpu_int_id[11:0];

//==========================================================
//               Define the MXSTATUS register
//==========================================================
// &Force("output","mxstatus_mspe"); @398
assign mxstatus_mspe = 1'b0;
assign mxstatus_cskyisaee = 1'b0;
assign mxstatus_value[31:0]  = {pm[1:0],5'b0,mxstatus_mspe,1'b0,mxstatus_cskyisaee,22'b0};
assign cp0_iu_cskyisaee = mxstatus_cskyisaee;

//==========================================================
//               Define the MEXSTATUS register
//==========================================================
assign reset_mode_in[1:0] = (&iui_oreg_rs1[1:0]) ? mexstatus_reset_mode[1:0] : iui_oreg_rs1[1:0];
assign lpmd_in[1:0]       = iui_oreg_rs1[3] ? mexstatus_lpmd[1:0] : iui_oreg_rs1[3:2];
always @(posedge oreg_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    mexstatus_reset_mode[1:0] <= 2'b0;
    mexstatus_lpmd[1:0]       <= 2'b0;
    mexstatus_wfe_en          <= 1'b1;
  end
  else if(mexstatus_local_en)
  begin
    mexstatus_reset_mode[1:0] <= reset_mode_in[1:0];
    mexstatus_lpmd[1:0]       <= lpmd_in[1:0];
    mexstatus_wfe_en          <= iui_oreg_rs1[4];
  end
  else
  begin
    mexstatus_reset_mode[1:0] <= mexstatus_reset_mode[1:0];
    mexstatus_lpmd[1:0]       <= mexstatus_lpmd[1:0];
    mexstatus_wfe_en          <= mexstatus_wfe_en;
  end
end

always @(posedge oreg_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    mexstatus_expt_vld <= 1'b0;
  else if(iu_yy_xx_dbgon && mexstatus_local_en)
    mexstatus_expt_vld <= iui_oreg_rs1[5];
  else if(iu_cp0_lockup_clr)
    mexstatus_expt_vld <= 1'b0;
  else if(iu_cp0_expt_vld && !iu_cp0_int_vld && !iu_cp0_nmi_vld)
    mexstatus_expt_vld <= 1'b1;
  else if(iui_oreg_inst_mret && !mexstatus_nmi_vld)
    mexstatus_expt_vld <= 1'b0;
  else
    mexstatus_expt_vld <= mexstatus_expt_vld;
end

always @(posedge oreg_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    mexstatus_nmi_vld <= 1'b0;
  else if(iu_yy_xx_dbgon && mexstatus_local_en)
    mexstatus_nmi_vld <= iui_oreg_rs1[7];
  else if(iu_cp0_lockup_clr)
    mexstatus_nmi_vld <= 1'b0;
  else if(iu_cp0_nmi_vld)
    mexstatus_nmi_vld <= 1'b1;
  else if(iui_oreg_inst_mret)
    mexstatus_nmi_vld <= 1'b0;
  else
    mexstatus_nmi_vld <= mexstatus_nmi_vld;
end
assign status_in_nmi = mexstatus_nmi_vld;

always @(posedge oreg_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    mexstatus_lockup_vld <= 1'b0;
  else if(iu_cp0_lockup_clr)
    mexstatus_lockup_vld <= 1'b0;
  else if(iu_cp0_lockup_vld)
    mexstatus_lockup_vld <= 1'b1;
  else
    mexstatus_lockup_vld <= mexstatus_lockup_vld;
end

assign mexstatus_value[31:0]  = {24'b0, mexstatus_nmi_vld, mexstatus_lockup_vld, mexstatus_expt_vld, mexstatus_wfe_en,
                                 mexstatus_lpmd[1:0], mexstatus_reset_mode[1:0]};

assign status_lpmd_lpmd[1:0]  = mexstatus_lpmd[1:0];

assign status_srst_req_valid  = mexstatus_local_en && (|reset_mode_in[1:0]);
assign status_srst_req_valid_noinput = mexstatus_sel && (|iui_oreg_rs1_raw[1:0]);
// &Force("bus", "iui_oreg_rs1_raw", 31, 0); @497

assign status_srst_value[1:0] = mexstatus_reset_mode[1:0];
assign cp0_iu_wfe_en = mexstatus_wfe_en;

assign cp0_iu_in_expt = mexstatus_expt_vld && vector[3:0] != 4'd11 && vector[3:0] != 4'd3;
assign cp0_iu_in_nmi   = status_in_nmi;
assign status_xx_nmi   = status_in_nmi;
assign cp0_iu_mret     = iui_oreg_inst_mret;

// &ModuleEnd; @507
endmodule


