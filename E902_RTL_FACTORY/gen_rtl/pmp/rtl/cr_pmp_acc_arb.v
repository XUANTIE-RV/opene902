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
module cr_pmp_acc_arb(
  cp0_pmp_mstatus_mpp,
  cp0_pmp_mstatus_mprv,
  cp0_yy_machine_mode_aft_dbg,
  ifu_access_deny_region,
  ifu_access_no_hit_deny,
  ifu_bmu_prot,
  lsu_access_deny_region,
  lsu_access_no_hit_deny,
  lsu_pmp_is_st,
  regs_comp_excut0,
  regs_comp_excut1,
  regs_comp_excut2,
  regs_comp_excut3,
  regs_comp_excut4,
  regs_comp_excut5,
  regs_comp_excut6,
  regs_comp_excut7,
  regs_comp_lock0,
  regs_comp_lock1,
  regs_comp_lock2,
  regs_comp_lock3,
  regs_comp_lock4,
  regs_comp_lock5,
  regs_comp_lock6,
  regs_comp_lock7,
  regs_comp_read0,
  regs_comp_read1,
  regs_comp_read2,
  regs_comp_read3,
  regs_comp_read4,
  regs_comp_read5,
  regs_comp_read6,
  regs_comp_read7,
  regs_comp_write0,
  regs_comp_write1,
  regs_comp_write2,
  regs_comp_write3,
  regs_comp_write4,
  regs_comp_write5,
  regs_comp_write6,
  regs_comp_write7
);

// &Ports; @25
input   [1:0]  cp0_pmp_mstatus_mpp;        
input          cp0_pmp_mstatus_mprv;       
input          cp0_yy_machine_mode_aft_dbg; 
input   [3:0]  ifu_bmu_prot;               
input          lsu_pmp_is_st;              
input          regs_comp_excut0;           
input          regs_comp_excut1;           
input          regs_comp_excut2;           
input          regs_comp_excut3;           
input          regs_comp_excut4;           
input          regs_comp_excut5;           
input          regs_comp_excut6;           
input          regs_comp_excut7;           
input          regs_comp_lock0;            
input          regs_comp_lock1;            
input          regs_comp_lock2;            
input          regs_comp_lock3;            
input          regs_comp_lock4;            
input          regs_comp_lock5;            
input          regs_comp_lock6;            
input          regs_comp_lock7;            
input          regs_comp_read0;            
input          regs_comp_read1;            
input          regs_comp_read2;            
input          regs_comp_read3;            
input          regs_comp_read4;            
input          regs_comp_read5;            
input          regs_comp_read6;            
input          regs_comp_read7;            
input          regs_comp_write0;           
input          regs_comp_write1;           
input          regs_comp_write2;           
input          regs_comp_write3;           
input          regs_comp_write4;           
input          regs_comp_write5;           
input          regs_comp_write6;           
input          regs_comp_write7;           
output  [7:0]  ifu_access_deny_region;     
output         ifu_access_no_hit_deny;     
output  [7:0]  lsu_access_deny_region;     
output         lsu_access_no_hit_deny;     

// &Regs; @26

// &Wires; @27
wire    [1:0]  cp0_pmp_mstatus_mpp;        
wire           cp0_pmp_mstatus_mprv;       
wire           cp0_yy_machine_mode_aft_dbg; 
wire           ifu_acc_machine_mode;       
wire           ifu_acc_user_mode;          
wire           ifu_access_deny0;           
wire           ifu_access_deny1;           
wire           ifu_access_deny2;           
wire           ifu_access_deny3;           
wire           ifu_access_deny4;           
wire           ifu_access_deny5;           
wire           ifu_access_deny6;           
wire           ifu_access_deny7;           
wire    [7:0]  ifu_access_deny_region;     
wire           ifu_access_no_hit_deny;     
wire    [3:0]  ifu_bmu_prot;               
wire           lsu_acc_machine_mode;       
wire           lsu_acc_user_mode;          
wire           lsu_access_deny0;           
wire           lsu_access_deny1;           
wire           lsu_access_deny2;           
wire           lsu_access_deny3;           
wire           lsu_access_deny4;           
wire           lsu_access_deny5;           
wire           lsu_access_deny6;           
wire           lsu_access_deny7;           
wire    [7:0]  lsu_access_deny_region;     
wire           lsu_access_no_hit_deny;     
wire           lsu_pmp_is_st;              
wire           regs_comp_excut0;           
wire           regs_comp_excut1;           
wire           regs_comp_excut2;           
wire           regs_comp_excut3;           
wire           regs_comp_excut4;           
wire           regs_comp_excut5;           
wire           regs_comp_excut6;           
wire           regs_comp_excut7;           
wire           regs_comp_lock0;            
wire           regs_comp_lock1;            
wire           regs_comp_lock2;            
wire           regs_comp_lock3;            
wire           regs_comp_lock4;            
wire           regs_comp_lock5;            
wire           regs_comp_lock6;            
wire           regs_comp_lock7;            
wire           regs_comp_read0;            
wire           regs_comp_read1;            
wire           regs_comp_read2;            
wire           regs_comp_read3;            
wire           regs_comp_read4;            
wire           regs_comp_read5;            
wire           regs_comp_read6;            
wire           regs_comp_read7;            
wire           regs_comp_write0;           
wire           regs_comp_write1;           
wire           regs_comp_write2;           
wire           regs_comp_write3;           
wire           regs_comp_write4;           
wire           regs_comp_write5;           
wire           regs_comp_write6;           
wire           regs_comp_write7;           


// &Force("bus","ifu_bmu_prot",3,0); @29
//==========================================================
//                Attribute Matching Logic
//==========================================================
//-------------------------------------------
// Check the access attribute of each region
//-------------------------------------------
assign lsu_acc_machine_mode = cp0_yy_machine_mode_aft_dbg && !cp0_pmp_mstatus_mprv
                           || (cp0_pmp_mstatus_mpp[1:0] == 2'b11) && cp0_pmp_mstatus_mprv;
                     
assign lsu_acc_user_mode    = !cp0_yy_machine_mode_aft_dbg && !cp0_pmp_mstatus_mprv
                           || (cp0_pmp_mstatus_mpp[1:0] == 2'b00)  && cp0_pmp_mstatus_mprv;

//when bmu not grant,acc machine mode and secure mode should not change
assign ifu_acc_machine_mode = ifu_bmu_prot[1]; 
assign ifu_acc_user_mode    = !ifu_bmu_prot[1];


//-----------------------------------------
// Checks the access attribute with no entry hit
//-----------------------------------------
assign ifu_access_no_hit_deny = ifu_acc_user_mode;
assign lsu_access_no_hit_deny = lsu_acc_user_mode;

//-----------------------------------------
// Checks the access attribute of region 0
//-----------------------------------------
//IFU deny will be generated when:
//1. ifu access in machine mode:
//(1) PMP entry is locked 
//(2) PMP entry is not executeable
//2. ifu access in user mode:
//(2) PMP entry is not executeable
assign ifu_access_deny_region[0] = ifu_access_deny0;
assign ifu_access_deny0          = ifu_acc_machine_mode && regs_comp_lock0 && !regs_comp_excut0
                                || ifu_acc_user_mode && !regs_comp_excut0;

//LSU deny will be generated when:
//1.lsu access in machine mode:
//(1) PMP entry is locked
//(2) access is load and PMP entry is not readable
//    access is store and PMP entry is not writeable
//2.lsu access in user mode:
//(1) access is load and PMP entry is not readable
//    access is store and PMP entry is not writeable
assign lsu_access_deny_region[0] = lsu_access_deny0;
assign lsu_access_deny0          = lsu_acc_machine_mode && regs_comp_lock0 
                                   && (lsu_pmp_is_st && !regs_comp_write0 
                                       || !lsu_pmp_is_st && !regs_comp_read0)
                                || lsu_acc_user_mode                              
                                   && (lsu_pmp_is_st && !regs_comp_write0 
                                       || !lsu_pmp_is_st && !regs_comp_read0);

//-----------------------------------------
// Checks the access attribute of region 1
//-----------------------------------------
assign ifu_access_deny_region[1] = ifu_access_deny1;
assign lsu_access_deny_region[1] = lsu_access_deny1;
assign ifu_access_deny1          = ifu_acc_machine_mode && regs_comp_lock1 && !regs_comp_excut1
                                || ifu_acc_user_mode && !regs_comp_excut1;

assign lsu_access_deny1          = lsu_acc_machine_mode && regs_comp_lock1 
                                   && (lsu_pmp_is_st && !regs_comp_write1 
                                       || !lsu_pmp_is_st && !regs_comp_read1)
                                || lsu_acc_user_mode                              
                                   && (lsu_pmp_is_st && !regs_comp_write1 
                                       || !lsu_pmp_is_st && !regs_comp_read1);

//-----------------------------------------
// Checks the access attribute of region 2
//-----------------------------------------
assign ifu_access_deny_region[2] = ifu_access_deny2;
assign lsu_access_deny_region[2] = lsu_access_deny2;
assign ifu_access_deny2          = ifu_acc_machine_mode && regs_comp_lock2 && !regs_comp_excut2
                                || ifu_acc_user_mode && !regs_comp_excut2;

assign lsu_access_deny2          = lsu_acc_machine_mode && regs_comp_lock2 
                                   && (lsu_pmp_is_st && !regs_comp_write2 
                                       || !lsu_pmp_is_st && !regs_comp_read2)
                                || lsu_acc_user_mode                              
                                   && (lsu_pmp_is_st && !regs_comp_write2 
                                       || !lsu_pmp_is_st && !regs_comp_read2);

//-----------------------------------------
// Checks the access attribute of region 3
//-----------------------------------------
assign ifu_access_deny_region[3] = ifu_access_deny3;
assign lsu_access_deny_region[3] = lsu_access_deny3;

assign ifu_access_deny3          = ifu_acc_machine_mode && regs_comp_lock3 && !regs_comp_excut3
                                || ifu_acc_user_mode && !regs_comp_excut3;

assign lsu_access_deny3          = lsu_acc_machine_mode && regs_comp_lock3 
                                   && (lsu_pmp_is_st && !regs_comp_write3 
                                       || !lsu_pmp_is_st && !regs_comp_read3)
                                || lsu_acc_user_mode                              
                                   && (lsu_pmp_is_st && !regs_comp_write3 
                                       || !lsu_pmp_is_st && !regs_comp_read3);

//-----------------------------------------
// Checks the access attribute of region 4
//-----------------------------------------
assign ifu_access_deny_region[4] = ifu_access_deny4;
assign lsu_access_deny_region[4] = lsu_access_deny4;

assign ifu_access_deny4          = ifu_acc_machine_mode && regs_comp_lock4 && !regs_comp_excut4
                                || ifu_acc_user_mode && !regs_comp_excut4;

assign lsu_access_deny4          = lsu_acc_machine_mode && regs_comp_lock4 
                                   && (lsu_pmp_is_st && !regs_comp_write4 
                                       || !lsu_pmp_is_st && !regs_comp_read4)
                                || lsu_acc_user_mode                              
                                   && (lsu_pmp_is_st && !regs_comp_write4 
                                       || !lsu_pmp_is_st && !regs_comp_read4);

//-----------------------------------------
// Checks the access attribute of region 5
//-----------------------------------------
assign ifu_access_deny_region[5] = ifu_access_deny5;
assign lsu_access_deny_region[5] = lsu_access_deny5;

assign ifu_access_deny5          = ifu_acc_machine_mode && regs_comp_lock5 && !regs_comp_excut5
                                || ifu_acc_user_mode && !regs_comp_excut5;

assign lsu_access_deny5          = lsu_acc_machine_mode && regs_comp_lock5 
                                   && (lsu_pmp_is_st && !regs_comp_write5 
                                       || !lsu_pmp_is_st && !regs_comp_read5)
                                || lsu_acc_user_mode                              
                                   && (lsu_pmp_is_st && !regs_comp_write5 
                                       || !lsu_pmp_is_st && !regs_comp_read5);                

//-----------------------------------------
// Checks the access attribute of region 6
//-----------------------------------------
assign ifu_access_deny_region[6] = ifu_access_deny6;
assign lsu_access_deny_region[6] = lsu_access_deny6;

assign ifu_access_deny6          = ifu_acc_machine_mode && regs_comp_lock6 && !regs_comp_excut6
                                || ifu_acc_user_mode && !regs_comp_excut6;

assign lsu_access_deny6          = lsu_acc_machine_mode && regs_comp_lock6 
                                   && (lsu_pmp_is_st && !regs_comp_write6 
                                       || !lsu_pmp_is_st && !regs_comp_read6)
                                || lsu_acc_user_mode                              
                                   && (lsu_pmp_is_st && !regs_comp_write6 
                                       || !lsu_pmp_is_st && !regs_comp_read6);
                                       
//-----------------------------------------
// Checks the access attribute of region 7
//-----------------------------------------
assign ifu_access_deny_region[7] = ifu_access_deny7;
assign lsu_access_deny_region[7] = lsu_access_deny7;

assign ifu_access_deny7          = ifu_acc_machine_mode && regs_comp_lock7 && !regs_comp_excut7
                                || ifu_acc_user_mode && !regs_comp_excut7;

assign lsu_access_deny7          = lsu_acc_machine_mode && regs_comp_lock7 
                                   && (lsu_pmp_is_st && !regs_comp_write7 
                                       || !lsu_pmp_is_st && !regs_comp_read7)
                                || lsu_acc_user_mode                              
                                   && (lsu_pmp_is_st && !regs_comp_write7 
                                       || !lsu_pmp_is_st && !regs_comp_read7);









// &ModuleEnd; @524
endmodule


