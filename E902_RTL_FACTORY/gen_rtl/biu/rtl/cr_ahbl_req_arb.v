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
module cr_ahbl_req_arb(
  ahbl_bmu_dbus_acc_err,
  ahbl_bmu_dbus_data,
  ahbl_bmu_dbus_data_vld,
  ahbl_bmu_dbus_grnt,
  ahbl_bmu_dbus_trans_cmplt,
  ahbl_bmu_ibus_acc_err,
  ahbl_bmu_ibus_data,
  ahbl_bmu_ibus_data_vld,
  ahbl_bmu_ibus_grnt,
  ahbl_bmu_ibus_trans_cmplt,
  ahbl_gated_clk,
  bmu_ahbl_dbus_acc_deny,
  bmu_ahbl_dbus_addr,
  bmu_ahbl_dbus_chk_fail,
  bmu_ahbl_dbus_prot,
  bmu_ahbl_dbus_req,
  bmu_ahbl_dbus_req_without_cmplt,
  bmu_ahbl_dbus_req_without_deny_chk_fail,
  bmu_ahbl_dbus_size,
  bmu_ahbl_dbus_write,
  bmu_ahbl_ibus_acc_deny,
  bmu_ahbl_ibus_addr,
  bmu_ahbl_ibus_hit,
  bmu_ahbl_ibus_prot,
  bmu_ahbl_ibus_req,
  bmu_ahbl_ibus_req_no_hit,
  bmu_ahbl_ibus_size,
  bmu_ahbl_ibus_vec_redirect,
  bmu_ahbl_ibus_write,
  bmu_ahbl_wdata,
  cpu_acc_err,
  cpu_addr,
  cpu_data_vld,
  cpu_prot,
  cpu_rdata,
  cpu_req,
  cpu_req_for_grnt,
  cpu_req_for_peak_power,
  cpu_req_grnt,
  cpu_sec,
  cpu_size,
  cpu_trans_cmplt,
  cpu_vec_redirect,
  cpu_wdata,
  cpu_write,
  cpurst_b,
  ibus_not_granted
);

// &Ports; @23
input           ahbl_gated_clk;                         
input           bmu_ahbl_dbus_acc_deny;                 
input   [31:0]  bmu_ahbl_dbus_addr;                     
input           bmu_ahbl_dbus_chk_fail;                 
input   [3 :0]  bmu_ahbl_dbus_prot;                     
input           bmu_ahbl_dbus_req;                      
input           bmu_ahbl_dbus_req_without_cmplt;        
input           bmu_ahbl_dbus_req_without_deny_chk_fail; 
input   [1 :0]  bmu_ahbl_dbus_size;                     
input           bmu_ahbl_dbus_write;                    
input           bmu_ahbl_ibus_acc_deny;                 
input   [31:0]  bmu_ahbl_ibus_addr;                     
input           bmu_ahbl_ibus_hit;                      
input   [3 :0]  bmu_ahbl_ibus_prot;                     
input           bmu_ahbl_ibus_req;                      
input           bmu_ahbl_ibus_req_no_hit;               
input   [1 :0]  bmu_ahbl_ibus_size;                     
input           bmu_ahbl_ibus_vec_redirect;             
input           bmu_ahbl_ibus_write;                    
input   [31:0]  bmu_ahbl_wdata;                         
input           cpu_acc_err;                            
input           cpu_data_vld;                           
input   [31:0]  cpu_rdata;                              
input           cpu_req_grnt;                           
input           cpu_sec;                                
input           cpu_trans_cmplt;                        
input           cpurst_b;                               
output          ahbl_bmu_dbus_acc_err;                  
output  [31:0]  ahbl_bmu_dbus_data;                     
output          ahbl_bmu_dbus_data_vld;                 
output          ahbl_bmu_dbus_grnt;                     
output          ahbl_bmu_dbus_trans_cmplt;              
output          ahbl_bmu_ibus_acc_err;                  
output  [31:0]  ahbl_bmu_ibus_data;                     
output          ahbl_bmu_ibus_data_vld;                 
output          ahbl_bmu_ibus_grnt;                     
output          ahbl_bmu_ibus_trans_cmplt;              
output  [31:0]  cpu_addr;                               
output  [3 :0]  cpu_prot;                               
output          cpu_req;                                
output          cpu_req_for_grnt;                       
output          cpu_req_for_peak_power;                 
output  [1 :0]  cpu_size;                               
output          cpu_vec_redirect;                       
output  [31:0]  cpu_wdata;                              
output          cpu_write;                              
output          ibus_not_granted;                       

// &Regs; @24
reg     [1 :0]  cpu_req_bus_grnt;                       
reg     [1 :0]  cpu_req_type;                           
reg             ibus_not_granted;                       

// &Wires; @25
wire            ahbl_bmu_dbus_acc_err;                  
wire    [31:0]  ahbl_bmu_dbus_data;                     
wire            ahbl_bmu_dbus_data_vld;                 
wire            ahbl_bmu_dbus_grnt;                     
wire            ahbl_bmu_dbus_trans_cmplt;              
wire            ahbl_bmu_ibus_acc_err;                  
wire    [31:0]  ahbl_bmu_ibus_data;                     
wire            ahbl_bmu_ibus_data_vld;                 
wire            ahbl_bmu_ibus_grnt;                     
wire            ahbl_bmu_ibus_trans_cmplt;              
wire            ahbl_gated_clk;                         
wire            bmu_ahbl_dbus_acc_deny;                 
wire    [31:0]  bmu_ahbl_dbus_addr;                     
wire            bmu_ahbl_dbus_chk_fail;                 
wire    [3 :0]  bmu_ahbl_dbus_prot;                     
wire            bmu_ahbl_dbus_req;                      
wire            bmu_ahbl_dbus_req_without_cmplt;        
wire            bmu_ahbl_dbus_req_without_deny_chk_fail; 
wire    [1 :0]  bmu_ahbl_dbus_size;                     
wire            bmu_ahbl_dbus_write;                    
wire    [31:0]  bmu_ahbl_had_addr;                      
wire    [3 :0]  bmu_ahbl_had_prot;                      
wire    [1 :0]  bmu_ahbl_had_size;                      
wire    [31:0]  bmu_ahbl_had_wdata;                     
wire            bmu_ahbl_had_write;                     
wire            bmu_ahbl_ibus_acc_deny;                 
wire    [31:0]  bmu_ahbl_ibus_addr;                     
wire            bmu_ahbl_ibus_hit;                      
wire    [3 :0]  bmu_ahbl_ibus_prot;                     
wire            bmu_ahbl_ibus_req;                      
wire            bmu_ahbl_ibus_req_no_hit;               
wire    [1 :0]  bmu_ahbl_ibus_size;                     
wire            bmu_ahbl_ibus_vec_redirect;             
wire            bmu_ahbl_ibus_write;                    
wire    [31:0]  bmu_ahbl_wdata;                         
wire            cpu_acc_err;                            
wire    [31:0]  cpu_addr;                               
wire            cpu_data_vld;                           
wire    [3 :0]  cpu_prot;                               
wire    [31:0]  cpu_rdata;                              
wire            cpu_req;                                
wire            cpu_req_dbus_grnt;                      
wire            cpu_req_for_grnt;                       
wire            cpu_req_for_peak_power;                 
wire            cpu_req_grnt;                           
wire            cpu_req_ibus_grnt;                      
wire    [1 :0]  cpu_size;                               
wire            cpu_trans_cmplt;                        
wire            cpu_vec_redirect;                       
wire    [31:0]  cpu_wdata;                              
wire            cpu_write;                              
wire            cpurst_b;                               
wire            dbus_req;                               
wire            dbus_req_without_deny_chk_fail;         
wire            dbus_req_without_deny_chk_fail_cmplt;   
wire            dbus_sel;                               
wire            had_req;                                
wire            had_req_without_cmplt;                  
wire            had_sel;                                
wire            ibus_req;                               
wire            ibus_req_only;                          
wire            ibus_req_without_deny;                  
wire            ibus_sel;                               


//=============================================================
//
//       generate request to ahb interface by priority
//
//=============================================================
assign had_req = 1'b0;
assign had_req_without_cmplt = 1'b0;
assign had_sel = 1'b0;
assign bmu_ahbl_had_addr[31:0] = 32'b0;
assign bmu_ahbl_had_prot[3:0]  = 4'b0;
assign bmu_ahbl_had_size[1:0]  = 2'b0;
assign bmu_ahbl_had_wdata[31:0] = 32'b0;
assign bmu_ahbl_had_write = 1'b0;
assign ibus_req = bmu_ahbl_ibus_req && !bmu_ahbl_ibus_acc_deny;
assign ibus_req_without_deny = bmu_ahbl_ibus_req;
assign dbus_req = bmu_ahbl_dbus_req && !bmu_ahbl_dbus_acc_deny 
              && !bmu_ahbl_dbus_chk_fail && !ibus_not_granted;
assign dbus_req_without_deny_chk_fail = bmu_ahbl_dbus_req_without_deny_chk_fail 
                                    && !ibus_not_granted;

assign dbus_req_without_deny_chk_fail_cmplt = bmu_ahbl_dbus_req_without_cmplt 
                                          && !ibus_not_granted;

assign ibus_sel = bmu_ahbl_ibus_hit && !dbus_req_without_deny_chk_fail_cmplt && !had_req_without_cmplt;
//assign dbus_sel = dbus_req_without_deny_chk_fail_cmplt || !inst_bus && !ibus_req_without_deny;
assign dbus_sel = dbus_req_without_deny_chk_fail_cmplt && !had_req_without_cmplt;

assign cpu_req = (ibus_req && !dbus_req_without_deny_chk_fail_cmplt && !had_req_without_cmplt) 
                 || dbus_req && !had_req_without_cmplt || had_req;
assign cpu_req_for_grnt = ibus_req_without_deny || dbus_req_without_deny_chk_fail_cmplt || had_req_without_cmplt;
assign cpu_req_for_peak_power = bmu_ahbl_ibus_req_no_hit && bmu_ahbl_ibus_hit
                             || dbus_req_without_deny_chk_fail_cmplt
                             || had_req_without_cmplt;

assign cpu_addr[31:0]   = {32{dbus_sel}} & bmu_ahbl_dbus_addr[31:0]
                        | {32{ibus_sel}} & bmu_ahbl_ibus_addr[31:0]
                        | {32{had_sel}}  & bmu_ahbl_had_addr[31:0];

assign cpu_prot[3:0]    = {4{dbus_sel}}  & bmu_ahbl_dbus_prot[3:0]
                        | {4{ibus_sel}}  & bmu_ahbl_ibus_prot[3:0]
                        | {4{had_sel}}   & bmu_ahbl_had_prot[3:0];

assign cpu_size[1:0]    = {2{dbus_sel}}  & bmu_ahbl_dbus_size[1:0]
                        | {2{ibus_sel}}  & bmu_ahbl_ibus_size[1:0]
                        | {2{had_sel}}   & bmu_ahbl_had_size[1:0];

assign cpu_write        = dbus_sel       & bmu_ahbl_dbus_write
                        | ibus_sel       & bmu_ahbl_ibus_write
                        | had_sel        & bmu_ahbl_had_write; 
assign cpu_vec_redirect = bmu_ahbl_ibus_vec_redirect;

// write data has only one source, selected in top module
//assign cpu_wdata[31:0]  = {32{cpu_req_bus_grnt}} & bmu_ahbl_wdata[31:0];
assign cpu_wdata[31:0]  = (cpu_req_bus_grnt[1:0] == 2'b1) ?   bmu_ahbl_wdata[31:0] :
                                          bmu_ahbl_had_wdata[31:0];
//always @(posedge ahbl_gated_clk or negedge cpurst_b)
//begin
//  if(!cpurst_b)
//     dbus_sel_ff <= 1'b0;
//  else if(dbus_sel && cpu_req_grnt)
//     dbus_sel_ff <= 1'b1;
//  else
//     dbus_sel_ff <= 1'b0;
//end

//===================================================
//        record the current request to generate
//      the response singal to corresonding module
//===================================================
// &Force("output", "cpu_req"); @118
// &CombBeg; @119
always @( had_req
       or dbus_req
       or ibus_req)
begin
casez({had_req, dbus_req, ibus_req})
  3'b1?? : cpu_req_type[1:0] = 2'b10;
  3'b01? : cpu_req_type[1:0] = 2'b01;
  default: cpu_req_type[1:0] = 2'b0;
endcase
// &CombEnd; @125
end
//assign cpu_req_type = dbus_req || !ibus_req;
always @(posedge ahbl_gated_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cpu_req_bus_grnt[1:0] <= 2'b0;
  else if(cpu_req && cpu_req_grnt)
    cpu_req_bus_grnt[1:0] <= cpu_req_type[1:0];
  else
    cpu_req_bus_grnt[1:0] <= cpu_req_bus_grnt[1:0];
end 

// mask dbus request grant when a previous ibus request 
// not granted by interface
// &Force("output", "ibus_not_granted"); @139
assign ibus_req_only = ibus_req && !dbus_req_without_deny_chk_fail_cmplt && !had_req_without_cmplt;
always @(posedge ahbl_gated_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ibus_not_granted <= 1'b0;
  else if(ibus_req_only && !cpu_req_grnt)
    ibus_not_granted <= 1'b1;
  else if(cpu_req_grnt && ibus_not_granted)
    ibus_not_granted <= 1'b0;
end 


//=============================================================
//
//    generate response and data to corresponding module
//
//=============================================================

//===================================================
//              grant signal
//===================================================
assign ahbl_bmu_ibus_grnt = !dbus_req_without_deny_chk_fail_cmplt
                          && ibus_req_without_deny && cpu_req_grnt && !had_req_without_cmplt;
assign ahbl_bmu_dbus_grnt = dbus_req_without_deny_chk_fail && cpu_req_grnt && !had_req_without_cmplt;

//===================================================
//             trans compltete signal
//===================================================
assign cpu_req_ibus_grnt = (cpu_req_bus_grnt[1:0] == 2'b00);
assign cpu_req_dbus_grnt = (cpu_req_bus_grnt[1:0] == 2'b01);
assign ahbl_bmu_ibus_trans_cmplt = cpu_req_ibus_grnt && cpu_trans_cmplt;
assign ahbl_bmu_dbus_trans_cmplt = cpu_req_dbus_grnt && cpu_trans_cmplt;


//===================================================
//             data valid  signal
//===================================================
assign ahbl_bmu_ibus_data_vld = cpu_req_ibus_grnt && cpu_data_vld;
assign ahbl_bmu_dbus_data_vld = cpu_req_dbus_grnt && cpu_data_vld;


//===================================================
//             access error  signal
//===================================================
assign ahbl_bmu_ibus_acc_err = cpu_req_ibus_grnt && cpu_acc_err;
assign ahbl_bmu_dbus_acc_err = cpu_req_dbus_grnt && cpu_acc_err;


// &Force("input","cpu_sec"); @216
//===================================================
//               read data signal
//===================================================
assign ahbl_bmu_ibus_data[31:0] = cpu_rdata[31:0];
assign ahbl_bmu_dbus_data[31:0] = cpu_rdata[31:0];



// &ModuleEnd; @249
endmodule


