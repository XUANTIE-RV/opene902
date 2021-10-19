#/*Copyright 2018-2021 T-Head Semiconductor Co., Ltd.
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
#*/
CPU_ARCH_FLAG_0 := e902m
CASE_LIST := \
      memcpy \
      memset \
      smoke \
      clic \
      clint \
      coremark \
      hello_world \
      jtag_debug \
      gpio \
      had_debug \



memcpy_build:
	@cp ./tests/cases/memcpy/* ./work
	@find ./tests/lib/ -maxdepth 1 -type f -exec cp {} ./work/ \; 
	@cp ./tests/lib/clib/* ./work
	@cp ./tests/lib/newlib_wrap/* ./work
	@cd ./work && make -s clean && make -s all CPU_ARCH_FLAG_0=e902m  ENDIAN_MODE=little-endian CASENAME=memcpy FILE=mem_copy_main >& memcpy_build.case.log 





memset_build:
	@cp ./tests/cases/memset/* ./work
	@find ./tests/lib/ -maxdepth 1 -type f -exec cp {} ./work/ \; 
	@cp ./tests/lib/clib/* ./work
	@cp ./tests/lib/newlib_wrap/* ./work
	@cd ./work && make -s clean && make -s all CPU_ARCH_FLAG_0=e902m  ENDIAN_MODE=little-endian CASENAME=memset FILE=mem_set_main >& memset_build.case.log 


smoke_build:
	@cp ./tests/cases/e902_smoke/* ./work
	@find ./tests/lib/ -maxdepth 1 -type f -exec cp {} ./work/ \; 
	@cd ./work && make -s clean && make -s all CPU_ARCH_FLAG_0=e902m  ENDIAN_MODE=little-endian CASENAME=smoke FILE=e902_smoke >& smoke_build.case.log 


clic_build:
	@cp ./tests/cases/interrupt/clic/* ./work
	@find ./tests/lib/ -maxdepth 1 -type f -exec cp {} ./work/ \; 
	@cd ./work && make -s clean && make -s all CPU_ARCH_FLAG_0=e902m  ENDIAN_MODE=little-endian CASENAME=clic FILE=e902_clic_intarb_priority >& clic_build.case.log 


clint_build:
	@cp ./tests/cases/interrupt/clint/* ./work
	@find ./tests/lib/ -maxdepth 1 -type f -exec cp {} ./work/ \; 
	@cd ./work && make -s clean && make -s all CPU_ARCH_FLAG_0=e902m  ENDIAN_MODE=little-endian CASENAME=clint FILE=e902_clint_mtimer_softint >& clint_build.case.log 


coremark_build:
	@cp ./tests/cases/coremark/* ./work
	@find ./tests/lib/ -maxdepth 1 -type f -exec cp {} ./work/ \; 
	@cp ./tests/lib/clib/* ./work
	@cp ./tests/lib/newlib_wrap/* ./work
	@cd ./work && make -s clean && make -s all CPU_ARCH_FLAG_0=e902m  ENDIAN_MODE=little-endian CASENAME=coremark FILE=core_main >& coremark_build.case.log 


hello_world_build:
	@cp ./tests/cases/hello_world/* ./work
	@find ./tests/lib/ -maxdepth 1 -type f -exec cp {} ./work/ \; 
	@cp ./tests/lib/clib/* ./work
	@cp ./tests/lib/newlib_wrap/* ./work
	@cd ./work && make -s clean && make -s all CPU_ARCH_FLAG_0=e902m  ENDIAN_MODE=little-endian CASENAME=hello_world FILE=hello_world_main >& hello_world_build.case.log 


jtag_debug_build:
	@cp ./tests/cases/e902_had_debug/jtag_test/* ./work
	@find ./tests/lib/ -maxdepth 1 -type f -exec cp {} ./work/ \; 
	@cd ./work && make -s clean && make -s all CPU_ARCH_FLAG_0=e902m  ENDIAN_MODE=little-endian CASENAME=jtag_debug FILE=e902_had_jtag_connect >& jtag_debug_build.case.log 


gpio_build:
	@cp ./tests/cases/gpio/* ./work
	@find ./tests/lib/ -maxdepth 1 -type f -exec cp {} ./work/ \; 
	@cd ./work && make -s clean && make -s all CPU_ARCH_FLAG_0=e902m  ENDIAN_MODE=little-endian CASENAME=gpio FILE=e902_gpio_io >& gpio_build.case.log 



had_debug_build:
	@cp ./tests/cases/e902_had_debug/had_test/* ./work
	@find ./tests/lib/ -maxdepth 1 -type f -exec cp {} ./work/ \; 
	@cd ./work && make -s clean && make -s all CPU_ARCH_FLAG_0=e902m  ENDIAN_MODE=little-endian CASENAME=had_debug FILE=e902_had_tests >& had_debug_build.case.log 




# Adjust verilog filelist for *.v case...
ifeq ($(CASE), jtag_debug)
SIM_FILELIST := ../tests/cases/e902_had_debug/jtag_test/had_drv.h ../tests/cases/e902_had_debug/jtag_test/e902_had_jtag_connect.v
endif
ifeq ($(CASE), gpio)
SIM_FILELIST := ../tests/cases/gpio/e902_gpio_io.v
endif
ifeq ($(CASE), had_debug)
SIM_FILELIST := ../tests/cases/e902_had_debug/had_test/had_drv.h ../tests/cases/e902_had_debug/had_test/e902_had_test.v
endif


define newline


endef


