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

// &Depend("cpu_cfig.h") @18
// &ModuleBeg; @19
module smpu_top(
  biu_pad_haddr,
  biu_pad_hprot,
  paddr,
  pclk,
  penable,
  prdata,
  presetn,
  psel,
  pwdata,
  pwrite,
  smpu_deny
);

// &Ports; @20
input   [31:0]  biu_pad_haddr;   
input   [3 :0]  biu_pad_hprot;   
input   [3 :2]  paddr;           
input           pclk;            
input           penable;         
input           presetn;         
input           psel;            
input   [31:0]  pwdata;          
input           pwrite;          
output  [31:0]  prdata;          
output          smpu_deny;       

// &Regs; @21
reg     [31:0]  prdata;          
reg     [31:0]  smpu_entry0;     
reg     [31:0]  smpu_entry1;     
reg     [31:0]  smpu_entry2;     

// &Wires; @22
wire    [31:0]  biu_pad_haddr;   
wire    [3 :0]  biu_pad_hprot;   
wire            hsec_0;          
wire            hsec_1;          
wire            hsec_2;          
wire            pad_biu_hsec_pre; 
wire    [3 :2]  paddr;           
wire            pclk;            
wire            penable;         
wire            presetn;         
wire            psel;            
wire    [31:0]  pwdata;          
wire            pwrite;          
wire            smpu_deny;       
wire            smpu_hit0;       
wire            smpu_hit1;       
wire            smpu_hit2;       



// &Force("bus","biu_pad_haddr",31,0); @25

//==========================================================
//                  APB PWDATA
//==========================================================

always @(posedge pclk or negedge presetn)
begin
  if(!presetn)
  begin
    smpu_entry0 <= 32'b0;
    smpu_entry1 <= 32'b0;
    smpu_entry2 <= 32'b0;
  end
  else
  begin
    if(psel && pwrite && penable)
    begin
      case(paddr[3:2])
        2'b00:
        begin
          smpu_entry0[31:0] <= pwdata[31:0];
        end
        2'b01:
        begin
          smpu_entry1[31:0] <= pwdata[31:0];
        end
        2'b10:
        begin
          smpu_entry2[31:0] <= pwdata[31:0];
        end
      endcase
    end
  end
end
    
//==========================================================
//                  APB PRDATA
//==========================================================
always @(posedge pclk)
begin
  if(psel && !pwrite && !penable)
  begin
    case(paddr[3:2])
      2'b00:
      begin
        prdata[31:0] <= smpu_entry0[31:0];
      end
      2'b01:
      begin
        prdata[31:0] <= smpu_entry1[31:0];
      end
      2'b10:
      begin
        prdata[31:0] <= smpu_entry2[31:0];
      end
      default:
      begin
        prdata[31:0] <= 32'bx;
      end
    endcase
  end
end




//&Instance("gated_clk_cell", "x_smpu_gated_clk");
// //&Connect(.clk_in(forever_cpuclk), @93
// //         .global_en(cp0_yy_clk_en), @94
// //         .module_en(mpu_module_en), @95
// //         .local_en(1'b0), @96
// //         .external_en(1'b0), @97
// //         .clk_out(cpuclk)); @98

// &Force("output", "smpu_deny") @100
assign smpu_deny = smpu_hit0 || smpu_hit1 || smpu_hit2;

// &Instance("smpu_comp_hit", "x_smpu_comp_hit_0"); @103
smpu_comp_hit  x_smpu_comp_hit_0 (
  .biu_pad_haddr (biu_pad_haddr),
  .biu_pad_hprot (biu_pad_hprot),
  .smpu_entry    (smpu_entry0  ),
  .smpu_entry0   (smpu_entry0  ),
  .smpu_hit      (smpu_hit0    ),
  .smpu_hsec     (hsec_0       )
);

// &Connect(.smpu_hit           (smpu_hit0      ), @104
//          .smpu_entry         (smpu_entry0    ), @105
//          .smpu_hsec          (hsec_0         )  @106
//  @107
//         ); @108

// &Instance("smpu_comp_hit", "x_smpu_comp_hit_1"); @110
smpu_comp_hit  x_smpu_comp_hit_1 (
  .biu_pad_haddr (biu_pad_haddr),
  .biu_pad_hprot (biu_pad_hprot),
  .smpu_entry    (smpu_entry1  ),
  .smpu_entry0   (smpu_entry0  ),
  .smpu_hit      (smpu_hit1    ),
  .smpu_hsec     (hsec_1       )
);

// &Connect(.smpu_hit           (smpu_hit1      ), @111
//          .smpu_entry         (smpu_entry1    ), @112
//          .smpu_hsec          (hsec_1         )  @113
//         ); @114

// &Instance("smpu_comp_hit", "x_smpu_comp_hit_2"); @116
smpu_comp_hit  x_smpu_comp_hit_2 (
  .biu_pad_haddr (biu_pad_haddr),
  .biu_pad_hprot (biu_pad_hprot),
  .smpu_entry    (smpu_entry2  ),
  .smpu_entry0   (smpu_entry0  ),
  .smpu_hit      (smpu_hit2    ),
  .smpu_hsec     (hsec_2       )
);

// &Connect(.smpu_hit           (smpu_hit2      ), @117
//          .smpu_entry         (smpu_entry2    ), @118
//          .smpu_hsec          (hsec_2         )  @119
//         ); @120


//biu hsec
assign pad_biu_hsec_pre = hsec_0 || hsec_1 || hsec_2;


// &Force("nonport", "pad_biu_hsec_pre"); @140

// &Force("nonport","pad_biu_hsec"); @145

// &ModuleEnd; @148
endmodule


