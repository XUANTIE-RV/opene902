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

// * if gpr write back and pc retire happen at the same time,there is need to 
// * use gpr buffer, if gpr write back is one cycle after pc retire, there is
// * no need to use gpr buffer.
//

// * interface with Smart SoC testbench.
// common interface
`define psr           tb.x_soc.x_cpu_sub_system_ahb.cp0_pad_mcause

// single issue cpu interface
`define retire        tb.x_soc.x_cpu_sub_system_ahb.biu_pad_retire
`define retire_pc     tb.x_soc.x_cpu_sub_system_ahb.biu_pad_retire_pc
`define wb_gpr_data   tb.x_soc.x_cpu_sub_system_ahb.biu_pad_wb_gpr_data
`define wb_gpr_index  tb.x_soc.x_cpu_sub_system_ahb.biu_pad_wb_gpr_index
`define wb_gpr_en     tb.x_soc.x_cpu_sub_system_ahb.biu_pad_wb_gpr_en

module mnt();

// * reg definition for PC buffer
// * these buffered signals are one cycle delay and used to print logfile
reg             retire_latch;
reg     [31:0]  retire_pc_latch;

// * reg definition for GPR buffer
// * these buffered signals are one cycle delay
reg             wb_gpr_en_delay1;
reg     [ 4:0]  wb_gpr_index_delay1;
reg     [31:0]  wb_gpr_data_delay1;

// * reg definition for GPR, these registers hold the old value of GPR
reg     [31:0]  GPR [31:0];

// * wire definition for GPR signal
// * these signals used to print logfile and is connected to wb_gpr directly 
// * or wb_gpr_delay1 signal according to definition USE_GPR_BUFFER
wire            wb_gpr_en_latch;
wire    [ 4:0]  wb_gpr_index_latch;
wire    [31:0]  wb_gpr_data_latch;



// * PC Buffer
always @(posedge `clk or negedge `rst_b)
begin
  if(!`rst_b)
    retire_latch     <=  1'b0;
  else
    retire_latch     <=  `retire;
end

always @(posedge `clk)
begin
  retire_pc_latch[31:0] <=  `retire_pc[31:0];
end

// * GPR Buffer
always @(posedge `clk or negedge `rst_b)
begin
  if(!`rst_b)
    wb_gpr_en_delay1  <= 1'b0;
  else
    wb_gpr_en_delay1  <= `wb_gpr_en;
end

always @(posedge `clk)
begin
  wb_gpr_index_delay1[4:0]  <= `wb_gpr_index[4:0];
  wb_gpr_data_delay1[31:0]  <= `wb_gpr_data[31:0];
end

// * wires connecttion
// * if USE_GPR_BUFFER, use delayed signal, else use signal directly
assign wb_gpr_en_latch          = `wb_gpr_en;
assign wb_gpr_index_latch[4:0]  = `wb_gpr_index[4:0];
assign wb_gpr_data_latch[31:0]  = `wb_gpr_data[31:0];

// * GPR has three write ports. port 1 is for single issue cpu, port 2 and port 3 are
// * for dual issue cpu. port 1 and port 2 or 3 cannot be valid at the same time. 
// * if port 2 and 3 are valid at the same time, they cannot write the same reigster.
// * this is assured by cpu inner logical
wire   gpr_we;

assign gpr_we   =   wb_gpr_en_latch;
  
integer i;

always @(posedge `clk or negedge `rst_b)
begin
  if(!`rst_b)
    begin
      for(i = 0; i < 32; i = i+1)
        begin
          GPR[i] <= 32'b0;
        end
    end
  else if(gpr_we)
    begin
      GPR[wb_gpr_index_latch]  <= wb_gpr_data_latch;
    end
end

// * logfile is new in current directory. The name of the file is GPR.log
// * there are 3 write ports. the first is for single issue cpu. the second and 
// * the third is for dual issue cpu. port for single issue and port for dual 
// * issue cannot be valied at the same time.
integer GPR_FH;

initial
begin
  GPR_FH = $fopen("GPR.log");
  if(GPR_FH == 0)
    begin
      $display("can't open log file GPR.log in mnt.v!");
      $finish;
    end
end


// * for single issue cpu, there is only one print function is valid at one time
// * when PC retire, print PC, PSR and GPR information
wire   retire_pc_print;
assign retire_pc_print   = retire_latch;

always @(posedge `clk)
begin
  if(retire_pc_print)      
    begin
      $fwrite(GPR_FH, "PC : %8h |", retire_pc_latch[31:0]);
      $fwrite(GPR_FH, "PSR: %8h\n", `psr);
      for(i = 0; i < 32; i = i+1)
        begin
          if(wb_gpr_en_latch && (i == wb_gpr_index_latch[4:0]))
            begin     
              $fwrite(GPR_FH, "gr%2d:%8h |",i,wb_gpr_data_latch[31:0]);
           end
          else
            begin
              $fwrite(GPR_FH, "gr%2d:%8h |",i,GPR[i]);
            end
          if(i % 4 == 3)
            begin
              $fwrite(GPR_FH, "\n");
            end
        end
      $fwrite(GPR_FH, "\n");
    end
end

endmodule
