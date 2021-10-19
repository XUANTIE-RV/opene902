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
.text
.global	__start
__start:



  la x3, __erodata
  la x4, __data_start__
  la x5, __data_end__

  sub x5, x5, x4
  beqz x5, L_loop0_done

L_loop0:
   lw x6, 0(x3)
   sw x6, 0(x4)
   addi x3, x3, 0x4
   addi x4, x4, 0x4
   addi x5, x5, -4
   bnez x5, L_loop0

L_loop0_done:
   la x3, __data_end__
   la x4, __bss_end__

   li x5, 0
   sub x4, x4, x3
   beqz x4, L_loop1_done

L_loop1:
   sw x5, 0(x3)
   addi x3, x3, 0x4
   addi x4, x4, -4
   bnez x4, L_loop1  


L_loop1_done:
  
  la x3, trap_handler
  csrw mtvec, x3

  la x3, vector_table
  addi x3, x3, 64
  csrw mtvt, x3

  la  x2, __kernel_stack
#enable cache
#  li x3, 0x1
#  csrw mhcr, x3

#open theadisaee
#  la  x3, 0x400000
#  csrrs x0, mxstatus, x3

#open mie in mstatus
  csrsi mstatus, 0x8

  
__to_main:
  jal main


  .global __exit
__exit:
  fence.i
  fence
  li    x4, 0x6000fff8
  addi  x3, x0,0xFF
  slli  x3, x3,0x4
  addi  x3, x3, 0xf #0xFFF
  sw	x3, 0(x4)

  .global __fail
__fail:
  fence.i
  fence
  li    x4, 0x6000fff8
  addi  x3, x0,0xEE
  slli  x3, x3,0x4
  addi  x3, x3,0xe #0xEEE
  sw	x3, 0(x4)

  .align 6  
  .global trap_handler
trap_handler:
  j __synchronous_exception
  .align 2  
  j __fail
 
__synchronous_exception:
  sw   x13,-4(x2)
  sw   x14,-8(x2)
  sw   x15,-12(x2)
  csrr x14,mcause
  andi x15,x14,0xff  #cause
  srli x14,x14,0x1b   #int
  andi x14,x14,0x10   #mask bit
  add  x14,x14,x15    #{int,cause}

  slli x14,x14,0x2  #offset
  la   x15,vector_table
  add  x15,x14,x15  #target pc
  lw   x14, 0(x15)  #get exception addr
  lw   x13, -4(x2)  #recover x16
  lw   x15, -12(x2) #recover x15
#addi x14,x14,-4
  jr   x14


  .global vector_table
  .align  6
vector_table:	#totally 256 entries
	.rept   256
	.long   __dummy
	.endr

  .global __dummy
__dummy:  
  j __fail
  
  .data
  .long 0
