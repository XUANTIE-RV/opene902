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
module ahb_fifo(
  biu_pad_haddr,
  biu_pad_hburst,
  biu_pad_hprot,
  biu_pad_hsize,
  biu_pad_htrans,
  biu_pad_hwrite,
  counter_num0,
  cpu_clk,
  cpu_rst_b,
  fifo_biu_hready,
  fifo_pad_haddr,
  fifo_pad_hburst,
  fifo_pad_hprot,
  fifo_pad_hsize,
  fifo_pad_htrans,
  fifo_pad_hwrite,
  pad_biu_hready
);

// &Ports; @20
input   [31:0]  biu_pad_haddr;      
input   [2 :0]  biu_pad_hburst;     
input   [3 :0]  biu_pad_hprot;      
input   [2 :0]  biu_pad_hsize;      
input   [1 :0]  biu_pad_htrans;     
input           biu_pad_hwrite;     
input   [31:0]  counter_num0;       
input           cpu_clk;            
input           cpu_rst_b;          
input           pad_biu_hready;     
output          fifo_biu_hready;    
output  [31:0]  fifo_pad_haddr;     
output  [2 :0]  fifo_pad_hburst;    
output  [3 :0]  fifo_pad_hprot;     
output  [2 :0]  fifo_pad_hsize;     
output  [1 :0]  fifo_pad_htrans;    
output          fifo_pad_hwrite;    

// &Regs; @21
reg     [1 :0]  burst_counter;      
reg             burst_counter_dec;  
reg             burst_counter_start; 
reg             cur_state;          
reg             entry_vld;          
reg             hready_mask;        
reg             next_state;         
reg     [45:0]  output_data;        

// &Wires; @22
wire    [31:0]  biu_pad_haddr;      
wire    [2 :0]  biu_pad_hburst;     
wire            biu_pad_hlock;      
wire    [3 :0]  biu_pad_hprot;      
wire    [2 :0]  biu_pad_hsize;      
wire    [1 :0]  biu_pad_htrans;     
wire            biu_pad_hwrite;     
wire            burst_ctrl;         
wire            burst_trans;        
wire            count_done;         
wire            counter_done;       
wire            counter_en;         
wire    [31:0]  counter_num0;       
wire            cpu_clk;            
wire            cpu_rst_b;          
wire            create_en;          
wire            create_en0;         
wire            fifo_biu_hready;    
wire            fifo_bypass;        
wire    [31:0]  fifo_pad_haddr;     
wire    [2 :0]  fifo_pad_hburst;    
wire            fifo_pad_hlock;     
wire    [3 :0]  fifo_pad_hprot;     
wire    [2 :0]  fifo_pad_hsize;     
wire    [1 :0]  fifo_pad_htrans;    
wire            fifo_pad_hwrite;    
wire    [54:0]  input_data;         
wire    [54:0]  output_data0;       
wire            pad_biu_hready;     
wire            pop_en;             
wire            pop_req;            
wire            raddr_hit;          


//set delay area

parameter IMEM_START = 32'h00000000;
parameter IMEM_END   = 32'h0001ffff;
parameter DMEM_START = 32'h20000000;
parameter DMEM_END   = 32'h2001ffff;
parameter SMEM_START = 32'h60000000;
parameter SMEM_END   = 32'h6001ffff;

assign raddr_hit = ((biu_pad_haddr[31:0] >= SMEM_START) && (biu_pad_haddr[31:0] <= SMEM_END)
                 || (biu_pad_haddr[31:0] >= DMEM_START) && (biu_pad_haddr[31:0] <= DMEM_END) 
                   ) && biu_pad_hprot[3];
// &Force("nonport", "raddr_hit");            @43
//****************************************************
//                creat_ptr maintenance
//****************************************************
// when entry is invalid delay entry can be bypassed if any of following conditions is met:
// 1. write trans 2. sequential burst trans 3. addr miss delay area 
assign fifo_bypass = (biu_pad_hwrite || burst_trans || !raddr_hit) && !entry_vld || ( counter_num0[31:0] == 32'h0)  ;
assign create_en = biu_pad_htrans[1] && !entry_vld && !fifo_bypass;

//monitor burst trans
assign burst_ctrl = create_en &&  biu_pad_hburst[1];
assign burst_trans = (cur_state == 1'b1) ; 
//burst fsm
always @(posedge cpu_clk or negedge cpu_rst_b)
begin
  if (!cpu_rst_b) 
    cur_state <= 1'b0;
  else
    cur_state <= next_state;
end

// &CombBeg; @64
always @( cur_state
       or burst_ctrl
       or fifo_biu_hready
       or count_done
       or biu_pad_htrans[1])
begin
burst_counter_start = 1'b0 ;
burst_counter_dec   = 1'b0 ;

case(cur_state)
1'b0:
  begin
    if(burst_ctrl)
      begin
        next_state = 1'b1;
        burst_counter_start = 1'b1;       
      end
    else
      next_state = 1'b0;
  end
1'b1:
  begin
   if (count_done && fifo_biu_hready)
     begin
       next_state = 1'b0;
     end
   else if(biu_pad_htrans[1] && fifo_biu_hready )
     begin
       burst_counter_dec = 1'b1; 
       next_state = 1'b1;
     end 
   else
     next_state = 1'b1;
  end
endcase
// &CombEnd; @94
end

//burst counter
always @(posedge cpu_clk  or negedge cpu_rst_b)
begin
  if (!cpu_rst_b)
    burst_counter[1:0] <= 2'b0;
  else if (burst_counter_start)  // wrap initial value
    burst_counter[1:0] <= 2'b10;
  else if (burst_counter_dec)
    burst_counter[1:0] <= burst_counter[1:0] - 1'b1;
  else
    burst_counter[1:0] <= burst_counter[1:0];
end

assign count_done = (burst_counter[1:0] == 2'b0);
//****************************************************
//                entry_vld maintenance
//****************************************************
always @(posedge cpu_clk or negedge cpu_rst_b)
begin
   if (!cpu_rst_b) 
     entry_vld <= 1'b0;
   else if (create_en)
     entry_vld <= 1'b1;
   else if (pop_en)
     entry_vld <= 1'b0;
end
  
//****************************************************
//                entry delay counter maintenance
//****************************************************


assign counter_en = create_en;
// &Instance("ahb_fifo_counter", "x_counter_entry0"); @129
ahb_fifo_counter  x_counter_entry0 (
  .counter_done (counter_done),
  .counter_en   (counter_en  ),
  .counter_load (counter_num0),
  .cpu_clk      (cpu_clk     ),
  .cpu_rst_b    (cpu_rst_b   )
);

// &Connect (.counter_load (counter_num0           ), @130
//           .counter_en   (counter_en             ), @131
//           .counter_done (counter_done           ) @132
//          );  @133

//****************************************************
//                pop logic maintenance
//****************************************************

assign pop_req = counter_done && entry_vld;
assign pop_en  = pop_req && pad_biu_hready; 


//****************************************************
//                entry content
//****************************************************
assign biu_pad_hlock = 1'b0;
assign input_data[45:0] = {biu_pad_hburst[2], biu_pad_hwrite, biu_pad_haddr[31:0], biu_pad_hburst[1:0], biu_pad_hlock, 
                            biu_pad_hprot[3:0], biu_pad_hsize[2:0], biu_pad_htrans[1:0]} ;


assign create_en0 = create_en ;

// &Instance("ahb_fifo_entry", "x_ahb_fifo_entry0"); @156
ahb_fifo_entry  x_ahb_fifo_entry0 (
  .create_en    (create_en0  ),
  .data_in      (input_data  ),
  .data_out     (output_data0),
  .entry_clk    (cpu_clk     ),
  .entry_rst_b  (cpu_rst_b   )
);

// &Connect (.entry_clk       (cpu_clk            ), @157
//           .entry_rst_b     (cpu_rst_b          ),         @158
//           .data_in         (input_data         ), @159
//           .create_en       (create_en0         ), @160
//           .data_out        (output_data0       ) @161
// ); @162


// &CombBeg; @165
always @( pop_en
       or output_data0[45:0])
begin
case (pop_en)
  1'b0:  output_data[45:0] = 46'b0;
  1'b1:  output_data[45:0] = output_data0[45:0];
  default:output_data[45:0] = 46'b0;
endcase
// &CombEnd; @171
end



//****************************************************
//               i/o interface
//****************************************************
//mask ready signal to acheive trans delay
always @(posedge cpu_clk or negedge cpu_rst_b)
begin
  if (!cpu_rst_b) 
    hready_mask <= 1'b1;
  else if (create_en)
    hready_mask <= 1'b0;
  else if (pop_en)
    hready_mask <= 1'b1;
  else
    hready_mask <= hready_mask;
end
  

assign fifo_pad_htrans[1:0] =  fifo_bypass ? biu_pad_htrans[1:0] : output_data[1:0];
assign fifo_pad_hsize[2:0]  =  fifo_bypass ? biu_pad_hsize[2:0] : output_data[4:2];
assign fifo_pad_hprot[3:0]  =  fifo_bypass ? biu_pad_hprot[3:0] : output_data[8:5];
assign fifo_pad_hlock       =  fifo_bypass ? biu_pad_hlock : output_data[9];
assign fifo_pad_hburst[2:0] =  fifo_bypass ? biu_pad_hburst[2:0] : {output_data[45],output_data[11:10]};
assign fifo_pad_haddr[31:0] =  fifo_bypass ? biu_pad_haddr[31:0] : output_data[43:12];
assign fifo_pad_hwrite      =  fifo_bypass ? biu_pad_hwrite : output_data[44];


// &Force("nonport", "fifo_pad_hlock"); @204

assign fifo_biu_hready = pad_biu_hready && hready_mask;
// &Force("output", "fifo_biu_hready"); @208

// &ModuleEnd; @210
endmodule


