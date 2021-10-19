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

`define sout          tb.uart0_sout
`define sin           tb.uart0_sin

module uart_mnt();

//#############################################
//            Create baud_clk
//#############################################
parameter FCPU = 1000000000/`CLK_PERIOD;
parameter BAUD = 19200;
parameter CYCLE_CUNT=FCPU/(BAUD*16) - 1;


reg[31:0] div_counter;

always @(posedge `clk or negedge `rst_b)
begin
  if(!`rst_b)
  begin
    div_counter[31:0]<=CYCLE_CUNT;
  end
  else if(div_counter[31:0]==32'b0)
  begin
    div_counter[31:0]<=CYCLE_CUNT;
  end
  else 
  begin
    div_counter[31:0]<=div_counter[31:0] - 1'b1;
  end
end

assign baud_clk=(div_counter[31:0]>=(CYCLE_CUNT/2))?0:1;


//#############################################
//            Receive data
//#############################################

reg sout_flop;
reg trig_count_en;
reg [4:0] trig_count;
reg shift_en;
reg [3:0] shift_count;
reg [3:0] capture_time;
reg[7:0] pack_data;

always @(posedge baud_clk or negedge `rst_b)
begin
  if(!`rst_b)
    sout_flop<=1'b0;
  else
    sout_flop<=`sout;
end

assign trig = sout_flop && !`sout && !shift_en;


always @(posedge baud_clk or negedge `rst_b)
begin
  if(!`rst_b)
    trig_count_en<=1'b0;
  else if(trig)
    trig_count_en<=1'b1;
  else if(shift_en)
    trig_count_en<=1'b0;
end

always @(posedge baud_clk or negedge `rst_b)
begin
  if(!`rst_b)
    trig_count[4:0]<=5'b0;
  else if(!trig_count_en)
    trig_count[4:0]<=5'b0;
  else if(trig_count_en)
    trig_count[4:0]<= trig_count[4:0] + 1;
end

always @(posedge baud_clk or negedge `rst_b)
begin
  if(!`rst_b)
    shift_en<=1'b0;
  else if(trig_count[4:0]==22)
    shift_en<=1'b1;
  else if(capture_time[3:0]==8)
    shift_en<=1'b0;
end

always @(posedge baud_clk or negedge `rst_b)
begin
  if(!`rst_b)
    shift_count[3:0]<=4'b0;
  else if(trig)
    shift_count[3:0]<=4'b0;
  else if(shift_en)
    shift_count[3:0]<= shift_count[3:0] + 1;
end

assign capture_en = shift_en && (shift_count[3:0]==0);

always @(posedge baud_clk or negedge `rst_b)
begin
  if(!`rst_b)
    capture_time[3:0]<=4'b0;
  else if(trig)
    capture_time[3:0]<=4'b0;
  else if(capture_en)
    capture_time[3:0]<= capture_time[3:0] + 1;
  end

always @(posedge baud_clk or negedge `rst_b)
begin
  if(!`rst_b)
  begin 
    pack_data[7:0]<=8'b0;
  end
  else if (capture_en)
  begin
    pack_data[7:0]<={`sout,pack_data[7:1]};
  end
  else 
  begin
    pack_data[7:0]<=pack_data[7:0];
  end
end

assign print_en = (capture_time[3:0]==8) && shift_en;

//#############################################
//            Print log
//#############################################
integer output_file;

initial
begin
  output_file=$fopen("uart_output.inf","w");
end

always @(posedge baud_clk )
begin
  if(print_en)
  begin
    $fwrite(output_file,"%C",pack_data[7:0]);
    $write("\033[0;31m%C\033[0m",pack_data[7:0]);
  end 
end

endmodule
