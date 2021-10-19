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
module jtag_rd_wr_test();

//JTAG interface define

//`define DOWNLOAD_TEST
`define   jtag_tclk        tb.jclk
`define   jtag_tms_i       tb.jtg_tms
`define   jtag_tms_o       tb.jtg_tms
`define   jtag_trst_b      tb.jrst_b
`ifndef   DOWNLOAD_TEST
`define   RETIRE_PC        tb.x_soc.x_cpu_sub_system_ahb.x_e902.iu_pad_retire_pc[31:0]
`define   RETIRE_VLD       tb.x_soc.x_cpu_sub_system_ahb.x_e902.iu_pad_inst_retire
`define   CLK              tb.x_soc.x_cpu_sub_system_ahb.x_e902.pll_core_cpuclk
`endif

//register index in HAD
`define cpuscr             7'b0001011
`define hcr                7'b0001101
`define hsr                7'b0001110
`define daddr              7'b0011000
`define ddata              7'b0011001
`define wbbr               7'b0010001
`define ir                 7'b0010100
`define csr                7'b0010101 
`define pc                 7'b0010011

//operation define
`define ir_go_nex          7'b1010100
`define cpuscr_go_nex      7'b1001011
`define pc_go_ex           7'b1110011

`define base_addr          32'h20000000

//inst opcode

  `define MOV_X4_X4        32'h20213
  `define MOV_X5_X5        32'h28293
  `define LDW_X4_X5        32'h2a203
  `define STW_X4_X5        32'h42a023

//***************************************************
//test the connection between the board and had&cpu
//***************************************************
reg [31:0] data_read_out;
reg [127:0] cpuscr_data_out;
reg [31:0] x4_backup;
reg [31:0] x5_backup;
reg        loop_flag;
reg [31:0] cpu_retire_pc;

static integer FILE;

initial
begin

//had register read and write test
jtag_rst(32'h10);
//set cpu into debug mode
`ifndef DOWNLOAD_TEST
#3000ns;
// loop_flag = 0;
// cpu_retire_pc = 32'hffff_fffc;
// while(!loop_flag)
// begin
//   @(posedge `CLK);
//   wait(`RETIRE_VLD);
//   cpu_retire_pc = `RETIRE_PC;
//   @(posedge `CLK);
//   wait(`RETIRE_VLD);
//   @(posedge `CLK);
//   wait(`RETIRE_VLD);
//   if(cpu_retire_pc == `RETIRE_PC)
//   begin
//     loop_flag = 1;
//   end
// end
`endif
write_hadreg(`hcr,32'h8000);       //set DR to enter debug mode
wait_debug_mode;
write_hadreg(`hcr,0);              //clear DR
read_hadreg(`ddata,data_read_out);
$display("*************************************************\n");
$display("the value of DDATA is 0x%h",data_read_out);
$display("*************************************************\n");
write_hadreg(`ddata,32'h12345678);
read_hadreg(`ddata,data_read_out);
if(data_read_out == 32'h12345678) begin
  $display("*************************************************\n");
  $display("connection between the board and had is passed!!!");
  $display("*************************************************\n");
end
else begin
  $display("*************************************************\n");
  $display("connection between the board and had fails!!!");
  $display("*************************************************\n");
  $finish;
end

//gpr read and write test
write_hadreg(`csr,16'h0); //clear FFY
write_hadreg(`ir_go_nex,`MOV_X4_X4);
read_hadreg(`wbbr,x4_backup);
$display("*************************************************\n");
$display("the data in X4 is 0x%h\n", x4_backup);
$display("*************************************************\n");
write_hadreg(`wbbr,32'h11223344);
write_hadreg(`csr,16'h100); //set FFY
write_hadreg(`ir_go_nex,`MOV_X4_X4);
write_hadreg(`wbbr,32'h0);
write_hadreg(`csr,16'h0); //clear FFY
write_hadreg(`ir_go_nex,`MOV_X4_X4);
data_read_out= 32'h0;
read_hadreg(`wbbr,data_read_out);
write_hadreg(`csr,16'h100);
write_hadreg(`wbbr,x4_backup);
write_hadreg(`ir_go_nex,`MOV_X4_X4);
if(data_read_out == 32'h11223344) begin
  $display("*************************************************\n");
  $display("connection between the board and cpu is passed!!!");
  $display("*************************************************\n");
end
else begin
  $display("*************************************************\n");
  $display("connection between the board and cpu fails!!!");
  $display("*************************************************\n");
  $finish;
end

//mem read and write test
write_hadreg(`csr,16'h0); //clear FFY
write_hadreg(`ir_go_nex,`MOV_X4_X4);
read_hadreg(`wbbr,x4_backup);
write_hadreg(`ir_go_nex,`MOV_X5_X5);
read_hadreg(`wbbr,x5_backup);
write_hadreg(`wbbr,`base_addr);
write_hadreg(`csr,16'h100); //set FFY
write_hadreg(`ir_go_nex,`MOV_X5_X5);
write_hadreg(`csr,16'h0);
write_hadreg(`ir_go_nex,`LDW_X4_X5);
read_hadreg(`wbbr,data_read_out);
$display("*************************************************\n");
$display("the data in mem is 0x%h\n", data_read_out);
$display("*************************************************\n");
write_hadreg(`wbbr,32'h55667788);
write_hadreg(`csr,16'h100); //set FFY
write_hadreg(`ir_go_nex,`MOV_X4_X4);
write_hadreg(`csr,16'h0);
write_hadreg(`ir_go_nex,`STW_X4_X5); //execute st.w r0, (r1,0x0) inst
$display("*************************************************\n");
$display("write data 0x55667788 to mem\n");
$display("*************************************************\n");
write_hadreg(`wbbr,32'h0);
write_hadreg(`csr,16'h0); //clear FFY
write_hadreg(`ir_go_nex,`LDW_X4_X5);
data_read_out= 32'h0;
read_hadreg(`wbbr,data_read_out);
write_hadreg(`csr,16'h100);
write_hadreg(`wbbr,x4_backup);
write_hadreg(`ir_go_nex,`MOV_X4_X4);
write_hadreg(`wbbr,x5_backup);
write_hadreg(`ir_go_nex,`MOV_X5_X5);
if(data_read_out == 32'h55667788) begin
  $display("*************************************************\n");
  $display("mem read and write test is passed!!!");
  $display("*************************************************\n");
end
else begin
  $display("*************************************************\n");
  $display("the data read from mem 0x%h after write is 0x%h\n", `base_addr, data_read_out);
  $display("mem read and write test failed!!!");
  $display("*************************************************\n");
  $finish;
end


//***************************************************
//download data using ddc mode
//***************************************************


//download data
write_hadreg(`hcr,32'h100000);      //enable ddc mode
write_hadreg(`daddr,`base_addr);    //the data written into the DADDR register is the address where to download
write_hadreg(`ddata,32'habcd1234);  //the data written into the DDATA register is the data to download
write_hadreg(`ddata,32'habcd1234);  //the DDC logic in HAD module executes the address addition automatically
write_hadreg(`ddata,32'habcd1234);
repeat(20)@(posedge `jtag_tclk);

`ifndef DOWNLOAD_TEST
read_hadreg(`pc, data_read_out);
data_read_out = data_read_out+4;
write_hadreg(`pc_go_ex, data_read_out);
$display("**************************************************");  
$display("*********** Congratulation!:HAD TEST PASS  *******");
$display("**************************************************");
FILE = $fopen("run_case.report","w");
$fdisplay(FILE,"TEST PASS");
`else
$finish;
`endif
end
//***************************************************
//the tasks are defined below
//***************************************************
task write_hadreg;
  input[6:0] reg_select;
  input[127:0] reg_value;
  begin
    case(reg_select & 7'b0011111)
      `wbbr,
      `ir,
      `hcr,
      `pc,
      `daddr,
      `ddata : begin
        write_ir({1'b0,reg_select[6:0]});
      	write_dr(reg_value,32);
      end

      `hsr,
      `csr : begin
      	write_ir({1'b0,reg_select[6:0]});
      	write_dr(reg_value,16);
      end
      
      `cpuscr : begin
        write_ir({1'b0,reg_select[6:0]});
        write_dr(reg_value,128);
      end

    endcase
  end
endtask

task read_hadreg;
  input[6:0] reg_select;
  output[127:0] jtag_data_out;
  reg[127:0] jtag_data_out;
  begin
    case(reg_select & 7'b0011111)
      `wbbr,
      `ir,
      `hcr,
      `pc,
      `daddr,
      `ddata : begin
        write_ir({1'b1,reg_select[6:0]});
      	read_dr(32, jtag_data_out);
      end

      `hsr,
      `csr : begin
      	write_ir({1'b1,reg_select[6:0]});
      	read_dr(16, jtag_data_out);
      end

      `cpuscr : begin
        write_ir({1'b1,reg_select[6:0]});
        read_dr(128, jtag_data_out);
      end

    endcase
  end
endtask	


  // Task for JTAG 2
  //jtag reset, for example: jtag_rst(100)
  task jtag_rst;
  input[31:0] rst_cycle;
  integer i;
  begin
    force `jtag_trst_b = 1'b1;
    force `jtag_tms_i = 1'b1;
  
    //wait until posedge tclk
    @(negedge `jtag_tclk); 
    force `jtag_trst_b = 1'b0;
  
    //wait for user specified cycles
    for(i=0; i<rst_cycle; i=i+1)
      @(negedge `jtag_tclk);
    force `jtag_trst_b = 1'b1;
    
    //drive TAP state machine into IDLE state
    @(negedge `jtag_tclk);
    @(negedge `jtag_tclk);
    //Notice!!! the operation below drives the TAP5 FSM to START
    force `jtag_tms_i = 1'b1;
  end
  endtask
  
  //write IR
  task write_ir;
  input [7:0] ir_value;
  integer i;
  reg  parity;
  begin
    parity = 1'b1;
    @(negedge `jtag_tclk); // start
    force `jtag_tms_i = 1'b0;
    @(negedge `jtag_tclk); // read/write
    force `jtag_tms_i = 1'b0;
    @(negedge `jtag_tclk); // RS[0]
    force `jtag_tms_i = 1'b0;
    @(negedge `jtag_tclk); // RS[1]
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk);
    for(i=0; i<8; i=i+1)begin
      force `jtag_tms_i = ir_value[i];
      parity = parity ^ ir_value[i];
      @(negedge `jtag_tclk); // Shift IR 
    end
    force `jtag_tms_i = parity;
    @(negedge `jtag_tclk); // Parity
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // IDLE
  end
  endtask
  
  //write DR
  task write_dr;
  input [127:0] jtag_data_in;
  input [8:0]   jtag_data_len;
  integer i;
  reg  parity;
  begin
    parity = 1'b1;
    @(negedge `jtag_tclk); // start
    force `jtag_tms_i = 1'b0;
    @(negedge `jtag_tclk); // read/write
    force `jtag_tms_i = 1'b0;
    @(negedge `jtag_tclk); // RS[0]
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // RS[1]
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk);
    for(i=0; i<32; i=i+1)begin
      force `jtag_tms_i = jtag_data_in[i];
      parity = parity ^ jtag_data_in[i];
      @(negedge `jtag_tclk); // Shift DR 
    end
    force `jtag_tms_i = parity; // Parity
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // Drive to IDLE
    force `jtag_tms_i = 1'b1;
  end
  endtask
  
  //Read DR
  task read_dr;
  input  [8:0]   jtag_data_len;
  output [127:0] jtag_data_out;
  reg    [127:0] jtag_data_out;
  integer i;
  reg  parity;
  begin
    parity = 1'b1;
    @(negedge `jtag_tclk); // start
    force `jtag_tms_i = 1'b0;
    @(negedge `jtag_tclk); // read/write
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // RS[0]
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // RS[1]
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms_i = 1'b1;
    @(posedge `jtag_tclk);
    release `jtag_tms_i;
    @(posedge `jtag_tclk); // Sync cycle
    for(i=0; i<32; i=i+1)begin
      @(posedge `jtag_tclk); // Shift DR 
      jtag_data_out[i] = `jtag_tms_o;
    end
    @(posedge `jtag_tclk); // Parity
    parity = `jtag_tms_i;
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms_i = 1'b1;
    @(negedge `jtag_tclk); // to IDLE
    force `jtag_tms_i = 1'b1;
  end
  endtask

task wait_debug_mode;
  reg[15:0] hsr_data_out;
  begin
    read_hadreg(`hsr,hsr_data_out);
    $display("---------------------------------------");
    $display("wait into debug mode......            |");
    $display("<wait_begin> The hsr is: 0x%h       |",
             hsr_data_out[15:0]);  
    while(hsr_data_out[1:0]!=2'b10)
    read_hadreg(`hsr,hsr_data_out);
    $display("<wait_end>   The hsr is: 0x%h       |",
             hsr_data_out[15:0]);  
    $display("Now, CPU is in Debug Mode!            |"); 
    $display("---------------------------------------");
  end
endtask

endmodule
