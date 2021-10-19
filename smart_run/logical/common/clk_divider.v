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
module clk_divider(
  clk_div_1,
  clk_div_2,
  clk_div_3,
  clk_div_4,
  clk_div_5,
  clk_div_6,
  clk_div_7,
  clk_div_8,
  clk_en_1,
  clk_en_2,
  clk_en_3,
  clk_en_4,
  clk_en_5,
  clk_en_6,
  clk_en_7,
  clk_en_8,
  osc_clk,
  pad_cpu_rst_b
);

// &Ports; @23
input          osc_clk;           
input          pad_cpu_rst_b;     
output         clk_div_1;         
output         clk_div_2;         
output         clk_div_3;         
output         clk_div_4;         
output         clk_div_5;         
output         clk_div_6;         
output         clk_div_7;         
output         clk_div_8;         
output         clk_en_1;          
output         clk_en_2;          
output         clk_en_3;          
output         clk_en_4;          
output         clk_en_5;          
output         clk_en_6;          
output         clk_en_7;          
output         clk_en_8;          

// &Regs; @24
reg            clk_div_3_en_1;    
reg            clk_div_3_en_2;    
reg            clk_div_3_toggle_1; 
reg            clk_div_3_toggle_2; 
reg            clk_div_5_toggle_1; 
reg            clk_div_5_toggle_2; 
reg            clk_div_6_en;      
reg            clk_div_6_toggle;  
reg            clk_div_7_toggle_1; 
reg            clk_div_7_toggle_2; 
reg     [2:0]  cnt_5;             
reg     [2:0]  cnt_7;             
reg            div_2_next_state;  
reg            div_2_state;       
reg     [1:0]  div_3_next_state;  
reg     [1:0]  div_3_state;       
reg            div_4_next_state;  
reg            div_4_state;       
reg     [1:0]  div_6_next_state;  
reg     [1:0]  div_6_state;       
reg            div_8_next_state;  
reg            div_8_state;       

// &Wires; @25
wire           clk_div_1;         
wire           clk_div_2;         
wire           clk_div_3;         
wire           clk_div_4;         
wire           clk_div_4_toggle;  
wire           clk_div_5;         
wire           clk_div_5_en_1;    
wire           clk_div_5_en_2;    
wire           clk_div_6;         
wire           clk_div_7;         
wire           clk_div_7_en_1;    
wire           clk_div_7_en_2;    
wire           clk_div_8;         
wire           clk_div_8_toggle;  
wire           clk_en_1;          
wire           clk_en_2;          
wire           clk_en_3;          
wire           clk_en_4;          
wire           clk_en_5;          
wire           clk_en_6;          
wire           clk_en_7;          
wire           clk_en_8;          
wire           osc_clk;           
wire           pad_cpu_rst_b;     


parameter STATE0 = 1'b0, STATE1 = 1'b1;
parameter DIV3_STATE0 = 2'b00,DIV3_STATE1 = 2'b01,DIV3_STATE2 = 2'b10;
parameter DIV1=3'b000,DIV2=3'b001,DIV3=3'b010,DIV4=3'b011,
          DIV5=3'b100,DIV6=3'b101,DIV7=3'b110,DIV8=3'b111;

//============================================================
// osc_clk domain clock divider
// 1. if reset falling edge exists when pll clk toggles,
//    using div_rst_pulse_b to reset all dividers to 0
// 2. if reset falling edge doesn't exist when pll clk toggles,
//    assume all flops are either 1 or 0
//============================================================

//generate 1/1 clock

assign clk_div_1 = osc_clk;

//generate 1/1 clock enable 

assign clk_en_1 = 1;

// generate 1/2 clock
always @(posedge osc_clk or negedge pad_cpu_rst_b)
begin
  if (!pad_cpu_rst_b)
    div_2_state <= 1'b0;
  else
    div_2_state <= div_2_next_state;
end

// &CombBeg; @57
always @( div_2_state)
begin
  div_2_next_state = 1'bx;
  case(div_2_state)
    STATE0: begin
              div_2_next_state = STATE1;
    end
    STATE1: begin
              div_2_next_state = STATE0;
    end
  endcase
// &CombEnd; @67
end

assign clk_div_2        = div_2_state;
assign clk_div_4_toggle = (div_2_state == STATE1);

//generate 1/2 clock enable
assign clk_en_2         = ~div_2_state;


// generate 1/3 clock
always@(posedge osc_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
    div_3_state[1:0] <= 2'b0;
  else
    div_3_state[1:0] <= div_3_next_state[1:0];
end

// &CombBeg; @85
always @( div_3_state)
begin
  case(div_3_state)
    DIV3_STATE0:begin
         div_3_next_state[1:0] = DIV3_STATE1;
         clk_div_3_en_2 = 1'b0;
         clk_div_3_en_1 =1'b1;
         end
    DIV3_STATE1:begin
         div_3_next_state[1:0] = DIV3_STATE2;
         clk_div_3_en_2 = 1'b0;
         clk_div_3_en_1 =1'b0;
         end
    DIV3_STATE2:begin
         div_3_next_state[1:0] = DIV3_STATE0;
         clk_div_3_en_2 = 1'b1;
         clk_div_3_en_1 =1'b0;
         end
    default : begin
         div_3_next_state[1:0] = DIV3_STATE0;
         clk_div_3_en_2 = 1'b1; 
         clk_div_3_en_1 = 1'b0;
	 end
  endcase
// &CombEnd; @108
end

always @(posedge osc_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
    clk_div_3_toggle_1 <= 1'b0;
  else if(clk_div_3_en_1)
    clk_div_3_toggle_1 <= ~clk_div_3_toggle_1;
end

always @(negedge osc_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
    clk_div_3_toggle_2 <= 1'b0;
  else if(clk_div_3_en_2)
    clk_div_3_toggle_2 <= ~clk_div_3_toggle_2;
end

assign clk_div_3 = clk_div_3_toggle_1^clk_div_3_toggle_2;

//generate 1/3 clock enable
assign clk_en_3 = clk_div_3_en_1;

//reg clk_div_3;
//always @(clk_div_3_toggle_1 or clk_div_3_toggle_2)
//begin
//  clk_div_3 = clk_div_3_toggle_1 ^ clk_div_3_toggle_2;
//end

// generate 1/5 clock
always@(posedge osc_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
    cnt_5[2:0] <= 3'b0;
  else if(cnt_5[2])
    cnt_5[2:0] <= 3'b0;
  else
    cnt_5[2:0] <= cnt_5[2:0] + 3'b001;
end

assign clk_div_5_en_1 = ~|cnt_5[2:0];
assign clk_div_5_en_2 = &cnt_5[1:0];

always @(posedge osc_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
    clk_div_5_toggle_1 <= 1'b0;
  else if(clk_div_5_en_1)
    clk_div_5_toggle_1 <= ~clk_div_5_toggle_1;
end

always @(negedge osc_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
    clk_div_5_toggle_2 <= 1'b0;
  else if(clk_div_5_en_2)
     clk_div_5_toggle_2 <= ~clk_div_5_toggle_2;
end

assign clk_div_5 = clk_div_5_toggle_1^clk_div_5_toggle_2;

//generate 1/5 clock enable

assign clk_en_5 = clk_div_5_en_1;

// generate 1/7 clock
always@(posedge osc_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
    cnt_7[2:0] <= 3'b0;
  else if(&cnt_7[2:1])
    cnt_7[2:0] <= 3'b0;
  else
    cnt_7[2:0] <= cnt_7[2:0] + 3'b001;
end

assign clk_div_7_en_1 = ~|cnt_7[2:0];
assign clk_div_7_en_2 = (cnt_7[2:0]==3'b100);

always @(posedge osc_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
    clk_div_7_toggle_1 <= 1'b0; 
  else if(clk_div_7_en_1)
    clk_div_7_toggle_1 <= ~clk_div_7_toggle_1;
end

always @(negedge osc_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
    clk_div_7_toggle_2 <= 1'b0;
  else if(clk_div_7_en_2) 
    clk_div_7_toggle_2 <= ~clk_div_7_toggle_2;
end

assign clk_div_7 = clk_div_7_toggle_1^clk_div_7_toggle_2;

 
//generate 1/7 clock enable
 
assign clk_en_7 = clk_div_7_en_1;


// generate 1/4 clock
always @(posedge osc_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
    div_4_state <= 1'b0;
  else
    div_4_state <= div_4_next_state;
end

// &CombBeg; @220
always @( div_4_state
       or clk_div_4_toggle)
begin
  div_4_next_state = 1'bx;
  case(div_4_state)
    STATE0: begin
        if(clk_div_4_toggle)
          div_4_next_state = STATE1;
        else
          div_4_next_state = STATE0;
    end
    STATE1: begin
        if(clk_div_4_toggle)
          div_4_next_state = STATE0;
        else
          div_4_next_state = STATE1;
    end
  endcase
// &CombEnd; @236
end

assign clk_div_4        = div_4_state;
assign clk_div_8_toggle = (div_4_state == STATE1) & (div_2_state == STATE1);

//generate 1/4 clock enable

assign clk_en_4 = (div_4_state == STATE0) & (div_2_state == STATE1);

// generate 1/6 clock
always @(posedge osc_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
    div_6_state[1:0] <= 2'b0;
  else
    div_6_state[1:0] <= div_6_next_state[1:0];
end

// &CombBeg; @254
always @( div_6_state[1:0])
begin
  div_6_next_state = 1'bx;
  clk_div_6_en     = 1'bx;
  case(div_6_state[1:0])
    DIV3_STATE0: 
    begin
      div_6_next_state = DIV3_STATE1;
      clk_div_6_en     = 1'b0;
    end
    DIV3_STATE1:
    begin
      div_6_next_state = DIV3_STATE2;
      clk_div_6_en     = 1'b0;
    end
    DIV3_STATE2:
    begin
      div_6_next_state = DIV3_STATE0;
      clk_div_6_en     = 1'b1;
    end
    default:
    begin
      div_6_next_state = DIV3_STATE0;
      clk_div_6_en     = 1'b0;
    end
  endcase
// &CombEnd; @279
end

always @(posedge osc_clk or negedge pad_cpu_rst_b )
begin
  if (!pad_cpu_rst_b)
    clk_div_6_toggle <= 1'b0;
  else if(clk_div_6_en)
    clk_div_6_toggle <= ~clk_div_6_toggle;
end

assign clk_div_6 = clk_div_6_toggle;

//generate 1/6 clock enable

assign clk_en_6 = ~clk_div_6_toggle & clk_div_6_en;


// generate 1/8 clock
always @(posedge osc_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
    div_8_state <= 1'b0;
  else  
    div_8_state <= div_8_next_state;
end

// &CombBeg; @305
always @( clk_div_8_toggle
       or div_8_state)
begin
  div_8_next_state = 1'bx;
  case(div_8_state)
    STATE0: begin
        if(clk_div_8_toggle)
          div_8_next_state = STATE1;
        else
          div_8_next_state = STATE0;
    end
    STATE1: begin
        if(clk_div_8_toggle)
          div_8_next_state = STATE0;
        else
          div_8_next_state = STATE1;
    end
  endcase
// &CombEnd; @321
end

assign clk_div_8      = div_8_state;

//generate 1/8 clock enable

assign clk_en_8 = ~div_8_state & clk_div_8_toggle;

// &ModuleEnd; @329
endmodule


