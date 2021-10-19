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
module cr_sys_io(
  clk_en,
  cp0_sysio_ipend_b,
  cp0_sysio_lpmd_b,
  cp0_sysio_srst,
  cpu_pad_lockup,
  cpu_pad_soft_rst,
  cpurst_b,
  forever_cpuclk,
  had_yy_xx_dbg,
  iu_sys_lp_wk_int,
  iu_sysio_lockup_on,
  iu_yy_xx_dbgon,
  pad_cpu_ext_int_b,
  pad_cpu_nmi,
  pad_cpu_rst_addr,
  pad_cpu_sys_cnt,
  pad_cpu_wakeup_event,
  pad_sysio_dbgrq_b,
  pad_yy_gate_clk_en_b,
  sysio_clint_me_int,
  sysio_clint_mtime,
  sysio_cp0_bigend,
  sysio_cp0_clkratio,
  sysio_cp0_endian_v2,
  sysio_cp0_rst_addr,
  sysio_cp0_sys_view_lpmd_b,
  sysio_had_sdb_req_b,
  sysio_ifu_rst_addr,
  sysio_iu_nmi_int,
  sysio_iu_rst_addr,
  sysio_iu_wk_event,
  sysio_pad_lpmd_b
);

// &Ports; @24
input           clk_en;                   
input           cp0_sysio_ipend_b;        
input   [1 :0]  cp0_sysio_lpmd_b;         
input   [1 :0]  cp0_sysio_srst;           
input           cpurst_b;                 
input           forever_cpuclk;           
input           had_yy_xx_dbg;            
input           iu_sys_lp_wk_int;         
input           iu_sysio_lockup_on;       
input           iu_yy_xx_dbgon;           
input           pad_cpu_ext_int_b;        
input           pad_cpu_nmi;              
input   [31:0]  pad_cpu_rst_addr;         
input   [63:0]  pad_cpu_sys_cnt;          
input           pad_cpu_wakeup_event;     
input           pad_sysio_dbgrq_b;        
input           pad_yy_gate_clk_en_b;     
output          cpu_pad_lockup;           
output  [1 :0]  cpu_pad_soft_rst;         
output          sysio_clint_me_int;       
output  [63:0]  sysio_clint_mtime;        
output          sysio_cp0_bigend;         
output  [2 :0]  sysio_cp0_clkratio;       
output          sysio_cp0_endian_v2;      
output  [31:0]  sysio_cp0_rst_addr;       
output  [1 :0]  sysio_cp0_sys_view_lpmd_b; 
output          sysio_had_sdb_req_b;      
output  [31:0]  sysio_ifu_rst_addr;       
output          sysio_iu_nmi_int;         
output  [31:0]  sysio_iu_rst_addr;        
output          sysio_iu_wk_event;        
output  [1 :0]  sysio_pad_lpmd_b;         

// &Regs; @25
reg     [63:0]  ccvr;                     
reg             cpu_ext_int_b;            
reg             cpu_nmi;                  
reg             cpu_wk_event;             
reg             sdb_req_b_r;              
reg             sysio_pad_dbg_b;          
reg             sysio_pad_ipend_b;        
reg             sysio_pad_lockup;         
reg     [1 :0]  sysio_pad_lpmd_b;         
reg     [1 :0]  sysio_pad_soft_rst;       
reg             sysio_pad_wakeup_b;       

// &Wires; @26
wire            clk_en;                   
wire            cp0_sysio_ipend_b;        
wire    [1 :0]  cp0_sysio_lpmd_b;         
wire    [1 :0]  cp0_sysio_srst;           
wire            cpu_pad_lockup;           
wire    [1 :0]  cpu_pad_soft_rst;         
wire    [31:0]  cpu_rst_addr;             
wire            cpu_wake_up_b;            
wire            cpurst_b;                 
wire            forever_cpuclk;           
wire            had_yy_xx_dbg;            
wire            iu_sys_lp_wk_int;         
wire            iu_sysio_lockup_on;       
wire            iu_yy_xx_dbgon;           
wire            pad_cpu_ext_int_b;        
wire            pad_cpu_nmi;              
wire    [31:0]  pad_cpu_rst_addr;         
wire    [63:0]  pad_cpu_sys_cnt;          
wire            pad_cpu_wakeup_event;     
wire            pad_sysio_dbgrq_b;        
wire            pad_yy_gate_clk_en_b;     
wire            sample_clk;               
wire            sysio_clint_me_int;       
wire    [63:0]  sysio_clint_mtime;        
wire            sysio_cp0_bigend;         
wire    [2 :0]  sysio_cp0_clkratio;       
wire            sysio_cp0_endian_v2;      
wire    [31:0]  sysio_cp0_rst_addr;       
wire    [1 :0]  sysio_cp0_sys_view_lpmd_b; 
wire            sysio_had_sdb_req_b;      
wire    [31:0]  sysio_ifu_rst_addr;       
wire            sysio_iu_nmi_int;         
wire    [31:0]  sysio_iu_rst_addr;        
wire            sysio_iu_wk_event;        
wire            sysio_lpmd_gated_clk;     
wire            sysio_lpmd_gated_en;      


//If global_en is cp0_yy_clk_en, at the cycle the cpu is enterring debug mode,
//the clock of sysio_flops will be closed by cp0_yy_clk_en and these flops can
//not be updated .As a result ,the global_en should always be 1'b1.When the 
//sysio_flops are updated, the clock will be closed by local_en

// &Instance("gated_clk_cell", "x_gated_sysio_lpmd_cpuclk_cell"); @33
gated_clk_cell  x_gated_sysio_lpmd_cpuclk_cell (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (sysio_lpmd_gated_clk),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (sysio_lpmd_gated_en ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in     (forever_cpuclk               ), @34
//          .global_en  (1'b1                         ), @35
//          .module_en  (1'b0                         ), @36
//          .local_en   (sysio_lpmd_gated_en          ), @37
//          .external_en(1'b0                         ), @38
//          .clk_out    (sysio_lpmd_gated_clk         )); @39

assign sysio_lpmd_gated_en = ((sysio_pad_dbg_b     ^ (~iu_yy_xx_dbgon))   ||
                              (sysio_pad_lpmd_b[1] ^ cp0_sysio_lpmd_b[1]) ||
                              (sysio_pad_lpmd_b[0] ^ cp0_sysio_lpmd_b[0]) ||
                              (sysio_pad_ipend_b   ^ cp0_sysio_ipend_b)   ||
                              (sysio_pad_wakeup_b  ^ cpu_wake_up_b)       ||
                              (pad_cpu_ext_int_b  ^ cpu_ext_int_b )       ||
                              (pad_cpu_nmi ^ cpu_nmi)       ||
                              (pad_cpu_wakeup_event ^ cpu_wk_event)       ||
                              |(pad_cpu_rst_addr[31:0] ^ cpu_rst_addr[31:0])       ||
                              |(sysio_pad_soft_rst[1:0] ^ cp0_sysio_srst[1:0]) ||
                              (sysio_pad_lockup   ^ iu_sysio_lockup_on)     ||
                              (pad_sysio_dbgrq_b  ^ sdb_req_b_r))
                            && clk_en;

// &Instance("gated_clk_cell", "x_sample_clk_cell"); @55
gated_clk_cell  x_sample_clk_cell (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (sample_clk          ),
  .external_en          (1'b0                ),
  .global_en            (1'b1                ),
  .local_en             (clk_en              ),
  .module_en            (1'b0                ),
  .pad_yy_gate_clk_en_b (pad_yy_gate_clk_en_b)
);

// &Connect(.clk_in     (forever_cpuclk               ), @56
//          .global_en  (1'b1                         ), @57
//          .module_en  (1'b0                         ), @58
//          .local_en   (clk_en                       ), @59
//          .external_en(1'b0                         ), @60
//          .clk_out    (sample_clk                   )); @61

//=========================================
//             input port 
//=========================================
//synchronize signal
// assign  sysio_cp0_bigend         =!pad_sysio_bigend_b;
// assign  sysio_cp0_endian_v2      = pad_sysio_endian_v2;
// assign  sysio_cp0_clkratio[2:0]  = pad_sysio_clkratio[2:0];
assign  sysio_cp0_bigend         = 1'b0;
assign  sysio_cp0_endian_v2      = 1'b0;
assign  sysio_cp0_clkratio[2:0]  = 3'b0;

always @ (posedge sample_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ccvr[63:0] <= 64'b0;
  else if (clk_en)
    ccvr[63:0] <= pad_cpu_sys_cnt[63:0];
  else
    ccvr[63:0] <= ccvr[63:0];
end

assign sysio_clint_mtime[63:0] = ccvr[63:0];

assign cpu_rst_addr[31:0] = pad_cpu_rst_addr[31:0];

assign  sysio_cp0_rst_addr[31:0] = cpu_rst_addr[31:0];
assign  sysio_ifu_rst_addr[31:0] = cpu_rst_addr[31:0];
assign  sysio_iu_rst_addr[31:0]  = cpu_rst_addr[31:0];

always @ (posedge sysio_lpmd_gated_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    cpu_ext_int_b <= 1'b1;
    cpu_nmi       <= 1'b0;
    cpu_wk_event  <= 1'b0;
  end
  else if (clk_en) begin
    cpu_ext_int_b <= pad_cpu_ext_int_b;
    cpu_nmi       <= pad_cpu_nmi;
    cpu_wk_event  <= pad_cpu_wakeup_event;
  end
  else begin
    cpu_ext_int_b <= cpu_ext_int_b;
    cpu_nmi       <= cpu_nmi;
    cpu_wk_event  <= cpu_wk_event;
  end
end

assign sysio_clint_me_int = !cpu_ext_int_b;
assign sysio_iu_nmi_int   = cpu_nmi;
assign sysio_iu_wk_event  = cpu_wk_event;

always @ (posedge sysio_lpmd_gated_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    sdb_req_b_r <= 1'b1;
  else if (clk_en)
    sdb_req_b_r <= pad_sysio_dbgrq_b;
  else
    sdb_req_b_r <= sdb_req_b_r;
end

assign sysio_had_sdb_req_b = sdb_req_b_r;


//=========================================
//            output port
//=========================================
// //&Force("output","sysio_pad_ipend_b"); @143
// //&Force("output","sysio_pad_dbg_b"); @144
// &Force("output","sysio_pad_lpmd_b"); @145
// //&Force("output","sysio_pad_wakeup_b"); @146

assign cpu_wake_up_b = iu_sys_lp_wk_int && !had_yy_xx_dbg;

always @(posedge sysio_lpmd_gated_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    sysio_pad_dbg_b       <= 1'b1;
    sysio_pad_lpmd_b[1:0] <= 2'b11;
    sysio_pad_ipend_b     <= 1'b0;
    sysio_pad_wakeup_b    <= 1'b0;
  end
  else if(clk_en) 
  begin
    sysio_pad_dbg_b       <= ~iu_yy_xx_dbgon;
    sysio_pad_lpmd_b[1:0] <= cp0_sysio_lpmd_b[1:0];
    sysio_pad_ipend_b     <= cp0_sysio_ipend_b;
    sysio_pad_wakeup_b    <= cpu_wake_up_b;
  end
end

always @(posedge sysio_lpmd_gated_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    sysio_pad_soft_rst[1:0] <= 2'b0;
    sysio_pad_lockup        <= 1'b0;
  end
  else if(clk_en) 
  begin
    sysio_pad_soft_rst[1:0] <= cp0_sysio_srst[1:0];
    sysio_pad_lockup        <= iu_sysio_lockup_on;
  end
end

assign sysio_cp0_sys_view_lpmd_b[1:0] = sysio_pad_lpmd_b[1:0];
// assign sysio_pad_srst = 1'b0;
assign cpu_pad_soft_rst[1:0] = sysio_pad_soft_rst[1:0];
assign cpu_pad_lockup        = sysio_pad_lockup;

// &ModuleEnd; @187
endmodule


