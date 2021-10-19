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
module cr_clint_regs(
  busif_regs_msip_sel,
  busif_regs_mtimecmp_hi_sel,
  busif_regs_mtimecmp_lo_sel,
  busif_regs_wdata,
  busif_regs_write_vld,
  clint_clk,
  clint_cpu_me_int,
  clint_cpu_ms_int,
  clint_cpu_mt_int,
  cpu_clint_mode,
  cpurst_b,
  msip_value,
  mtime_hi_value,
  mtime_lo_value,
  mtimecmp_hi_value,
  mtimecmp_lo_value,
  sysio_clint_me_int,
  sysio_clint_mtime
);

// &Ports; @23
input           busif_regs_msip_sel;       
input           busif_regs_mtimecmp_hi_sel; 
input           busif_regs_mtimecmp_lo_sel; 
input   [31:0]  busif_regs_wdata;          
input           busif_regs_write_vld;      
input           clint_clk;                 
input   [1 :0]  cpu_clint_mode;            
input           cpurst_b;                  
input           sysio_clint_me_int;        
input   [63:0]  sysio_clint_mtime;         
output          clint_cpu_me_int;          
output          clint_cpu_ms_int;          
output          clint_cpu_mt_int;          
output  [31:0]  msip_value;                
output  [31:0]  mtime_hi_value;            
output  [31:0]  mtime_lo_value;            
output  [31:0]  mtimecmp_hi_value;         
output  [31:0]  mtimecmp_lo_value;         

// &Regs; @24
reg             msip_en;                   
reg     [31:0]  mtimecmp_hi;               
reg     [31:0]  mtimecmp_lo;               

// &Wires; @25
wire            busif_regs_msip_sel;       
wire            busif_regs_mtimecmp_hi_sel; 
wire            busif_regs_mtimecmp_lo_sel; 
wire    [31:0]  busif_regs_wdata;          
wire            busif_regs_write_vld;      
wire            clint_clk;                 
wire            clint_cpu_me_int;          
wire            clint_cpu_ms_int;          
wire            clint_cpu_mt_int;          
wire    [1 :0]  cpu_clint_mode;            
wire            cpu_is_m_mode;             
wire            cpurst_b;                  
wire            mregs_write_vld;           
wire    [31:0]  msip_value;                
wire    [31:0]  mtime_hi_value;            
wire    [31:0]  mtime_lo_value;            
wire    [31:0]  mtimecmp_hi_value;         
wire    [31:0]  mtimecmp_lo_value;         
wire            sysio_clint_me_int;        
wire    [63:0]  sysio_clint_mtime;         


parameter CPU_M_MODE = 2'b11;

//==========================================================
//                       Write Ctrl
//==========================================================
assign cpu_is_m_mode = cpu_clint_mode[1:0] == CPU_M_MODE;

assign mregs_write_vld = busif_regs_write_vld && cpu_is_m_mode;

//==========================================================
//                         Regs
//==========================================================
//----------------- MSIP ---------------
always @ (posedge clint_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    msip_en <= 1'b0;
  else if (mregs_write_vld && busif_regs_msip_sel)
    msip_en <= busif_regs_wdata[0];
  else
    msip_en <= msip_en;
end
assign msip_value[31:0] = {31'b0, msip_en};


//------------- MTIMECMP_LO ------------
always @ (posedge clint_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    mtimecmp_lo[31:0] <= 32'b0;
  else if (mregs_write_vld && busif_regs_mtimecmp_lo_sel)
    mtimecmp_lo[31:0] <= busif_regs_wdata[31:0];
  else
    mtimecmp_lo[31:0] <= mtimecmp_lo[31:0];
end
assign mtimecmp_lo_value[31:0] = mtimecmp_lo[31:0];


//------------- MTIMECMP_HI ------------
always @ (posedge clint_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    mtimecmp_hi[31:0] <= 32'b0;
  else if (mregs_write_vld && busif_regs_mtimecmp_hi_sel)
    mtimecmp_hi[31:0] <= busif_regs_wdata[31:0];
  else
    mtimecmp_hi[31:0] <= mtimecmp_hi[31:0];
end
assign mtimecmp_hi_value[31:0] = mtimecmp_hi[31:0];


//--------------- MTIME_LOW ------------
assign mtime_lo_value[31:0] = sysio_clint_mtime[31:0];

//--------------- MTIME_HI -------------
assign mtime_hi_value[31:0] = sysio_clint_mtime[63:32];


//==========================================================
//                   CLINT Output Signal
//==========================================================
assign clint_cpu_ms_int = msip_en;
assign clint_cpu_mt_int = !({mtimecmp_hi[31:0], mtimecmp_lo[31:0]}
                           > sysio_clint_mtime[63:0]);
assign clint_cpu_me_int = sysio_clint_me_int;

// &ModuleEnd; @93
endmodule


