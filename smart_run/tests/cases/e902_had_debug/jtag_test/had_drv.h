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

//signal remaning
`ifdef JTAG_5
`define jtag_tdo        tb.jtg_tdo
`define jtag_tdi        tb.jtg_tdi
`endif
`define jtag_tclk       tb.jclk
`define jtag_tms        tb.jtg_tms
`define jtag_trst_b     tb.jrst_b
//-----------------------------------------------
//define the instructions opcodes
`define BKPT32          32'h80000000
`define BKPT16          16'h0
`define MOV_R0_R0       32'hc4004820
`define MOV_R1_R1       32'hc4014821
`define MOV_R2_R2       32'hc4024822
`define MOV_R3_R3       32'hc4034823
`define MOV_R4_R4       32'hc4044824
`define MOV_R5_R5       32'hc4054825
`define MOV_R6_R6       32'hc4064826
`define MOV_R7_R7       32'hc4074827
`define MOV_R8_R8       32'hc4084828
`define MOV_R9_R9       32'hc4094829
`define MOV_R10_R10     32'hc40a482a
`define MOV_R11_R11     32'hc40b482b
`define MOV_R12_R12     32'hc40c482c
`define MOV_R13_R13     32'hc40d482d
`define MOV_R14_R14     32'hc40e482e
`define MOV_R15_R15     32'hc40f482f
`define MOV_R16_R16     32'hc4104830
`define MOV_R17_R17     32'hc4114831
`define MOV_R18_R18     32'hc4124832
`define MOV_R19_R19     32'hc4134833
`define MOV_R20_R20     32'hc4144834
`define MOV_R21_R21     32'hc4154835
`define MOV_R22_R22     32'hc4164836
`define MOV_R23_R23     32'hc4174837
`define MOV_R24_R24     32'hc4184838
`define MOV_R25_R25     32'hc4194839
`define MOV_R26_R26     32'hc41a483a
`define MOV_R27_R27     32'hc41b483b
`define MOV_R28_R28     32'hc41c483c
`define MOV_R29_R29     32'hc41d483d
`define MOV_R30_R30     32'hc41e483e
`define MOV_R31_R31     32'hc41f483f

`define MFCR_R1_CR0     32'hc0006021
`define MFCR_R1_CR1     32'hc0016021
`define MFCR_R1_CR2     32'hc0026021
`define MFCR_R1_CR3     32'hc0036021
`define MFCR_R1_CR4     32'hc0046021
`define MFCR_R1_CR5     32'hc0056021
`define MFCR_R1_CR6     32'hc0066021
`define MFCR_R1_CR7     32'hc0076021
`define MFCR_R1_CR8     32'hc0086021
`define MFCR_R1_CR9     32'hc0096021
`define MFCR_R1_CR10    32'hc00a6021
`define MFCR_R1_CR11    32'hc00b6021
`define MFCR_R1_CR12    32'hc00c6021
`define MFCR_R1_CR13    32'hc00d6021
`define MFCR_R1_CR14    32'hc00e6021
`define MFCR_R1_CR15    32'hc00f6021
`define MFCR_R1_CR16    32'hc0106021
`define MFCR_R1_CR17    32'hc0116021
`define MFCR_R1_CR18    32'hc0126021
`define MFCR_R1_CR19    32'hc0136021
`define MFCR_R1_CR20    32'hc0146021
`define MFCR_R1_CR21    32'hc0156021

`define MTCR_R1_CR0     32'hc0016420
`define MTCR_R1_CR1     32'hc0016421
`define MTCR_R1_CR2     32'hc0016422
`define MTCR_R1_CR3     32'hc0016423
`define MTCR_R1_CR4     32'hc0016424
`define MTCR_R1_CR5     32'hc0016425
`define MTCR_R1_CR6     32'hc0016426
`define MTCR_R1_CR7     32'hc0016427
`define MTCR_R1_CR8     32'hc0016428
`define MTCR_R1_CR9     32'hc0016429
`define MTCR_R1_CR10    32'hc001642a
`define MTCR_R1_CR11    32'hc001642b
`define MTCR_R1_CR12    32'hc001642c
`define MTCR_R1_CR13    32'hc001642d

`define LDW_R1_R2_0x0   32'hd8222000
`define LDW_R1_R2_0x4   32'hd8222001
`define LDW_R1_R2_0x8   32'hd8222002
`define LDW_R1_R2_0xc   32'hd8222003
`define LDW_R1_R2_0x10  32'hd8222004
`define LDW_R1_R2_0x14  32'hd8222005
`define LDW_R1_R2_0x18  32'hd8222006
`define LDW_R1_R2_0x1c  32'hd8222007
`define LDW_R1_R2_0x20  32'hd8222008
`define LDW_R1_R2_0x24  32'hd8222009
`define LDW_R1_R2_0x28  32'hd822200a
`define LDW_R1_R2_0x2c  32'hd822200b
`define LDW_R1_R2_0x30  32'hd822200c
`define LDW_R1_R2_0x34  32'hd822200d
`define LDW_R1_R2_0x38  32'hd822200e
`define LDW_R1_R2_0x3c  32'hd822200f
`define LDW_R1_R2_0x40  32'hd8222010
`define LDW_R1_R2_0x44  32'hd8222011
`define LDW_R1_R2_0x48  32'hd8222012
`define LDW_R1_R2_0x4c  32'hd8222013
`define LDW_R1_R2_0x50  32'hd8222014
`define LDW_R1_R2_0x54  32'hd8222015

`define LDW_R1_R6_0x0   32'hd8262000
`define LDW_R1_R6_0x4   32'hd8262001

`define STW_R1_R2_0x0   32'hdc222000
`define STW_R1_R5_0x0   32'hdc252000
`define STW_R1_R5_0x4   32'hdc252001
`define STW_R1_R5_0x8   32'hdc252002
`define STW_R1_R5_0xc   32'hdc252003
`define STW_R1_R5_0x10  32'hdc252004

//-----------------------------------------------
//define the HAD registers
`define id           7'b0000010
`define tracer       7'b0000011
`define mbca         7'b0000100
`define mbcb         7'b0000101
`define pcfifo       7'b0000110
`define baba         7'b0000111
`define babb         7'b0001000
`define bama         7'b0001001
`define bamb         7'b0001010
`define cpuscr       7'b0001011
`define bypass       7'b0001100
`define hcr          7'b0001101
`define hsr          7'b0001110

`define daddr        7'b0011000
`define ddata        7'b0011001

`define wbbr         7'b0010001
`define psr          7'b0010010
`define pc           7'b0010011
`define ir           7'b0010100
`define csr          7'b0010101 

`define wbbr_go_ex   7'b1110001
`define wbbr_go_nex  7'b1010001
`define wbbr_ngo_ex  7'b0110001
`define wbbr_ngo_nex 7'b0010001
`define psr_go_ex    7'b1110010
`define psr_go_nex   7'b1010010
`define psr_ngo_ex   7'b0110010
`define psr_ngo_nex  7'b0010010
`define pc_go_ex     7'b1110011
`define pc_go_nex    7'b1010011
`define pc_ngo_ex    7'b0110011
`define pc_ngo_nex   7'b0010011
`define ir_go_ex     7'b1110100
`define ir_go_nex    7'b1010100
`define ir_ngo_ex    7'b0110100
`define ir_ngo_nex   7'b0010100
`define csr_go_ex    7'b1110101
`define csr_go_nex   7'b1010101
`define csr_ngo_ex   7'b0110101
`define csr_ngo_nex  7'b0010101
`define cpuscr_go_ex 7'b1101011
`define cpuscr_go_nex 7'b1001011


`define bypass_go_ex    7'b1101100
`define bypass_go_nex   7'b1001100
`define bypass_ngo_ex   7'b0101100
`define bypass_ngo_nex  7'b0001100
`ifdef JTAG_5
  // Task for JTAG 5
  //jtag reset, for example: jtag_rst(100)
  task jtag_rst;
  input[31:0] rst_cycle;
  integer i;
  begin
    force `jtag_trst_b = 1'b1;
    force `jtag_tms  = 1'b0;
  
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
    force `jtag_tms = 1'b0;
  end
  endtask
  
  //write IR
  task write_ir;
  input [7:0] ir_value;
  integer i;
  reg  parity;
  begin
    @(negedge `jtag_tclk); //drive to Select DR Scan
    force `jtag_tms = 1'b1;     
    @(negedge `jtag_tclk); //drive to Select IR Scan
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); //drive to Capture IR
    force `jtag_tms = 1'b0;
    @(negedge `jtag_tclk); //drive to Shift IR
    force `jtag_tms = 1'b0;
    @(negedge `jtag_tclk);
    for(i=0;i<7;i=i+1)begin
      force `jtag_tms = 1'b0;
      force `jtag_tdi = ir_value[i];
      @(negedge `jtag_tclk); //stay at Shift IR cycle 
    end
    force `jtag_tms = 1'b1; //stay at Shift IR cycle 8,drive to EXIT IR
    force `jtag_tdi = ir_value[7];
    @(negedge `jtag_tclk); //drive to Update IR
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); //drive to IDLE
    force `jtag_tms = 1'b0;
  end
  endtask
  
  //write DR
  task write_dr;
  input [143:0] jtag_data_in;
  input [8:0]   jtag_data_len;
  integer i;
  reg  parity;
  begin
    @(negedge `jtag_tclk); //drive to Select DR Scan
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); //drive to Capture DR
    force `jtag_tms = 1'b0;
    @(negedge `jtag_tclk); //drive to Shift DR
    force `jtag_tms = 1'b0;
    @(negedge `jtag_tclk);
    for(i=0;i<jtag_data_len-1;i=i+1)begin
      force `jtag_tms = 1'b0;
      force `jtag_tdi = jtag_data_in[i];
      @(negedge `jtag_tclk); //stay at Shift DR cycle i 
    end
    force `jtag_tms = 1'b1; //stay at Shift DR last cycle 
    force `jtag_tdi = jtag_data_in[i];
    @(negedge `jtag_tclk); //drive to Update DR
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); //drive to IDLE
    force `jtag_tms = 1'b0;
  end
  endtask
  
  //Read DR
  task read_dr;
  input  [8:0]   jtag_data_len;
  output [143:0] jtag_data_out;
  reg    [143:0] jtag_data_out;
  integer i;
  reg  parity;
  begin
    @(negedge `jtag_tclk); //drive to Select DR Scan
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); //drive to Capture DR
    force `jtag_tms = 1'b0;
    @(negedge `jtag_tclk); //drive to Shift DR
    force `jtag_tms = 1'b0;
    for(i=0;i<jtag_data_len-1;i=i+1)begin
      @(negedge `jtag_tclk); //stay at Shift DR cycle i 
      force `jtag_tms = 1'b0;
      @(posedge `jtag_tclk); 
      jtag_data_out[i] = `jtag_tdo;
    end
    @(negedge `jtag_tclk); //stay at Shift DR last cycle 
    force `jtag_tms = 1'b1;
    @(posedge `jtag_tclk);
    jtag_data_out[i] = `jtag_tdo;
    @(negedge `jtag_tclk); //drive to Update DR
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); //drive to IDLE
    force `jtag_tms = 1'b0;
  end
  endtask

`else
  // Task for JTAG 2
  //jtag reset, for example: jtag_rst(100)
  task jtag_rst;
  input[31:0] rst_cycle;
  integer i;
  begin
    force `jtag_trst_b = 1'b1;
    force `jtag_tms = 1'b1;
  
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
    force `jtag_tms = 1'b1;
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
    force `jtag_tms = 1'b0;
    @(negedge `jtag_tclk); // read/write
    force `jtag_tms = 1'b0;
    @(negedge `jtag_tclk); // RS[0]
    force `jtag_tms = 1'b0;
    @(negedge `jtag_tclk); // RS[1]
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk);
    for(i=0; i<8; i=i+1)begin
      force `jtag_tms = ir_value[i];
      parity = parity ^ ir_value[i];
      @(negedge `jtag_tclk); // Shift IR 
    end
    force `jtag_tms = parity;
    @(negedge `jtag_tclk); // Parity
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); // IDLE
  end
  endtask
  
  //write DR
  task write_dr;
  input [143:0] jtag_data_in;
  input [8:0]   jtag_data_len;
  integer i;
  reg  parity;
  begin
    parity = 1'b1;
    @(negedge `jtag_tclk); // start
    force `jtag_tms = 1'b0;
    @(negedge `jtag_tclk); // read/write
    force `jtag_tms = 1'b0;
    @(negedge `jtag_tclk); // RS[0]
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); // RS[1]
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk);
    for(i=0; i<32; i=i+1)begin
      force `jtag_tms = jtag_data_in[i];
      parity = parity ^ jtag_data_in[i];
      @(negedge `jtag_tclk); // Shift DR 
    end
    force `jtag_tms = parity; // Parity
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); // Drive to IDLE
    force `jtag_tms = 1'b1;
  end
  endtask
  
  //Read DR
  task read_dr;
  input  [8:0]   jtag_data_len;
  output [143:0] jtag_data_out;
  reg    [143:0] jtag_data_out;
  integer i;
  reg  parity;
  begin
    parity = 1'b1;
    @(negedge `jtag_tclk); // start
    force `jtag_tms = 1'b0;
    @(negedge `jtag_tclk); // read/write
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); // RS[0]
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); // RS[1]
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms = 1'b1;
    @(posedge `jtag_tclk);
    release `jtag_tms;
    @(posedge `jtag_tclk); // Sync cycle
    for(i=0; i<32; i=i+1)begin
      @(posedge `jtag_tclk); // Shift DR 
      jtag_data_out[i] = `jtag_tms;
    end
    @(posedge `jtag_tclk); // Parity
    parity = `jtag_tms;
    @(negedge `jtag_tclk); // Trn
    force `jtag_tms = 1'b1;
    @(negedge `jtag_tclk); // to IDLE
    force `jtag_tms = 1'b1;
  end
  endtask
`endif

/*****************************************************
The following task has defined the task write_hadreg.
User can invoke this task to write the target register.
If user want to write register and set go,ex simultan
-eously,just add some identifiers in agreement such as
_go_ex,_go_nex,_ngo_ex,_ngo_nex.
Special condition:the registor Bypass was cut,just reserve
the interface to keep the compatibility with CK6xx and CK5xx
usage: write_hadreg(`target_reg_name,value)
       write_hadreg(`wbbr_go_ex,value)
*******************************************************/
task write_hadreg;
  input[6:0] reg_select;
  input[143:0] reg_value;
//  input[143:0] cpuscr_value;
  begin
    case(reg_select & 7'b0011111)
      `id,
      `pcfifo,
      `baba,
      `babb,
      `wbbr,
      `psr,
      `pc,
      `ir,
      `hcr,
      `daddr,
      `ddata : begin
        write_ir({1'b0,reg_select[6:0]});//select id
      	write_dr(reg_value,32);
      end

      `tracer,
      `mbca,
      `mbcb,
      `bama,
      `bamb,
      `bypass: begin
      	write_ir({1'b0,reg_select[6:0]});//select mbcb
      	write_dr(reg_value,8);
      end

      `hsr,
      `csr : begin
      	write_ir({1'b0,reg_select[6:0]});//select hsr
      	write_dr(reg_value,16);
      end
      
      `cpuscr : begin
        write_ir({1'b0,reg_select[6:0]});
        write_dr(reg_value,128);
      end

      default:$display("There is no target!");
    endcase
  end
endtask

/*****************************************************
The following task has defined the task read_hadreg.
User can invoke this task to read the target
register.
Special condition:the same to write_hadreg.
usage:read_hadreg(`target_reg_name,value)
*******************************************************/
task read_hadreg;
  input[6:0] reg_select;
//  output[143:0] jtag_cpuscr_out;
  output[143:0] jtag_data_out;
  reg[143:0] jtag_data_out;
//  reg[143:0] jtag_cpuscr_out;
  begin
    case(reg_select & 7'b0011111)
      `id,
      `pcfifo,
      `baba,
      `babb,
      `wbbr,
      `psr,
      `pc,
      `ir,
      `hcr,
      `daddr,
      `ddata : begin
        write_ir({1'b1,reg_select[6:0]});//select id
      	read_dr(32, jtag_data_out);
      end

      `tracer,
      `mbca,
      `mbcb,
      `bama,
      `bamb, 
      `bypass:begin
      	write_ir({1'b1,reg_select[6:0]});//select mbcb
      	read_dr(8, jtag_data_out);
      end

      `hsr,
      `csr : begin
      	write_ir({1'b1,reg_select[6:0]});//select hsr
      	read_dr(16, jtag_data_out);
      end

      `cpuscr : begin
        write_ir({1'b1,reg_select[6:0]});
        read_dr(128, jtag_data_out);
      end

      default:$display("There is no target!");
    endcase
  end
endtask	

/***********************************************************
The following task was defined to wait CPU enter into debug
mode.
************************************************************/
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

/***********************************************************
The following task was defined to check the cpu mode.
If the cpu has into debug mode, 
************************************************************/
task check_cpu_mode;
  reg[15:0] hsr_data_out;
  begin
    read_hadreg(`hsr,hsr_data_out);
    if(hsr_data_out[1:0]==2'b00)
      begin
      $display("----------------------------------------");
      $display("*** <CHECK> hsr value is:0x%h  ***   |",
               hsr_data_out[15:0]);
      $display("***  CPU is in Normal Mode!  ***       |"); 
      $display("----------------------------------------");
      end
    else if(hsr_data_out[1:0]==2'b01)
      begin
      $display("----------------------------------------");
      $display("*** <CHECK> hsr value is:0x%h  ***   |",
               hsr_data_out[15:0]);
      $display("***  CPU is in LowPower Mode!  ***     |"); 
      $display("----------------------------------------");
      end
    else if(hsr_data_out[1:0]==2'b10)
      begin
      $display("----------------------------------------");
      $display("*** <CHECK> hsr value is:0x%h  ***   |",
               hsr_data_out[15:0]);
      $display("***  CPU is in Debug Mode!  ***        |"); 
      $display("----------------------------------------");
      end
    else  
      begin 
      $display("----------------------------------------");
      $display("*** <CHECK> hsr value is:0x%h  ***   |",
               hsr_data_out[15:0]);
      $display("***  CPU is in Reserve Mode!  ***      |"); 
      $display("----------------------------------------");
      end
  end 
endtask 

