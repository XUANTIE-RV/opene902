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
module cr_bmu_ibus_if(
  biu_bmu_ibus_acc_err,
  biu_bmu_ibus_data,
  biu_bmu_ibus_data_vld,
  biu_bmu_ibus_grnt,
  biu_bmu_ibus_trans_cmplt,
  bmu_biu_ibus_acc_deny,
  bmu_biu_ibus_addr,
  bmu_biu_ibus_hit,
  bmu_biu_ibus_prot,
  bmu_biu_ibus_req,
  bmu_biu_ibus_req_no_hit,
  bmu_biu_ibus_size,
  bmu_biu_ibus_vec_redirect,
  bmu_iahbl_ibus_acc_deny,
  bmu_iahbl_ibus_addr,
  bmu_iahbl_ibus_hit,
  bmu_iahbl_ibus_prot,
  bmu_iahbl_ibus_req,
  bmu_iahbl_ibus_req_no_hit,
  bmu_iahbl_ibus_size,
  bmu_iahbl_ibus_vec_redirect,
  bmu_tcipif_ibus_acc_deny,
  bmu_tcipif_ibus_addr,
  bmu_tcipif_ibus_req,
  bmu_tcipif_ibus_write,
  bmu_xx_ibus_acc_err,
  bmu_xx_ibus_data,
  bmu_xx_ibus_data_vld,
  bmu_xx_ibus_grnt,
  bmu_xx_ibus_trans_cmplt,
  cpurst_b,
  deny_clk,
  iahbl_bmu_ibus_acc_err,
  iahbl_bmu_ibus_data,
  iahbl_bmu_ibus_data_vld,
  iahbl_bmu_ibus_grnt,
  iahbl_bmu_ibus_trans_cmplt,
  ibus_deny_clk_en,
  ifu_bmu_addr,
  ifu_bmu_idle,
  ifu_bmu_prot,
  ifu_bmu_req,
  ifu_bmu_wfd1,
  iu_bmu_vec_redirect,
  pad_bmu_iahbl_base,
  pad_bmu_iahbl_mask,
  pmp_bmu_ibus_acc_deny,
  tcipif_bmu_ibus_acc_err,
  tcipif_bmu_ibus_data,
  tcipif_bmu_ibus_data_vld,
  tcipif_bmu_ibus_grnt,
  tcipif_bmu_ibus_trans_cmplt
);

// &Ports; @25
input           biu_bmu_ibus_acc_err;       
input   [31:0]  biu_bmu_ibus_data;          
input           biu_bmu_ibus_data_vld;      
input           biu_bmu_ibus_grnt;          
input           biu_bmu_ibus_trans_cmplt;   
input           cpurst_b;                   
input           deny_clk;                   
input           iahbl_bmu_ibus_acc_err;     
input   [31:0]  iahbl_bmu_ibus_data;        
input           iahbl_bmu_ibus_data_vld;    
input           iahbl_bmu_ibus_grnt;        
input           iahbl_bmu_ibus_trans_cmplt; 
input   [31:0]  ifu_bmu_addr;               
input           ifu_bmu_idle;               
input   [3 :0]  ifu_bmu_prot;               
input           ifu_bmu_req;                
input           ifu_bmu_wfd1;               
input           iu_bmu_vec_redirect;        
input   [11:0]  pad_bmu_iahbl_base;         
input   [11:0]  pad_bmu_iahbl_mask;         
input           pmp_bmu_ibus_acc_deny;      
input           tcipif_bmu_ibus_acc_err;    
input   [31:0]  tcipif_bmu_ibus_data;       
input           tcipif_bmu_ibus_data_vld;   
input           tcipif_bmu_ibus_grnt;       
input           tcipif_bmu_ibus_trans_cmplt; 
output          bmu_biu_ibus_acc_deny;      
output  [31:0]  bmu_biu_ibus_addr;          
output          bmu_biu_ibus_hit;           
output  [3 :0]  bmu_biu_ibus_prot;          
output          bmu_biu_ibus_req;           
output          bmu_biu_ibus_req_no_hit;    
output  [1 :0]  bmu_biu_ibus_size;          
output          bmu_biu_ibus_vec_redirect;  
output          bmu_iahbl_ibus_acc_deny;    
output  [31:0]  bmu_iahbl_ibus_addr;        
output          bmu_iahbl_ibus_hit;         
output  [3 :0]  bmu_iahbl_ibus_prot;        
output          bmu_iahbl_ibus_req;         
output          bmu_iahbl_ibus_req_no_hit;  
output  [1 :0]  bmu_iahbl_ibus_size;        
output          bmu_iahbl_ibus_vec_redirect; 
output          bmu_tcipif_ibus_acc_deny;   
output  [31:0]  bmu_tcipif_ibus_addr;       
output          bmu_tcipif_ibus_req;        
output          bmu_tcipif_ibus_write;      
output          bmu_xx_ibus_acc_err;        
output  [31:0]  bmu_xx_ibus_data;           
output          bmu_xx_ibus_data_vld;       
output          bmu_xx_ibus_grnt;           
output          bmu_xx_ibus_trans_cmplt;    
output          ibus_deny_clk_en;           

// &Regs; @26
reg             acc_err_for_deny;           
reg             iahbl_hit_ff;               
reg             tcipif_hit_ff;              

// &Wires; @27
wire            biu_bmu_ibus_acc_err;       
wire    [31:0]  biu_bmu_ibus_data;          
wire            biu_bmu_ibus_data_vld;      
wire            biu_bmu_ibus_grnt;          
wire            biu_bmu_ibus_trans_cmplt;   
wire            biu_data_vld;               
wire            bmu_biu_ibus_acc_deny;      
wire    [31:0]  bmu_biu_ibus_addr;          
wire            bmu_biu_ibus_hit;           
wire    [3 :0]  bmu_biu_ibus_prot;          
wire            bmu_biu_ibus_req;           
wire            bmu_biu_ibus_req_no_hit;    
wire    [1 :0]  bmu_biu_ibus_size;          
wire            bmu_biu_ibus_vec_redirect;  
wire            bmu_iahbl_ibus_acc_deny;    
wire    [31:0]  bmu_iahbl_ibus_addr;        
wire            bmu_iahbl_ibus_hit;         
wire    [3 :0]  bmu_iahbl_ibus_prot;        
wire            bmu_iahbl_ibus_req;         
wire            bmu_iahbl_ibus_req_no_hit;  
wire    [1 :0]  bmu_iahbl_ibus_size;        
wire            bmu_iahbl_ibus_vec_redirect; 
wire            bmu_tcipif_ibus_acc_deny;   
wire    [31:0]  bmu_tcipif_ibus_addr;       
wire            bmu_tcipif_ibus_req;        
wire            bmu_tcipif_ibus_write;      
wire            bmu_xx_ibus_acc_err;        
wire    [31:0]  bmu_xx_ibus_data;           
wire            bmu_xx_ibus_data_vld;       
wire            bmu_xx_ibus_grnt;           
wire            bmu_xx_ibus_trans_cmplt;    
wire            cpurst_b;                   
wire            dahbl_bmu_ibus_acc_err;     
wire    [31:0]  dahbl_bmu_ibus_data;        
wire            dahbl_bmu_ibus_data_vld;    
wire            dahbl_bmu_ibus_grnt;        
wire            dahbl_bmu_ibus_trans_cmplt; 
wire            dahbl_data_vld;             
wire            dahbl_hit;                  
wire            dahbl_hit_ff;               
wire            dahbl_hit_upd;              
wire            deny_clk;                   
wire            iahbl_bmu_ibus_acc_err;     
wire    [31:0]  iahbl_bmu_ibus_data;        
wire            iahbl_bmu_ibus_data_vld;    
wire            iahbl_bmu_ibus_grnt;        
wire            iahbl_bmu_ibus_trans_cmplt; 
wire            iahbl_data_vld;             
wire            iahbl_hit;                  
wire            iahbl_hit_upd;              
wire            ibus_deny_clk_en;           
wire            ibus_grnt;                  
wire    [31:0]  ifu_bmu_addr;               
wire            ifu_bmu_idle;               
wire    [3 :0]  ifu_bmu_prot;               
wire            ifu_bmu_req;                
wire            ifu_bmu_wfd1;               
wire            iu_bmu_vec_redirect;        
wire    [11:0]  pad_bmu_iahbl_base;         
wire    [11:0]  pad_bmu_iahbl_mask;         
wire            pmp_bmu_ibus_acc_deny;      
wire            tcipif_bmu_ibus_acc_err;    
wire    [31:0]  tcipif_bmu_ibus_data;       
wire            tcipif_bmu_ibus_data_vld;   
wire            tcipif_bmu_ibus_grnt;       
wire            tcipif_bmu_ibus_trans_cmplt; 
wire            tcipif_data_vld;            
wire            tcipif_hit;                 
wire            tcipif_hit_upd;             


//parameter IAHBL_BASE  = 3'b000;
parameter TCIPIF_BASE = 4'b1110;

//==========================================================
//      compare base address with ahbl base addr
//==========================================================
assign iahbl_hit = ((ifu_bmu_addr[31:20] & pad_bmu_iahbl_mask[11:0]) == pad_bmu_iahbl_base[11:0]);
assign iahbl_hit_upd = (iahbl_hit_ff ^ iahbl_hit) & ifu_bmu_req & ifu_bmu_idle;
always @(posedge deny_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    iahbl_hit_ff <= 1'b1;
  else if(iahbl_hit_upd)
    iahbl_hit_ff <= iahbl_hit;
  else
    iahbl_hit_ff <= iahbl_hit_ff;
end
// &Force("input", "ifu_bmu_idle"); @50

assign dahbl_hit     = 1'b0;
assign dahbl_hit_ff  = 1'b0;
assign dahbl_hit_upd = 1'b0;


//==========================================================
//                    request to AHBLite Interface
//==========================================================
//interface to ILITE
assign bmu_iahbl_ibus_req         = ifu_bmu_req & iahbl_hit & iahbl_hit_ff;
assign bmu_iahbl_ibus_req_no_hit  = ifu_bmu_req & iahbl_hit_ff;
assign bmu_iahbl_ibus_hit         = iahbl_hit_ff;
assign bmu_iahbl_ibus_acc_deny    = pmp_bmu_ibus_acc_deny;
assign bmu_iahbl_ibus_size[1:0]   = 2'b10;
assign bmu_iahbl_ibus_addr[31:0]  = ifu_bmu_addr[31:0];
assign bmu_iahbl_ibus_vec_redirect= iu_bmu_vec_redirect;
assign bmu_iahbl_ibus_prot[3:0]   = ifu_bmu_prot[3:0]; 

//interface to DLITE
assign dahbl_bmu_ibus_acc_err     = 1'b0;
assign dahbl_bmu_ibus_data[31:0]  = 32'b0;
assign dahbl_bmu_ibus_data_vld    = 1'b0;
assign dahbl_bmu_ibus_grnt        = 1'b0;
assign dahbl_bmu_ibus_trans_cmplt = 1'b0;

//==========================================================
//                    request to system register file
//==========================================================
assign tcipif_hit = (ifu_bmu_addr[31:28] == TCIPIF_BASE);
assign tcipif_hit_upd = (tcipif_hit_ff ^ tcipif_hit) & ifu_bmu_req & ifu_bmu_idle;
always @(posedge deny_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    tcipif_hit_ff <= 1'b0;
  else if(tcipif_hit_upd)
    tcipif_hit_ff <= tcipif_hit;
  else
    tcipif_hit_ff <= tcipif_hit_ff;
end
assign bmu_tcipif_ibus_req         = ifu_bmu_req & tcipif_hit & tcipif_hit_ff;
assign bmu_tcipif_ibus_acc_deny    = pmp_bmu_ibus_acc_deny;
assign bmu_tcipif_ibus_write       = 1'b0;
assign bmu_tcipif_ibus_addr[31:0]  = ifu_bmu_addr[31:0];

//==========================================================
//                    request to system bus
//==========================================================
assign bmu_biu_ibus_req          = ifu_bmu_req & ~iahbl_hit & ~dahbl_hit 
                                                            & ~tcipif_hit
                                 & ~iahbl_hit_ff & ~dahbl_hit_ff 
                                                 & ~tcipif_hit_ff;
assign bmu_biu_ibus_req_no_hit   = ifu_bmu_req & ~iahbl_hit_ff 
                                               & ~dahbl_hit_ff 
                                               & ~tcipif_hit_ff;
assign bmu_biu_ibus_hit          = ~iahbl_hit_ff & ~dahbl_hit_ff
                                                 & ~tcipif_hit_ff;
assign bmu_biu_ibus_acc_deny     = pmp_bmu_ibus_acc_deny;
assign bmu_biu_ibus_size[1:0]    = 2'b10;
assign bmu_biu_ibus_addr[31:0]   = ifu_bmu_addr[31:0];
assign bmu_biu_ibus_vec_redirect = iu_bmu_vec_redirect;
assign bmu_biu_ibus_prot[3:0]    = ifu_bmu_prot[3:0]; 

//==========================================================
//                BMU ACK to LSU
//==========================================================
assign ibus_grnt        = iahbl_bmu_ibus_grnt  |
                          dahbl_bmu_ibus_grnt  |
                          tcipif_bmu_ibus_grnt |
                          biu_bmu_ibus_grnt;
assign bmu_xx_ibus_grnt = ibus_grnt;

assign ibus_deny_clk_en = acc_err_for_deny || pmp_bmu_ibus_acc_deny 
                       || iahbl_hit_upd
                       || dahbl_hit_upd
                       || tcipif_hit_upd;


//         &Force("nonport","ibus_deny_clk_en"); @209
always @(posedge deny_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    acc_err_for_deny <= 1'b0;
  else if(ibus_grnt)
    acc_err_for_deny <= pmp_bmu_ibus_acc_deny;
  else if(acc_err_for_deny && ifu_bmu_wfd1)
    acc_err_for_deny <= 1'b0;
end

// &Force("output","bmu_xx_ibus_trans_cmplt"); @224
assign bmu_xx_ibus_trans_cmplt = iahbl_bmu_ibus_trans_cmplt  |
                                 dahbl_bmu_ibus_trans_cmplt  |
                                 tcipif_bmu_ibus_trans_cmplt |
                                 biu_bmu_ibus_trans_cmplt    |
                                 acc_err_for_deny & ifu_bmu_wfd1;

assign bmu_xx_ibus_data_vld    = iahbl_bmu_ibus_data_vld  |
                                 dahbl_bmu_ibus_data_vld  |
                                 tcipif_bmu_ibus_data_vld |
                                 biu_bmu_ibus_data_vld;

assign iahbl_data_vld = iahbl_bmu_ibus_data_vld;
assign dahbl_data_vld = dahbl_bmu_ibus_data_vld;
assign biu_data_vld   = biu_bmu_ibus_data_vld;
assign tcipif_data_vld = tcipif_bmu_ibus_data_vld;

assign bmu_xx_ibus_data[31:0]  = ({32{iahbl_data_vld}}  & iahbl_bmu_ibus_data[31:0])  |
                                 ({32{dahbl_data_vld}}  & dahbl_bmu_ibus_data[31:0])  |
                                 ({32{tcipif_data_vld}} & tcipif_bmu_ibus_data[31:0]) |
                                 ({32{biu_data_vld}}    & biu_bmu_ibus_data[31:0]);



assign bmu_xx_ibus_acc_err     = iahbl_bmu_ibus_acc_err |
                                 dahbl_bmu_ibus_acc_err |
                                 tcipif_bmu_ibus_acc_err |
                                 biu_bmu_ibus_acc_err   |
                                 acc_err_for_deny & ifu_bmu_wfd1;

// &ModuleEnd; @265
endmodule



