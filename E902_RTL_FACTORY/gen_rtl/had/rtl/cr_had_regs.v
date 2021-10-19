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
module cr_had_regs(
  cp0_had_cpuid_idx0,
  cp0_had_int_exit,
  cp0_had_lpmd_b,
  cp0_had_mcause_data,
  cpuclk,
  ctrl_regs_exit_dbg,
  ctrl_regs_update_adro,
  ctrl_regs_update_dro,
  ctrl_regs_update_mbo,
  ctrl_regs_update_swo,
  ctrl_regs_update_to,
  ddc_regs_ffy,
  ddc_regs_ir,
  ddc_regs_update_csr,
  ddc_regs_update_ir,
  had_core_dbg_mode_req,
  had_idu_wbbr_data,
  had_idu_wbbr_vld,
  had_ifu_ir,
  had_ifu_ir_vld,
  had_iu_force_dbg_en,
  had_iu_int_vld,
  had_iu_pc,
  had_iu_rte_pc_sel,
  had_iu_xx_fdb,
  had_tcipif_cmplt,
  had_tcipif_rdata,
  hadrst_b,
  iu_had_fast_retire_acc_err_pc_update,
  iu_had_fast_retire_acc_err_pc_val,
  iu_had_int_ack,
  iu_had_retire_with_had_int,
  iu_had_xx_data,
  iu_had_xx_data_vld,
  iu_had_xx_dbg_ack,
  iu_had_xx_retire_pc,
  iu_yy_xx_dbgon,
  jtag_regs_srst,
  jtag_regs_update_hacr,
  jtag_xx_capture_dr,
  jtag_xx_capture_dr_mask,
  jtag_xx_data,
  jtag_xx_update_dr,
  regs_bkpta_base,
  regs_bkpta_bkpti_en,
  regs_bkpta_ctrl,
  regs_bkpta_mask,
  regs_bkptb_base,
  regs_bkptb_ctrl,
  regs_bkptb_mask,
  regs_bkptc_base,
  regs_bkptc_en,
  regs_bkptd_base,
  regs_bkptd_en,
  regs_bkpte_base,
  regs_bkpte_en,
  regs_ctrl_adr,
  regs_ctrl_dr,
  regs_ctrl_exit_sel,
  regs_ctrl_hacr_ex,
  regs_ctrl_hacr_go,
  regs_ctrl_had_int_on,
  regs_ctrl_mbee,
  regs_ddc_daddr_sel,
  regs_ddc_ddata_sel,
  regs_jtag_data,
  regs_jtag_hacr_rw,
  regs_jtag_reg16_sel,
  regs_jtag_reg8_sel,
  regs_pin_pm,
  regs_trace_en,
  regs_xx_ddc_en,
  tcipif_had_addr,
  tcipif_had_sel,
  tcipif_had_wdata,
  tcipif_had_write
);

// &Ports; @23
input   [31:0]  cp0_had_cpuid_idx0;                  
input           cp0_had_int_exit;                    
input   [1 :0]  cp0_had_lpmd_b;                      
input   [31:0]  cp0_had_mcause_data;                 
input           cpuclk;                              
input           ctrl_regs_exit_dbg;                  
input           ctrl_regs_update_adro;               
input           ctrl_regs_update_dro;                
input           ctrl_regs_update_mbo;                
input           ctrl_regs_update_swo;                
input           ctrl_regs_update_to;                 
input           ddc_regs_ffy;                        
input   [31:0]  ddc_regs_ir;                         
input           ddc_regs_update_csr;                 
input           ddc_regs_update_ir;                  
input           hadrst_b;                            
input           iu_had_fast_retire_acc_err_pc_update; 
input   [30:0]  iu_had_fast_retire_acc_err_pc_val;   
input           iu_had_int_ack;                      
input           iu_had_retire_with_had_int;          
input   [31:0]  iu_had_xx_data;                      
input           iu_had_xx_data_vld;                  
input           iu_had_xx_dbg_ack;                   
input   [31:0]  iu_had_xx_retire_pc;                 
input           iu_yy_xx_dbgon;                      
input           jtag_regs_srst;                      
input           jtag_regs_update_hacr;               
input           jtag_xx_capture_dr;                  
input           jtag_xx_capture_dr_mask;             
input   [31:0]  jtag_xx_data;                        
input           jtag_xx_update_dr;                   
input   [15:0]  tcipif_had_addr;                     
input           tcipif_had_sel;                      
input   [31:0]  tcipif_had_wdata;                    
input           tcipif_had_write;                    
output          had_core_dbg_mode_req;               
output  [31:0]  had_idu_wbbr_data;                   
output          had_idu_wbbr_vld;                    
output  [31:0]  had_ifu_ir;                          
output          had_ifu_ir_vld;                      
output          had_iu_force_dbg_en;                 
output          had_iu_int_vld;                      
output  [30:0]  had_iu_pc;                           
output          had_iu_rte_pc_sel;                   
output          had_iu_xx_fdb;                       
output          had_tcipif_cmplt;                    
output  [31:0]  had_tcipif_rdata;                    
output  [31:0]  regs_bkpta_base;                     
output          regs_bkpta_bkpti_en;                 
output  [2 :0]  regs_bkpta_ctrl;                     
output  [7 :0]  regs_bkpta_mask;                     
output  [31:0]  regs_bkptb_base;                     
output  [2 :0]  regs_bkptb_ctrl;                     
output  [7 :0]  regs_bkptb_mask;                     
output  [31:0]  regs_bkptc_base;                     
output          regs_bkptc_en;                       
output  [31:0]  regs_bkptd_base;                     
output          regs_bkptd_en;                       
output  [31:0]  regs_bkpte_base;                     
output          regs_bkpte_en;                       
output          regs_ctrl_adr;                       
output          regs_ctrl_dr;                        
output          regs_ctrl_exit_sel;                  
output          regs_ctrl_hacr_ex;                   
output          regs_ctrl_hacr_go;                   
output          regs_ctrl_had_int_on;                
output  [8 :0]  regs_ctrl_mbee;                      
output          regs_ddc_daddr_sel;                  
output          regs_ddc_ddata_sel;                  
output  [31:0]  regs_jtag_data;                      
output          regs_jtag_hacr_rw;                   
output          regs_jtag_reg16_sel;                 
output          regs_jtag_reg8_sel;                  
output  [1 :0]  regs_pin_pm;                         
output          regs_trace_en;                       
output          regs_xx_ddc_en;                      

// &Regs; @24
reg             adro;                                
reg     [31:0]  baba_reg;                            
reg     [31:0]  babb_reg;                            
reg     [31:0]  babc_reg;                            
reg     [31:0]  babd_reg;                            
reg     [31:0]  babe_reg;                            
reg     [7 :0]  bama_reg;                            
reg     [7 :0]  bamb_reg;                            
reg     [1 :0]  bsel;                                
reg     [31:0]  ddera_reg;                           
reg             ddera_vld;                           
reg     [31:0]  dderb_reg;                           
reg             dderb_vld;                           
reg             dro;                                 
reg             fdb;                                 
reg             ffy;                                 
reg     [7 :0]  hacr_reg;                            
reg     [7 :0]  had_mcause_mil;                      
reg             had_mcause_mpie;                     
reg     [1 :0]  had_mcause_mpp;                      
reg             had_mcause_mpsp;                     
reg             hcr_adr;                             
reg     [2 :0]  hcr_bca;                             
reg     [2 :0]  hcr_bcb;                             
reg             hcr_bxen_bkptc;                      
reg             hcr_bxen_bkptd;                      
reg             hcr_bxen_bkpte;                      
reg             hcr_ddcen;                           
reg             hcr_dr;                              
reg             hcr_jtgr_int_en;                     
reg             hcr_jtgw_int_en;                     
reg             hcr_tme;                             
reg             jr_active;                           
reg             jr_pending;                          
reg             jw_active;                           
reg             jw_pending;                          
reg             mbo;                                 
reg     [30:0]  pc;                                  
reg             pm_dbg_mode;                         
reg     [31:0]  regs_rdata;                          
reg             rte_pc_sel;                          
reg             swo;                                 
reg             to;                                  
reg     [31:0]  wbbr_reg;                            

// &Wires; @25
wire            baba_wen;                            
wire            babb_wen;                            
wire            babc_wen;                            
wire            babd_wen;                            
wire            babe_wen;                            
wire    [31:0]  babf_reg;                            
wire    [31:0]  babg_reg;                            
wire    [31:0]  babh_reg;                            
wire    [31:0]  babi_reg;                            
wire            bama_wen;                            
wire            bamb_wen;                            
wire    [7 :0]  bamc_reg;                            
wire    [7 :0]  bamd_reg;                            
wire    [7 :0]  bame_reg;                            
wire    [7 :0]  bamf_reg;                            
wire    [7 :0]  bamg_reg;                            
wire    [7 :0]  bamh_reg;                            
wire    [7 :0]  bami_reg;                            
wire            bsel_0;                              
wire            bsel_0_jtg;                          
wire            bsel_0_tcipif;                       
wire            bsel_1;                              
wire            bsel_1_jtg;                          
wire            bsel_1_tcipif;                       
wire    [1 :0]  bsel_val;                            
wire            bsel_wen;                            
wire    [31:0]  cp0_had_cpuid_idx0;                  
wire            cp0_had_int_exit;                    
wire    [1 :0]  cp0_had_lpmd_b;                      
wire    [31:0]  cp0_had_mcause_data;                 
wire            cp0_had_secu_dbg_en;                 
wire            cpu_hsr2_wen;                        
wire            cpuclk;                              
wire    [15:0]  csr_reg;                             
wire            csr_wen;                             
wire            ctrl_regs_exit_dbg;                  
wire            ctrl_regs_update_adro;               
wire            ctrl_regs_update_dro;                
wire            ctrl_regs_update_mbo;                
wire            ctrl_regs_update_swo;                
wire            ctrl_regs_update_to;                 
wire    [31:0]  dacsr_rd_val;                        
wire    [31:0]  dacsr_reg;                           
wire    [31:0]  darwr_reg;                           
wire    [31:0]  datr_reg;                            
wire    [31:0]  dbg_ctrl_reg;                        
wire            dbgexp_regs_updt_vld;                
wire            dcc_regs_updt_vld;                   
wire            ddc_regs_ffy;                        
wire    [31:0]  ddc_regs_ir;                         
wire            ddc_regs_update_csr;                 
wire            ddc_regs_update_ir;                  
wire    [31:0]  dder_rd_val;                         
wire            ddera_ren;                           
wire            ddera_wen;                           
wire            dderb_ren;                           
wire            dderb_wen;                           
wire    [31:0]  force_reg;                           
wire            hacr_ex;                             
wire            hacr_go;                             
wire            hacr_indx_baba_sel;                  
wire            hacr_indx_baba_sel_rd;               
wire            hacr_indx_babb_sel;                  
wire            hacr_indx_babb_sel_rd;               
wire            hacr_indx_babc_sel;                  
wire            hacr_indx_babc_sel_rd;               
wire            hacr_indx_babd_sel;                  
wire            hacr_indx_babd_sel_rd;               
wire            hacr_indx_babe_sel;                  
wire            hacr_indx_babe_sel_rd;               
wire            hacr_indx_babf_sel;                  
wire            hacr_indx_babf_sel_rd;               
wire            hacr_indx_babg_sel;                  
wire            hacr_indx_babg_sel_rd;               
wire            hacr_indx_babh_sel;                  
wire            hacr_indx_babh_sel_rd;               
wire            hacr_indx_babi_sel;                  
wire            hacr_indx_babi_sel_rd;               
wire            hacr_indx_bama_sel;                  
wire            hacr_indx_bama_sel_rd;               
wire            hacr_indx_bamb_sel;                  
wire            hacr_indx_bamb_sel_rd;               
wire            hacr_indx_bamc_sel;                  
wire            hacr_indx_bamc_sel_rd;               
wire            hacr_indx_bamd_sel;                  
wire            hacr_indx_bamd_sel_rd;               
wire            hacr_indx_bame_sel;                  
wire            hacr_indx_bame_sel_rd;               
wire            hacr_indx_bamf_sel;                  
wire            hacr_indx_bamf_sel_rd;               
wire            hacr_indx_bamg_sel;                  
wire            hacr_indx_bamg_sel_rd;               
wire            hacr_indx_bamh_sel;                  
wire            hacr_indx_bamh_sel_rd;               
wire            hacr_indx_bami_sel;                  
wire            hacr_indx_bami_sel_rd;               
wire            hacr_indx_bsel_sel;                  
wire            hacr_indx_bsel_sel_rd;               
wire            hacr_indx_bypass_sel;                
wire            hacr_indx_csr_sel;                   
wire            hacr_indx_csr_sel_rd;                
wire            hacr_indx_dacsr_sel;                 
wire            hacr_indx_dacsr_sel_rd;              
wire            hacr_indx_daddr_sel;                 
wire            hacr_indx_daddr_sel_rd;              
wire            hacr_indx_darwr_sel;                 
wire            hacr_indx_darwr_sel_rd;              
wire            hacr_indx_datr_sel;                  
wire            hacr_indx_datr_sel_rd;               
wire            hacr_indx_dbg_ctrl_sel;              
wire            hacr_indx_dbg_ctrl_sel_rd;           
wire            hacr_indx_ddata_sel;                 
wire            hacr_indx_ddata_sel_rd;              
wire            hacr_indx_dder_sel;                  
wire            hacr_indx_dder_sel_rd;               
wire            hacr_indx_force_reg_sel;             
wire            hacr_indx_force_reg_sel_rd;          
wire            hacr_indx_hcr_sel;                   
wire            hacr_indx_hcr_sel_rd;                
wire            hacr_indx_hsr2_sel;                  
wire            hacr_indx_hsr2_sel_rd;               
wire            hacr_indx_hsr_sel;                   
wire            hacr_indx_hsr_sel_rd;                
wire            hacr_indx_id_sel;                    
wire            hacr_indx_id_sel_rd;                 
wire            hacr_indx_ir_sel;                    
wire            hacr_indx_mbca_sel;                  
wire            hacr_indx_mbca_sel_rd;               
wire            hacr_indx_mbcb_sel;                  
wire            hacr_indx_mbcb_sel_rd;               
wire            hacr_indx_mbee_sel;                  
wire            hacr_indx_mbee_sel_rd;               
wire            hacr_indx_mbir_sel;                  
wire            hacr_indx_mbir_sel_rd;               
wire            hacr_indx_mbse_sel;                  
wire            hacr_indx_mbse_sel_rd;               
wire            hacr_indx_pc_sel;                    
wire            hacr_indx_pc_sel_rd;                 
wire            hacr_indx_prof_cnt_sel;              
wire            hacr_indx_prof_cnt_sel_rd;           
wire            hacr_indx_psr_sel;                   
wire            hacr_indx_psr_sel_rd;                
wire    [4 :0]  hacr_indx_reuse;                     
wire            hacr_indx_sysrsv_sel;                
wire            hacr_indx_sysrsv_sel_rd;             
wire            hacr_indx_tc_sel;                    
wire            hacr_indx_tc_sel_rd;                 
wire            hacr_indx_wbbr_sel;                  
wire            hacr_indx_wbbr_sel_rd;               
wire            hacr_rw;                             
wire            had_core_dbg_mode_req;               
wire    [31:0]  had_idu_wbbr_data;                   
wire            had_idu_wbbr_vld;                    
wire    [31:0]  had_ifu_ir;                          
wire            had_ifu_ir_vld;                      
wire            had_iu_force_dbg_en;                 
wire            had_iu_int_vld;                      
wire    [30:0]  had_iu_pc;                           
wire            had_iu_rte_pc_sel;                   
wire            had_iu_xx_fdb;                       
wire            had_tcipif_cmplt;                    
wire    [31:0]  had_tcipif_rdata;                    
wire            hadrst_b;                            
wire            hcr_bca_wen;                         
wire            hcr_bcb_wen;                         
wire    [6 :0]  hcr_bxen;                            
wire    [2 :0]  hcr_bxen_bkpt4;                      
wire    [3 :0]  hcr_bxen_bkpt8;                      
wire            hcr_bxen_bkptc_wen;                  
wire            hcr_bxen_bkptd_wen;                  
wire            hcr_bxen_bkpte_wen;                  
wire            hcr_dcc_wen;                         
wire            hcr_ddae;                            
wire    [31:0]  hcr_reg;                             
wire            hcr_wen_jtg_only;                    
wire    [31:0]  hsr2_reg;                            
wire            hsr_dbg_dis;                         
wire    [15:0]  hsr_reg;                             
wire    [31:0]  id_reg;                              
wire            iu_had_fast_retire_acc_err_pc_update; 
wire    [30:0]  iu_had_fast_retire_acc_err_pc_val;   
wire            iu_had_int_ack;                      
wire            iu_had_retire_with_had_int;          
wire    [31:0]  iu_had_xx_data;                      
wire            iu_had_xx_data_vld;                  
wire            iu_had_xx_dbg_ack;                   
wire    [31:0]  iu_had_xx_retire_pc;                 
wire            iu_yy_xx_dbgon;                      
wire            jtag_psr_pc_wen;                     
wire            jtag_regs_srst;                      
wire            jtag_regs_update_hacr;               
wire            jtag_xx_capture_dr;                  
wire            jtag_xx_capture_dr_mask;             
wire    [31:0]  jtag_xx_data;                        
wire            jtag_xx_update_dr;                   
wire    [31:0]  mbee_reg;                            
wire    [3 :0]  mbir_reg;                            
wire    [31:0]  mbse_reg;                            
wire    [31:0]  pc_reg;                              
wire            pc_wen;                              
wire    [1 :0]  pm;                                  
wire            pm_lowpwr_mode;                      
wire            prof_cnt_en;                         
wire    [31:0]  prof_cnt_reg;                        
wire    [31:0]  psr_reg;                             
wire            psr_wen;                             
wire    [31:0]  regs_bkpta_base;                     
wire            regs_bkpta_bkpti_en;                 
wire    [2 :0]  regs_bkpta_ctrl;                     
wire    [7 :0]  regs_bkpta_mask;                     
wire    [31:0]  regs_bkptb_base;                     
wire    [2 :0]  regs_bkptb_ctrl;                     
wire    [7 :0]  regs_bkptb_mask;                     
wire    [31:0]  regs_bkptc_base;                     
wire            regs_bkptc_en;                       
wire    [31:0]  regs_bkptd_base;                     
wire            regs_bkptd_en;                       
wire    [31:0]  regs_bkpte_base;                     
wire            regs_bkpte_en;                       
wire            regs_ctrl_adr;                       
wire            regs_ctrl_dr;                        
wire            regs_ctrl_exit_sel;                  
wire            regs_ctrl_hacr_ex;                   
wire            regs_ctrl_hacr_go;                   
wire            regs_ctrl_had_int_on;                
wire    [8 :0]  regs_ctrl_mbee;                      
wire            regs_ddc_daddr_sel;                  
wire            regs_ddc_ddata_sel;                  
wire    [31:0]  regs_jtag_data;                      
wire            regs_jtag_hacr_rw;                   
wire            regs_jtag_reg16_sel;                 
wire            regs_jtag_reg8_sel;                  
wire    [1 :0]  regs_pin_pm;                         
wire            regs_trace_en;                       
wire            regs_xx_ddc_en;                      
wire    [31:0]  regs_xx_wdata;                       
wire            sec_bit_jtag;                        
wire            sec_jtag;                            
wire            secure_mode_match_jtag;              
wire            tcipif_dcc_read_vld;                 
wire            tcipif_dcc_updt_vld;                 
wire    [15:0]  tcipif_had_addr;                     
wire            tcipif_had_sel;                      
wire    [31:0]  tcipif_had_wdata;                    
wire            tcipif_had_write;                    
wire            tcipif_psr_pc_wen;                   
wire            tcipif_reg_sel;                      
wire            wbbr_wen;                            


// &Force("input","tcipif_had_write"); @28
//   &Force("input","tcipif_xx_dbus_sec"); @30

//==============================================================================
//  HACR
//==============================================================================
always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    hacr_reg[7:0] <= 8'h82; // point to HAD_ID, read op
  else if (jtag_regs_srst)
    hacr_reg[7:0] <= 8'h82;
  else if (jtag_regs_update_hacr)
    hacr_reg[7:0] <= jtag_xx_data[7:0];
  else
    hacr_reg[7:0] <= hacr_reg[7:0];
end

assign hacr_rw = hacr_reg[7];
assign hacr_go = hacr_reg[6];
assign hacr_ex = hacr_reg[5];

assign tcipif_reg_sel       = tcipif_had_sel
                         && !jtag_xx_update_dr
                         && !jtag_xx_capture_dr_mask;
assign hacr_indx_reuse[4:0] = tcipif_reg_sel ?  tcipif_had_addr[6:2] : hacr_reg[4:0];

//==============================================================================
//  HAD Bank Seleect Register
//==============================================================================
assign bsel_wen = jtag_xx_update_dr && hacr_indx_bsel_sel;
always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    bsel[1:0] <= 2'b0;
  else if (jtag_regs_srst)
    bsel[1:0] <= 2'b0;
  else if (bsel_wen)
    bsel[1:0] <= jtag_xx_data[1:0];
  else
    bsel[1:0] <= bsel[1:0];
end

//area optimization for bsel registers
  assign bsel_val[1:0] = {1'b0, bsel[0]};

// &Force("bus","tcipif_had_addr",15,0); @98
assign bsel_0_jtg    = bsel_val[1:0] == 2'b0;
assign bsel_0_tcipif = tcipif_had_addr[11:7] == 5'b0;
assign bsel_0        = tcipif_reg_sel ? bsel_0_tcipif : bsel_0_jtg;

    assign bsel_1_jtg    = bsel_val[1:0] == 2'b1;
    assign bsel_1_tcipif = tcipif_had_addr[11:7] == 5'b1;
    assign bsel_1        = tcipif_reg_sel ? bsel_1_tcipif : bsel_1_jtg;


assign hacr_indx_bsel_sel     = (hacr_indx_reuse[4:0] == 5'b11110); //for any bank

//decode for register bank 0
assign hacr_indx_id_sel       = (hacr_indx_reuse[4:0] == 5'b00010) && bsel_0;
assign hacr_indx_tc_sel       = 1'b0;
assign hacr_indx_bypass_sel   = (hacr_indx_reuse[4:0] == 5'b01100) && bsel_0;
assign hacr_indx_hsr_sel      = (hacr_indx_reuse[4:0] == 5'b01110) && bsel_0;
assign hacr_indx_wbbr_sel     = (hacr_indx_reuse[4:0] == 5'b10001) && bsel_0;
assign hacr_indx_ir_sel       = (hacr_indx_reuse[4:0] == 5'b10100) && bsel_0;
assign hacr_indx_csr_sel      = (hacr_indx_reuse[4:0] == 5'b10101) && bsel_0;
assign hacr_indx_daddr_sel    = (hacr_indx_reuse[4:0] == 5'b11000) && bsel_0;
assign hacr_indx_ddata_sel    = (hacr_indx_reuse[4:0] == 5'b11001) && bsel_0;
assign hacr_indx_sysrsv_sel   = (hacr_indx_reuse[4:0] == 5'b11111) && bsel_0;

assign hacr_indx_psr_sel      = (hacr_indx_reuse[4:0] == 5'b10010) && bsel_0;
assign hacr_indx_pc_sel       = (hacr_indx_reuse[4:0] == 5'b10011) && bsel_0;
assign hacr_indx_hcr_sel      = (hacr_indx_reuse[4:0] == 5'b01101) && bsel_0;
assign hacr_indx_hsr2_sel     = (hacr_indx_reuse[4:0] == 5'b01111) && bsel_0;
assign hacr_indx_dder_sel     = (hacr_indx_reuse[4:0] == 5'b10110) && bsel_0;

assign hacr_indx_mbca_sel     = 1'b0;
assign hacr_indx_mbcb_sel     = 1'b0;
assign hacr_indx_baba_sel     = (hacr_indx_reuse[4:0] == 5'b00111) && bsel_0;
assign hacr_indx_bama_sel     = (hacr_indx_reuse[4:0] == 5'b01001) && bsel_0;

assign hacr_indx_babb_sel     = (hacr_indx_reuse[4:0] == 5'b01000) && bsel_0;
assign hacr_indx_bamb_sel     = (hacr_indx_reuse[4:0] == 5'b01010) && bsel_0;

// decode for register bank 1
assign hacr_indx_babc_sel     = (hacr_indx_reuse[4:0] == 5'b00000) && bsel_1;
assign hacr_indx_babd_sel     = (hacr_indx_reuse[4:0] == 5'b00010) && bsel_1;
assign hacr_indx_babe_sel     = (hacr_indx_reuse[4:0] == 5'b00100) && bsel_1;
assign hacr_indx_bamc_sel     = 1'b0;
assign hacr_indx_bamd_sel     = 1'b0;
assign hacr_indx_bame_sel     = 1'b0;

assign hacr_indx_babf_sel     = 1'b0;
assign hacr_indx_babg_sel     = 1'b0;
assign hacr_indx_babh_sel     = 1'b0;
assign hacr_indx_babi_sel     = 1'b0;
assign hacr_indx_bamf_sel     = 1'b0;
assign hacr_indx_bamg_sel     = 1'b0;
assign hacr_indx_bamh_sel     = 1'b0;
assign hacr_indx_bami_sel     = 1'b0;

assign hacr_indx_dacsr_sel    = 1'b0;
assign hacr_indx_datr_sel     = 1'b0;
assign hacr_indx_darwr_sel    = 1'b0;

assign hacr_indx_mbir_sel     = 1'b0;
assign hacr_indx_mbee_sel     = 1'b0;
assign hacr_indx_mbse_sel     = 1'b0;

//decode for register bank 2
assign hacr_indx_dbg_ctrl_sel  = 1'b0;
assign hacr_indx_prof_cnt_sel  = 1'b0;
assign hacr_indx_force_reg_sel = 1'b0;

  assign tcipif_dcc_updt_vld         = tcipif_reg_sel && tcipif_had_write;
  assign tcipif_dcc_read_vld         = tcipif_reg_sel && !tcipif_had_write;

assign dcc_regs_updt_vld             = jtag_xx_update_dr || tcipif_dcc_updt_vld;


assign dbgexp_regs_updt_vld          = jtag_xx_update_dr;

assign regs_xx_wdata[31:0]       = tcipif_reg_sel ? tcipif_had_wdata[31:0]
                                                  : jtag_xx_data[31:0];
//==============================================================================
//  HAD DR Bank 0
//==============================================================================
//==========================================================
// HAD_ID register
//==========================================================
// +-------+-----+---------+-------+------+-----+-----+
// | 31:28 |27:26|  25:18  | 17 | 16 | 15:12 | 11:8 | 7:4 | 3:0 |
// +-------+-----+---------+----+----+-------+------+-----+-----+
//     |      |              |    |      |       |    |     |
//     |      |              |    |      |       |    |     +--- ID_VERSION
//     |      |              |    |      |       |    +--------- HAD_VERSION
//     |      |              |    |      |       +-------------- HAD_REVISION
//     |      |              |    |      +---------------------- BKPT_NUM
//     |      |              |    +----------------------------- DDC
//     |      |              +---------------------------------- BANK1
//     |      +--------------------------------------- CPU Inst. Arch                               
//     +---------------------------------------------- JTAG InterfaceType

// &Force("bus", "cp0_had_cpuid_idx0", 31, 0); @319

assign id_reg[31:28] = 4'b0001; // JTAG_2 interface

assign id_reg[27:26] = cp0_had_cpuid_idx0[27:26];

assign id_reg[25:18] = 8'b0;

assign id_reg[17]    = 1'b0;

assign id_reg[16]    = 1'b0;

assign id_reg[15:12] = 4'd5;

//------------------------------------------------
// initial version: 2.0
// huanghuanhuan
//------------------------------------------------
// version 2.1
// huanghuanhuan, 2014/03/10
// add 4 registers for mem-bkpt-c and mem-bkpt-d
// add 2 ctrl bits in hcr to enable bkpt-c and bkpt-d
//------------------------------------------------
// version 2.2
// huanghuanhuan, 2014/03/14
// 1. add SRST status bit in HSR
//    SRST indicates CPU is reset by software
// 2. seperate hadrst_b and cpurst_b
//    cpurst_b cannot reset had registers
//------------------------------------------------
// version 2.3
// huanghuanhuan, 2014/04/04
// 1. add 4 more bkpt, there are 9 bkpt now
// 2. add BSEL register for register bank select
// 3. add BKPT_NUM field in ID register
//------------------------------------------------
// version 2.4
// huanghuanhuan, 2014/06/30
// 1. add one more register, HSR2;
// 2. define a status bit in HSR2 to indicate CPU
//    is in debug forbidden region
//------------------------------------------------
// version 2.5
// huanghuanhuan, 2014/07/08
// 1. add HAD_BKPT_9 macro
// ------------------------------------------------
// version 2.6
// chenchen, 2015/05/13
// 1. add HAD tcip img
// 2. add profiling cnt
// ------------------------------------------------
// version 2.7
// chenchen, 2016/01/05
// 1. add DCC function
// 2. add TEE support
// ------------------------------------------------
// version 2.8
// chenchen, 2016/10/09
// 1. fix trace on ldst
// ------------------------------------------------
// version 2.9
// chenchen, 2016/12/27
// 1. add dbg expt
// 2. add DDMA
// ------------------------------------------------
// version 2.10
// reserve for the difference between
// trunk code and branch code
// ------------------------------------------------
// version 2.11
// wangs, 2017/09/05
// 1. had area optimization
// 2. tcip and jtag reuse read/write port
// 3. add the mechanism between DBG_EXP and TEE
assign id_reg[11:8]  = 4'd11;
assign id_reg[7:4]   = 4'b0011; // HAD_V4, for RV

//------------------------------------------------
// V1
assign id_reg[3:0]   = 4'b0001;
//------------------------------------------------
// V2
// add BKPT_NUM, DDC, BANK1 field
//assign id_reg[3:0] = 4'd2;

//==========================================================
// BABA -- Base Address of Breakpoint A
//==========================================================
assign baba_wen = dbgexp_regs_updt_vld && hacr_indx_baba_sel;

always @(posedge cpuclk)
begin
  if (baba_wen)
    baba_reg[31:0] <= regs_xx_wdata[31:0];
  else
    baba_reg[31:0] <= baba_reg[31:0];
end

//==========================================================
// BAMA -- Base Address Mask of Breakpoint A
//==========================================================
// reset BAMA to zero for low power design
assign bama_wen = dbgexp_regs_updt_vld && hacr_indx_bama_sel;

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    bama_reg[7:0] <= 8'b0;
  else if (bama_wen)
    bama_reg[7:0] <= regs_xx_wdata[7:0];
  else
    bama_reg[7:0] <= bama_reg[7:0];
end

//==========================================================
// BABB -- Base Address of Breakpoint B
//==========================================================
assign babb_wen = dbgexp_regs_updt_vld && hacr_indx_babb_sel;

always @(posedge cpuclk)
begin
  if (babb_wen)
    babb_reg[31:0] <= regs_xx_wdata[31:0];
  else
    babb_reg[31:0] <= babb_reg[31:0];
end

//==========================================================
// BAMB -- Base Address Mask of Breakpoint B
//==========================================================
// reset BAMB to zero for low power design
assign bamb_wen = dbgexp_regs_updt_vld && hacr_indx_bamb_sel;

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    bamb_reg[7:0] <= 8'b0;
  else if (bamb_wen)
    bamb_reg[7:0] <= regs_xx_wdata[7:0];
  else
    bamb_reg[7:0] <= bamb_reg[7:0];
end

//==========================================================
// WBBR -- Write Back Bus Register
//==========================================================
assign wbbr_wen = jtag_xx_update_dr && (hacr_indx_wbbr_sel
                                     || hacr_indx_daddr_sel
                                     || hacr_indx_ddata_sel);
always @(posedge cpuclk)
begin
  if (wbbr_wen)
    wbbr_reg[31:0] <= jtag_xx_data[31:0];
//  else if (ddc_regs_update_wbbr)
//    wbbr_reg[31:0] <= ddc_regs_wbbr[31:0];
  else if (iu_had_xx_data_vld)
    wbbr_reg[31:0] <= iu_had_xx_data[31:0];
  else
    wbbr_reg[31:0] <= wbbr_reg[31:0];
end

// &Force("bus", "cp0_had_psr_data", 31, 0); @542
//==========================================================                                        
// PSR -- Processor Status Register
// as the psr nolong exist when processor enter debug mode
// it only exist when had int happen
//==========================================================
assign jtag_psr_pc_wen   = jtag_xx_update_dr && iu_yy_xx_dbgon;
assign tcipif_psr_pc_wen = tcipif_dcc_updt_vld && !iu_had_retire_with_had_int;
assign psr_wen = ((jtag_psr_pc_wen && cp0_had_secu_dbg_en) || tcipif_psr_pc_wen)
               && hacr_indx_psr_sel;


//always @(posedge cpuclk)
//begin
//  if (iu_had_xx_dbg_ack) begin
//    psr_s        <= cp0_had_psr_data[31];
//    psr_vec[7:0] <= cp0_had_psr_data[23:16];
//    psr_mm       <= cp0_had_psr_data[9];
//    psr_ee       <= cp0_had_psr_data[8];
//    psr_ic       <= cp0_had_psr_data[7];
//    psr_ie       <= cp0_had_psr_data[6];
//    psr_c        <= cp0_had_psr_data[0];
//  end
//  else if (iu_had_int_ack) begin
//    psr_s        <= cp0_had_spsr_data[31];
//    psr_vec[7:0] <= cp0_had_spsr_data[23:16];
//    psr_mm       <= cp0_had_spsr_data[9];
//    psr_ee       <= cp0_had_spsr_data[8];
//    psr_ic       <= cp0_had_spsr_data[7];
//    psr_ie       <= cp0_had_spsr_data[6];
//    psr_c        <= cp0_had_spsr_data[0];
//  end
//  else if (psr_wen) begin
//    psr_s        <= regs_xx_wdata[31];
//    psr_vec[7:0] <= regs_xx_wdata[23:16];
//    psr_mm       <= regs_xx_wdata[9];
//    psr_ee       <= regs_xx_wdata[8];
//    psr_ic       <= regs_xx_wdata[7];
//    psr_ie       <= regs_xx_wdata[6];
//    psr_c        <= regs_xx_wdata[0];
//  end
//end
//
//assign psr_se = 1'b0;
//assign psr_sp = 1'b0;
//assign psr_hs = 1'b0;
//assign psr_sc = 1'b0;
//
//assign psr_prgsign_ins_cnt_en = 1'b0;
//assign psr_prgsign_strong     = 1'b0;
//assign psr_prgisgn_en         = 1'b0;
//
//assign psr_bm = 1'b0;
//
//assign psr_af = 1'b0;
//
//assign psr_reg[31:0] = {psr_s , psr_se, psr_sp, psr_hs,
//                        psr_sc, psr_prgsign_ins_cnt_en,
//                        psr_prgsign_strong, psr_prgisgn_en,
//                        psr_vec[7:0], 6'b0,
//                        psr_mm, psr_ee, psr_ic, psr_ie, 
//                        3'b0, psr_bm, psr_af, psr_c};
//
// &Force("bus", "cp0_had_mcause_data", 31, 0); @676
always @(posedge cpuclk)
begin
  if (iu_had_int_ack) begin
    had_mcause_mpp[1:0]     <= cp0_had_mcause_data[29:28];
    had_mcause_mil[7:0]     <= cp0_had_mcause_data[23:16];
    had_mcause_mpie         <= cp0_had_mcause_data[27];
    had_mcause_mpsp         <= cp0_had_mcause_data[26];
  end
  else if (psr_wen) begin
    had_mcause_mpp[1:0]     <= regs_xx_wdata[29:28];
    had_mcause_mil[7:0]     <= regs_xx_wdata[23:16];
    had_mcause_mpie         <= regs_xx_wdata[27];
    had_mcause_mpsp         <= regs_xx_wdata[26];
  end
end
assign psr_reg[31:0]      = {1'b0,1'b0,had_mcause_mpp[1:0],had_mcause_mpie,had_mcause_mpsp,2'b0,had_mcause_mil[7:0],16'b0};
//==========================================================
// PC
//==========================================================
// &Force("bus", "iu_had_xx_retire_pc", 31, 0); @696
assign pc_wen = (jtag_psr_pc_wen || tcipif_psr_pc_wen)
              && hacr_indx_pc_sel;
always @(posedge cpuclk)
begin
  if (iu_had_fast_retire_acc_err_pc_update || iu_had_int_ack)
    pc[30:0] <= iu_had_fast_retire_acc_err_pc_val[30:0];
  else if (iu_had_xx_dbg_ack)
    pc[30:0] <= iu_had_xx_retire_pc[31:1];
  else if (pc_wen)
    pc[30:0] <= regs_xx_wdata[31:1];
  else
    pc[30:0] <= pc[30:0];
end

assign pc_reg[31:0] = {pc[30:0], 1'b0};

//==========================================================
// IR
//==========================================================

//==========================================================
// CSR
//==========================================================
assign csr_wen = jtag_xx_update_dr && hacr_indx_csr_sel;
always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b) begin
    ffy         <= 1'b0;
    fdb         <= 1'b0;
  end
  else if (csr_wen) begin
    ffy         <= jtag_xx_data[8];
    fdb         <= jtag_xx_data[7];
  end
  else if (ddc_regs_update_csr) begin
    ffy         <= ddc_regs_ffy;
    fdb         <= 1'b0;
  end
  else begin
    ffy         <= ffy;
    fdb         <= fdb;
  end
end

assign csr_reg[15:0] = {7'b0, ffy, fdb, 7'b0};

//==========================================================
// HCR -- Had Control Reigster
//==========================================================
// +-------+------+---+---+------+---+---+---+---+---+-----+--+----+
// | 31:29 |28:22 |21 |20 |19:16 |15 |14 |13 |12 |11 |10:6 |5 |4:0 |
// +-------+------+---+---+------+---+---+---+---+---+-----+--+----+
//            |     |   |          |       |       |    |   |   |
//            |     |   |          |       |       |    |   |   +---- BCA
//            |     |   |          |       |       |    |   +-------- RCA
//            |     |   |          |       |       |    +------------ BCB
//            |     |   |          |       |       +----------------- RCB
//            |     |   |          |       +------------------------- TME
//            |     |   |          +--------------------------------- DR
//            |     |   +-------------------------------------------- DDCEN
//            |     +------------------------------------------------ ADR
//            +------------------------------------------------------ BxEN
// BCA: BKPTA Mode Ctrl
// RCA: BKPTA Region Ctrl
// BCB: BKPTB Mode Ctrl
// RCB: BKPTB Region Ctrl
// TME: Trace Mode Enable
// DR : Debug Request
// DDCEN : DDC Mode Enable
// ADR : Async Debug Request
// BxEN : BKPTC - BKPTH Enable, BxEN[0] = BCEN, ... BxEN[5] = BHEN

//jtag write only
assign hcr_wen_jtg_only = jtag_xx_update_dr && hacr_indx_hcr_sel;
always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b) begin
    hcr_adr      <= 1'b0; // Debug Request when CPU Dead
    hcr_ddcen    <= 1'b0; // DDC mode Enable
    hcr_dr       <= 1'b0; // Debug Request
    hcr_tme      <= 1'b0; // Trace Mode Enable
  end
  else if (hcr_wen_jtg_only) begin
    hcr_adr      <= jtag_xx_data[21];
    hcr_ddcen    <= jtag_xx_data[20];
    hcr_dr       <= jtag_xx_data[15];
    hcr_tme      <= jtag_xx_data[13];
  end
  else begin
    hcr_adr      <= hcr_adr;
    hcr_ddcen    <= hcr_ddcen;
    hcr_dr       <= hcr_dr;
    hcr_tme      <= hcr_tme;
  end
end

assign hcr_bca_wen = dbgexp_regs_updt_vld && hacr_indx_hcr_sel;

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b) begin
    hcr_bca[2:0] <= 3'b0; // memory Breakpoint Cotrol A
  end
  else if (hcr_bca_wen) begin
    hcr_bca[2:0] <= regs_xx_wdata[2:0];
  end
  else begin
    hcr_bca[2:0] <= hcr_bca[2:0];
  end
end

  assign hcr_bcb_wen = dbgexp_regs_updt_vld && hacr_indx_hcr_sel;

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b) begin
    hcr_bcb[2:0]  <= 3'b0;
  end
  else if (hcr_bcb_wen) begin
    hcr_bcb[2:0]  <= regs_xx_wdata[8:6];
  end
  else begin
    hcr_bcb[2:0]  <= hcr_bcb[2:0];
  end
end

//hcr_bxen_bkpt for mbkpt c/d/e
assign hcr_bxen_bkptc_wen = dbgexp_regs_updt_vld && hacr_indx_hcr_sel;

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    hcr_bxen_bkptc <= 1'b0;
  else if (hcr_bxen_bkptc_wen)
    hcr_bxen_bkptc <= regs_xx_wdata[22];
  else
    hcr_bxen_bkptc <= hcr_bxen_bkptc;
end

assign hcr_bxen_bkptd_wen = dbgexp_regs_updt_vld && hacr_indx_hcr_sel;

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    hcr_bxen_bkptd <= 1'b0;
  else if (hcr_bxen_bkptd_wen)
    hcr_bxen_bkptd <= regs_xx_wdata[23];
  else
    hcr_bxen_bkptd <= hcr_bxen_bkptd;
end

assign hcr_bxen_bkpte_wen = dbgexp_regs_updt_vld && hacr_indx_hcr_sel;

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    hcr_bxen_bkpte <= 1'b0;
  else if (hcr_bxen_bkpte_wen)
    hcr_bxen_bkpte <= regs_xx_wdata[24];
  else
    hcr_bxen_bkpte <= hcr_bxen_bkpte;
end

assign hcr_bxen_bkpt4[2:0] = {hcr_bxen_bkpte, hcr_bxen_bkptd, hcr_bxen_bkptc};

assign hcr_bxen_bkpt8[3:0] = 4'b0;

assign hcr_bxen[6:0] = {hcr_bxen_bkpt8[3:0], hcr_bxen_bkpt4[2:0]};

assign hcr_ddae = 1'b0;

assign hcr_dcc_wen = dcc_regs_updt_vld && hacr_indx_hcr_sel;
always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b) begin
    hcr_jtgw_int_en <= 1'b0;
    hcr_jtgr_int_en <= 1'b0;
  end
  else if (hcr_dcc_wen) begin
    hcr_jtgw_int_en <= regs_xx_wdata[18];
    hcr_jtgr_int_en <= regs_xx_wdata[19];
  end
  else begin
    hcr_jtgw_int_en <= hcr_jtgw_int_en;
    hcr_jtgr_int_en <= hcr_jtgr_int_en;
  end
end  

assign hcr_reg[31:0] = {2'b0, hcr_ddae, hcr_bxen[6:0], hcr_adr, hcr_ddcen,
                        hcr_jtgr_int_en, hcr_jtgw_int_en, 2'b0, hcr_dr, 1'b0,
                        hcr_tme, 4'b0, hcr_bcb[2:0], 3'b0, hcr_bca[2:0]};

assign regs_bkpta_bkpti_en = (hcr_bxen[6:0] != 7'b0)
                          || (hcr_bcb[2:0]  != 3'b0)
                          || (hcr_bca[2:0]  != 3'b0);

//==========================================================
// HSR -- Had Status Reigster
//==========================================================
// +-------+----+----+---+---+---+---+---+-----+-----+
// | 15:12 | 11 | 10 | 9 | 8 | 7 | 6 | 5 | 4:2 | 1:0 |
// +-------+----+----+---+---+---+---+---+-----+-----+
//           |         |   |   |   |   |          |
//           |         |   |   |   |   |          +---- PM
//           |         |   |   |   |   +--------------- TO
//           |         |   |   |   +------------------- SWO
//           |         |   |   +----------------------- MBO
//           |         |   +--------------------------- DRO
//           |         +------------------------------- HDRO
//           +----------------------------------------- SRST
// PM   - Processor Mode
// TO   - Trace Debug Occurrence
// SWO  - Software Debug Occurrence
// MBO  - Memory Breakpoint Occurrence                                                              
// DRO  - Compulsive Debug Request Occurrence
// HDRO - Hardware Debug Request Occurrence
// SRST - CPU has been reset by SRST inst

//// SRST - CPU has been reset by SRST inst
//always @(posedge cpuclk or negedge hadrst_b)
//begin
//  if (!hadrst_b)
//    srst <= 1'b0;
//  else if (iu_had_soft_rst)
//    srst <= 1'b1;
//  else if (ctrl_regs_exit_dbg)
//    srst <= 1'b0;
//  else
//    srst <= srst;
//end

// HDRO - Hardware Debug Request Occurrence
always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    adro <= 1'b0;
  else if (ctrl_regs_update_adro)
    adro <= 1'b1;
  else if (ctrl_regs_exit_dbg)
    adro <= 1'b0;
  else
    adro <= adro;
end

// DRO - Compulsive Debug Request Occurrence
always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    dro <= 1'b0;
  else if (ctrl_regs_update_dro)
    dro <= 1'b1;
  else if (ctrl_regs_exit_dbg)
    dro <= 1'b0;
  else
    dro <= dro;
end

// MBO - Memory Breakpoint Occurrence
always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    mbo <= 1'b0;
  else if (ctrl_regs_update_mbo)
    mbo <= 1'b1;
  else if (ctrl_regs_exit_dbg)
    mbo <= 1'b0;
  else
    mbo <= mbo;
end

// SWO - Software Debug Occurrence
always @(posedge cpuclk or negedge hadrst_b)
begin                                                                                               
  if (!hadrst_b)
    swo <= 1'b0;
  else if (ctrl_regs_update_swo)
    swo <= 1'b1;
  else if (ctrl_regs_exit_dbg)
    swo <= 1'b0;
  else
    swo <= swo;
end

// TO - Trace Debug Occurrence
always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    to <= 1'b0;
  else if (ctrl_regs_update_to)
    to <= 1'b1;
  else if (ctrl_regs_exit_dbg)
    to <= 1'b0;
  else
    to <= to;
end

// PM - Processor Mode
// PM[0] : Low-power Mode
assign pm_lowpwr_mode = !cp0_had_lpmd_b[1] || !cp0_had_lpmd_b[0];

// PM[1] : Debug Mode
always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
  begin
    pm_dbg_mode <= 1'b0;
  end
  else
  begin
    if (ctrl_regs_exit_dbg)
      pm_dbg_mode <= 1'b0;
    else if (iu_yy_xx_dbgon)
      pm_dbg_mode <= 1'b1;
    else
      pm_dbg_mode <= pm_dbg_mode;
  end
end

assign pm[1:0] = {pm_dbg_mode, pm_lowpwr_mode};

//always @(posedge cpuclk or negedge hadrst_b)
//begin
//  if (!hadrst_b)
//    pm[1:0] <= 2'b0;
//  else if (iu_yy_xx_dbgon) // Debug Mode 2'b10
//    pm[1:0] <= 2'b10;
//  else if (!cp0_had_lpmd_b[1] || !cp0_had_lpmd_b[0]) // Low-power mode 2'b01
//    pm[1:0] <= 2'b01;
//  else  // Normal mode
//    pm[1:0] <= 2'b00;                                                                             
//end

assign had_core_dbg_mode_req = pm_dbg_mode && !iu_yy_xx_dbgon;
assign hsr_reg[15:0] = {6'b0, adro, dro,
                        mbo, swo, to, 3'b0, pm[1:0]};

//==========================================================
// EHSR
//==========================================================
assign hsr_dbg_dis = 1'b0;

//dder valid
always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    ddera_vld <= 1'b0;
  else if(ddera_wen)
    ddera_vld <= 1'b1;
  else if(ddera_ren)
    ddera_vld <= 1'b0;
  else
    ddera_vld <= ddera_vld;
end

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    dderb_vld <= 1'b0;
  else if(dderb_wen)
    dderb_vld <= 1'b1;
  else if(dderb_ren)
    dderb_vld <= 1'b0;
  else
    dderb_vld <= dderb_vld;
end

//jw jr int state
assign cpu_hsr2_wen = tcipif_dcc_updt_vld && hacr_indx_hsr2_sel;
always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    jw_pending <= 1'b0;
  else if (ddera_wen && hcr_jtgw_int_en)
    jw_pending <= 1'b1;
  else if (iu_had_int_ack && jw_pending)
    jw_pending <= 1'b0;
  else
    jw_pending <= jw_pending;
end

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    jw_active <= 1'b0;
  else if (cpu_hsr2_wen)
    jw_active <= tcipif_had_wdata[3];
  else if (iu_had_int_ack && jw_pending)
    jw_active <= 1'b1;
  else if (cp0_had_int_exit && jw_active && rte_pc_sel)
    jw_active <= 1'b0;
  else 
    jw_active <= jw_active;
end

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    jr_pending <= 1'b0;
  else if (dderb_ren && hcr_jtgr_int_en)
    jr_pending <= 1'b1;
  else if (iu_had_int_ack && jr_pending && !jw_pending)
    jr_pending <= 1'b0;
  else
    jr_pending <= jr_pending;
end

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    jr_active <= 1'b0;
  else if (cpu_hsr2_wen)
    jr_active <= tcipif_had_wdata[4];
  else if (iu_had_int_ack && jr_pending && !jw_pending)
    jr_active <= 1'b1;
  else if (cp0_had_int_exit && jr_active && rte_pc_sel)
    jr_active <= 1'b0;
  else
    jr_active <= jr_active;
end

assign had_iu_int_vld = (jw_pending || jr_pending) 
                     && (!jw_active && !jr_active);

always @(posedge cpuclk or negedge hadrst_b)
begin
  if (!hadrst_b)
    rte_pc_sel <= 1'b0;
  else if (cpu_hsr2_wen)
    rte_pc_sel <= tcipif_had_wdata[5];
  else if (iu_had_int_ack)
    rte_pc_sel <= 1'b1;
  else if (cp0_had_int_exit && rte_pc_sel)
    rte_pc_sel <= 1'b0;
  else 
    rte_pc_sel <= rte_pc_sel;
end    

assign regs_ctrl_had_int_on = rte_pc_sel;
assign had_iu_rte_pc_sel = rte_pc_sel;
// &Force("input","cp0_had_int_exit"); @1382

assign hsr2_reg[31:0] = {26'b0, rte_pc_sel,
                         jr_active, jw_active, 
                         dderb_vld, ddera_vld, hsr_dbg_dis};

//==========================================================
// DDER
//==========================================================
assign ddera_wen = jtag_xx_update_dr   && hacr_indx_dder_sel;
assign ddera_ren = tcipif_dcc_read_vld && hacr_indx_dder_sel;

always @(posedge cpuclk)
begin
  if (ddera_wen)
    ddera_reg[31:0] <= jtag_xx_data[31:0];
  else
    ddera_reg[31:0] <= ddera_reg[31:0];
end

assign dderb_wen = tcipif_dcc_updt_vld && hacr_indx_dder_sel;
assign dderb_ren = jtag_xx_capture_dr  && hacr_indx_dder_sel;

always @(posedge cpuclk)
begin
  if (dderb_wen)
    dderb_reg[31:0] <= tcipif_had_wdata[31:0];
  else
    dderb_reg[31:0] <= dderb_reg[31:0];
end

// &CombBeg; @1530
// &CombEnd; @1536
// &CombBeg; @1543
// &CombEnd; @1549
// &CombBeg; @1572
// &CombEnd; @1597
// &CombBeg; @1599
// &CombEnd; @1624
assign dacsr_reg[31:0] = 32'b0;
assign darwr_reg[31:0] = 32'b0;
assign datr_reg[31:0]  = 32'b0;

assign sec_jtag = 1'b0;
assign cp0_had_secu_dbg_en = 1'b1;

assign secure_mode_match_jtag = cp0_had_secu_dbg_en || ~(cp0_had_secu_dbg_en || sec_jtag);
assign sec_bit_jtag = cp0_had_secu_dbg_en? dacsr_reg[10] : 1'b0; 

//==============================================================================
//  HAD DR Bank 1
//==============================================================================
//======================================
//BKPTC
//======================================
assign babc_wen = dbgexp_regs_updt_vld && hacr_indx_babc_sel;

always @(posedge cpuclk)
begin
  if (babc_wen)
    babc_reg[31:0] <= regs_xx_wdata[31:0];
  else
    babc_reg[31:0] <= babc_reg[31:0];
end

//assign bamc_wen = regs_updt_vld && bsel_1 && hacr_indx_bamc_sel;
//
//always @(posedge cpuclk)
//begin
//  if (bamc_wen)
//    bamc_reg[7:0] <= regs_xx_wdata[7:0];
//  else
//    bamc_reg[7:0] <= bamc_reg[7:0];
//end

//======================================
//BKPTD
//======================================
assign babd_wen = dbgexp_regs_updt_vld && hacr_indx_babd_sel;

always @(posedge cpuclk)
begin
  if (babd_wen)
    babd_reg[31:0] <= regs_xx_wdata[31:0];
  else
    babd_reg[31:0] <= babd_reg[31:0];
end

//assign bamd_wen = regs_updt_vld && bsel_1 && hacr_indx_bamd_sel;
//
//always @(posedge cpuclk)
//begin
//  if (bamd_wen)
//    bamd_reg[7:0] <= regs_xx_wdata[7:0];
//  else
//    bamd_reg[7:0] <= bamd_reg[7:0];
//end

//======================================
//BKPTE
//======================================
assign babe_wen = dbgexp_regs_updt_vld && hacr_indx_babe_sel;

always @(posedge cpuclk)
begin
  if (babe_wen)
    babe_reg[31:0] <= regs_xx_wdata[31:0];
  else
    babe_reg[31:0] <= babe_reg[31:0];
end

//assign bame_wen = regs_updt_vld && bsel_1 && hacr_indx_bame_sel;
//
//always @(posedge cpuclk)
//begin
//  if (bame_wen)
//    bame_reg[7:0] <= regs_xx_wdata[7:0];
//  else
//    bame_reg[7:0] <= bame_reg[7:0];
//end

assign babf_reg[31:0] = 32'b0;
assign babg_reg[31:0] = 32'b0;
assign babh_reg[31:0] = 32'b0;
assign babi_reg[31:0] = 32'b0;

assign bamc_reg[7:0] = 8'b0;
assign bamd_reg[7:0] = 8'b0;
assign bame_reg[7:0] = 8'b0;
assign bamf_reg[7:0] = 8'b0;
assign bamg_reg[7:0] = 8'b0;
assign bamh_reg[7:0] = 8'b0;
assign bami_reg[7:0] = 8'b0;

assign mbir_reg[3:0]  = 4'b0;
assign mbee_reg[31:0] = 32'b0;
assign mbse_reg[31:0] = 32'b0;

//==============================================================================
//  HAD DR Bank 2
//==============================================================================
//==========================================================
//  DEBUG CONTROL register
//==========================================================
assign prof_cnt_en        = 1'b0;
assign prof_cnt_reg[31:0] = 32'b0;

assign dbg_ctrl_reg[31:0] = {31'b0, prof_cnt_en};

//==========================================================
//  Force register
//==========================================================
assign had_iu_force_dbg_en = 1'b0;
assign force_reg[31:0] = 32'b0;

//==============================================================================
// Read port for HAD registers
//==============================================================================
assign hacr_indx_bsel_sel_rd      = hacr_indx_bsel_sel   && !tcipif_reg_sel;
assign hacr_indx_id_sel_rd        = hacr_indx_id_sel     && !tcipif_reg_sel;
assign hacr_indx_tc_sel_rd        = 1'b0;
assign hacr_indx_hsr_sel_rd       = hacr_indx_hsr_sel    && !tcipif_reg_sel;
assign hacr_indx_wbbr_sel_rd      = hacr_indx_wbbr_sel   && !tcipif_reg_sel;
// &Force("output","hacr_indx_pcfifo_sel_rd"); @2455
assign hacr_indx_csr_sel_rd       = hacr_indx_csr_sel    && !tcipif_reg_sel;
assign hacr_indx_daddr_sel_rd     = hacr_indx_daddr_sel  && !tcipif_reg_sel;
assign hacr_indx_ddata_sel_rd     = hacr_indx_ddata_sel  && !tcipif_reg_sel;
assign hacr_indx_sysrsv_sel_rd    = hacr_indx_sysrsv_sel && !tcipif_reg_sel;

   assign hacr_indx_psr_sel_rd    = hacr_indx_psr_sel;
//                                && (tcipif_reg_sel || iu_yy_xx_dbgon);
   assign hacr_indx_pc_sel_rd     = hacr_indx_pc_sel;
//                                && (tcipif_reg_sel || iu_yy_xx_dbgon);
   assign hacr_indx_hsr2_sel_rd   = hacr_indx_hsr2_sel;
   assign hacr_indx_dder_sel_rd   = hacr_indx_dder_sel;

  assign hacr_indx_hcr_sel_rd     = hacr_indx_hcr_sel;

assign hacr_indx_mbca_sel_rd      = 1'b0;
assign hacr_indx_mbcb_sel_rd      = 1'b0;
assign hacr_indx_bamc_sel_rd      = 1'b0;
assign hacr_indx_bamd_sel_rd      = 1'b0;
assign hacr_indx_bame_sel_rd      = 1'b0;
assign hacr_indx_bamf_sel_rd      = 1'b0;
assign hacr_indx_bamg_sel_rd      = 1'b0;
assign hacr_indx_bamh_sel_rd      = 1'b0;
assign hacr_indx_bami_sel_rd      = 1'b0;
assign hacr_indx_baba_sel_rd      = hacr_indx_baba_sel && !tcipif_reg_sel;
assign hacr_indx_bama_sel_rd      = hacr_indx_bama_sel && !tcipif_reg_sel;
assign hacr_indx_babb_sel_rd      = hacr_indx_babb_sel && !tcipif_reg_sel;
assign hacr_indx_bamb_sel_rd      = hacr_indx_bamb_sel && !tcipif_reg_sel;
assign hacr_indx_babc_sel_rd      = hacr_indx_babc_sel && !tcipif_reg_sel;
assign hacr_indx_babd_sel_rd      = hacr_indx_babd_sel && !tcipif_reg_sel;
assign hacr_indx_babe_sel_rd      = hacr_indx_babe_sel && !tcipif_reg_sel;
assign hacr_indx_babf_sel_rd      = hacr_indx_babf_sel && !tcipif_reg_sel;
assign hacr_indx_babg_sel_rd      = hacr_indx_babg_sel && !tcipif_reg_sel;
assign hacr_indx_babh_sel_rd      = hacr_indx_babh_sel && !tcipif_reg_sel;
assign hacr_indx_babi_sel_rd      = hacr_indx_babi_sel && !tcipif_reg_sel;

assign hacr_indx_dacsr_sel_rd     = hacr_indx_dacsr_sel && !tcipif_reg_sel;
assign hacr_indx_datr_sel_rd      = hacr_indx_datr_sel  && !tcipif_reg_sel;
assign hacr_indx_darwr_sel_rd     = hacr_indx_darwr_sel && !tcipif_reg_sel
                                 && secure_mode_match_jtag;

assign hacr_indx_mbir_sel_rd      = hacr_indx_mbir_sel;
assign hacr_indx_mbee_sel_rd      = hacr_indx_mbee_sel;
assign hacr_indx_mbse_sel_rd      = hacr_indx_mbse_sel;

assign hacr_indx_dbg_ctrl_sel_rd  = hacr_indx_dbg_ctrl_sel  && !tcipif_reg_sel;
assign hacr_indx_prof_cnt_sel_rd  = hacr_indx_prof_cnt_sel  && !tcipif_reg_sel;
assign hacr_indx_force_reg_sel_rd = hacr_indx_force_reg_sel && !tcipif_reg_sel;

// special read data
assign dder_rd_val[31:0]  = tcipif_reg_sel ? ddera_reg[31:0] : dderb_reg[31:0];
assign dacsr_rd_val[31:0] = {dacsr_reg[31:11], sec_bit_jtag, dacsr_reg[9:0]};

always @( * )
begin
  case (1'b1)
    hacr_indx_bsel_sel_rd :
      regs_rdata[31:0] = {30'b0, bsel_val[1:0]};
//bank 0
    hacr_indx_id_sel_rd :
      regs_rdata[31:0] = id_reg[31:0];
    hacr_indx_tc_sel_rd :
      regs_rdata[31:0] = 32'b0;
    hacr_indx_mbca_sel_rd :
      regs_rdata[31:0] = 32'b0;
    hacr_indx_baba_sel_rd :
      regs_rdata[31:0] = baba_reg[31:0];
    hacr_indx_bama_sel_rd :
      regs_rdata[31:0] = {24'b0, bama_reg[7:0]};
    hacr_indx_hcr_sel_rd :
      regs_rdata[31:0] = hcr_reg[31:0];
    hacr_indx_hsr_sel_rd :
      regs_rdata[31:0] = {16'b0, hsr_reg[15:0]};
    hacr_indx_hsr2_sel_rd :
      regs_rdata[31:0] = hsr2_reg[31:0];
    hacr_indx_wbbr_sel_rd :
      regs_rdata[31:0] = wbbr_reg[31:0];
    hacr_indx_psr_sel_rd :
      regs_rdata[31:0] = {32{cp0_had_secu_dbg_en}} & psr_reg[31:0];
    hacr_indx_pc_sel_rd :
      regs_rdata[31:0] = pc_reg[31:0];
    hacr_indx_csr_sel_rd :
      regs_rdata[31:0] = {16'b0, csr_reg[15:0]};
    hacr_indx_dder_sel_rd :
      regs_rdata[31:0] = dder_rd_val[31:0];
    hacr_indx_daddr_sel_rd :
      regs_rdata[31:0] = wbbr_reg[31:0];
    hacr_indx_ddata_sel_rd :
      regs_rdata[31:0] = wbbr_reg[31:0];
    hacr_indx_sysrsv_sel_rd :
      regs_rdata[31:0] = id_reg[31:0];
    hacr_indx_mbcb_sel_rd :
      regs_rdata[31:0] = 32'b0;
    hacr_indx_babb_sel_rd:
      regs_rdata[31:0] = babb_reg[31:0];
    hacr_indx_bamb_sel_rd:
      regs_rdata[31:0] = {24'b0, bamb_reg[7:0]};
//bank 1
    hacr_indx_babc_sel_rd :
      regs_rdata[31:0] = babc_reg[31:0];
    hacr_indx_bamc_sel_rd :
      regs_rdata[31:0] = {24'b0, bamc_reg[7:0]};
    hacr_indx_babd_sel_rd :
      regs_rdata[31:0] = babd_reg[31:0];
    hacr_indx_bamd_sel_rd :
      regs_rdata[31:0] = {24'b0, bamd_reg[7:0]};
    hacr_indx_babe_sel_rd :
      regs_rdata[31:0] = babe_reg[31:0];
    hacr_indx_bame_sel_rd :
      regs_rdata[31:0] = {24'b0, bame_reg[7:0]};
    hacr_indx_babf_sel_rd :
      regs_rdata[31:0] = babf_reg[31:0];
    hacr_indx_bamf_sel_rd :
      regs_rdata[31:0] = {24'b0, bamf_reg[7:0]};
    hacr_indx_babg_sel_rd :
      regs_rdata[31:0] = babg_reg[31:0];
    hacr_indx_bamg_sel_rd :
      regs_rdata[31:0] = {24'b0, bamg_reg[7:0]};
    hacr_indx_babh_sel_rd :
      regs_rdata[31:0] = babh_reg[31:0];
    hacr_indx_bamh_sel_rd :
      regs_rdata[31:0] = {24'b0, bamh_reg[7:0]};
    hacr_indx_babi_sel_rd :
      regs_rdata[31:0] = babi_reg[31:0];
    hacr_indx_bami_sel_rd :
      regs_rdata[31:0] = {24'b0, bami_reg[7:0]};
    hacr_indx_dacsr_sel_rd :
      regs_rdata[31:0] = dacsr_rd_val[31:0];
    hacr_indx_datr_sel_rd :
      regs_rdata[31:0] = datr_reg[31:0];
    hacr_indx_darwr_sel_rd :
      regs_rdata[31:0] = darwr_reg[31:0];
    hacr_indx_mbir_sel_rd :
      regs_rdata[31:0] = {28'b0, mbir_reg[3:0]};
    hacr_indx_mbee_sel_rd :
      regs_rdata[31:0] = mbee_reg[31:0];
    hacr_indx_mbse_sel_rd :
      regs_rdata[31:0] = mbse_reg[31:0];
//bank 2
    hacr_indx_dbg_ctrl_sel_rd :
      regs_rdata[31:0] = dbg_ctrl_reg[31:0];
    hacr_indx_prof_cnt_sel_rd :
      regs_rdata[31:0] = prof_cnt_reg[31:0];
    hacr_indx_force_reg_sel_rd :
      regs_rdata[31:0] = force_reg[31:0];
    default :
      regs_rdata[31:0] = 32'b0;
  endcase
end

//==============================================================================
// Output signals to other modules
//==============================================================================
// to CPU Core
//======================================
// 1. to IFU
assign had_ifu_ir[31:0] = ddc_regs_update_ir ? ddc_regs_ir[31:0]
                                             : jtag_xx_data[31:0];
assign had_ifu_ir_vld   =
  ((jtag_xx_update_dr && hacr_indx_ir_sel && hacr_go && !hacr_ex) ||
  (ddc_regs_update_ir && hcr_ddcen)) && iu_yy_xx_dbgon;

// 2. to IU
assign had_iu_pc[30:0] = pc_reg[31:1];
assign had_iu_xx_fdb   = fdb;
                                                                                                    
// 3. to IDU
assign had_idu_wbbr_data[31:0] = wbbr_reg[31:0];
assign had_idu_wbbr_vld        = ffy && iu_yy_xx_dbgon;

// 4. to CP0
//5. to TCIP
assign had_tcipif_cmplt       = tcipif_reg_sel;
assign had_tcipif_rdata[31:0] = regs_rdata[31:0];

// to HAD internal modules
//======================================
// 1. to jtag
assign regs_jtag_data[31:0]  = regs_rdata[31:0];
assign regs_jtag_hacr_rw     = hacr_rw;
assign regs_jtag_reg8_sel    = hacr_indx_mbca_sel ||
                               hacr_indx_mbcb_sel ||
                               hacr_indx_bama_sel ||
                               hacr_indx_bamb_sel ||
                               hacr_indx_tc_sel   ||
                               hacr_indx_bamc_sel ||
                               hacr_indx_bamd_sel ||
                               hacr_indx_bame_sel ||
                               hacr_indx_bamf_sel ||
                               hacr_indx_bamg_sel ||
                               hacr_indx_bamh_sel ||
                               hacr_indx_bami_sel;

assign regs_jtag_reg16_sel   = hacr_indx_hsr_sel ||
                               hacr_indx_csr_sel;
// 2. to ctrl
assign regs_ctrl_hacr_go     = hacr_go;
assign regs_ctrl_hacr_ex     = hacr_ex;
assign regs_ctrl_dr          = hcr_dr;
assign regs_ctrl_adr         = hcr_adr;
assign regs_ctrl_exit_sel    = hacr_indx_pc_sel    ||
                               hacr_indx_ir_sel    ||
                               hacr_indx_wbbr_sel  ||
                               hacr_indx_psr_sel   ||
                               hacr_indx_csr_sel   ||
                               hacr_indx_bypass_sel;
//assign regs_xx_fdb           = fdb;
// 3. to ddc
assign regs_ddc_daddr_sel    = hacr_indx_daddr_sel;
assign regs_ddc_ddata_sel    = hacr_indx_ddata_sel;
assign regs_xx_ddc_en        = hcr_ddcen;
// 4. to trace
//assign regs_trace_cnt_sel    = regs_updt_vld && bsel_0 && hacr_indx_tc_sel;
assign regs_trace_en         = hcr_tme;
// 5. to pin
assign regs_pin_pm[1:0]      = pm[1:0];
// 6. to bkpt
assign regs_bkpta_base[31:0] = baba_reg[31:0];
assign regs_bkpta_mask[7:0]  = bama_reg[7:0];
assign regs_bkpta_ctrl[2:0]  = hcr_bca[2:0];
//assign regs_bkpta_region     = hcr_rca;
//assign regs_bkpta_cnt_sel    = regs_updt_vld && bsel_0 && hacr_indx_mbca_sel;

assign regs_bkptb_base[31:0] = babb_reg[31:0];
assign regs_bkptb_mask[7:0]  = bamb_reg[7:0];
assign regs_bkptb_ctrl[2:0]  = hcr_bcb[2:0];
//assign regs_bkptb_region     = hcr_rcb;                                                             
//assign regs_bkptb_cnt_sel    = regs_updt_vld && bsel_0 && hacr_indx_mbcb_sel;

assign regs_bkptc_base[31:0] = babc_reg[31:0];
//assign regs_bkptc_mask[7:0]  = bamc_reg[7:0];
assign regs_bkptc_en         = hcr_bxen[0];

assign regs_bkptd_base[31:0] = babd_reg[31:0];
//assign regs_bkptd_mask[7:0]  = bamd_reg[7:0];
assign regs_bkptd_en         = hcr_bxen[1];

assign regs_bkpte_base[31:0] = babe_reg[31:0];
//assign regs_bkpte_mask[7:0]  = bame_reg[7:0];
assign regs_bkpte_en         = hcr_bxen[2];



assign regs_ctrl_mbee[8:0]   = mbee_reg[8:0];

// &ModuleEnd; @2847
endmodule



