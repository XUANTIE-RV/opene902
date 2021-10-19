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

// &Depend("environment.h"); @21
// &Depend("cpu_cfig.h"); @22

// &ModuleBeg; @24
module pmu(
  apb_pmu_paddr,
  apb_pmu_penable,
  apb_pmu_psel,
  apb_pmu_pwdata,
  apb_pmu_pwrite,
  biu_pad_lpmd_b,
  corec_pmu_sleep_out,
  cpu_clk,
  gate_en0,
  gate_en1,
  had_pad_wakeup_req_b,
  i_pad_cpu_jtg_rst_b,
  i_pad_jtg_tclk,
  intraw_vld,
  pad_cpu_rst_b,
  pad_had_jtg_tap_en,
  pad_had_jtg_tms_i,
  pad_had_jtg_trst_b,
  pad_had_jtg_trst_b_pre,
  pg_reset_b,
  pmu_apb_prdata,
  pmu_clk,
  pmu_corec_isolation,
  pmu_corec_sleep_in,
  sys_rst
);

// &Ports; @25
input   [11:0]  apb_pmu_paddr;         
input           apb_pmu_penable;       
input           apb_pmu_psel;          
input   [31:0]  apb_pmu_pwdata;        
input           apb_pmu_pwrite;        
input   [1 :0]  biu_pad_lpmd_b;        
input           corec_pmu_sleep_out;   
input           cpu_clk;               
input           had_pad_wakeup_req_b;  
input           i_pad_cpu_jtg_rst_b;   
input           i_pad_jtg_tclk;        
input           intraw_vld;            
input           pad_cpu_rst_b;         
input           pad_had_jtg_tap_en;    
input           pad_had_jtg_tms_i;     
input           pad_had_jtg_trst_b_pre; 
input           pmu_clk;               
input           sys_rst;               
output          gate_en0;              
output          gate_en1;              
output          pad_had_jtg_trst_b;    
output          pg_reset_b;            
output  [31:0]  pmu_apb_prdata;        
output          pmu_corec_isolation;   
output          pmu_corec_sleep_in;    

// &Regs; @26
reg     [31:0]  counter;               
reg             counter_en_ff;         
reg     [31:0]  counter_load;          
reg     [31:0]  ctrl_reg;              
reg     [2 :0]  cur_state;             
reg             debug_pending;         
reg             event_ff;              
reg             event_pending;         
reg     [2 :0]  next_state;            
reg     [2 :0]  pg_next_state;         
reg     [2 :0]  pg_state;              
reg     [31:0]  pmu_apb_prdata;        

// &Wires; @27
wire    [11:0]  apb_pmu_paddr;         
wire            apb_pmu_penable;       
wire            apb_pmu_psel;          
wire    [31:0]  apb_pmu_pwdata;        
wire            apb_pmu_pwrite;        
wire    [1 :0]  biu_pad_lpmd_b;        
wire            corec_pmu_sleep_out;   
wire            counter_en;            
wire            cpu_clk;               
wire            debug_ctl_en;          
wire            debug_vld;             
wire            debug_vld_pre;         
wire            debug_wake_vld;        
wire            doze_mode;             
wire            event_ctl_en;          
wire            event_vld;             
wire            gate_en0;              
wire            gate_en1;              
wire            had_pad_wakeup_req_b;  
wire            i_pad_cpu_jtg_rst_b;   
wire            i_pad_jtg_tclk;        
wire            intraw_vld;            
wire            load_cnt_en;           
wire            low_power_dis;         
wire            low_power_dis_pre;     
wire            lpmd_en;               
wire            lpmd_en_ff;            
wire            pad_cpu_rst_b;         
wire            pad_had_jtg_tap_en;    
wire            pad_had_jtg_tms_i;     
wire            pad_had_jtg_trst_b;    
wire            pad_had_jtg_trst_b_pre; 
wire            pad_vic_event_vld;     
wire            pg_reset_b;            
wire            pmu_clk;               
wire            pmu_corec_isolation;   
wire            pmu_corec_sleep_in;    
wire            pmu_debug_wakeup;      
wire            pmu_event_wakeup;      
wire            pmu_wakeup;            
wire            pmu_wic_wakeup;        
wire            stop_mode;             
wire            sys_rst;               
wire            wait_mode;             
wire            wic_ctl_en;            


parameter IDLE       = 3'b000;
parameter WAIT       = 3'b001;
parameter DOZE       = 3'b010;
parameter STOP       = 3'b011;
parameter WAIT_AWAKE = 3'b100;

parameter PG_IDLE          = 3'b000;
parameter PG_RESET_ON      = 3'b001;
parameter PG_ISO_ON        = 3'b010;
parameter PG_POWER_OFF_REQ = 3'b011;
parameter PG_POWER_OFF     = 3'b100;
parameter PG_POWER_ON      = 3'b101;
parameter PG_ISO_OFF       = 3'b110;
parameter PG_RESET_OFF     = 3'b111;

assign low_power_dis_pre = (biu_pad_lpmd_b[1:0] == 2'b11);


assign lpmd_en = (biu_pad_lpmd_b[1:0] != 2'b11) ;

////////////sync /////////////////////
// &Instance("sync", "x_cpu2pmu_sync1"); @58
sync  x_cpu2pmu_sync1 (
  .fast_clk      (cpu_clk      ),
  .in            (lpmd_en      ),
  .out           (lpmd_en_ff   ),
  .pad_cpu_rst_b (pad_cpu_rst_b),
  .slow_clk      (pmu_clk      )
);

// &Connect( .in              ( lpmd_en                  ), @59
//           .out             ( lpmd_en_ff               ), @60
//           .fast_clk        ( cpu_clk                  ), @61
//           .slow_clk        ( pmu_clk                  ) @62
//          ); @63





// &Instance("sync", "x_cpu2pmu_sync2"); @69
sync  x_cpu2pmu_sync2 (
  .fast_clk          (cpu_clk          ),
  .in                (low_power_dis_pre),
  .out               (low_power_dis    ),
  .pad_cpu_rst_b     (pad_cpu_rst_b    ),
  .slow_clk          (pmu_clk          )
);

// &Connect( .in              ( low_power_dis_pre        ), @70
//           .out             ( low_power_dis            ), @71
//           .fast_clk        ( cpu_clk                  ), @72
//           .slow_clk        ( pmu_clk                  ) @73
//          ); @74

//------------------------------------------------
//WRITE CTRL REG
//------------------------------------------------

always @ (posedge pmu_clk or negedge pad_cpu_rst_b)
begin
if (!pad_cpu_rst_b)
  begin
    ctrl_reg[31:0] <= 32'b0;
  end
else if (apb_pmu_psel && apb_pmu_pwrite && apb_pmu_penable)
  begin
    if (!apb_pmu_paddr[11:0] )
      ctrl_reg[31:0] <= apb_pmu_pwdata[31:0];
    else if (apb_pmu_paddr[11:0] == 12'h4 )
      counter_load[31:0] <= apb_pmu_pwdata[31:0];
  end
end

//------------------------------------------------
//READ CTRL REG
//------------------------------------------------

// &CombBeg; @99
always @( apb_pmu_paddr[11:0]
       or ctrl_reg[3:0]
       or apb_pmu_psel
       or apb_pmu_pwrite
       or counter[31:0])
begin
if (apb_pmu_psel && !apb_pmu_pwrite) 
begin
  if(!apb_pmu_paddr[11:0] )
    pmu_apb_prdata[31:0] = {28'b0,ctrl_reg[3:0]};
  else if (apb_pmu_paddr[11:0] == 12'h4 )
    pmu_apb_prdata[31:0] = counter[31:0];
  else
    pmu_apb_prdata[31:0] = 32'b0;
end
// &CombEnd; @109
end

assign wic_ctl_en = ctrl_reg[0];
assign event_ctl_en = ctrl_reg[1];
assign debug_ctl_en = ctrl_reg[2];
assign counter_en = ctrl_reg[3];

//event counter
always @(posedge pmu_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
  begin
    counter_en_ff <=0;
  end
  else
  begin
    counter_en_ff <=counter_en ;
  end
end

assign load_cnt_en= (counter_en && !counter_en_ff)
                    || !(|counter[31:0]);

always @(posedge pmu_clk or negedge pad_cpu_rst_b)
begin
  if(!pad_cpu_rst_b)
  begin
    counter[31:0] <= 32'h0;
  end
  else if (load_cnt_en)
  begin
    counter[31:0] <= counter_load[31:0];
  end
  else if (counter_en)
     counter[31:0] <= counter[31:0] -1'b1;
  else
     counter[31:0] <= counter[31:0];
end

assign pad_vic_event_vld = (counter[31:0] == 32'b0) && counter_en;



assign pmu_wic_wakeup = intraw_vld && wic_ctl_en && lpmd_en_ff ;

// event_wakeup

assign event_vld = pad_vic_event_vld && !event_ff && lpmd_en_ff ;

always @(posedge pmu_clk or negedge pad_cpu_rst_b)
begin
  if (!pad_cpu_rst_b)
    event_ff <= 1'b0;
  else
    event_ff <= pad_vic_event_vld;
end

always @(posedge pmu_clk or negedge pad_cpu_rst_b)
begin
  if (!pad_cpu_rst_b)
    event_pending <= 1'b0;
  else if (event_vld)
    event_pending <= 1'b1;
  else if (low_power_dis)
    event_pending <= 1'b0;
end

assign pmu_event_wakeup = event_pending && event_ctl_en ;

//debug wake up 

// &Instance("tap2_sm", "x_tap2_sm"); @180
tap2_sm  x_tap2_sm (
  .debug_wake_vld      (debug_wake_vld     ),
  .pad_had_jtg_tap_en  (pad_had_jtg_tap_en ),
  .tclk                (i_pad_jtg_tclk     ),
  .tms_i               (pad_had_jtg_tms_i  ),
  .trst_b              (i_pad_cpu_jtg_rst_b)
);

// &Connect(.tclk         (i_pad_jtg_tclk         ), @181
// //         .trst_b       (i_pad_jtg_trst_b       ), @182
//          .trst_b       (i_pad_cpu_jtg_rst_b    ), @183
//          .tms_i        (pad_had_jtg_tms_i      ) @184
//         ); @185

assign debug_vld_pre = (debug_wake_vld || !had_pad_wakeup_req_b) && lpmd_en_ff;

// &Instance("px_had_sync", "x_jtag2pmu_sync"); @193
px_had_sync  x_jtag2pmu_sync (
  .clk1                   (i_pad_jtg_tclk        ),
  .clk2                   (pmu_clk               ),
  .rst1_b                 (pad_had_jtg_trst_b_pre),
  .rst2_b                 (pad_cpu_rst_b         ),
  .sync_in                (debug_vld_pre         ),
  .sync_out               (debug_vld             )
);

// &Connect(.clk1         (i_pad_jtg_tclk         ), @194
//          .clk2         (pmu_clk                ), @195
//          .rst1_b       (pad_had_jtg_trst_b_pre ), @196
//          .rst2_b       (pad_cpu_rst_b          ), @197
//          .sync_in      (debug_vld_pre          ), @198
//          .sync_out     (debug_vld              ) @199
//         ); @200



always @(posedge pmu_clk or negedge pad_cpu_rst_b)
begin
  if (!pad_cpu_rst_b)
    debug_pending <= 1'b0;
  else if (debug_vld)
    debug_pending <= 1'b1;
  else if (low_power_dis)
    debug_pending <= 1'b0;
end

 
//assign pad_had_jdb_req_b = !debug_pending;
assign pmu_debug_wakeup = debug_pending && debug_ctl_en ;

/////
assign pmu_wakeup = pmu_event_wakeup || pmu_wic_wakeup || pmu_debug_wakeup ;
//-----------------------------------------
//              PMU FSM             
//-----------------------------------------
always @(posedge pmu_clk or negedge pad_cpu_rst_b)
begin
  if (!pad_cpu_rst_b)
    cur_state[2:0] <= IDLE;
  else
    cur_state[2:0] <= next_state[2:0];
end


assign doze_mode = ( biu_pad_lpmd_b[1:0] == 2'b10);
assign wait_mode = ( biu_pad_lpmd_b[1:0] == 2'b01);
assign stop_mode = ( biu_pad_lpmd_b[1:0] == 2'b00);



// &CombBeg; @243
always @( cur_state
       or pmu_wakeup
       or pg_state[2:0]
       or biu_pad_lpmd_b[1:0]
       or doze_mode
       or stop_mode
       or wait_mode)
begin
case(cur_state)
IDLE:
begin
  if(doze_mode )
  begin
    next_state = DOZE;
  end
  else if(wait_mode )
  begin
    next_state = WAIT;
   end
  else if(stop_mode )
  begin
    next_state = STOP;
    end
  else
  begin
    next_state = IDLE;
  end
end

DOZE:
begin
  if(pmu_wakeup)
  begin
    next_state = WAIT_AWAKE;
  end
  else
  begin
    next_state = DOZE;
  end
end

WAIT:
begin
  if(pmu_wakeup)
  begin
    next_state = WAIT_AWAKE;
  end
  else
  begin
    next_state = WAIT;
  end
end

STOP:////////  more states more pg crtl signal 
begin
  if(pg_state[2:0]==3'b111)
  begin
    next_state = WAIT_AWAKE;
  end
  else
  begin
    next_state = STOP;
  end
end 

WAIT_AWAKE:
begin
  if(biu_pad_lpmd_b[1:0] == 2'b11)
  begin
    next_state = IDLE;
  end
  else
  begin
    next_state = WAIT_AWAKE;
  end
end

endcase
// &CombEnd; @314
end



assign gate_en0 = (cur_state[2:0] == IDLE) || (cur_state[2:0] == WAIT_AWAKE);
assign gate_en1 = (cur_state[2:0] == WAIT) || (cur_state[2:0] == IDLE)
               || (cur_state[2:0] == WAIT_AWAKE);

//----------------------------------------
//              Power Gating FSM             
//-----------------------------------------

always @(posedge pmu_clk or negedge pad_cpu_rst_b)
begin
  if (!pad_cpu_rst_b)
    pg_state[2:0] <= PG_IDLE;
  else
    pg_state[2:0] <= pg_next_state[2:0];
end

// &CombBeg; @334
always @( pmu_wakeup
       or pg_state[2:0]
       or corec_pmu_sleep_out
       or cur_state[2:0])
begin
case(pg_state[2:0])
PG_IDLE:
begin
  if(cur_state[2:0] == STOP)
    pg_next_state = PG_RESET_ON;
  else
    pg_next_state = PG_IDLE;
end
PG_RESET_ON:
  pg_next_state = PG_ISO_ON;
PG_ISO_ON:
  pg_next_state = PG_POWER_OFF_REQ;
PG_POWER_OFF_REQ:
begin
  if(corec_pmu_sleep_out)
    pg_next_state = PG_POWER_OFF;
  else
    pg_next_state = PG_POWER_OFF_REQ;
end
PG_POWER_OFF:
begin
  if(pmu_wakeup)
    pg_next_state = PG_POWER_ON;
  else
    pg_next_state = PG_POWER_OFF;
end
PG_POWER_ON:
  pg_next_state = PG_ISO_OFF;
PG_ISO_OFF:
  pg_next_state = PG_RESET_OFF;
PG_RESET_OFF:
  pg_next_state = IDLE;
endcase
// &CombEnd @368
end



assign pmu_corec_sleep_in   =  pg_state[2:0] == PG_POWER_OFF_REQ 
                            || pg_state[2:0] == PG_POWER_OFF;

assign pmu_corec_isolation  =  pg_state[2:0] == PG_ISO_ON
                            || pg_state[2:0] == PG_POWER_OFF_REQ
                            || pg_state[2:0] == PG_POWER_OFF
                            || pg_state[2:0] == PG_POWER_ON
                            || pg_state[2:0] == PG_ISO_OFF;

assign pg_reset_b          = pg_state[2:0] == PG_IDLE 
                           && pad_cpu_rst_b && sys_rst;

assign pad_had_jtg_trst_b  = pg_state[2:0] == PG_IDLE 
                           && pad_had_jtg_trst_b_pre;



// &ModuleEnd; @389
endmodule



