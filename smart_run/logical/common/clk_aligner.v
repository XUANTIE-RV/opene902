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

// &ModuleBeg; @22
module clk_aligner(
  clk_div_1,
  clk_div_2,
  clk_div_3,
  clk_div_4,
  clk_div_5,
  clk_div_6,
  clk_div_7,
  clk_div_8,
  clk_en,
  clk_en_1,
  clk_en_2,
  clk_en_3,
  clk_en_4,
  clk_en_5,
  clk_en_6,
  clk_en_7,
  clk_en_8,
  clkrst_b,
  cpu_clk,
  forever_cpuclk,
  gate_en0,
  gate_en1,
  paddr,
  penable,
  per_clk,
  pmu_clk,
  prdata,
  psel,
  pwdata,
  pwrite,
  wic_clk
);

// &Ports; @23
input           clk_div_1;      
input           clk_div_2;      
input           clk_div_3;      
input           clk_div_4;      
input           clk_div_5;      
input           clk_div_6;      
input           clk_div_7;      
input           clk_div_8;      
input           clk_en_1;       
input           clk_en_2;       
input           clk_en_3;       
input           clk_en_4;       
input           clk_en_5;       
input           clk_en_6;       
input           clk_en_7;       
input           clk_en_8;       
input           clkrst_b;       
input           forever_cpuclk; 
input           gate_en0;       
input           gate_en1;       
input   [11:0]  paddr;          
input           penable;        
input           psel;           
input   [2 :0]  pwdata;         
input           pwrite;         
output          clk_en;         
output          cpu_clk;        
output          per_clk;        
output          pmu_clk;        
output  [31:0]  prdata;         
output          wic_clk;        

// &Regs; @24
reg             clk_en;         
reg             gen_clk_en;     
reg     [2 :0]  input_clkratio; 
reg     [31:0]  prdata;         
reg             pre_clk_en;     
reg             pre_sysclk;     
reg             save_clk_en;    
reg     [2 :0]  save_clkratio;  
reg             save_sysclk;    
reg     [1 :0]  state_c;        
reg     [1 :0]  state_n;        
reg             sysclk;         

// &Wires; @25
wire            clk_div_1;      
wire            clk_div_2;      
wire            clk_div_3;      
wire            clk_div_4;      
wire            clk_div_5;      
wire            clk_div_6;      
wire            clk_div_7;      
wire            clk_div_8;      
wire            clk_en_1;       
wire            clk_en_2;       
wire            clk_en_3;       
wire            clk_en_4;       
wire            clk_en_5;       
wire            clk_en_6;       
wire            clk_en_7;       
wire            clk_en_8;       
wire            clkratio_chg_en; 
wire            clkrst_b;       
wire            cpu_clk;        
wire            forever_cpuclk; 
wire            gate_en0;       
wire            gate_en1;       
wire    [11:0]  paddr;          
wire            penable;        
wire            per_clk;        
wire            pmu_clk;        
wire    [2 :0]  pre_clkratio;   
wire            psel;           
wire    [2 :0]  pwdata;         
wire            pwrite;         
wire            wic_clk;        


parameter IDLE = 2'b00,WAIT_PRE_EN = 2'b01,WAIT_NEXT_EN = 2'b10,MASK_SYSCLK = 2'b11;

//==============================================================================
//                        finite state machine
//IDLE: wait clkratio change enable signal
//WAIT_PRE_EN : wait previous clock enable signal and mask the clock enable signal
//WAIT_NEXT_EN : wait next clock enable signal and mask the clock enable signal and system clock 
//MASK_SYSCLK : wait next clock enable singal and mask the system clock
//==============================================================================
always@(posedge per_clk or negedge clkrst_b)
begin
  if (!clkrst_b)
    input_clkratio[2:0] <= 3'b0;
  else if(psel && pwrite && penable)
  begin
    if (!paddr[11:0] )
      input_clkratio[2:0] <= pwdata[2:0];
  end
end

assign clkratio_chg_en = psel && pwrite && penable && !paddr[11:0] 
                      && !(pre_clkratio[2:0] ==pwdata[2:0]);

// &CombBeg; @50
always @( input_clkratio[2:0]
       or paddr[11:0]
       or psel
       or pwrite)
begin
if(psel && !pwrite)
begin
  if(!paddr[11:0] )
    prdata[31:0] = {29'b0, input_clkratio[2:0]};
  else 
    prdata[31:0] = 32'b0;
end
// &CombEnd; @58
end

   
//fsm state transition

always@(posedge forever_cpuclk or negedge clkrst_b)
//always@(posedge forever_cpuclk)
begin
  if(!clkrst_b)
    state_c[1:0] <= IDLE;
  else
    state_c[1:0] <= state_n[1:0];
end

// &CombBeg; @72
always @( clkratio_chg_en
       or state_c[1:0]
       or save_clk_en
       or pre_clk_en)
begin
  case(state_c[1:0]) // synopsys parallel_case
  IDLE:
  begin
    if (clkratio_chg_en)
      state_n[1:0] = WAIT_PRE_EN;
    else
      state_n[1:0] = IDLE;
  end
  WAIT_PRE_EN:
  begin
    if (save_clk_en)
      state_n[1:0] = WAIT_NEXT_EN;
    else
      state_n[1:0] = WAIT_PRE_EN;
  end
  WAIT_NEXT_EN:
  begin
//    if(cur_clk_en)
    if(pre_clk_en)
      state_n[1:0] = MASK_SYSCLK;
//      state_n[1:0] = IDLE;
    else
      state_n[1:0] = WAIT_NEXT_EN;
  end
  MASK_SYSCLK:
  begin
    if(pre_clk_en)
      state_n[1:0] = IDLE;
    else
      state_n[1:0] = MASK_SYSCLK;
  end
  default:
  begin
    state_n[1:0] = IDLE;
  end
  endcase
// &CombEnd; @109
end


//fsm output signal
// &CombBeg; @113
always @( save_sysclk
       or pre_sysclk
       or state_c[1:0]
       or pre_clk_en)
begin
case(state_c[1:0])
  IDLE:
  begin
    gen_clk_en = pre_clk_en;
    sysclk = pre_sysclk;
//    cpuclk = forever_cpuclk;
  end
  WAIT_PRE_EN:
  begin
//    clk_en = save_clk_en;
//    gen_clk_en = save_clk_en;
    gen_clk_en = 0;
    sysclk = save_sysclk;
//    cpuclk = forever_cpuclk;
  end
  WAIT_NEXT_EN:
  begin
    gen_clk_en = 0;
    sysclk = 0;
//    cpuclk = 0;
  end
  MASK_SYSCLK:
  begin
    gen_clk_en = pre_clk_en;
    sysclk = 0;
//    cpuclk = 0;
  end
  default:
  begin
    gen_clk_en = pre_clk_en;
    sysclk = pre_sysclk;
//    cpuclk = forever_cpuclk;
  end
endcase
// &CombEnd; @148
end

//===============================================================
//      clk_en and sysclk generate for different type clkratio 
//===============================================================

assign pre_clkratio[2:0] = input_clkratio[2:0];


always @(posedge forever_cpuclk or negedge clkrst_b)
begin
  if(!clkrst_b)
    save_clkratio[2:0] <= 3'b0;
  else if(clkratio_chg_en)
    save_clkratio[2:0] <= pre_clkratio[2:0];
end


// &CombBeg; @166
always @( clk_div_2
       or clk_en_7
       or clk_div_7
       or clk_div_4
       or clk_div_5
       or clk_en_5
       or clk_div_6
       or pre_clkratio[2:0]
       or clk_div_8
       or clk_div_1
       or clk_en_3
       or clk_en_8
       or clk_en_2
       or clk_en_4
       or clk_div_3
       or clk_en_6
       or clk_en_1)
begin
  case (pre_clkratio[2:0])
  3'b000:
  begin 
    pre_clk_en = clk_en_1;   // 1:1
    pre_sysclk = clk_div_1;
  end
  3'b001: 
  begin 
    pre_clk_en = clk_en_2;   // 1:2
    pre_sysclk = clk_div_2;
  end
  3'b010:
  begin 
    pre_clk_en = clk_en_3;   // 1:3
    pre_sysclk = clk_div_3;
  end
  3'b011: 
  begin 
    pre_clk_en = clk_en_4;   // 1:4
    pre_sysclk = clk_div_4;
  end
  3'b100: 
  begin 
    pre_clk_en = clk_en_5;   // 1:5
    pre_sysclk = clk_div_5;
  end
  3'b101: 
  begin 
    pre_clk_en = clk_en_6;   // 1:6
    pre_sysclk = clk_div_6;
  end
  3'b110: 
  begin 
    pre_clk_en = clk_en_7;   // 1:7
    pre_sysclk = clk_div_7;
  end
  3'b111: 
  begin 
    pre_clk_en = clk_en_8;   // 1:8
    pre_sysclk = clk_div_8;
  end
  default:
  begin 
    pre_clk_en = clk_en_1;   // 1:1
    pre_sysclk = clk_div_1;
  end
  endcase
// &CombEnd; @214
end

// &CombBeg; @216
always @( clk_div_2
       or clk_en_7
       or clk_div_7
       or clk_div_4
       or clk_en_5
       or clk_div_5
       or clk_div_6
       or clk_div_8
       or clk_en_3
       or clk_div_1
       or clk_en_8
       or save_clkratio[2:0]
       or clk_en_2
       or clk_en_4
       or clk_en_6
       or clk_div_3
       or clk_en_1)
begin
  case (save_clkratio[2:0])
  3'b000:
  begin 
    save_clk_en = clk_en_1;   // 1:1
    save_sysclk = clk_div_1;
  end
  3'b001: 
  begin 
    save_clk_en = clk_en_2;   // 1:2
    save_sysclk = clk_div_2;
  end
  3'b010:
  begin 
    save_clk_en = clk_en_3;   // 1:3
    save_sysclk = clk_div_3;
  end
  3'b011: 
  begin 
    save_clk_en = clk_en_4;   // 1:4
    save_sysclk = clk_div_4;
  end
  3'b100: 
  begin 
    save_clk_en = clk_en_5;   // 1:5
    save_sysclk = clk_div_5;
  end
  3'b101: 
  begin 
    save_clk_en = clk_en_6;   // 1:6
    save_sysclk = clk_div_6;
  end
  3'b110: 
  begin 
    save_clk_en = clk_en_7;   // 1:7
    save_sysclk = clk_div_7;
  end
  3'b111: 
  begin 
    save_clk_en = clk_en_8;   // 1:8
    save_sysclk = clk_div_8;
  end
  default:
  begin 
    save_clk_en = clk_en_1;   // 1:1
    save_sysclk = clk_div_1;
  end
  endcase
// &CombEnd; @264
end

// &Force("output","per_clk"); @266

//===========================================================
//                output generate singal
//===========================================================

//assign clkgen_cpuclk = forever_cpuclk;

//this mux is for eliminate race condition
// &CombBeg; @275
always @( gen_clk_en)
begin
  case(1'b1) // synopsys infer_mux
    1'b1: clk_en <= gen_clk_en;
    1'b0: clk_en <= 1'b0;
  endcase
// &CombEnd; @280
end


assign wic_clk = forever_cpuclk;
assign pmu_clk = sysclk;

//assign cpu_clk = forever_cpuclk;
// &Instance("soc_gated_clk_cell", "x_soc_gated_cpuclk_cell");  @287
soc_gated_clk_cell  x_soc_gated_cpuclk_cell (
  .SE             (1'b0          ),
  .clk_in         (forever_cpuclk),
  .clk_out        (cpu_clk       ),
  .external_en    (gate_en0      )
);

// &Connect ( @288
//   .clk_in               (forever_cpuclk      ), @289
//   .clk_out              (cpu_clk             ), @290
//   .external_en          (gate_en0            ), @291
//   .SE                   (1'b0                ) @292
//   );       @293

//assign per_clk = sysclk;      
// &Instance("soc_gated_clk_cell", "x_soc_gated_sysclk_cell");  @296
soc_gated_clk_cell  x_soc_gated_sysclk_cell (
  .SE          (1'b0       ),
  .clk_in      (sysclk     ),
  .clk_out     (per_clk    ),
  .external_en (gate_en1   )
);

// &Connect ( @297
//    .clk_in               (sysclk              ), @298
//    .clk_out              (per_clk             ), @299
//    .external_en          (gate_en1            ), @300
//    .SE                   (1'b0                )   @301
//   );          @302


// &ModuleEnd; @305
endmodule


