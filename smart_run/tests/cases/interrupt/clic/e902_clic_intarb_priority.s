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
#.include "core_init.h"
.set CLIC_INT      ,0x1
.set NORM_INT      ,0x0

.set CLICCFG       ,0x0000
.set CLICINFO      ,0x0004
.set MINTTHRESH	   ,0x0008
.set INTIP         ,0x1000
.set INTIE         ,0x1001
.set INTATTR       ,0x1002
.set INTCTL        ,0x1003


   
.macro SETINT VECTOR_MODE,EXP_CODE, HANDLER_BEGIN,HANDLER_END
addi t0,x0,\VECTOR_MODE
la   t1, vector_table+64
la   t2, vector_table+64
.long 0x00028463 #beqz t0,label_1
mv   t0, t2
.short 0xa011    #j label_2
#label_1:
mv   t0,t1
#label_2:
addi t1,x0,\EXP_CODE
slli t1,t1,0x2
add  t1,t1,t0   

la   t0, \HANDLER_BEGIN
sw   t0, 0(t1) 
j    \HANDLER_END 
lw   a4, -8(sp)
.endm

.macro EXIT
la  x1,  __exit
jr	x1
.endm

.macro FAIL
la  x1,  __fail 
jr	x1
.endm  
#---------------------------------------
#exception handler
#---------------------------------------

 SETINT          CLIC_INT 16  INT_SERVICE16_BEGIN INT_SERVICE16_END
.global INT_SERVICE16_BEGIN
INT_SERVICE16_BEGIN:
    addi            x15, x15, 0x1
    csrr            x1 , mcause
    li              x3 , 0xff
    and             x1 , x1 , x3
    li              x3 , 16
    bne             x1 , x3 , TEST_FAIL
    csrr            x11, mclicbase
    li              x12, INTIP
    add             x11, x11, x12
    sb              x0 , 0x40( x11)
    sb              x0 , 0x44( x11)
    csrr            x1 , mintstatus
    li              x3 , 0xff000000
    bne             x1 , x3 , TEST_FAIL
    mret           
.global INT_SERVICE16_END
INT_SERVICE16_END:

    SETINT          CLIC_INT 17  INT_SERVICE17_BEGIN INT_SERVICE17_END
.global INT_SERVICE17_BEGIN
INT_SERVICE17_BEGIN:
    addi            x14, x14, 0x1
    csrr            x1 , mcause
    li              x3 , 0xff
    and             x1 , x1 , x3 
    li              x3 , 17 
    bne             x1 , x3 , TEST_FAIL
    csrr            x11, mclicbase
    li              x12, INTIP
    add             x11, x11, x12
    sb              x0 , 0x40( x11)
    sb              x0 , 0x44( x11)
    csrr            x1 , mintstatus
    li              x3 , 0xff000000
    bne             x1 , x3 , TEST_FAIL
    mret           
.global INT_SERVICE17_END
INT_SERVICE17_END:
#---------------------------------------//
#clic init  level > pri
#---------------------------------------//

.global TEST_BEGIN
TEST_BEGIN:
##//initial mtvec mode
#    csrsi           mtvec, 0x1
#    csrsi           mtvec, 0x2
#//clr mie
    csrci           mstatus, 0x8
    li              x15, 0x0
    li              x14, 0x0

#//init cliccfg nlbits = 1
.global NLBITS
NLBITS:
    li              x10, 0x2
    csrr            x11, mclicbase
    li              x12, CLICCFG
    add             x11, x11, x12
    sb              x10, 0x0( x11)      #m mode nlbits = 1

#//enable ID16  posedge pulse trigger  ie =1   level =1XXXXXXXX//vector int 
    li              x10, 0x8003ffff
    csrr            x11, mclicbase
    li              x12, INTIP
    add             x11, x11, x12
    sw              x10, 0x40( x11)
    sw              x10, 0x40( x11)
#//enable ID17  posedge pulse trigger  ie =1   level =0XXXXXXXX//vector int
    li              x10, 0x7f03ffff
    csrr            x11, mclicbase
    li              x12, INTIP
    add             x11, x11, x12
    sw              x10, 0x44( x11)
    sw              x10, 0x44( x11)

#test begin
.global CLRMIE2
CLRMIE2:
    csrsi           mstatus, 0x8          #mie = 0
.global INTOCCURS
INTOCCURS:
    mv              x10, x0 
    mv              x10, x0 
    li              x1 , 0x1
    bne             x1 , x15, TEST_FAIL
    csrr            x1 , mcause
    li              x3 , 0xff
    and             x1 , x1 , x3 
    li              x3 , 16 
    bne             x1 , x3 , TEST_FAIL
    csrr            x1 , mintstatus
    li              x3 , 0x0
    bne             x1 , x3 , TEST_FAIL

#************************************************
#level = 255, int16=int17, but priority is clicintctl[7:5], so int16 > int17
#***********************************************

    li              x1 , 0x8
    csrrc           x0 , mstatus, x1 

#//enable ID16  posedge pulse trigger  ie =1   level =1XXXXXXXX
    li              x10, 0xff03ffff
    csrr            x11, mclicbase
    li              x12, INTIP
    add             x11, x11, x12
    sw              x10, 0x40( x11)
    sw              x10, 0x40( x11)

#//enable ID17  posedge pulse trigger  ie =1   level =1XXXXXXXX
    li              x10, 0x8003ffff
    csrr            x11, mclicbase
    li              x12, INTIP
    add             x11, x11, x12
    sw              x10, 0x44( x11)
    sw              x10, 0x44( x11)
    csrsi           mstatus, 0x8           #set mie

.global INTOCCURS1
INTOCCURS1:
    mv              x10, x0 
    mv              x10, x0 
    li              x1 , 0x2
    bne             x1 , x15, TEST_FAIL
    csrr            x1 , mcause
    li              x3 , 0xff
    and             x1 , x1 , x3 
    li              x3 , 16 
    bne             x1 , x3 , TEST_FAIL
    csrr            x1 , mintstatus
    li              x3 , 0x0
    bne             x1 , x3 , TEST_FAIL
    csrci           mstatus, 0x8

#***************************************
#same level  same pri, check the int id, id17>id16   
#***************************************
#enable ID16  posedge pulse trigger  ie =1   level =1XXXXXXXX
    li              x10, 0xff03ffff
    csrr            x11, mclicbase
    li              x12, INTIP
    add             x11, x11, x12
    sw              x10, 0x40( x11)
    sw              x10, 0x40( x11)

#enable ID17  posedge pulse trigger  ie =1   level =1XXXXXXXX
    li              x10, 0xff03ffff
    csrr            x11, mclicbase
    li              x12, INTIP
    add             x11, x11, x12
    sw              x10, 0x44( x11)
    sw              x10, 0x44( x11)
    csrsi           mstatus, 0x8         #set mie
#test begin
.global INTOCCURS2
INTOCCURS2:
    mv              x10, x0 
    mv              x10, x0 
    csrr            x1 , mcause
    li              x3 , 0xff
    and             x1 , x1 , x3 
    li              x3 , 17 
    bne             x1 , x3 , TEST_FAIL
    csrr            x1 , mintstatus
    li              x3 , 0x0
    bne             x1 , x3 , TEST_FAIL
    li              x1 , 0x2
    bne             x1 , x15, TEST_FAIL
    li              x1 , 0x1
    bne             x1 , x14, TEST_FAIL
.global EXIT
EXIT:
    EXIT           
.global TEST_FAIL
TEST_FAIL:
    FAIL           

