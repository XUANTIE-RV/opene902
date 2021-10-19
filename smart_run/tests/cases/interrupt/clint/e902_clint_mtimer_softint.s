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
.align 2
.global main
main:
#clic
.set CLICCFG       ,0x0000
.set CLICINFO      ,0x0004
.set MINTTHRESH	   ,0x0008
.set INTIP         ,0x1000
.set INTIE         ,0x1001
.set INTATTR       ,0x1002
.set INTCTL        ,0x1003
#clint
.set MTIME_CMP_LO_ADDR      ,0xe0004000
.set MTIME_CMP_HI_ADDR      ,0xe0004004
.set MSIP_ADDR              ,0xe0000000
.set MTIME_LO_ADDR          ,0xe000bff8
.set MTIME_HI_ADDR          ,0xe000bffc

.macro SETINT EXP_CODE, HANDLER_BEGIN,HANDLER_END
la   t0, vector_table+64
addi t1,x0,\EXP_CODE
slli t1,t1,0x2
add  t1,t1,t0   

la   t0, \HANDLER_BEGIN
sw   t0, 0(t1) 
j    \HANDLER_END 
.endm

li x10 , 0x0

SETINT   7   MTIME_BEG MTIME_END
MTIME_BEG:
    li    x1 , 0x1
    li    x3 , MTIME_CMP_HI_ADDR
    sw    x1 , 0x0( x3 )
    addi  x10, x10, 0x1
    csrr  x1 , mepc
    addi  x1 , x1 , 4
    csrw  mepc , x1
    mret 
MTIME_END:

#set mtimecmp
    li    x12, MTIME_CMP_HI_ADDR
    li    x1 , 0x0
    sw    x1 , 0x0( x12)
    li    x12, MTIME_CMP_LO_ADDR
    li    x1 , 0x1000
    sw    x1 , 0x0( x12)
    
#set clic
    csrr  x1 , mclicbase
    li    x11 , 0x6
    sw    x11 , 0x0(x1)   #priority bis is 3
    li    x3 , INTIP
    add   x1 , x1 , x3 
    li    x11 , 0x80010100  #priority is 4, posedge pulse int, enable mtime int, hardware vec
    sw    x11 , 0x1c(x1)    #write to num 7 int config reg


Loop:
    j     Loop

    nop
    nop
    nop
    nop
    li    x1  , 0x1
    bne   x10 , x1 , __fail


#set clic num 3 int : m soft
SETINT   3   MSOFT_BEG MSOFT_END
MSOFT_BEG:
    li    x1 , MSIP_ADDR
    li    x3 , 0x0
    sw    x3 , 0x0(x1)
    addi  x10, x10, 0x1
    mv    x1 , x1
    mv    x1 , x1
    mv    x1 , x1
    mv    x1 , x1 #wait for pending in clic is clear, because clint to clic costs severl cycles
    mret           
MSOFT_END:
    csrr  x1 , mclicbase
    li    x3 , INTIP
    add   x1 , x1 , x3 
    li    x11 , 0x80000100  #priority is 4, level int, enable m soft int
    sw    x11 , 0xc(x1)     #write to num 3 int config reg
    li    x1 , MSIP_ADDR
    li    x11 , 0x1
    sw    x11 , 0x0(x1)     #set soft int pending

    mv    x1 , x1
    mv    x1 , x1
    mv    x1 , x1
    mv    x1 , x1
    mv    x1 , x1
    mv    x1 , x1
    mv    x1 , x1
    mv    x1 , x1
    mv    x1 , x1
    mv    x1 , x1   #wait soft int trigger


    li    x11 , 0x2
    bne   x10, x11 , __fail

    j     __exit

