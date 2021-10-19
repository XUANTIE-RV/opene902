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

// &ModuleBeg; @23
module cr_lsu_dp(
  bmu_lsu_data,
  cp0_yy_be_v1,
  cp0_yy_be_v2,
  cp0_yy_clk_en,
  cp0_yy_machine_mode_aft_dbg,
  cpurst_b,
  ctrl_dp_ldst_info_buf_reuse,
  ctrl_dp_ldst_req_grnt,
  ctrl_dp_store_buffer_updt,
  dp_ctrl_misalign,
  forever_cpuclk,
  iu_lsu_adder_rst,
  iu_lsu_base,
  iu_lsu_data,
  iu_lsu_ex_byte,
  iu_lsu_ex_data_sel,
  iu_lsu_ex_half,
  iu_lsu_ex_uns,
  iu_lsu_imm_data,
  iu_lsu_imm_write_en,
  iu_lsu_offset,
  iu_lsu_oper_mux_en,
  iu_lsu_rs2,
  lsu_bmu_addr,
  lsu_bmu_prot,
  lsu_bmu_size,
  lsu_bmu_store_error,
  lsu_bmu_wdata,
  lsu_bmu_write,
  lsu_had_addr,
  lsu_had_st,
  lsu_inst_store,
  lsu_iu_addr,
  lsu_iu_addr_vld,
  lsu_iu_alu_sel,
  lsu_iu_data,
  lsu_iu_mad_buf,
  lsu_iu_store,
  lsu_iu_wb_load_data,
  pad_yy_gate_clk_en_b,
  pmp_lsu_acc_scu,
  randclk_dp_size_buf_mod_en_w5,
  sysmap_lsu_acc_ca,
  unalign_dp_first_req,
  unalign_dp_load_data_byte1_to_byte1,
  unalign_dp_load_data_byte1_to_byte2,
  unalign_dp_load_data_byte1_to_byte3,
  unalign_dp_load_data_byte1_to_byte4,
  unalign_dp_load_data_byte2_to_byte1,
  unalign_dp_load_data_byte2_to_byte2,
  unalign_dp_load_data_byte2_to_byte3,
  unalign_dp_load_data_byte2_to_byte4,
  unalign_dp_load_data_byte3_to_byte1,
  unalign_dp_load_data_byte3_to_byte2,
  unalign_dp_load_data_byte3_to_byte3,
  unalign_dp_load_data_byte3_to_byte4,
  unalign_dp_load_data_byte4_to_byte1,
  unalign_dp_load_data_byte4_to_byte2,
  unalign_dp_load_data_byte4_to_byte3,
  unalign_dp_load_data_byte4_to_byte4,
  unalign_dp_store_data_byte1_to_byte1,
  unalign_dp_store_data_byte1_to_byte2,
  unalign_dp_store_data_byte1_to_byte3,
  unalign_dp_store_data_byte1_to_byte4,
  unalign_dp_store_data_byte2_to_byte1,
  unalign_dp_store_data_byte2_to_byte2,
  unalign_dp_store_data_byte2_to_byte3,
  unalign_dp_store_data_byte2_to_byte4,
  unalign_dp_store_data_byte3_to_byte1,
  unalign_dp_store_data_byte3_to_byte2,
  unalign_dp_store_data_byte3_to_byte3,
  unalign_dp_store_data_byte3_to_byte4,
  unalign_dp_store_data_byte4_to_byte1,
  unalign_dp_store_data_byte4_to_byte2,
  unalign_dp_store_data_byte4_to_byte3,
  unalign_dp_store_data_byte4_to_byte4
);

// &Ports; @24
input   [31:0]  bmu_lsu_data;                        
input           cp0_yy_be_v1;                        
input           cp0_yy_be_v2;                        
input           cp0_yy_clk_en;                       
input           cp0_yy_machine_mode_aft_dbg;         
input           cpurst_b;                            
input           ctrl_dp_ldst_info_buf_reuse;         
input           ctrl_dp_ldst_req_grnt;               
input           ctrl_dp_store_buffer_updt;           
input           forever_cpuclk;                      
input   [31:0]  iu_lsu_adder_rst;                    
input   [31:0]  iu_lsu_base;                         
input   [31:0]  iu_lsu_data;                         
input           iu_lsu_ex_byte;                      
input           iu_lsu_ex_data_sel;                  
input           iu_lsu_ex_half;                      
input           iu_lsu_ex_uns;                       
input   [31:0]  iu_lsu_imm_data;                     
input           iu_lsu_imm_write_en;                 
input   [31:0]  iu_lsu_offset;                       
input           iu_lsu_oper_mux_en;                  
input   [31:0]  iu_lsu_rs2;                          
input           lsu_inst_store;                      
input           pad_yy_gate_clk_en_b;                
input           pmp_lsu_acc_scu;                     
input           randclk_dp_size_buf_mod_en_w5;       
input           sysmap_lsu_acc_ca;                   
input           unalign_dp_first_req;                
input           unalign_dp_load_data_byte1_to_byte1; 
input           unalign_dp_load_data_byte1_to_byte2; 
input           unalign_dp_load_data_byte1_to_byte3; 
input           unalign_dp_load_data_byte1_to_byte4; 
input           unalign_dp_load_data_byte2_to_byte1; 
input           unalign_dp_load_data_byte2_to_byte2; 
input           unalign_dp_load_data_byte2_to_byte3; 
input           unalign_dp_load_data_byte2_to_byte4; 
input           unalign_dp_load_data_byte3_to_byte1; 
input           unalign_dp_load_data_byte3_to_byte2; 
input           unalign_dp_load_data_byte3_to_byte3; 
input           unalign_dp_load_data_byte3_to_byte4; 
input           unalign_dp_load_data_byte4_to_byte1; 
input           unalign_dp_load_data_byte4_to_byte2; 
input           unalign_dp_load_data_byte4_to_byte3; 
input           unalign_dp_load_data_byte4_to_byte4; 
input           unalign_dp_store_data_byte1_to_byte1; 
input           unalign_dp_store_data_byte1_to_byte2; 
input           unalign_dp_store_data_byte1_to_byte3; 
input           unalign_dp_store_data_byte1_to_byte4; 
input           unalign_dp_store_data_byte2_to_byte1; 
input           unalign_dp_store_data_byte2_to_byte2; 
input           unalign_dp_store_data_byte2_to_byte3; 
input           unalign_dp_store_data_byte2_to_byte4; 
input           unalign_dp_store_data_byte3_to_byte1; 
input           unalign_dp_store_data_byte3_to_byte2; 
input           unalign_dp_store_data_byte3_to_byte3; 
input           unalign_dp_store_data_byte3_to_byte4; 
input           unalign_dp_store_data_byte4_to_byte1; 
input           unalign_dp_store_data_byte4_to_byte2; 
input           unalign_dp_store_data_byte4_to_byte3; 
input           unalign_dp_store_data_byte4_to_byte4; 
output          dp_ctrl_misalign;                    
output  [31:0]  lsu_bmu_addr;                        
output  [3 :0]  lsu_bmu_prot;                        
output  [1 :0]  lsu_bmu_size;                        
output          lsu_bmu_store_error;                 
output  [31:0]  lsu_bmu_wdata;                       
output          lsu_bmu_write;                       
output  [31:0]  lsu_had_addr;                        
output          lsu_had_st;                          
output  [31:0]  lsu_iu_addr;                         
output          lsu_iu_addr_vld;                     
output          lsu_iu_alu_sel;                      
output  [31:0]  lsu_iu_data;                         
output  [31:0]  lsu_iu_mad_buf;                      
output          lsu_iu_store;                        
output  [31:0]  lsu_iu_wb_load_data;                 

// &Regs; @25
reg     [4 :0]  ldst_size_buffer;                    
reg     [1 :0]  lsu_addr_mask;                       
reg     [31:0]  lsu_data_sign_extd;                  
reg             lsu_misalign;                        
reg     [31:0]  lsu_sized_data;                      
reg     [31:0]  lsu_store_wdata;                     
reg     [31:0]  store_data_buffer;                   
reg     [31:0]  store_data_buffer_updt_val;          

// &Wires; @26
wire    [31:0]  bmu_lsu_data;                        
wire    [4 :0]  buffer_ldst_info;                    
wire            cp0_yy_be_v1;                        
wire            cp0_yy_be_v2;                        
wire            cp0_yy_clk_en;                       
wire            cp0_yy_machine_mode_aft_dbg;         
wire            cpurst_b;                            
wire            ctrl_dp_ldst_info_buf_reuse;         
wire            ctrl_dp_ldst_req_grnt;               
wire            ctrl_dp_store_buffer_updt;           
wire            dp_ctrl_misalign;                    
wire            forever_cpuclk;                      
wire    [31:0]  iu_lsu_adder_rst;                    
wire    [31:0]  iu_lsu_data;                         
wire            iu_lsu_ex_byte;                      
wire            iu_lsu_ex_data_sel;                  
wire            iu_lsu_ex_half;                      
wire            iu_lsu_ex_uns;                       
wire    [31:0]  iu_lsu_imm_data;                     
wire            iu_lsu_imm_write_en;                 
wire            iu_lsu_oper_mux_en;                  
wire    [1 :0]  iu_lsu_size;                         
wire    [31:0]  lsu_addr;                            
wire    [1 :0]  lsu_addr_1_0;                        
wire    [1 :0]  lsu_addr_1_0_pre_mux;                
wire    [31:0]  lsu_addr_post;                       
wire    [31:0]  lsu_bmu_addr;                        
wire    [3 :0]  lsu_bmu_prot;                        
wire    [1 :0]  lsu_bmu_size;                        
wire            lsu_bmu_store_error;                 
wire    [31:0]  lsu_bmu_wdata;                       
wire            lsu_bmu_write;                       
wire    [31:0]  lsu_data;                            
wire    [31:0]  lsu_had_addr;                        
wire            lsu_had_st;                          
wire            lsu_inst_store;                      
wire    [31:0]  lsu_iu_addr;                         
wire            lsu_iu_addr_vld;                     
wire            lsu_iu_alu_sel;                      
wire    [31:0]  lsu_iu_data;                         
wire    [31:0]  lsu_iu_mad_buf;                      
wire            lsu_iu_store;                        
wire    [31:0]  lsu_iu_wb_load_data;                 
wire            lsu_sign_exten;                      
wire    [1 :0]  lsu_size;                            
wire    [1 :0]  lsu_size_post;                       
wire    [7 :0]  lsu_sized_data_default;              
wire    [7 :0]  lsu_store_wdata_default;             
wire    [1 :0]  lsu_wb_addr_1_0;                     
wire            lsu_wb_sign_exten;                   
wire    [1 :0]  lsu_wb_size;                         
wire    [31:0]  lsu_wdata;                           
wire            pad_yy_gate_clk_en_b;                
wire            pmp_lsu_acc_scu;                     
wire            randclk_dp_size_buf_mod_en_w5;       
wire            size_buf_clk;                        
wire            size_buf_clk_en;                     
wire            size_buf_en;                         
wire            size_buf_vld;                        
wire            store_buffer_clk;                    
wire            store_buffer_clk_en;                 
wire            store_buffer_updt;                   
wire    [31:0]  store_buffer_updt_data;              
wire            sysmap_lsu_acc_ca;                   
wire            unalign_dp_first_req;                
wire            unalign_dp_load_data_byte1_to_byte1; 
wire            unalign_dp_load_data_byte1_to_byte2; 
wire            unalign_dp_load_data_byte1_to_byte3; 
wire            unalign_dp_load_data_byte1_to_byte4; 
wire            unalign_dp_load_data_byte2_to_byte1; 
wire            unalign_dp_load_data_byte2_to_byte2; 
wire            unalign_dp_load_data_byte2_to_byte3; 
wire            unalign_dp_load_data_byte2_to_byte4; 
wire            unalign_dp_load_data_byte3_to_byte1; 
wire            unalign_dp_load_data_byte3_to_byte2; 
wire            unalign_dp_load_data_byte3_to_byte3; 
wire            unalign_dp_load_data_byte3_to_byte4; 
wire            unalign_dp_load_data_byte4_to_byte1; 
wire            unalign_dp_load_data_byte4_to_byte2; 
wire            unalign_dp_load_data_byte4_to_byte3; 
wire            unalign_dp_load_data_byte4_to_byte4; 
wire            unalign_dp_store_data_byte1_to_byte1; 
wire            unalign_dp_store_data_byte1_to_byte2; 
wire            unalign_dp_store_data_byte1_to_byte3; 
wire            unalign_dp_store_data_byte1_to_byte4; 
wire            unalign_dp_store_data_byte2_to_byte1; 
wire            unalign_dp_store_data_byte2_to_byte2; 
wire            unalign_dp_store_data_byte2_to_byte3; 
wire            unalign_dp_store_data_byte2_to_byte4; 
wire            unalign_dp_store_data_byte3_to_byte1; 
wire            unalign_dp_store_data_byte3_to_byte2; 
wire            unalign_dp_store_data_byte3_to_byte3; 
wire            unalign_dp_store_data_byte3_to_byte4; 
wire            unalign_dp_store_data_byte4_to_byte1; 
wire            unalign_dp_store_data_byte4_to_byte2; 
wire            unalign_dp_store_data_byte4_to_byte3; 
wire            unalign_dp_store_data_byte4_to_byte4; 
wire    [3 :0]  unalign_ld_byte1_sel;                
wire    [3 :0]  unalign_ld_byte2_sel;                
wire    [3 :0]  unalign_ld_byte3_sel;                
wire    [3 :0]  unalign_ld_byte4_sel;                
wire    [3 :0]  unalign_st_byte1_sel;                
wire    [3 :0]  unalign_st_byte2_sel;                
wire    [3 :0]  unalign_st_byte3_sel;                
wire    [3 :0]  unalign_st_byte4_sel;                


//==========================================================
//                 Instance of Gated Cell  
//==========================================================
// &Instance("gated_clk_cell", "x_unalign_buf_gated_clk"); @33
// &Connect(.clk_in      (forever_cpuclk), @34
//          .external_en (1'b0), @35
//          .global_en   (cp0_yy_clk_en), @36
//          .module_en   (randclk_dp_unalign_buf_mod_en_w24), @37
//          .local_en    (unalign_buf_en), @38
//          .clk_out     (unalign_buf_clk)); @39

assign size_buf_vld = !lsu_inst_store;
assign size_buf_en = ctrl_dp_ldst_info_buf_reuse
                     && unalign_dp_first_req
                     && size_buf_vld;
assign size_buf_clk_en = (ctrl_dp_ldst_info_buf_reuse || ctrl_dp_ldst_req_grnt)
                     && unalign_dp_first_req
                     && size_buf_vld;
// &Instance("gated_clk_cell", "x_size_buf_gated_clk"); @54
gated_clk_cell  x_size_buf_gated_clk (
  .clk_in                        (forever_cpuclk               ),
  .clk_out                       (size_buf_clk                 ),
  .external_en                   (1'b0                         ),
  .global_en                     (cp0_yy_clk_en                ),
  .local_en                      (size_buf_clk_en              ),
  .module_en                     (randclk_dp_size_buf_mod_en_w5),
  .pad_yy_gate_clk_en_b          (pad_yy_gate_clk_en_b         )
);

// &Connect(.clk_in      (forever_cpuclk), @55
//          .external_en (1'b0), @56
//          .global_en   (cp0_yy_clk_en), @57
//          .module_en   (randclk_dp_size_buf_mod_en_w5), @58
//          .local_en    (size_buf_clk_en), @59
//          .clk_out     (size_buf_clk)); @60
// &Instance("gated_clk_cell", "x_size_buf_gated_clk"); @67
// &Connect(.clk_in      (forever_cpuclk), @68
//          .external_en (1'b0), @69
//          .global_en   (cp0_yy_clk_en), @70
//          .module_en   (randclk_dp_size_buf_mod_en_w5), @71
//          .local_en    (size_buf_en), @72
//          .clk_out     (size_buf_clk)); @73

// &Instance("gated_clk_cell", "x_bspval_gated_clk"); @80
// &Connect(.clk_in      (forever_cpuclk), @81
//          .external_en (1'b0), @82
//          .global_en   (cp0_yy_clk_en), @83
//          .module_en   (randclk_dp_bspval_mod_en_w32), @84
//          .local_en    (bspval_en), @85
//          .clk_out     (bspval_clk)); @86

//==========================================================
//                    Operands Mux
//==========================================================
// &Force("bus","iu_lsu_ldr_shift",3,0); @93
//Mask critical logic operands to reduce combinational logic
//power
assign iu_lsu_size[1:0]   = iu_lsu_ex_byte ? 2'b00 : iu_lsu_ex_half ? 2'b01 : 2'b10;
assign lsu_wdata[31:0]    = {32{iu_lsu_oper_mux_en}} & iu_lsu_data[31:0];
assign lsu_size[1:0]      = iu_lsu_size[1:0];
assign lsu_addr_1_0[1:0]  = lsu_addr_1_0_pre_mux[1:0];
assign lsu_sign_exten     = !iu_lsu_ex_uns;

assign lsu_data[31:0]     = bmu_lsu_data[31:0];

//==========================================================
//                address prepare
//==========================================================
parameter BYTE = 2'b00, HALF = 2'b01, WORD = 2'b10;
parameter LE = 2'b00;
parameter BE_V1 = 2'b10, BE_V2 = 2'b01;

//assign lsu_addr_offset[31:0] = lsu_offset[31:0];

// &Force("input", "iu_lsu_base"); @135
// &Force("bus", "iu_lsu_base", 31, 0); @136
// &Force("input", "iu_lsu_rs2"); @137
// &Force("bus", "iu_lsu_rs2", 31, 0); @138
// &Force("input", "iu_lsu_offset"); @139
// &Force("bus", "iu_lsu_offset", 31, 0); @140
assign lsu_iu_alu_sel = iu_lsu_oper_mux_en;
assign lsu_addr[31:0] = {32{iu_lsu_oper_mux_en}} & iu_lsu_adder_rst[31:0];


assign lsu_bmu_store_error = 1'b0;

// &Force("output", "lsu_bmu_addr"); @148
// &Force("bus","lsu_bmu_addr",31,0); @149
assign lsu_bmu_addr[31:0]      = lsu_addr_post[31:0];
assign lsu_bmu_size[1:0]       = lsu_size_post[1:0];
assign lsu_bmu_prot[3:0]       = {sysmap_lsu_acc_ca,
                                  pmp_lsu_acc_scu,
                                  cp0_yy_machine_mode_aft_dbg,
                                  1'b1};

// &CombBeg; @171
// &CombEnd; @177
// &CombBeg; @218
always @( lsu_size[1:0])
begin
  case(lsu_size[1:0])
    WORD : lsu_addr_mask[1:0] = 2'b00;
    HALF : lsu_addr_mask[1:0] = 2'b10;
    default     : lsu_addr_mask[1:0] = 2'b11;
  endcase
// &CombEnd; @224
end

assign lsu_addr_1_0_pre_mux[1:0]  = lsu_addr_mask[1:0] & lsu_addr[1:0];

// &CombBeg; @228
always @( lsu_addr[1:0]
       or lsu_size[1:0])
begin
  case(lsu_size[1:0])
    WORD    : lsu_misalign = | lsu_addr[1:0];
    HALF    : lsu_misalign = lsu_addr[0];
    default : lsu_misalign = 1'b0;
  endcase
// &CombEnd; @234
end

assign dp_ctrl_misalign = lsu_misalign;
assign lsu_size_post[1:0] = lsu_size[1:0];
//when not UNALIGN_LOAD_STORE, the addr of ld st is from ALU adder
assign lsu_addr_post[31:0] = {lsu_addr[31:2], lsu_addr_1_0[1:0]};



//==========================================================
//               write data and write valid
//==========================================================
assign lsu_bmu_write = lsu_inst_store && iu_lsu_ex_data_sel;
assign lsu_iu_store  = lsu_inst_store;

assign unalign_st_byte1_sel[3:0] = {unalign_dp_store_data_byte1_to_byte1,
                                    unalign_dp_store_data_byte2_to_byte1,
                                    unalign_dp_store_data_byte3_to_byte1,
                                    unalign_dp_store_data_byte4_to_byte1};

assign lsu_store_wdata_default[7:0] = 8'b0;

// &CombBeg; @263
always @( lsu_addr_1_0[1:0]
       or unalign_st_byte1_sel[3:0]
       or cp0_yy_be_v2
       or lsu_size[1:0]
       or lsu_wdata[7:0]
       or lsu_wdata[31:8]
       or lsu_store_wdata_default[7:0]
       or cp0_yy_be_v1)
begin
  lsu_store_wdata[7:0]  = lsu_store_wdata_default[7:0];
  casez({unalign_st_byte1_sel[3:0],cp0_yy_be_v1,cp0_yy_be_v2,lsu_size[1:0],lsu_addr_1_0[1:0]})
    {4'b1000,2'b??,2'b??,2'b??} : lsu_store_wdata[7:0]  = lsu_wdata[7:0];
    {4'b0100,2'b??,2'b??,2'b??} : lsu_store_wdata[7:0]  = lsu_wdata[15:8];
    {4'b0010,2'b??,2'b??,2'b??} : lsu_store_wdata[7:0]  = lsu_wdata[23:16];
    {4'b0001,2'b??,2'b??,2'b??} : lsu_store_wdata[7:0]  = lsu_wdata[31:24];
    {4'b0000,BE_V1,BYTE, 2'b11} : lsu_store_wdata[7:0]  = lsu_wdata[7:0];
    {4'b0000,BE_V1,HALF, 2'b1?} : lsu_store_wdata[7:0]  = lsu_wdata[7:0];
    {4'b0000,BE_V1,WORD, 2'b??} : lsu_store_wdata[7:0]  = lsu_wdata[7:0];
    {4'b0000,BE_V2,BYTE, 2'b00} : lsu_store_wdata[7:0]  = lsu_wdata[7:0];
    {4'b0000,BE_V2,HALF, 2'b0?} : lsu_store_wdata[7:0]  = lsu_wdata[15:8];
    {4'b0000,BE_V2,WORD, 2'b??} : lsu_store_wdata[7:0]  = lsu_wdata[31:24];
    {4'b0000,LE   ,BYTE, 2'b00} : lsu_store_wdata[7:0]  = lsu_wdata[7:0];
    {4'b0000,LE   ,HALF, 2'b0?} : lsu_store_wdata[7:0]  = lsu_wdata[7:0];
    {4'b0000,LE   ,WORD, 2'b??} : lsu_store_wdata[7:0]  = lsu_wdata[7:0];
  endcase
// &CombEnd; @280
end


assign unalign_st_byte2_sel[3:0] = {unalign_dp_store_data_byte1_to_byte2,
                                    unalign_dp_store_data_byte2_to_byte2,
                                    unalign_dp_store_data_byte3_to_byte2,
                                    unalign_dp_store_data_byte4_to_byte2};

// &CombBeg; @288
always @( lsu_addr_1_0[1:0]
       or cp0_yy_be_v2
       or lsu_size[1:0]
       or lsu_wdata[7:0]
       or lsu_wdata[31:8]
       or lsu_store_wdata_default[7:0]
       or cp0_yy_be_v1
       or unalign_st_byte2_sel[3:0])
begin
  lsu_store_wdata[15:8]  = lsu_store_wdata_default[7:0];
  casez({unalign_st_byte2_sel[3:0],cp0_yy_be_v1,cp0_yy_be_v2,lsu_size[1:0],lsu_addr_1_0[1:0]})
    {4'b1000,2'b??,2'b??,2'b??} : lsu_store_wdata[15:8]  = lsu_wdata[7:0];
    {4'b0100,2'b??,2'b??,2'b??} : lsu_store_wdata[15:8]  = lsu_wdata[15:8];
    {4'b0010,2'b??,2'b??,2'b??} : lsu_store_wdata[15:8]  = lsu_wdata[23:16];
    {4'b0001,2'b??,2'b??,2'b??} : lsu_store_wdata[15:8]  = lsu_wdata[31:24];
    {4'b0000,BE_V1,BYTE, 2'b10} : lsu_store_wdata[15:8]  = lsu_wdata[7:0];
    {4'b0000,BE_V1,HALF, 2'b1?} : lsu_store_wdata[15:8]  = lsu_wdata[15:8];
    {4'b0000,BE_V1,WORD, 2'b??} : lsu_store_wdata[15:8]  = lsu_wdata[15:8];
    {4'b0000,BE_V2,BYTE, 2'b01} : lsu_store_wdata[15:8]  = lsu_wdata[7:0];
    {4'b0000,BE_V2,HALF, 2'b0?} : lsu_store_wdata[15:8]  = lsu_wdata[7:0];
    {4'b0000,BE_V2,WORD, 2'b??} : lsu_store_wdata[15:8]  = lsu_wdata[23:16];
    {4'b0000,LE   ,BYTE, 2'b01} : lsu_store_wdata[15:8]  = lsu_wdata[7:0];
    {4'b0000,LE   ,HALF, 2'b0?} : lsu_store_wdata[15:8]  = lsu_wdata[15:8];
    {4'b0000,LE   ,WORD, 2'b??} : lsu_store_wdata[15:8]  = lsu_wdata[15:8];
  endcase
// &CombEnd; @305
end


assign unalign_st_byte3_sel[3:0] = {unalign_dp_store_data_byte1_to_byte3,
                                    unalign_dp_store_data_byte2_to_byte3,
                                    unalign_dp_store_data_byte3_to_byte3,
                                    unalign_dp_store_data_byte4_to_byte3};

// &CombBeg; @313
always @( lsu_addr_1_0[1:0]
       or cp0_yy_be_v2
       or unalign_st_byte3_sel[3:0]
       or lsu_size[1:0]
       or lsu_wdata[7:0]
       or lsu_wdata[31:8]
       or lsu_store_wdata_default[7:0]
       or cp0_yy_be_v1)
begin
  lsu_store_wdata[23:16]  = lsu_store_wdata_default[7:0];
  casez({unalign_st_byte3_sel[3:0],cp0_yy_be_v1,cp0_yy_be_v2,lsu_size[1:0],lsu_addr_1_0[1:0]})
    {4'b1000,2'b??,2'b??,2'b??} : lsu_store_wdata[23:16] = lsu_wdata[7:0];
    {4'b0100,2'b??,2'b??,2'b??} : lsu_store_wdata[23:16] = lsu_wdata[15:8];
    {4'b0010,2'b??,2'b??,2'b??} : lsu_store_wdata[23:16] = lsu_wdata[23:16];
    {4'b0001,2'b??,2'b??,2'b??} : lsu_store_wdata[23:16] = lsu_wdata[31:24];
    {4'b0000,BE_V1,BYTE, 2'b01} : lsu_store_wdata[23:16] = lsu_wdata[7:0];
    {4'b0000,BE_V1,HALF, 2'b0?} : lsu_store_wdata[23:16] = lsu_wdata[7:0];
    {4'b0000,BE_V1,WORD, 2'b??} : lsu_store_wdata[23:16] = lsu_wdata[23:16];
    {4'b0000,BE_V2,BYTE, 2'b10} : lsu_store_wdata[23:16] = lsu_wdata[7:0];
    {4'b0000,BE_V2,HALF, 2'b1?} : lsu_store_wdata[23:16] = lsu_wdata[15:8];
    {4'b0000,BE_V2,WORD, 2'b??} : lsu_store_wdata[23:16] = lsu_wdata[15:8];
    {4'b0000,LE   ,BYTE, 2'b10} : lsu_store_wdata[23:16] = lsu_wdata[7:0];
    {4'b0000,LE   ,HALF, 2'b1?} : lsu_store_wdata[23:16] = lsu_wdata[7:0];
    {4'b0000,LE   ,WORD, 2'b??} : lsu_store_wdata[23:16] = lsu_wdata[23:16];
  endcase
// &CombEnd; @330
end


assign unalign_st_byte4_sel[3:0] = {unalign_dp_store_data_byte1_to_byte4,
                                    unalign_dp_store_data_byte2_to_byte4,
                                    unalign_dp_store_data_byte3_to_byte4,
                                    unalign_dp_store_data_byte4_to_byte4};

// &CombBeg; @338
always @( lsu_addr_1_0[1:0]
       or cp0_yy_be_v2
       or lsu_size[1:0]
       or lsu_wdata[7:0]
       or lsu_wdata[31:8]
       or lsu_store_wdata_default[7:0]
       or cp0_yy_be_v1
       or unalign_st_byte4_sel[3:0])
begin
  lsu_store_wdata[31:24]  = lsu_store_wdata_default[7:0];
  casez({unalign_st_byte4_sel[3:0],cp0_yy_be_v1,cp0_yy_be_v2,lsu_size[1:0],lsu_addr_1_0[1:0]})
    {4'b1000,2'b??,2'b??,2'b??} : lsu_store_wdata[31:24] = lsu_wdata[7:0];
    {4'b0100,2'b??,2'b??,2'b??} : lsu_store_wdata[31:24] = lsu_wdata[15:8];
    {4'b0010,2'b??,2'b??,2'b??} : lsu_store_wdata[31:24] = lsu_wdata[23:16];
    {4'b0001,2'b??,2'b??,2'b??} : lsu_store_wdata[31:24] = lsu_wdata[31:24];
    {4'b0000,BE_V1,BYTE, 2'b00} : lsu_store_wdata[31:24] = lsu_wdata[7:0];
    {4'b0000,BE_V1,HALF, 2'b0?} : lsu_store_wdata[31:24] = lsu_wdata[15:8];
    {4'b0000,BE_V1,WORD, 2'b??} : lsu_store_wdata[31:24] = lsu_wdata[31:24];
    {4'b0000,BE_V2,BYTE, 2'b11} : lsu_store_wdata[31:24] = lsu_wdata[7:0];
    {4'b0000,BE_V2,HALF, 2'b1?} : lsu_store_wdata[31:24] = lsu_wdata[7:0];
    {4'b0000,BE_V2,WORD, 2'b??} : lsu_store_wdata[31:24] = lsu_wdata[7:0];
    {4'b0000,LE   ,BYTE, 2'b11} : lsu_store_wdata[31:24] = lsu_wdata[7:0];
    {4'b0000,LE   ,HALF, 2'b1?} : lsu_store_wdata[31:24] = lsu_wdata[15:8];
    {4'b0000,LE   ,WORD, 2'b??} : lsu_store_wdata[31:24] = lsu_wdata[31:24];
  endcase
// &CombEnd; @355
end

//==========================================================
//                     Write Buffer
//==========================================================
//the write data should be buffered, to make store fast retire
//pre buffer:
assign store_buffer_clk_en = store_buffer_updt;
// &Instance("gated_clk_cell", "x_store_buffer_clk"); @364
gated_clk_cell  x_store_buffer_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (store_buffer_clk    ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (store_buffer_clk_en ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in      (forever_cpuclk), @365
//          .external_en (1'b0), @366
//          .global_en   (cp0_yy_clk_en), @367
//          .module_en   (1'b0), @368
//          .local_en    (store_buffer_clk_en), @369
//          .clk_out     (store_buffer_clk)); @370

assign store_buffer_updt = ctrl_dp_store_buffer_updt
                        || iu_lsu_imm_write_en;
assign store_buffer_updt_data[31:0] = 
                       {32{ctrl_dp_store_buffer_updt}} & lsu_store_wdata[31:0]
                     | {32{iu_lsu_imm_write_en}}       & iu_lsu_imm_data[31:0];          
// &CombBeg; @377
always @( store_buffer_updt_data[31:0]
       or store_buffer_updt
       or store_data_buffer[31:0])
begin
  if(store_buffer_updt)
    store_data_buffer_updt_val[31:0] = store_buffer_updt_data[31:0];
  else
    store_data_buffer_updt_val[31:0] = store_data_buffer[31:0];
// &CombEnd; @382
end

always @(posedge store_buffer_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    store_data_buffer[31:0] <= 32'b0;
  else 
    store_data_buffer[31:0] <= store_data_buffer_updt_val[31:0];
end

assign lsu_bmu_wdata[31:0] = store_data_buffer[31:0];
assign lsu_iu_mad_buf[31:0] = store_data_buffer[31:0];

// &Force("input", "ctrl_dp_store_buffer_updt"); @401

//==========================================================
//               Load data process
//==========================================================
//buffer the size information of load instruction, used for
//size and endian adjust
assign buffer_ldst_info[4:0] = {lsu_sign_exten,
                                lsu_size[1:0],
                                lsu_addr_1_0[1:0]};

always @(posedge size_buf_clk)
begin
  if(size_buf_en)
    ldst_size_buffer[4:0] <= buffer_ldst_info[4:0];
end

//wb size information
assign lsu_wb_addr_1_0[1:0] = ldst_size_buffer[1:0];
assign lsu_wb_size[1:0]     = ldst_size_buffer[3:2];
assign lsu_wb_sign_exten    = ldst_size_buffer[4];



assign unalign_ld_byte1_sel[3:0] = {unalign_dp_load_data_byte1_to_byte1,
                                    unalign_dp_load_data_byte2_to_byte1, 
                                    unalign_dp_load_data_byte3_to_byte1,
                                    unalign_dp_load_data_byte4_to_byte1};

assign lsu_sized_data_default[7:0] = 8'b0;

//endian transfer
// &CombBeg; @477
always @( lsu_wb_size[1:0]
       or unalign_ld_byte1_sel[3:0]
       or lsu_wb_addr_1_0[1:0]
       or cp0_yy_be_v2
       or lsu_data[31:16]
       or cp0_yy_be_v1
       or lsu_sized_data_default[7:0]
       or lsu_data[15:0])
begin
  lsu_sized_data[7:0]  = lsu_sized_data_default[7:0];
  casez({unalign_ld_byte1_sel[3:0],cp0_yy_be_v1,cp0_yy_be_v2,lsu_wb_size[1:0],lsu_wb_addr_1_0[1:0]})
    {4'b1000,2'b??,2'b??,2'b??} : lsu_sized_data[7:0]  = lsu_data[7:0];
    {4'b0100,2'b??,2'b??,2'b??} : lsu_sized_data[7:0]  = lsu_data[15:8];
    {4'b0010,2'b??,2'b??,2'b??} : lsu_sized_data[7:0]  = lsu_data[23:16];
    {4'b0001,2'b??,2'b??,2'b??} : lsu_sized_data[7:0]  = lsu_data[31:24];
    {4'b0000,BE_V1,BYTE, 2'b00} : lsu_sized_data[7:0]  = lsu_data[31:24];
    {4'b0000,BE_V1,BYTE, 2'b01} : lsu_sized_data[7:0]  = lsu_data[23:16];
    {4'b0000,BE_V1,BYTE, 2'b10} : lsu_sized_data[7:0]  = lsu_data[15:8];
    {4'b0000,BE_V1,BYTE, 2'b11} : lsu_sized_data[7:0]  = lsu_data[7:0];
    {4'b0000,BE_V1,HALF, 2'b0?} : lsu_sized_data[7:0]  = lsu_data[23:16];
    {4'b0000,BE_V1,HALF, 2'b1?} : lsu_sized_data[7:0]  = lsu_data[7:0];
    {4'b0000,BE_V1,WORD, 2'b??} : lsu_sized_data[7:0]  = lsu_data[7:0];
    {4'b0000,BE_V2,BYTE, 2'b00} : lsu_sized_data[7:0]  = lsu_data[7:0];
    {4'b0000,BE_V2,BYTE, 2'b01} : lsu_sized_data[7:0]  = lsu_data[15:8];
    {4'b0000,BE_V2,BYTE, 2'b10} : lsu_sized_data[7:0]  = lsu_data[23:16];
    {4'b0000,BE_V2,BYTE, 2'b11} : lsu_sized_data[7:0]  = lsu_data[31:24];
    {4'b0000,BE_V2,HALF, 2'b0?} : lsu_sized_data[7:0]  = lsu_data[15:8];
    {4'b0000,BE_V2,HALF, 2'b1?} : lsu_sized_data[7:0]  = lsu_data[31:24];
    {4'b0000,BE_V2,WORD, 2'b??} : lsu_sized_data[7:0]  = lsu_data[31:24];
    {4'b0000,LE   ,BYTE, 2'b00} : lsu_sized_data[7:0]  = lsu_data[7:0];
    {4'b0000,LE   ,BYTE, 2'b01} : lsu_sized_data[7:0]  = lsu_data[15:8];
    {4'b0000,LE   ,BYTE, 2'b10} : lsu_sized_data[7:0]  = lsu_data[23:16];
    {4'b0000,LE   ,BYTE, 2'b11} : lsu_sized_data[7:0]  = lsu_data[31:24];
    {4'b0000,LE   ,HALF, 2'b0?} : lsu_sized_data[7:0]  = lsu_data[7:0];
    {4'b0000,LE   ,HALF, 2'b1?} : lsu_sized_data[7:0]  = lsu_data[23:16];
    {4'b0000,LE   ,WORD, 2'b??} : lsu_sized_data[7:0]  = lsu_data[7:0];
  endcase
// &CombEnd; @506
end


assign unalign_ld_byte2_sel[3:0] = {unalign_dp_load_data_byte1_to_byte2,
                                    unalign_dp_load_data_byte2_to_byte2,
                                    unalign_dp_load_data_byte3_to_byte2,
                                    unalign_dp_load_data_byte4_to_byte2};
//endian transfer
// &CombBeg; @514
always @( lsu_wb_size[1:0]
       or lsu_wb_addr_1_0[1:0]
       or cp0_yy_be_v2
       or lsu_data[31:16]
       or cp0_yy_be_v1
       or lsu_sized_data_default[7:0]
       or lsu_data[15:0]
       or unalign_ld_byte2_sel[3:0])
begin
  lsu_sized_data[15:8]  = lsu_sized_data_default[7:0];
  casez({unalign_ld_byte2_sel[3:0],cp0_yy_be_v1,cp0_yy_be_v2,lsu_wb_size[1:0],lsu_wb_addr_1_0[1:0]})
    {4'b1000,2'b??,2'b??,2'b??} : lsu_sized_data[15:8] = lsu_data[7:0];
    {4'b0100,2'b??,2'b??,2'b??} : lsu_sized_data[15:8] = lsu_data[15:8];
    {4'b0010,2'b??,2'b??,2'b??} : lsu_sized_data[15:8] = lsu_data[23:16];
    {4'b0001,2'b??,2'b??,2'b??} : lsu_sized_data[15:8] = lsu_data[31:24];
    {4'b0000,BE_V1,HALF, 2'b0?} : lsu_sized_data[15:8] = lsu_data[31:24];
    {4'b0000,BE_V1,HALF, 2'b1?} : lsu_sized_data[15:8] = lsu_data[15:8];
    {4'b0000,BE_V1,WORD, 2'b??} : lsu_sized_data[15:8] = lsu_data[15:8];
    {4'b0000,BE_V2,HALF, 2'b0?} : lsu_sized_data[15:8] = lsu_data[7:0];
    {4'b0000,BE_V2,HALF, 2'b1?} : lsu_sized_data[15:8] = lsu_data[23:16];
    {4'b0000,BE_V2,WORD, 2'b??} : lsu_sized_data[15:8] = lsu_data[23:16];
    {4'b0000,LE   ,HALF, 2'b0?} : lsu_sized_data[15:8] = lsu_data[15:8];
    {4'b0000,LE   ,HALF, 2'b1?} : lsu_sized_data[15:8] = lsu_data[31:24];
    {4'b0000,LE   ,WORD, 2'b??} : lsu_sized_data[15:8] = lsu_data[15:8];
  endcase
// &CombEnd; @531
end


assign unalign_ld_byte3_sel[3:0] = {unalign_dp_load_data_byte1_to_byte3,
                                    unalign_dp_load_data_byte2_to_byte3,
                                    unalign_dp_load_data_byte3_to_byte3,
                                    unalign_dp_load_data_byte4_to_byte3};
//endian transfer
// &CombBeg; @539
always @( lsu_wb_size[1:0]
       or lsu_wb_addr_1_0[1:0]
       or cp0_yy_be_v2
       or lsu_data[31:16]
       or cp0_yy_be_v1
       or lsu_sized_data_default[7:0]
       or unalign_ld_byte3_sel[3:0]
       or lsu_data[15:0])
begin
  lsu_sized_data[23:16]  = lsu_sized_data_default[7:0];
  casez({unalign_ld_byte3_sel[3:0],cp0_yy_be_v1,cp0_yy_be_v2,lsu_wb_size[1:0],lsu_wb_addr_1_0[1:0]})
    {4'b1000,2'b??,2'b??,2'b??} : lsu_sized_data[23:16] = lsu_data[7:0];
    {4'b0100,2'b??,2'b??,2'b??} : lsu_sized_data[23:16] = lsu_data[15:8];
    {4'b0010,2'b??,2'b??,2'b??} : lsu_sized_data[23:16] = lsu_data[23:16];
    {4'b0001,2'b??,2'b??,2'b??} : lsu_sized_data[23:16] = lsu_data[31:24];
    {4'b0000,BE_V1,WORD ,2'b??} : lsu_sized_data[23:16] = lsu_data[23:16];
    {4'b0000,BE_V2,WORD ,2'b??} : lsu_sized_data[23:16] = lsu_data[15:8];
    {4'b0000,LE   ,WORD ,2'b??} : lsu_sized_data[23:16] = lsu_data[23:16];
  endcase
// &CombEnd; @550
end


assign unalign_ld_byte4_sel[3:0] = {unalign_dp_load_data_byte1_to_byte4,
                                    unalign_dp_load_data_byte2_to_byte4,
                                    unalign_dp_load_data_byte3_to_byte4, 
                                    unalign_dp_load_data_byte4_to_byte4};
//endian transfer
// &CombBeg; @558
always @( lsu_wb_size[1:0]
       or lsu_wb_addr_1_0[1:0]
       or cp0_yy_be_v2
       or lsu_data[31:16]
       or cp0_yy_be_v1
       or lsu_sized_data_default[7:0]
       or unalign_ld_byte4_sel[3:0]
       or lsu_data[15:0])
begin
  lsu_sized_data[31:24]  = lsu_sized_data_default[7:0];
  casez({unalign_ld_byte4_sel[3:0],cp0_yy_be_v1,cp0_yy_be_v2,lsu_wb_size[1:0],lsu_wb_addr_1_0[1:0]})
    {4'b1000,2'b??,2'b??,2'b??} : lsu_sized_data[31:24] = lsu_data[7:0];
    {4'b0100,2'b??,2'b??,2'b??} : lsu_sized_data[31:24] = lsu_data[15:8];
    {4'b0010,2'b??,2'b??,2'b??} : lsu_sized_data[31:24] = lsu_data[23:16];
    {4'b0001,2'b??,2'b??,2'b??} : lsu_sized_data[31:24] = lsu_data[31:24];
    {4'b0000,BE_V1,WORD ,2'b??} : lsu_sized_data[31:24] = lsu_data[31:24];
    {4'b0000,BE_V2,WORD ,2'b??} : lsu_sized_data[31:24] = lsu_data[7:0];
    {4'b0000,LE   ,WORD ,2'b??} : lsu_sized_data[31:24] = lsu_data[31:24];
  endcase
// &CombEnd; @569
end

//sign extension
// &CombBeg; @572
always @( lsu_wb_size[1:0]
       or lsu_sized_data[31:0]
       or lsu_wb_sign_exten)
begin
  case({lsu_wb_sign_exten,lsu_wb_size[1:0]})
    {1'b1,BYTE} : lsu_data_sign_extd[31:0] = {{24{lsu_sized_data[7]}},lsu_sized_data[7:0]};
    {1'b1,HALF} : lsu_data_sign_extd[31:0] = {{16{lsu_sized_data[15]}},lsu_sized_data[15:0]};
    default     : lsu_data_sign_extd[31:0] = lsu_sized_data[31:0];
  endcase
// &CombEnd; @578
end


// &CombBeg; @622
// &CombEnd; @632
//the dbus data at EX stage to RBUS
assign lsu_iu_data[31:0] = lsu_data_sign_extd[31:0];

//when LOAD_FAST_RETIRE, the data from dbus at WB stage will be sent to WB to
//write back
assign lsu_iu_wb_load_data[31:0] = lsu_data_sign_extd[31:0];

assign lsu_iu_addr_vld   = iu_lsu_ex_data_sel;
assign lsu_iu_addr[31:0] = lsu_addr[31:0];

//==========================================================
//               interface to had
//==========================================================
assign lsu_had_st         = lsu_inst_store;
assign lsu_had_addr[31:0] = lsu_bmu_addr[31:0];

// &ModuleEnd; @677
endmodule



