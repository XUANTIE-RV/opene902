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
#############################################################################################
# This SDC file in only needed for Block-Level Implementation
#############################################################################################

################################################################################
# Initial variables for synthesis; modify this part based on design
################################################################################

set IF_READ_BUIDIN_VARIABLES	1 ;# For standalone usage, set to "1" ; For synthesis, set to "0"

set CPU_PERIOD   		[expr (1000.00/1000)] ;# CPU is constrained at 1.0GHz
set JTG_PERIOD			[expr (1000.00/50)] ;# JTG_CLK frequency is default set to 50MHz

set IF_LITTLEEND		0 ;# 1 stands for LittleEndian, 0 stands for BigEndian, default 0;

if {$IF_READ_BUIDIN_VARIABLES} {
   set SETUP_UNCERTAINTY	0.2
   set HOLD_UNCERTAINTY		0.08
   set MAX_FANOUT		32
   set MAX_TRANSITION		0.5

   set LOAD_PIN			"AN2D2BWP30P140/A1"
   set DRIVING_CELL		"BUFFD2BWP30P140"
}

# User-Edit Ends Here

#################################################################################
# Basic Constraints
#################################################################################

set CLK_INPUTS               [get_ports {*clk *clock *tck}]
set DATA_INPUTS              [remove_from_collection [all_inputs] $CLK_INPUTS]

set_max_fanout $MAX_FANOUT [current_design]
set_max_transition $MAX_TRANSITION [current_design]
set_input_transition 0.1 $CLK_INPUTS
set_load [expr [load_of [get_lib_pins */$LOAD_PIN]]*5.0] [all_outputs]
set_driving_cell -lib_cell $DRIVING_CELL $DATA_INPUTS

create_clock [get_ports pll_core_cpuclk]  -name CPU_CLK -period $CPU_PERIOD
create_clock [get_ports pad_had_jtg_tclk] -name JTG_CLK -period $JTG_PERIOD

create_clock -name V_CPU_CLK     -period $CPU_PERIOD
create_clock -name V_JTG_CLK     -period $JTG_PERIOD

set CPU_CLK_LIST "CPU_CLK V_CPU_CLK"
set JTG_CLK_LIST "JTG_CLK V_JTG_CLK"

################################################################################
# Ports Constrains
################################################################################

### JTG Ports
set JTG_INPUTS {pad_had_jtg_*}
set JTG_OUTPUTS {had_pad_jtg_*}

set_input_delay  -max [expr $JTG_PERIOD*0.9] -clock V_JTG_CLK [get_ports $JTG_INPUTS]
set_input_delay  -min 0                      -clock V_JTG_CLK [get_ports $JTG_INPUTS]

set_output_delay -max [expr $JTG_PERIOD*0.9] -clock V_JTG_CLK [get_ports $JTG_OUTPUTS]  -clock_fall
set_output_delay -min 0                      -clock V_JTG_CLK [get_ports $JTG_OUTPUTS]  -clock_fall

### CPU_INPUT
set CPU_INPUTS  [remove_from_collection $DATA_INPUTS  [get_ports $JTG_INPUTS]]
set CPU_OUTPUTS [remove_from_collection [all_outputs] [get_ports $JTG_OUTPUTS]]

set_input_delay  -max [expr $CPU_PERIOD*0.5] -clock V_CPU_CLK $CPU_INPUTS
set_input_delay  -min 0                      -clock V_CPU_CLK $CPU_INPUTS

set_output_delay -max [expr $CPU_PERIOD*0.5] -clock V_CPU_CLK $CPU_OUTPUTS
set_output_delay -min 0                      -clock V_CPU_CLK $CPU_OUTPUTS

set_max_delay [expr $CPU_PERIOD*1.5] -from $CPU_INPUTS -to $CPU_OUTPUTS

### Constants & Debug
set CONSTANTS {
pad_bmu_iahbl_*
}
set_false_path -from [get_ports $CONSTANTS]

set DEBUG_OUTPUTS {
iu_pad_inst_retire
iu_pad_inst_split
iu_pad_retire_pc
iu_pad_gpr_data
iu_pad_gpr_index
iu_pad_gpr_we
cp0_pad_mstatus
cp0_pad_mintstatus
cp0_pad_mcause
}
set_output_delay -max 0 -clock V_CPU_CLK [get_ports $DEBUG_OUTPUTS]
set_output_delay -min 0 -clock V_CPU_CLK [get_ports $DEBUG_OUTPUTS]

################################################################################
# Group Path
################################################################################

group_path -name INPUT  -from [all_inputs]
group_path -name OUTPUT -to [all_outputs]
group_path -name COMB   -from [all_inputs] -to [all_outputs]

set_clock_uncertainty -setup $SETUP_UNCERTAINTY [all_clocks]
set_clock_uncertainty -hold $HOLD_UNCERTAINTY [all_clocks]

################################################################################
# False Paths Between Clock Domains
################################################################################

set_clock_group -async -group $CPU_CLK_LIST -group $JTG_CLK_LIST

################################################################################
# Set DFT Signals
################################################################################

if {[sizeof_collection [get_ports -quiet pad_yy_bist_tst_en]]} {
   set_false_path -from [get_ports pad_yy_bist_tst_en]
}

set_case_analysis 0 [get_ports pad_yy_test_mode]
set_case_analysis 0 [get_ports pad_yy_gate_clk_en_b]
if {[sizeof_collection [get_ports -quiet pad_yy_scan_enable]]} {
   set_case_analysis 0 [get_ports pad_yy_scan_enable]
}

