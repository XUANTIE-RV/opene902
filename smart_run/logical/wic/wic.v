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

// &ModuleBeg; @28
module wic(
  awake_data,
  awake_disable,
  awake_enable,
  int_cfg,
  int_exit,
  int_pending,
  int_vld,
  pad_cpu_rst_b,
  pending_clr,
  wic_awake_en,
  wic_clk
);

// &Ports; @29
input        awake_data;   
input        awake_disable; 
input        awake_enable; 
input        int_cfg;      
input        int_exit;     
input        int_vld;      
input        pad_cpu_rst_b; 
input        pending_clr;  
input        wic_clk;      
output       int_pending;  
output       wic_awake_en; 

// &Regs; @30
reg          int_pending;  
reg          int_vld_ff;   
reg          wic_awake_en; 

// &Wires; @31
wire         awake_data;   
wire         awake_disable; 
wire         awake_enable; 
wire         int_cfg;      
wire         int_exit;     
wire         int_level;    
wire         int_pulse;    
wire         int_vld;      
wire         pad_cpu_rst_b; 
wire         pending_clr;  
wire         wic_clk;      


//always@(posedge wic_clk or negedge pad_cpu_rst_b)
//begin
//  if (!pad_cpu_rst_b)
//    pending_ctrl_ff <= 1'b0;
//  else 
//    pending_ctrl_ff <= pending_ctrl;
//end

 
always@(posedge wic_clk or negedge pad_cpu_rst_b)
begin
  if (!pad_cpu_rst_b)
    wic_awake_en <= 1'b0;
  else if (awake_enable && awake_data)
    wic_awake_en <= 1'b1;
  else if (awake_disable && awake_data)
    wic_awake_en <= 1'b0;
end
//------------------------------------------------
//   sample level-sensitive interrupt
//------------------------------------------------

assign int_level = int_vld && !int_cfg && int_exit; 

//------------------------------------------------
//   sample pulse-sensitive interrupt
//------------------------------------------------
always@(posedge wic_clk or negedge pad_cpu_rst_b)
begin
  if (!pad_cpu_rst_b)
    int_vld_ff <= 1'b0;
  else 
    int_vld_ff <= int_vld;
end

assign int_pulse = int_vld && !int_vld_ff;

//------------------------------------------------
//        int  pending
//------------------------------------------------
always@(posedge wic_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
    int_pending <= 1'b0;
  else if (!int_cfg)
    int_pending <= int_level;
  else if (pending_clr)
    int_pending <= 1'b0;
  else if(int_cfg)
    int_pending <= int_pulse;
end
// &ModuleEnd; @98
endmodule



