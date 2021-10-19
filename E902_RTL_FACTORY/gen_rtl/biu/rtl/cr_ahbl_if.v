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
module cr_ahbl_if(
  ahbLif_ahbl_haddr,
  ahbLif_ahbl_hburst,
  ahbLif_ahbl_hprot,
  ahbLif_ahbl_hsize,
  ahbLif_ahbl_htrans,
  ahbLif_ahbl_hwdata,
  ahbLif_ahbl_hwrite,
  ahbl_ahbLif_hrdata,
  ahbl_ahbLif_hready,
  ahbl_ahbLif_hresp,
  ahbl_clk_en,
  ahbl_gated_clk,
  ahblif_busy,
  ahblif_idle,
  ahblif_power_mask,
  cpu_acc_err,
  cpu_addr,
  cpu_data_vld,
  cpu_prot,
  cpu_rdata,
  cpu_req,
  cpu_req_grnt,
  cpu_req_power_masked,
  cpu_sec,
  cpu_size,
  cpu_trans_cmplt,
  cpu_vec_redirect,
  cpu_wdata_sel,
  cpu_wr_data,
  cpu_write,
  cpurst_b,
  pad_cpu_halt_ff2
);

// &Ports; @24
input   [31:0]  ahbl_ahbLif_hrdata;    
input           ahbl_ahbLif_hready;    
input           ahbl_ahbLif_hresp;     
input           ahbl_gated_clk;        
input           ahblif_power_mask;     
input   [31:0]  cpu_addr;              
input   [3 :0]  cpu_prot;              
input           cpu_req;               
input           cpu_req_power_masked;  
input   [1 :0]  cpu_size;              
input           cpu_vec_redirect;      
input   [31:0]  cpu_wr_data;           
input           cpu_write;             
input           cpurst_b;              
input           pad_cpu_halt_ff2;      
output  [31:0]  ahbLif_ahbl_haddr;     
output  [2 :0]  ahbLif_ahbl_hburst;    
output  [3 :0]  ahbLif_ahbl_hprot;     
output  [2 :0]  ahbLif_ahbl_hsize;     
output  [1 :0]  ahbLif_ahbl_htrans;    
output  [31:0]  ahbLif_ahbl_hwdata;    
output          ahbLif_ahbl_hwrite;    
output          ahbl_clk_en;           
output          ahblif_busy;           
output          ahblif_idle;           
output          cpu_acc_err;           
output          cpu_data_vld;          
output  [31:0]  cpu_rdata;             
output          cpu_req_grnt;          
output          cpu_sec;               
output          cpu_trans_cmplt;       
output          cpu_wdata_sel;         

// &Regs; @25
reg     [2 :0]  ahbLif_cur_state;      
reg     [2 :0]  ahbLif_nxt_state;      
reg             buf_write;             

// &Wires; @26
wire            acc_err;               
wire    [31:0]  ahbLif_ahbl_haddr;     
wire    [2 :0]  ahbLif_ahbl_hburst;    
wire    [3 :0]  ahbLif_ahbl_hprot;     
wire    [2 :0]  ahbLif_ahbl_hsize;     
wire    [1 :0]  ahbLif_ahbl_htrans;    
wire    [31:0]  ahbLif_ahbl_hwdata;    
wire            ahbLif_ahbl_hwrite;    
wire            ahbLif_ahbl_vec_redrct; 
wire    [31:0]  ahbl_ahbLif_hrdata;    
wire            ahbl_ahbLif_hready;    
wire            ahbl_ahbLif_hresp;     
wire            ahbl_ahbLif_hsec;      
wire            ahbl_clk_en;           
wire            ahbl_gated_clk;        
wire            ahblif_busy;           
wire            ahblif_idle;           
wire            ahblif_power_mask;     
wire    [31:0]  bus_rdata;             
wire            bus_ready;             
wire            bus_resp;              
wire            bus_sec;               
wire            cpu_acc_err;           
wire    [31:0]  cpu_addr;              
wire            cpu_data_vld;          
wire    [3 :0]  cpu_prot;              
wire    [31:0]  cpu_rdata;             
wire            cpu_req;               
wire            cpu_req_grnt;          
wire            cpu_req_power_masked;  
wire            cpu_sec;               
wire    [1 :0]  cpu_size;              
wire            cpu_trans_cmplt;       
wire            cpu_vec_redirect;      
wire            cpu_wdata_sel;         
wire    [31:0]  cpu_wr_data;           
wire            cpu_write;             
wire            cpurst_b;              
wire            data_vld;              
wire    [31:0]  hwdata;                
wire            pad_cpu_halt_ff2;      
wire            req_grnt;              
wire            trans_cmplt;           


parameter DATA_WIDTH = 32;
//==============================================================================
//
//                 AHB LITE master interface FSM
//
//==============================================================================
//1. control one transfer: SINGLE
//2. generate control signals for AHB LITE control signals: HTRANS, HCTRL

//===================================================================
//     parameter description
//IDLE  : wait for the cpu request; when cpu has request and hready, 
//        control information is put on the AHB LITE in this state.
//WFD   : wait for the data from the AHB LITE; if back-to-back 
//        transfer occur, the fsm will stay in the state.
//ERROR : wait for the second phase of the two signal error response.
//ERROR1: generate the error vld signal to cpu.
//===================================================================
parameter IDLE   = 3'b000,
          WFD    = 3'b001,
          WFG    = 3'b010,
          ERROR1 = 3'b110,
          ERROR2 = 3'b111;

//==========================================================
//     FSM main body
//==========================================================
always@(posedge ahbl_gated_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ahbLif_cur_state[2:0] <= IDLE;
  else
  begin
      ahbLif_cur_state[2:0] <= ahbLif_nxt_state[2:0];
  end
end 

// &CombBeg; @65
always @( cpu_req_power_masked
       or bus_ready
       or ahbLif_cur_state
       or cpu_req
       or bus_resp
       or pad_cpu_halt_ff2)
begin
case(ahbLif_cur_state)
  IDLE: 
  begin
    if(cpu_req_power_masked && !pad_cpu_halt_ff2) 
      if(bus_ready)
        ahbLif_nxt_state = WFD;
      else //no ready
        ahbLif_nxt_state = WFG;
    else //no request
      ahbLif_nxt_state = IDLE;
  end
  WFG: 
  begin
    if(cpu_req)
      if(bus_ready)
        ahbLif_nxt_state = WFD;
      else //no ready
        ahbLif_nxt_state = WFG;
    else //no request
      ahbLif_nxt_state = IDLE;
  end
  WFD:   // in this state AHBL wait for the data.
  begin
    if(bus_resp) //resp is ERROR
      ahbLif_nxt_state = ERROR1;
    else if(!bus_ready) //resp == OK, hready == 0
      ahbLif_nxt_state = WFD;
    else //resp == OK, hready == 1
    begin
      if(cpu_req)
        ahbLif_nxt_state = WFD;
      else
        ahbLif_nxt_state = IDLE;
    end
  end
  ERROR1: // error occurs
  begin
    if(bus_resp)               // resp is ERROR
      if(!bus_ready)           // ready == 0
        ahbLif_nxt_state = ERROR1;
      else
        ahbLif_nxt_state = ERROR2; // bus resp is ERROR, hready == 1
    else
      ahbLif_nxt_state = ERROR2; // bus resp is ERROR, hready == 1
  end
  ERROR2: // error occurs
  begin
    ahbLif_nxt_state = IDLE; 
  end
  default:
    ahbLif_nxt_state = IDLE;
endcase
// &CombEnd; @118
end

//===========================================================
//     FSM output signal 
//===========================================================

always @( posedge ahbl_gated_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    buf_write <= 1'b0;
  else if(cpu_req && req_grnt)
    buf_write <= cpu_write;
end
assign cpu_wdata_sel = buf_write;

//==================================================
//            cpu grant singal
//==================================================
assign req_grnt = ((ahbLif_cur_state[2:0]==IDLE && !ahblif_power_mask && !pad_cpu_halt_ff2)
                 || ahbLif_cur_state[2:0]==WFG
                 || ahbLif_cur_state[2:0]==WFD)
                 && bus_ready && !bus_resp;

//==================================================
//            trans complete singal
//==================================================
assign trans_cmplt  = (ahbLif_cur_state[2:0]==WFD) &&  bus_ready && !bus_resp
                   || (ahbLif_cur_state[2:0]==ERROR2); //error vld
                    

//==================================================
//            data valid singal
//==================================================
assign data_vld = (ahbLif_cur_state[2:0]==WFD) && !buf_write
                && bus_ready && !bus_resp;

//==================================================
//            access error valid singal
//==================================================
assign acc_err = (ahbLif_cur_state[2:0]==ERROR2);


//==============================================================================
//
//                       AHB LITE BUS interface signal
//
//==============================================================================

//==============================================================================
//     AHB LITE -> AHBL signals
//==============================================================================
assign bus_ready        = ahbl_ahbLif_hready;
assign bus_resp         = ahbl_ahbLif_hresp;

assign bus_rdata[DATA_WIDTH-1:0] = ahbl_ahbLif_hrdata[DATA_WIDTH-1:0];

assign ahbl_ahbLif_hsec = 1'b0;


assign bus_sec                   = ahbl_ahbLif_hsec;



//==============================================================================
//     AHBL -> AHB LITE signals
//==============================================================================
//==========================================================
//     HADDR
//==========================================================
assign ahbLif_ahbl_haddr[31:0] = cpu_addr[31:0];

//==========================================================
//     HWDATA
//==========================================================

// &Instance("cr_beu_enc32", "x_cr_biu_wdata_enc"); @215
// &Connect(.data_in(cpu_wr_data), @216
//          .f_key0 (pad_biu_beu_key0), @217
//          .f_key1 (pad_biu_beu_key1), @218
//          .data_out(cpu_cwdata) @219
// ); @220
//   &Instance("cr_ahbl_scram", "x_cr_biu_wdata_scram"); @224
//   &Connect(.data_in(cpu_wr_data), @225
//            .f_key0 (pad_biu_beu_key0), @226
//            .f_key1 (pad_biu_beu_key1), @227
//            .data_out(cpu_cwdata) @228
//   ); @229
  assign hwdata[DATA_WIDTH-1:0] = cpu_wr_data[DATA_WIDTH-1:0];

assign ahbLif_ahbl_hwdata[DATA_WIDTH-1:0] = hwdata[DATA_WIDTH-1:0];

// BUS Polarity

// &Force("output","ahbLif_ahbl_hwdata"); @245


//==========================================================
//     HTRANS
//==========================================================

assign ahbLif_ahbl_htrans[1] = ahbLif_cur_state[2:0]==IDLE &&
                               !pad_cpu_halt_ff2 &&
                               cpu_req_power_masked || 
                              (ahbLif_cur_state[2:0]==WFG ||
                               ahbLif_cur_state[2:0]==WFD) &&
                               cpu_req; // && bus_ready;

assign ahbLif_ahbl_htrans[0] = 1'b0;

//==========================================================
//     HWRITE
//==========================================================
assign ahbLif_ahbl_hwrite = cpu_write;

//==========================================================
//     HSIZE
//==========================================================

assign ahbLif_ahbl_hsize[2:0] = { 1'b0, cpu_size[1:0]};

//==========================================================
//     HPROT
//==========================================================

assign ahbLif_ahbl_hprot[3:0] = cpu_prot[3:0];

//==========================================================
//     HBURST
//==========================================================

assign ahbLif_ahbl_hburst[2:0] = 3'b0;

//==========================================================
//     interface with EMMU
//==========================================================


//==========================================================
//     Vector Redirect Information
//==========================================================
// &Force("nonport", "ahbLif_ahbl_vec_redrct"); @307
assign ahbLif_ahbl_vec_redrct = cpu_vec_redirect;
//==============================================================================
//
//                            interface with CPU
//
//==============================================================================

//==========================================================
//     CPU_GNT
//==========================================================

assign cpu_req_grnt = req_grnt;

//==========================================================
//     TRANS COMPLETE
//==========================================================

assign cpu_trans_cmplt = trans_cmplt;

//==========================================================
//     DATA VALID
//==========================================================

assign cpu_data_vld = data_vld;

//==========================================================
//     LOAD DATA
//==========================================================
//   //&Force("output","cpu_rdata_pol"); @338
//   //&Connect(.data_in(bus_pol_rdata), @342
//   //         .f_key0 (pad_biu_beu_key1), @343
//   //         .f_key1 (pad_biu_beu_key0), @344
//   //         .data_out(bus_pdata) @345
//   //); @346
//   //&Connect(.data_in(bus_rdata), @351
//   //         .f_key0 (pad_biu_beu_key1), @352
//   //         .f_key1 (pad_biu_beu_key0), @353
//   //         .data_out(bus_pdata) @354
//   //); @355
//   &Instance("cr_beu_enc32", "x_cr_biu_rdata_dec"); @358
//   &Connect(.data_in(bus_rdata), @359
//            .f_key0 (pad_biu_beu_key1), @360
//            .f_key1 (pad_biu_beu_key0), @361
//            .data_out(bus_pdata) @362
//   ); @363
//   &Instance("cr_ahbl_descram", "x_cr_biu_rdata_descram"); @367
//   &Connect(.data_in(bus_rdata), @368
//            .f_key0 (pad_biu_beu_key0), @369
//            .f_key1 (pad_biu_beu_key1), @370
//            .data_out(bus_pdata) @371
//   ); @372
  assign cpu_rdata[DATA_WIDTH-1:0] = bus_rdata[DATA_WIDTH-1:0];

//==========================================================
//     LOAD_ERROR
//==========================================================

assign cpu_acc_err = acc_err;

assign cpu_sec     = bus_sec; 
//==========================================================
//     BIU CLK EN
//==========================================================

assign ahbl_clk_en = !(ahbLif_cur_state[2:0]==IDLE) || cpu_req;

assign ahblif_busy = !(ahbLif_cur_state[2:0]==IDLE);

assign ahblif_idle = ahbLif_cur_state[2:0]==IDLE;

// &ModuleEnd; @396
endmodule


