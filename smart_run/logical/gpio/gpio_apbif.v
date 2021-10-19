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

`define gpio_swporta_dr_OFFSET    5'b00000
`define gpio_swporta_ddr_OFFSET   5'b00001
`define gpio_swporta_ctl_OFFSET   5'b00010

`define gpio_inten_OFFSET         5'b01100
`define gpio_intmask_OFFSET       5'b01101
`define gpio_inttype_level_OFFSET 5'b01110
`define gpio_int_polarity_OFFSET  5'b01111
`define gpio_intstatus_OFFSET     5'b10000
`define gpio_raw_intstatus_OFFSET 5'b10001

`define gpio_porta_eoi_OFFSET     5'b10011
`define gpio_ext_porta_OFFSET     5'b10100

`define gpio_ls_sync_OFFSET       5'b11000


// &ModuleBeg; @38
module gpio_apbif(
  gpio_ext_porta_rb,
  gpio_int_polarity,
  gpio_inten,
  gpio_intmask,
  gpio_intstatus,
  gpio_inttype_level,
  gpio_ls_sync,
  gpio_porta_eoi,
  gpio_raw_intstatus,
  gpio_swporta_ctl,
  gpio_swporta_ddr,
  gpio_swporta_dr,
  paddr,
  pclk,
  penable,
  prdata,
  presetn,
  psel,
  pwdata,
  pwrite
);

// &Ports; @39
input   [7 :0]  gpio_ext_porta_rb;     
input   [7 :0]  gpio_intstatus;        
input   [7 :0]  gpio_raw_intstatus;    
input   [6 :2]  paddr;                 
input           pclk;                  
input           penable;               
input           presetn;               
input           psel;                  
input   [31:0]  pwdata;                
input           pwrite;                
output  [7 :0]  gpio_int_polarity;     
output  [7 :0]  gpio_inten;            
output  [7 :0]  gpio_intmask;          
output  [7 :0]  gpio_inttype_level;    
output          gpio_ls_sync;          
output  [7 :0]  gpio_porta_eoi;        
output  [7 :0]  gpio_swporta_ctl;      
output  [7 :0]  gpio_swporta_ddr;      
output  [7 :0]  gpio_swporta_dr;       
output  [31:0]  prdata;                

// &Regs; @40
reg     [3 :0]  gpio_int_polarity_wen; 
reg     [3 :0]  gpio_inten_wen;        
reg     [3 :0]  gpio_intmask_wen;      
reg     [3 :0]  gpio_inttype_level_wen; 
reg     [3 :0]  gpio_ls_sync_wen;      
reg     [3 :0]  gpio_porta_eoi_wen;    
reg     [3 :0]  gpio_swporta_ctl_wen;  
reg     [3 :0]  gpio_swporta_ddr_wen;  
reg     [3 :0]  gpio_swporta_dr_wen;   
reg     [31:0]  int_gpio_int_polarity; 
reg     [31:0]  int_gpio_inten;        
reg     [31:0]  int_gpio_intmask;      
reg     [31:0]  int_gpio_inttype_level; 
reg     [31:0]  int_gpio_ls_sync;      
reg     [31:0]  int_gpio_porta_eoi;    
reg     [31:0]  int_gpio_swporta_ctl;  
reg     [31:0]  int_gpio_swporta_ddr;  
reg     [31:0]  int_gpio_swporta_dr;   
reg     [31:0]  iprdata;               
reg     [31:0]  prdata;                
reg     [31:0]  pwdata_int;            
reg     [31:0]  ri_gpio_ext_porta_rb;  
reg     [31:0]  ri_gpio_int_polarity;  
reg     [31:0]  ri_gpio_inten;         
reg     [31:0]  ri_gpio_intmask;       
reg     [31:0]  ri_gpio_intstatus;     
reg     [31:0]  ri_gpio_inttype_level; 
reg     [31:0]  ri_gpio_ls_sync;       
reg     [31:0]  ri_gpio_raw_intstatus; 
reg     [31:0]  ri_gpio_swporta_ctl;   
reg     [31:0]  ri_gpio_swporta_ddr;   
reg     [31:0]  ri_gpio_swporta_dr;    

// &Wires; @41
wire    [7 :0]  gpio_ext_porta_rb;     
wire    [7 :0]  gpio_int_polarity;     
wire    [7 :0]  gpio_inten;            
wire    [7 :0]  gpio_intmask;          
wire    [7 :0]  gpio_intstatus;        
wire    [7 :0]  gpio_inttype_level;    
wire            gpio_ls_sync;          
wire    [7 :0]  gpio_porta_eoi;        
wire    [7 :0]  gpio_raw_intstatus;    
wire    [7 :0]  gpio_swporta_ctl;      
wire    [7 :0]  gpio_swporta_ddr;      
wire    [7 :0]  gpio_swporta_dr;       
wire    [6 :2]  paddr;                 
wire            pclk;                  
wire            penable;               
wire            presetn;               
wire            psel;                  
wire    [31:0]  pwdata;                
wire            pwrite;                


// pwdata_int assigns to pwdata and padded with zero's
// &CombBeg; @44
always @( pwdata[31:0])
begin
  pwdata_int = {31{1'b0}};
  pwdata_int[31:0] = pwdata[31:0];
// &CombEnd; @47
end

// Generate Write Enable bus for gpio_swporta_dr register,
// gpio_swporta_dr register and gpio_swporta_ctl register.
// &CombBeg; @51
always @( paddr[6:2]
       or penable
       or psel
       or pwrite)
begin
  gpio_swporta_dr_wen[3:0] = 4'b0000;
  gpio_swporta_ddr_wen[3:0] = 4'b0000;
  gpio_swporta_ctl_wen[3:0] = 4'b0000;
  
  if((psel == 1'b1) && (penable == 1'b1) && (pwrite == 1'b1)) 
  begin
    if(paddr[6:2] ==
       `gpio_swporta_dr_OFFSET) 
    begin
      gpio_swporta_dr_wen[3:0] = {4{1'b1}};
    end
    else if(paddr[6:2] ==
            `gpio_swporta_ddr_OFFSET) 
    begin
      gpio_swporta_ddr_wen[3:0] = {4{1'b1}};
    end
    else if(paddr[6:2] ==
            `gpio_swporta_ctl_OFFSET) 
    begin
      gpio_swporta_ctl_wen[3:0] = {4{1'b0}};
    end
  end
// &CombEnd; @74
end

// Generate Write Enable bus for gpio_inten register, 
// gpio_intmask register, gpio_inttype_level register,
// gpio_int_polarity register, gpio_ls_sync register
// and clear gpio_porta_eoi register.
// &CombBeg; @80
always @( paddr[6:2]
       or penable
       or psel
       or pwrite)
begin
  gpio_inten_wen[3:0] = 4'b0000;
  gpio_intmask_wen[3:0] = 4'b0000;
  gpio_inttype_level_wen[3:0] = 4'b0000;
  gpio_int_polarity_wen[3:0] = 4'b0000;
  gpio_ls_sync_wen[3:0] = 4'b0000;
  gpio_porta_eoi_wen[3:0] = 4'b0000;
  
  if((psel == 1'b1) && (penable == 1'b1) && (pwrite == 1'b1)) 
  begin
    if(paddr[6:2] ==
       `gpio_inten_OFFSET) 
    begin
      gpio_inten_wen[3:0] = {4{1'b1}};
    end 
    else if(paddr[6:2] ==
            `gpio_intmask_OFFSET) 
    begin
      gpio_intmask_wen[3:0] = {4{1'b1}};
    end
    else if(paddr[6:2] ==
            `gpio_inttype_level_OFFSET)
    begin
      gpio_inttype_level_wen[3:0] = {4{1'b1}};
    end
    else if(paddr[6:2] ==
            `gpio_int_polarity_OFFSET) 
    begin
      gpio_int_polarity_wen[3:0] = {4{1'b1}};
    end
    else if(paddr[6:2] ==
            `gpio_ls_sync_OFFSET) 
    begin
      gpio_ls_sync_wen[3:0] = {4{1'b1}};
    end
    else if(paddr[6:2] ==
            `gpio_porta_eoi_OFFSET)
    begin
      gpio_porta_eoi_wen[3:0] = {4{1'b1}};
    end
  end
// &CombEnd; @121
end

// Register used to store Software Port A Data register
always@(posedge pclk or negedge presetn)
begin
  if(!presetn)
    int_gpio_swporta_dr[31:0] <= {32{1'b0}}; 
  else
    if(&gpio_swporta_dr_wen)
      int_gpio_swporta_dr[31:0] <= pwdata_int[31:0];
end

assign gpio_swporta_dr[7:0] = int_gpio_swporta_dr[7:0];

// &CombBeg; @135
always @( int_gpio_swporta_dr[7:0])
begin
  ri_gpio_swporta_dr[31:0] = {32{1'b0}};
  ri_gpio_swporta_dr[7:0] = int_gpio_swporta_dr[7:0];
// &CombEnd; @138
end

// Register used to store Software Port A Data Direction register
always@(posedge pclk or negedge presetn)
begin
  if(!presetn)
    int_gpio_swporta_ddr[31:0] <= {32{1'b0}};
  else
    if(&gpio_swporta_ddr_wen)
      int_gpio_swporta_ddr[31:0] <= pwdata_int[31:0];
end

assign gpio_swporta_ddr[7:0] = int_gpio_swporta_ddr[7:0];

// &CombBeg; @152
always @( int_gpio_swporta_ddr[7:0])
begin
  ri_gpio_swporta_ddr[31:0] = {32{1'b0}};
  ri_gpio_swporta_ddr[7:0] = int_gpio_swporta_ddr[7:0];
// &CombEnd; @155
end

// Register used to store Software Port A mode control register
always@(posedge pclk or negedge presetn)
begin
  if(!presetn)
    int_gpio_swporta_ctl[31:0] <= {32{1'b0}};
  else
    if(&gpio_swporta_ctl_wen)
      int_gpio_swporta_ctl[31:0] <= pwdata_int[31:0];
end

assign gpio_swporta_ctl[7:0] = int_gpio_swporta_ctl[7:0];

// &CombBeg; @169
always @( int_gpio_swporta_ctl[7:0])
begin
  ri_gpio_swporta_ctl[31:0] = {32{1'b0}};
  ri_gpio_swporta_ctl[7:0] = int_gpio_swporta_ctl[7:0];
// &CombEnd; @172
end

// Register used to store Interrupt Enable for each bit 
// of Port A
always@(posedge pclk or negedge presetn)
begin
  if(!presetn)
    int_gpio_inten[31:0] <= 32'b0;
  else 
    if(&gpio_inten_wen)
      int_gpio_inten[31:0] <= pwdata_int[31:0];
end

assign gpio_inten[7:0] = int_gpio_inten[7:0];

// &CombBeg; @187
always @( int_gpio_inten[7:0])
begin
  ri_gpio_inten[31:0] = {32{1'b0}};
  ri_gpio_inten[7:0] = int_gpio_inten[7:0];
// &CombEnd; @190
end

// Register used to store Interrupt mask for each bit of Port A
always@(posedge pclk or negedge presetn)
begin
  if(!presetn)
    int_gpio_intmask[31:0] <= 32'b0;
  else 
    if(&gpio_intmask_wen)
      int_gpio_intmask[31:0] <= pwdata_int[31:0];
end

assign gpio_intmask[7:0] = int_gpio_intmask[7:0];

// &CombBeg; @204
always @( int_gpio_intmask[7:0])
begin
  ri_gpio_intmask[31:0] = {32{1'b0}};
  ri_gpio_intmask[7:0] = int_gpio_intmask[7:0];
// &CombEnd; @207
end

// Register used to store Interrupt type, level or edge,  for each bit of Port A
always@(posedge pclk or negedge presetn)
begin
  if(!presetn)
    int_gpio_inttype_level[31:0] <= 32'b0;
  else 
    if(&gpio_inttype_level_wen)
      int_gpio_inttype_level[31:0] <= pwdata_int[31:0];
end

assign gpio_inttype_level[7:0] = int_gpio_inttype_level[7:0];

// &CombBeg; @221
always @( int_gpio_inttype_level[7:0])
begin
  ri_gpio_inttype_level[31:0] = {32{1'b0}};
  ri_gpio_inttype_level[7:0] = int_gpio_inttype_level[7:0];
// &CombEnd; @224
end

// Register used to store Interrupt polarity for each bit of Port A
always@(posedge pclk or negedge presetn)
begin
  if(!presetn)
    int_gpio_int_polarity[31:0] <= 32'b0;
  else 
    if(&gpio_int_polarity_wen)
      int_gpio_int_polarity[31:0] <= pwdata_int[31:0];
end

assign gpio_int_polarity[7:0] = int_gpio_int_polarity[7:0];

// &CombBeg; @238
always @( int_gpio_int_polarity[7:0])
begin
  ri_gpio_int_polarity[31:0] = {32{1'b0}};
  ri_gpio_int_polarity[7:0] = int_gpio_int_polarity[7:0];
// &CombEnd; @241
end

// Register used to store level sensitive interrupt synchronization
always@(posedge pclk or negedge presetn)
begin
  if(!presetn)
    int_gpio_ls_sync[31:0] <= 32'b0;
  else 
    if(&gpio_ls_sync_wen)
      int_gpio_ls_sync[31:0] <= pwdata_int[31:0];
end

assign gpio_ls_sync = int_gpio_ls_sync[0];

// &CombBeg; @255
always @( int_gpio_ls_sync[7:0])
begin
  ri_gpio_ls_sync[31:0] = {32{1'b0}};
  ri_gpio_ls_sync[7:0] = int_gpio_ls_sync[7:0];
// &CombEnd; @258
end

// A write to Interrupt clear address generates pulse
// to control logic to clear interrupt.
// &CombBeg; @262
always @( gpio_porta_eoi_wen
       or pwdata_int[31:0])
begin
  int_gpio_porta_eoi[31:0] = {32{1'b0}};
  if(&gpio_porta_eoi_wen)
    int_gpio_porta_eoi[31:0] = pwdata_int[31:0];
// &CombEnd; @266
end

assign gpio_porta_eoi[7:0] = int_gpio_porta_eoi[7:0];

// Read only raw interrupt status register from ctrl block
// &CombBeg; @271
always @( gpio_intstatus[7:0]
       or gpio_raw_intstatus[7:0])
begin
  ri_gpio_raw_intstatus[31:0] = {32{1'b0}};
  ri_gpio_intstatus[31:0] = {32{1'b0}};

  ri_gpio_raw_intstatus[7:0] = gpio_raw_intstatus[7:0];
  ri_gpio_intstatus[7:0] = gpio_intstatus[7:0];
// &CombEnd; @277
end

// &CombBeg; @279
always @( gpio_ext_porta_rb[7:0])
begin
  ri_gpio_ext_porta_rb[31:0] = {32{1'b0}};

  ri_gpio_ext_porta_rb[7:0] = gpio_ext_porta_rb[7:0];
// &CombEnd; @283
end

// Output of Read back data mux registered and driven onto 
// prdata bus. 
always @(posedge pclk or negedge presetn)
begin
  if(!presetn)
    iprdata[31:0] <= {32{1'b0}};
  else
    if((pwrite == 1'b0) && (psel == 1'b1) && (penable == 1'b0))
      case(paddr[6:2])
        `gpio_swporta_dr_OFFSET    : iprdata <= ri_gpio_swporta_dr;
        `gpio_swporta_ddr_OFFSET   : iprdata <= ri_gpio_swporta_ddr;
        `gpio_swporta_ctl_OFFSET   : iprdata <= ri_gpio_swporta_ctl;
        `gpio_inten_OFFSET         : iprdata <= ri_gpio_inten;
        `gpio_intmask_OFFSET       : iprdata <= ri_gpio_intmask;
        `gpio_inttype_level_OFFSET : iprdata <= ri_gpio_inttype_level;
        `gpio_int_polarity_OFFSET  : iprdata <= ri_gpio_int_polarity;
        `gpio_intstatus_OFFSET     : iprdata <= ri_gpio_intstatus;
        `gpio_raw_intstatus_OFFSET : iprdata <= ri_gpio_raw_intstatus;
        `gpio_ls_sync_OFFSET       : iprdata <= ri_gpio_ls_sync;
        `gpio_ext_porta_OFFSET     : iprdata <= ri_gpio_ext_porta_rb;
        default : iprdata[31:0] <= {32{1'b0}};
      endcase
end

// &CombBeg; @309
always @( iprdata[7:0])
begin
  prdata[31:0] = {32{1'b0}};
  prdata[7:0] = iprdata[7:0];
// &CombEnd; @312
end

// &ModuleEnd; @314
endmodule


