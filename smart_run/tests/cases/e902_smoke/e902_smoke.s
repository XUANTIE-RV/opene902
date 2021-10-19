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
.align 1
.global main
main:

#---------------------------------------#
#       main execution routine          #  
#---------------------------------------#
#---------------------------------------#
#          RV32I  instructions          #
#---------------------------------------#
#---------------------------------------#
#          Int Reg-imm Ins              #
#---------------------------------------#
#ADDi
ADDI:
#func 1 test basic
#-1 +5
li   x5, 0x4
li   x4, 0x5
addi x4, x4, 0xffffffff
bne  x4, x5, TEST_FAIL

#2047+2047
li   x5, 0xffe
li   x4, 0x7ff
addi x4, x4, 0x7ff
bne  x4, x5, TEST_FAIL

#-2048+-2048
li   x5, 0xfffff000
li   x4, 0xfffff800
addi x4, x4, 0xfffff800
bne  x4, x5, TEST_FAIL


#func 2 test MV
addi x4, x4, 0x123
addi x5, x4, 0x0
bne  x4, x5, TEST_FAIL
 
#func 3 test nop
li   x5, 0x0
addi x5, x5, 0x0
addi x0, x0, 0x0
addi x0, x0, 0x5
bne  x5, x0, TEST_FAIL

#SLTI
SLTI:
li   x4, 0x1
#signed compare 0xfff compare with 0xffffffff(imm expand)
li   x5, 0xfff
slti x5, x5, 0xffffffff
bne  x5, x0, TEST_FAIL

#signed compare 0xfff compare with 0x1(imm not expand)
li   x5, 0xfff
slti x5, x5, 0x1
bne  x5, x0, TEST_FAIL

#signed compare 0xffffffff compare with 0x1 
li   x5, 0xffffffff
slti x5, x5, 0x1
bne  x5, x4, TEST_FAIL

#signed compare 0x1 compare with 0x1
li   x5, 0x1
slti x5, x5, 0x1
bne  x5, x0, TEST_FAIL

#SLTIU
SLTIU:
li    x4, 0x1
#0xffffffff compare with 0xfff
li    x5, 0xffffffff
sltiu x5, x5, 0x7ff
bne   x5, x0, TEST_FAIL

#0xfff compare with 0x1
li    x5, 0xfff
sltiu x5, x5, 0x1
bne   x5, x0, TEST_FAIL

#0x1 compare with 0xfff(no sign extend)
li    x5, 0x1
sltiu x5, x5, 0x7ff
bne   x5, x4, TEST_FAIL

#ANDI
ANDI:
#0xaaaaaaaa andi 0xfff(sign extend)
li   x4, 0xaaaaaaaa
li   x5, 0xaaaaaaaa
andi x5, x5, 0xffffffff
bne  x4, x5, TEST_FAIL

#0xaaaaaaaa andi 0x7ff(sign extend)
li   x4, 0x2aa
li   x5, 0xaaaaaaaa
andi x5, x5, 0x7ff
bne  x4, x5, TEST_FAIL

#0xaaaaaaaa andi 0x0
li	x4, 0x0
li	x5, 0xaaaaaaaa
andi	x5, x5, 0x0
bne	x4, x5, TEST_FAIL

#ORI
ORI:
#0xaaaaaaaa ori 0xffffffff(sign extend)
li   x4, 0xffffffff
li   x5, 0xaaaaaaaa
ori  x5, x5, 0xffffffff
bne  x4, x5, TEST_FAIL

#0xaaaaaaaa ori 0x7ff(sign extend)
li   x4, 0x2aa
li   x5, 0xaaaaaaaa
ori  x5, x5, 0x7ff
beq  x4, x5, TEST_FAIL

#0xaaaaaaaa ori 0x0
li   x4, 0xaaaaaaaa
li   x5, 0xaaaaaaaa
ori  x5, x5, 0x0
bne  x4, x5, TEST_FAIL
#XORI
XORI:
#not
li   x4, 0xabcdabcd
xori x5, x4, -1
not  x6, x4
bne  x6, x5, TEST_FAIL

#0xf
li   x4, 0xabcdffff
li   x6, 0xabcdfff0
xori x5, x4, 0xf
bne  x6, x5, TEST_FAIL

#0x0
li   x4, 0xabcdabcd
li   x6, 0xabcdabcd
xori x5, x4, 0x0
bne  x6, x5, TEST_FAIL

#SLLI
SLLI:
li      x4, 0xabcd1234
slli    x2, x4, 0              #IMM5 = 0, x2 = x4
bne     x2, x4, TEST_FAIL

li      x4, 0xabcd1234
slli    x2, x4, 31             #IMM5 = 31, x2 = 0
li      x3, 0x0
bne     x2, x3, TEST_FAIL

li      x4, 0xaaaaaaaa
slli    x2, x4, 8             #IMM5 = 8, x2 = 0xaaaaaa
li      x3, 0xaaaaaa00
bne     x2, x3, TEST_FAIL


#SRLI
SRLI:
li      x2, 0xabcd1234
srli    x3, x2, 0              #IMM5 = 0, r2 = r1
bne     x2, x3, TEST_FAIL

li      x2, 0xaaaaaaaa
srli    x3, x2, 31             #IMM5 = 31, r2 = 1
li      x4, 0x1
bne     x3, x4, TEST_FAIL

li      x2, 0xaaaaaaaa
srli    x2, x2, 1             #IMM5 = 1, r2 = 0x55555555
li      x3, 0x55555555
bne     x2, x3, TEST_FAIL


#SRAI
SRAI:

li      x2, 0xaaaaaaaa
srai    x2, x2, 31           #IMM5 = 31,sign=1, x2 = 0xffffffff
li      x3, 0xffffffff
bne     x2, x3, TEST_FAIL

li      x2, 0x55555555
srai    x2, x2, 31           #IMM5=31, sign=0, x2 = 0
li      x3, 0
bne     x2, x3, TEST_FAIL
 
li      x2, 0x55555555
srai    x2, x2, 1           #IMM5=1 , x2 = 2aaaaaaa
li      x3, 0x2aaaaaaa
bne     x2, x3, TEST_FAIL

li      x2, 0xabcd1234
srai    x2, x2, 0           # /IMM5=0, r2 = abcd1234
li      x3, 0xabcd1234
bne     x2, x3, TEST_FAIL

#LUI
LUI:
lui     x2, 0x7bcd1           
li      x3, 0x7bcd1000
bne     x2, x3, TEST_FAIL

lui     x2, 0x89abc           
li      x3, 0x89abc000
bne     x2, x3, TEST_FAIL
#AUIPC
 AUIPC:
auipc   x2, 0x0
li      x3, 0xa00e
add     x2, x3, x2
auipc   x4, 0xa
bne     x2, x4, TEST_FAIL

auipc   x2, 0x0
li      x3, 0x8000000e
add     x2, x3, x2
auipc   x4, 0x80000
bne     x2, x4, TEST_FAIL

#---------------------------------------#
#          Int Reg-Reg Ins              #
#---------------------------------------#
#ADD
ADD:
#-1+ -1
li    x3, 0xffffffff
li    x4, 0xffffffff
add   x5, x3, x4
li    x6, 0xfffffffe
bne   x5, x6, TEST_FAIL

#0x8000000+ 0x80000000
li    x3, 0x80000000
li    x4, 0x80000000
add   x5, x3, x4
li    x6, 0x0
bne   x5, x6, TEST_FAIL


#0x7fffffff+ 0x7fffffff
li    x3, 0x7fffffff
li    x4, 0x7fffffff
add   x5, x3, x4
li    x6, 0xfffffffe
bne   x5, x6, TEST_FAIL


#SUB
SUB:
#0x80000000- 0x7fffffff
li    x3, 0x80000000
li    x4, 0x7fffffff
sub   x5, x3, x4
li    x6, 0x1
bne   x5, x6, TEST_FAIL

#0x7fffffff -  0x80000000
li    x3, 0x7fffffff
li    x4, 0x80000000
sub   x5, x3, x4
li    x6, 0xffffffff
bne   x5, x6, TEST_FAIL

#0xf - 0x2
li    x3, 0xf
li    x4, 0x2
sub   x5, x3, x4
li    x6, 0xd
bne   x5, x6, TEST_FAIL

#SLT
 SLT:
li    x3, 0x1
li    x4, 0x0
li    x5, 0x80000000
li    x6, 0xffffffff

#1 / 1
slt   x7, x3, x3
bne   x7, x4, TEST_FAIL

#1 / 0
slt   x7, x3, x4
bne   x7, x4, TEST_FAIL

#0 / 1
slt   x7, x4, x3
bne   x7, x3, TEST_FAIL

#0x80000000/ 0x1 # -max /1
slt   x7, x5, x3
bne   x7, x3, TEST_FAIL

#SLTU
 SLTU:
li    x3, 0x1
li    x4, 0x0
li    x5, 0x80000000
li    x6, 0xffffffff

#1 / 1
sltu	x7, x3, x3
bne	x7, x4, TEST_FAIL

#1 / 0
sltu	x7, x3, x4
bne	x7, x4, TEST_FAIL

#0 / 1
sltu	x7, x4, x3
bne	x7, x3, TEST_FAIL

#0x80000000/0x1 
sltu	x7, x5, x3
bne	x7, x4, TEST_FAIL

#AND
 AND:
li     x3, 0x0
li     x4, 0xffffffff

#0xabcdabcd  0xffffffff
li     x5, 0xabcdabcd
and    x6, x5, x4
bne    x6, x5, TEST_FAIL

#0xabcdabcd  0x0 
li     x5, 0xabcdabcd
and    x6, x5, x3
bne    x6, x3, TEST_FAIL

#OR
 OR:
li     x3, 0x0
li     x4, 0xffffffff

#0xabcdabcd | 0xffffffff
li     x5, 0xabcdabcd
or     x6, x5, x4
bne    x6, x4, TEST_FAIL

#0xabcdabcd | 0x0 
li     x5, 0xabcdabcd
or    	x6, x5, x3
bne    x6, x5, TEST_FAIL

#XOR
 XOR:
li     x3, 0x0
li     x4, 0xffffffff

#0xabcd | 0xffffffff #not
li     x5, 0xabcdabcd
xor    x6, x5, x4
not	x5, x5
bne    x6, x5, TEST_FAIL

#0xabcd | 0x0 
li     x5, 0xabcdabcd
xor    x6, x5, x3
bne    x6, x5, TEST_FAIL

#SLL
SLL:
li     x4, 0xabcd1234
sll    x2, x4, x0             #IMM5 = 0, x2 = x4
bne	x2, x4, TEST_FAIL

li	x4, 0xabcd1234
li 	x5, 31
sll    x2, x4, x5             #IMM5 = 31, x2 = 0
li   	x3, 0x0
bne   	x2, x3, TEST_FAIL

li    	x4, 0xaaaaaaaa
li     x5, 0x8
sll  	x2, x4, x5             #IMM5 = 8, x2 = 0xaaaaaa
li    	x3, 0xaaaaaa00
bne   	x2, x3, TEST_FAIL

li     x4, 0xaaaaaaaa
li	x5, 0x21
sll	x2, x4, x5          #IMM5 = 0x1, x2 = 0x55555554
li     x3, 0x55555554
bne    x2, x3, TEST_FAIL

#SRL
SRL:
li     x2, 0xabcd1234
srl	x3, x2, x0              #IMM5 = 0, r2 = r1
bne    x2, x3, TEST_FAIL

li     x2, 0xaaaaaaaa
li     x5, 31
srl    x3, x2, x5             #IMM5 = 31, r2 = 1
li     x4, 0x1
bne    x3, x4, TEST_FAIL

li     x2, 0xaaaaaaaa
li     x5, 0x1
srl    x2, x2, x5             #IMM5 = 1, r2 = 0x55555555
li     x3, 0x55555555
bne    x2, x3, TEST_FAIL

li     x2, 0xaaaaaaaa
li	x5, 0x21
srl    x2, x2, x5          #IMM5 = 0x1, x2 = 0x55555555
li     x3, 0x55555555
bne    x2, x3, TEST_FAIL

#SRA
SRA:

li      x2, 0xaaaaaaaa
li      x5, 0x1f
sra     x2, x2, x5           #IMM5 = 31,sign=1, x2 = 0xffffffff
li      x3, 0xffffffff
bne     x2, x3, TEST_FAIL

li     x2, 0x55555555
li	x5, 0x1f
sra    x2, x2, x5           #IMM5=31, sign=0, x2 = 0
li     x3, 0
bne    x2, x3, TEST_FAIL
 
li     x2, 0x55555555
li	x5, 0x1
sra    x2, x2, x5           #IMM5=1 , x2 = 2aaaaaaa
li     x3, 0x2aaaaaaa
bne    x2, x3, TEST_FAIL

li     x2, 0x55555555
li	x5, 0x21
sra    x2, x2, x5         #IMM5=1 , x2 = 2aaaaaaa
li     x3, 0x2aaaaaaa
bne    x2, x3, TEST_FAIL

li     x2, 0xabcd1234
sra    x2, x2, x0          # /IMM5=0, r2 = abcd1234
li     x3, 0xabcd1234
bne    x2, x3, TEST_FAIL

#---------------------------------------#
#          RV32M  instructions          #
#---------------------------------------#
#MUL 
 MUL:
li	x3, 0x80000000
li	x4, 0x7fffffff
li	x10,0xabcde 
# one source is 0
#                  1. The other is negative     0x80000000
#                  2. The other is 0
#                  3. The other is positive     0x7fffffff
mul	x5, x0, x3
bne	x5, x0, TEST_FAIL
    
mul	x5, x0, x0
bne  	x5, x0, TEST_FAIL

mul	x5, x0, x4
bne 	x5, x0, TEST_FAIL

# one source is positive       0x7fffffff
#                  1. The other is positive     0x7fffffff
#                  2. The other is 0
#                  3. The other is negative     0x80000000
#                  4. The other is positive	 0xabcde
mul	x5, x4, x4
li 	x6, 0x1
bne 	x5, x6, TEST_FAIL

mul 	x5, x4, x0
bne 	x5, x0, TEST_FAIL

mul 	x5, x4, x3
li	x6, 0x80000000
bne	x5, x6, TEST_FAIL

mul 	x5, x4, x10
li	x6, 0xfff54322
bne	x5, x6, TEST_FAIL

# one source is positive       0x800000000
#                  1. The other is positive     0x80000000
#                  2. The other is 0
#                  3. The other is negtive     0x7fffffff
#                  4. The other is positive	 0xabcde

mul 	x5, x3, x3
li     x6, 0x0
bne 	x5, x6, TEST_FAIL

mul 	x5, x3, x0
bne 	x5, x0, TEST_FAIL

mul 	x5, x3, x4
li 	x6, 0x80000000
bne 	x6, x5, TEST_FAIL

mul 	x5, x3, x10
li 	x6, 0x0
bne 	x6, x5, TEST_FAIL

#0xabcde x 0xabcde
mul 	x5, x10, x10
li 	x6, 0x4caed084
bne 	x6, x5, TEST_FAIL


#MULH
 MULH:
li	x3, 0x7fffffff
li	x4, 0x80000000 
li	x10,0xabcde
# one source is 0
#                  1. The other is positive     0x7fffffff
#                  2. The other is 0
#                  3. The other is negative     0x80000000
mulh	x5, x0, x3
bne	x5, x0, TEST_FAIL
    
mulh	x5, x0, x0
bne  	x5, x0, TEST_FAIL

mulh	x5, x0, x4
bne 	x5, x0, TEST_FAIL

# one source is negative       0x80000000
#                  1. The other is positive     0x7fffffff
#                  2. The other is 0
#                  3. The other is negative     0x80000000
#                  4. The other is positive	 0xabcde

mulh	x5, x4, x3
li 	x6, 0xc0000000
bne 	x5, x6, TEST_FAIL

mulh 	x5, x4, x0
bne 	x5, x0, TEST_FAIL

mulh 	x5, x4, x4
li	x6, 0x40000000
bne	x5, x6, TEST_FAIL

mulh 	x5, x4, x10
li	x6, 0xfffaa191
bne	x5, x6, TEST_FAIL

#0xabcde x 0xabcde
mulh 	x5, x10, x10
li 	x6, 0x73
bne 	x6, x5, TEST_FAIL

#MULHU
 MULHU:
li	 x3, 0xffffffff
li	 x4, 0x23456
li	 x10, 0xabcde 
# one source is 0
#                  1. The other is negative     0xffffffff
#                  2. The other is 0
#                  3. The other is positive     0x23456
mulhu	x5, x0, x3
bne	x5, x0, TEST_FAIL
    
mulhu	x5, x0, x0
bne  	x5, x0, TEST_FAIL

mulhu	x5, x0, x4
bne 	x5, x0, TEST_FAIL

# one source is unsigned       0x23456
#                  1. The other is unsigned     0xffffffff
#                  2. The other is unsigned     0x23456
mulhu	x5, x4, x3
li 	x6, 0x23455
bne 	x5, x6, TEST_FAIL

mulhu 	x5, x4, x4
li	x6,0x4
bne	x5, x6, TEST_FAIL

# one source is unsigned     0xffffffff
#                  1. The other is unsigned    0xffffffff
#                  2. The other is unsigned    0x23456
mulhu 	x5, x3, x3
li	x6, 0xfffffffe
bne 	x5, x6, TEST_FAIL

mulhu 	x5, x3, x4
li 	x6, 0x23455
bne 	x6, x5, TEST_FAIL

#MULHSU
 MULHSU:
li	 x3, 0x80000000
li	 x4, 0x7fffffff
li	 x10,0x23456 
# one source is 0
#                  1. The other is negative     0x80000000
#                  2. The other is 0
#                  3. The other is positive     0x7fffffff
#                  3. The other is positive     0x23456
mulhsu	x5, x0, x3
bne	x5, x0, TEST_FAIL
    
mulhsu	x5, x0, x0
bne  	x5, x0, TEST_FAIL

mulhsu	x5, x0, x4
bne 	x5, x0, TEST_FAIL

mulhsu x5, x0, x10
bne 	x5, x0, TEST_FAIL
# one source is   signed     0x7fffffff
#                  1. The other is unsigned     0x80000000
#                  2. The other is unsigned     0x7fffffff
#                  2. The other is unsigned     0x23456
mulhsu	x5, x4, x3
li 	x6, 0x3fffffff
bne 	x5, x6, TEST_FAIL

mulhsu	x5, x4, x4
li 	x6, 0x3fffffff
bne	x5, x6, TEST_FAIL

mulhsu	x5, x4, x10
li 	x6, 0x11a2a
bne	x5, x6, TEST_FAIL

# one source is    signed    0x80000000
#                  1. The other is unsigned     0x80000000
#                  2. The other is unsigned     0x7fffffff
#                  2. The other is unsigned     0x23456

mulhsu	x5, x3, x3
li	x6, 0xc0000000
bne 	x5, x6, TEST_FAIL

mulhsu x5, x3, x4
li 	x6, 0xc0000000
bne 	x6, x5, TEST_FAIL

mulhsu x5, x3, x10
li 	x6, 0xfffee5d5
bne 	x6, x5, TEST_FAIL

#DIV
DIV:
li	x2, 0x80000000
li	x3, 0xabcdabcd
li	x4, 0x789a789a
li     x5, 0xffffffff

#0x0/0x789a789a
div    x6, x0, x4
li     x7, 0x0
bne	x6, x7, TEST_FAIL


#0xabcdabcd/0x789a789a
div    x6, x3, x4
li     x7, 0x0
bne	x6, x7, TEST_FAIL

#0x789a789a/0xabcdabcd
div    x6, x4, x3
li     x7, 0xffffffff
bne	x6, x7, TEST_FAIL

#0xabcdabcd/0x0
div	x6, x3, x0
mv	x7, x5
bne	x6, x7, TEST_FAIL

#0x80000000/0xffffffff
div	x6, x2, x5
mv	x7, x2
bne	x6, x7, TEST_FAIL

#DIVU
DIVU:
li	x2, 0x80000000
li	x3, 0xabcdabcd
li	x4, 0x789a789a
li     x5, 0xffffffff

#0x0/0x789a789a
divu   x6, x0, x4
li     x7, 0x0
bne	x6, x7, TEST_FAIL

#0xabcdabcd/0x789a789a
divu  	x6, x3, x4
li     x7, 0x1
bne	x6, x7, TEST_FAIL

#0x789a789a/0xabcdabcd
divu 	x6, x4, x3
li     x7, 0x0
bne	x6, x7, TEST_FAIL

#0xabcdabcd/0x0
divu	x6, x3, x0
mv	x7, x5
bne	x6, x7, TEST_FAIL

#0x80000000/0xffffffff
divu	x6, x2, x5
mv	x7, x0
bne	x6, x7, TEST_FAIL

#REM
REM:
li	x2, 0x80000000
li	x3, 0xabcdabcd
li	x4, 0x789a789a
li     x5, 0xffffffff

#0x0/0x789a789a
rem   x6, x0, x4
li     x7, 0x0
bne	x6, x7, TEST_FAIL

#0xabcdabcd/0x789a789a
rem  	x6, x3, x4
li     x7, 0xabcdabcd
bne	x6, x7, TEST_FAIL

#0x789a789a/0xabcdabcd
rem 	x6, x4, x3
li     x7, 0x24682467
bne	x6, x7, TEST_FAIL

#0xabcdabcd/0x0
rem	x6, x3, x0
mv	x7, x3
bne	x6, x7, TEST_FAIL

#0x80000000/0xffffffff
rem	x6, x2, x5
mv	x7, x0
bne	x6, x7, TEST_FAIL

#REMU
REMU:
li	x2, 0x80000000
li	x3, 0xabcdabcd
li	x4, 0x789a789a
li     x5, 0xffffffff

#0x0/0x789a789a
remu   x6, x0, x4
li     x7, 0x0
bne	x6, x7, TEST_FAIL

#0xabcdabcd/0x789a789a
remu  	x6, x3, x4
li     x7, 0x33333333
bne	x6, x7, TEST_FAIL

#0x789a789a/0xabcdabcd
remu 	x6, x4, x3
li     x7, 0x789a789a
bne	x6, x7, TEST_FAIL

#0xabcdabcd/0x0
remu	x6, x3, x0
mv	x7, x3
bne	x6, x7, TEST_FAIL

#0x80000000/0xffffffff
remu	x6, x2, x5
mv	x7, x2
bne	x6, x7, TEST_FAIL

#---------------------------------------#
#          RV32C  instructions          #
#---------------------------------------#
#---------------------------------------#
#          Int Cons-Gen Ins             #
#---------------------------------------#
#CLI
#sign extend
CLI:
c.li	x4, 0x1f
li	x5, 0x1f
bne	x4, x5, TEST_FAIL

c.li	x4, -32
li	x5, -32
bne	x4, x5, TEST_FAIL	
#CLUI
CLUI:
c.lui	x4, 0xfffe0
li	x5, 0xfffe0000
bne	x4, x5, TEST_FAIL

c.lui	x4, 0x1f
li	x5, 0x1f000
bne	x4, x5, TEST_FAIL	
#---------------------------------------#
#          Int Reg-Imm  Ins             #
#---------------------------------------#
#CADDI
CADDI:
li	x4, 0x80000000
li	x5, 0x7fffffe0
c.addi	x4, -32
bne	x4, x5, TEST_FAIL

li	x4, 0x80000000
li	x5, 0x8000001f
c.addi	x4, 31
bne	x4, x5, TEST_FAIL

#CADDI16SP
CADDI16SP:
li          x2, 0x0
li          x3, -512
c.addi16sp  x2, -512
bne	     x2, x3, TEST_FAIL

li          x2, 0x0
li          x3, 0x1f0
c.addi16sp  x2, 0x1f0
bne	     x2, x3, TEST_FAIL

#CADDI4SPN 
CADDI4SPN:
li          x2, 0x0
li          x3, 0x380
c.addi4spn  x8, x2, 0x380 #test 0 extend
bne	     x8, x3, TEST_FAIL

li          x2, 0x0
li          x3, 124
c.addi4spn  x8, x2,0x7c
bne	     x8, x3, TEST_FAIL

#CSLLI
CSLLI:
li	x3, 0xaaaaaaaa
li	x4, 0x0
c.slli	x3, 0x1f
bne	x3, x4, TEST_FAIL


li	x3, 0xaaaa
li	x4, 0x55550000
c.slli	x3, 0xf
bne	x3, x4, TEST_FAIL


#CSRLI
#CSRLI
#li	x4, 0x0
#c.srli	x0, 0x1f
#bne	x0, x4, TEST_FAIL

li	x8, 0xaaaaaaaa
li	x4, 0x1
c.srli	x8, 0x1f
bne	x8, x4, TEST_FAIL

li	x8, 0x55555555
li	x4, 0x5555555
c.srli	x8, 0x4
bne	x8, x4, TEST_FAIL



#CSRAI
CSRAI:
#li	x4, 0x0
#c.srai	x0, 0x1f
#bne	x0, x4, TEST_FAIL

li	x8, 0xaaaaaaaa
li	x4, 0xffffffff
c.srai	x8, 0x1f
bne	x8, x4, TEST_FAIL

li	x8, 0x55555555
li	x4, 0x5555555
c.srai	x8, 0x4
bne	x8, x4, TEST_FAIL


#CANDI
CANDI:
#li	x4, 0x0
#c.andi	x0, 0x1f
#bne	x0, x4, TEST_FAIL

li	x8, 0xaaaaaaaa
li	x4, 0xaaaaaaaa
c.andi	x8, -1
bne	x8, x4, TEST_FAIL

li	x8, 0xaaaaaaaa
li	x4, 0xa
c.andi	x8, 0x1f
bne	x8, x4, TEST_FAIL

li	x8, 0xaaaaaaaa
li	x4, 0xaaaaaaa0
c.andi	x8, -32
bne	x8, x4, TEST_FAIL


#---------------------------------------#
#          Int Reg-Reg  Ins             #
#---------------------------------------#
#CMV
CMV:
li	x4, 0xabcdabcd
li	x5, 0x0
c.mv	x5, x4
bne	x4, x5, TEST_FAIL

#CADD
CADD:
#-1+ -1
li	x3, 0xffffffff
li	x4, 0xffffffff
c.add	x3, x4
li	x5, 0xfffffffe
bne	x3, x5, TEST_FAIL

#0x8000000+ 0x80000000
li	x3, 0x80000000
li	x4, 0x80000000
c.add	x3, x4
li	x5, 0x0
bne	x3, x5, TEST_FAIL

#0x7fffffff+ 0x7fffffff
li	x3, 0x7fffffff
li	x4, 0x7fffffff
c.add	x3, x4
li	x5, 0xfffffffe
bne	x3, x5, TEST_FAIL


#CAND
CAND:
li     x8, 0x0
li     x9, 0xffffffff

#0xabcd  0xffffffff
li     x5, 0xabcdabcd
li     x10, 0xabcdabcd
c.and	x10, x9
bne    x10, x5, TEST_FAIL

#0xabcd  0x0 
li     x5, 0xabcdabcd
li     x10, 0xabcdabcd
c.and	x10, x8
bne    x10, x8, TEST_FAIL

#COR
 COR:
li     x8, 0x0
li     x9, 0xffffffff

#0xabcd | 0xffffffff
li     x5, 0xabcdabcd
li     x10, 0xabcdabcd
c.or  	x10, x9
bne    x10, x9, TEST_FAIL

#0xabcd | 0x0 
li     x5, 0xabcdabcd
li     x10, 0xabcdabcd
c.or   x10, x8
bne    x10, x5, TEST_FAIL

#CXOR
 CXOR:
li     x8, 0x0
li     x9, 0xffffffff

#0xabcd xor 0xffffffff
li     x10, 0xabcdabcd
not    x5, x10
c.xor  x10, x9
bne    x10, x5, TEST_FAIL

#0xabcd xor 0x0 
li     x5, 0xabcdabcd
li     x10, 0xabcdabcd
c.xor  x10, x8
bne    x10, x5, TEST_FAIL

#CSUB
CSUB:
#0x80000000- 0x7fffffff
li    x8, 0x80000000
li    x9, 0x7fffffff
c.sub x8, x9
li    x5, 0x1
bne   x8, x5, TEST_FAIL

#0x7fffffff -  0x80000000
li    x8, 0x7fffffff
li    x9, 0x80000000
c.sub x8, x9
li    x5, 0xffffffff
bne   x8, x5, TEST_FAIL

#0xf - 0x2
li    x8, 0xf
li    x9, 0x2
c.sub x8, x9
li    x5, 0xd
bne   x8, x5, TEST_FAIL


##############################
#                         RV32I
###############################

#*****************************************************
#                  store and load
#*****************************************************

#r1 is link reg  ,r2 is stack reg
#r0 = 0
#r3 = ffffffff
li     x3,0xffffffff
li     x8,0xaaaaaaaa
#x3 = ffffffff


#addr is in x4
#sw and lw 
li    x4,0x0000a000           #x4 = 0000a000

sw     x8,0xfffffffc(x4)          #mem[0x0000affc] = 0xaaaaaaaa
lw     x5,0xfffffffc(x4)          # x5 = aaaaaaaa
bne    x8,x5,TEST_FAIL      

sw     x8,0x7fc(x4)          #mem[0x0000a7fc] = 0xaaaaaaaa
lw     x5,0x7fc(x4)          # x5 = aaaaaaaa
bne    x8,x5,TEST_FAIL      

sw     x3,0x0(x4)           #mem[0x0000a000] = 0xffffffff
lw     x5,0x0(x4)           # x5 = 0xffffffff
bne    x3,x5,TEST_FAIL          

li     x6,0xffff8000       #x6 =  0xffff_8000
li     x8,0x00008000       #x8 cmp reg = 0000_8000
li     x9,0xaaaaaaaa
li     x10,0xaaaa8000

#sh and lh
sw     x9,0x0(x4)           #mem[0x0000a000] = 0xaaaaaaaa
sh     x6,0x0(x4)           #mem[0x0000a000] = 0xaaaa_8000
lhu    x7,0x0(x4)           # x7 = 0x0000_8000  zeroextend
lh     x5,0x0(x4)           #x5 = 0xffff_8000   signextend
lw     x11,0x0(x4) 
bne    x7,x8,TEST_FAIL
bne    x6,x5,TEST_FAIL
bne    x11,x10,TEST_FAIL

sh     x6,0xfffffffe(x4)           #mem[0x0000affe] = 0x8000
lhu    x7,0xfffffffe(x4)           # x7 = 0x0000_8000  zeroextend
lh     x5,0xfffffffe(x4)           #x5 = 0xffff_8000   signextend
bne    x7,x8,TEST_FAIL
bne    x6,x5,TEST_FAIL

sh     x6,0x7fe(x4)           #mem[0x0000a7fe] = 0x8000
lhu    x7,0x7fe(x4)           # x7 = 0x0000_8000  zeroextend
lh     x5,0x7fe(x4)           #x5 = 0xffff_8000   signextend
bne    x7,x8,TEST_FAIL
bne    x6,x5,TEST_FAIL



#sb and lb
li     x8,0x000000ff
li     x9,0xaaaaaaaa
li     x10,0xaaaaaaff
sw     x9,0x0(x4)            #mem[0x0000a000] = 0xaaaaaaaa
sb     x3,0x0(x4)            #mem[0x0000a000] = 0xaaaaaaff
lbu    x7,0x0(x4)            # x7 = 0x0000_00ff   zeroextend
lb     x5,0x0(x4)            #x5  = 0xffff_ffff   signextend
lw     x11,0x0(x4) 
bne    x7,x8,TEST_FAIL
bne    x3,x5,TEST_FAIL
bne    x10,x11,TEST_FAIL

sb     x3,0xffffffff(x4)            #mem[0x0000afff] = ff
lbu    x7,0xffffffff(x4)            # x7 = 0x0000_00ff   zeroextend
lb     x5,0xffffffff(x4)            #x5  = 0xffff_ffff   signextend
bne    x7,x8,TEST_FAIL
bne    x3,x5,TEST_FAIL

sb     x3,0x7ff(x4)            #mem[0x0000a7ff] = ff
lbu    x7,0x7ff(x4)            # x7 = 0x0000_00ff   zeroextend
lb     x5,0x7ff(x4)            #x5  = 0xffff_ffff   signextend
bne    x7,x8,TEST_FAIL
bne    x3,x5,TEST_FAIL

 

#*************************************************
#                      jmp 
#**************************************************

jal x1,BRANCH_LABEL            #x1 = next pc
A:
jal x0,JREG_LABEL                 #j

#***********************************************************
#               branch 
#r0 = 0
#r3 = ffff_ffff
#r4 = 8000_0000
#*************************************************************

BRANCH_LABEL:
li x4,0x80000000
#beq 
beq x0,x4,TEST_FAIL
beq x4,x4,BNE_LABEL 
beq x0,x0,TEST_FAIL                   #not execute

#bne
BNE_LABEL:
bne x4,x4,TEST_FAIL
bne x0,x4,BLT_LABEL 
beq x0,x0,TEST_FAIL                   #not execute

#blt
BLT_LABEL:            
blt x0,x4,TEST_FAIL
blt x4,x4,TEST_FAIL
blt x4,x0,BGE_LABEL
beq x0,x0,TEST_FAIL                   #not execute

#bge   
BGE_LABEL:
bge x4,x3,TEST_FAIL
bge x3,x4,BGEE_LABEL
beq x0,x0,TEST_FAIL                    #not execute

BGEE_LABEL:                  #equal
bge x3,x3,BGEU_LABEL
beq x0,x0,TEST_FAIL                    #not execute

#bgeu
BGEU_LABEL:
bgeu  x4,x3,TEST_FAIL
bgeu  x3,x4,BGEUE_LABEL
beq x0,x0,TEST_FAIL                    #not execute

BGEUE_LABEL:
bgeu x3,x3,BLTU_LABEL
beq x0,x0,TEST_FAIL                    #not execute

#bltu
BLTU_LABEL:
bltu x4,x0,TEST_FAIL
bltu x4,x4,TEST_FAIL
bltu x0,x4,J_LABEL
beq x0,x0,TEST_FAIL                   #not execute

J_LABEL:
jalr  x1,x1,0x0                  #jump to A

B:
jal x0,C_LABEL
     
JREG_LABEL:
jalr  x0,x1,0x0                 #jr  jump to B
         


###############################/
#                     RV32C
###############################/
C_LABEL:
#*****************************************************
#                  store and load
#*****************************************************

#r1   is link reg  ,r2 is stack reg
#r0 = 0
#r8 = ffffffff        
#x9 = 0
li x8,0xffffffff
li x9,0xaaaaaaaa

li    x10,0x0000b000              #x10 = 0000b000
c.sw     x8,0x0(x10)            #mem[0x0000b000] = 0xffffffff
lw     x11,0x0(x10)           # x11 = 0xffffffff
bne    x8,x11,TEST_FAIL 

#offset = all 1
c.sw     x8,0x7c(x10)            #mem[0x0000b07c] = 0xffffffff
lw x11,0x7c(x10)
bne    x8,x11,TEST_FAIL 

c.sw     x8,0x3c(x10)            #mem[0x0000b07c] = 0xffffffff
lw x11,0x3c(x10)
bne    x8,x11,TEST_FAIL 

c.sw     x8,0x40(x10)            #mem[0x0000b07c] = 0xffffffff
lw x11,0x40(x10)
bne    x8,x11,TEST_FAIL 



sw x9,0x40(x10)
c.lw     x11,0x40(x10)           # x11 = 0xffffffff
bne    x9,x11,TEST_FAIL 

sw x9,0x3c(x10)
c.lw     x11,0x3c(x10)           # x11 = 0xffffffff
bne    x9,x11,TEST_FAIL 

sw x9,0x7c(x10)
c.lw     x11,0x7c(x10)           # x11 = 0xffffffff
bne    x9,x11,TEST_FAIL 

sw x9,0x0(x10)
c.lw     x11,0x0(x10)           # x11 = 0xffffffff
bne    x9,x11,TEST_FAIL 




             
#selfcheck
#*****************************************
#     stack_point based load and store
#******************************************
li x8,0x55555555
li x9,0xaaaaaaaa
li x2,110000
mv x7,x2
c.swsp x8,0x0(sp)
lw x12,0x0(x7)
bne x8,x12,TEST_FAIL 

c.swsp x9,0xfc(sp)
lw x12,0xfc(x7)
bne x9,x12,TEST_FAIL 

c.swsp x8,0x80(sp)
lw x12,0x80(x7)
bne x8,x12,TEST_FAIL 

c.swsp x8,0x7c(sp)
lw x12,0x7c(x7)
bne x8,x12,TEST_FAIL 


sw x7,0x0(x7)
c.lwsp x12,0x0(sp)        #offset all 0
bne x7,x12,TEST_FAIL 

sw x7,0x80(x7)
c.lwsp x12,0x80(sp)        #offset all 0
bne x7,x12,TEST_FAIL 

sw x7,0xfc(x7)
c.lwsp x12,0xfc(sp)        #offset all 0
bne x7,x12,TEST_FAIL 

sw x7,0x7c(x7)
c.lwsp x12,0x7c(sp)        #offset all 0
bne x7,x12,TEST_FAIL 

                    
c.swsp x9,0xfc(sp)
c.lwsp x12,0xfc(sp)       #offset all 1
bne x9,x12,TEST_FAIL
                 
#*************************************************
#                      jmp 
#**************************************************

c.jal JR_LABEL1               #x1 = nextpc
C:
c.jr x1                         #jump to D
JR_LABEL1:
c.j   BRANCH_LABEL_16
beq x8,x8,TEST_FAIL                 #no execute


#***********************************************************
#               branch 
#r8 = ffffffff
#r9 = 00000000
#r10 =80000b000
#r11 = ffffffff
#*************************************************************
BRANCH_LABEL_16:
li x10,0x80000000
li x9,0x00000000

#beqz
c.beqz x8,TEST_FAIL
c.beqz x10,TEST_FAIL                      
c.beqz x9,BNEZ_LABEL
beq x0,x0,TEST_FAIL                      #not execute

BNEZ_LABEL:
c.bnez x9,TEST_FAIL
c.bnez x10,C_J

C_J:
c.jalr x1                         #jump to C
D:
c.jal FENCE_LABEL
beq x0,x0,TEST_FAIL                      #not execute

#**************************************************************
#                      fence
#**************************************************************

FENCE_LABEL:
fence
fence io,rw
fence rw,io
fence io,iorw
fence iorw,io
fence io,rw
fence.i

#---------------------------------------#
#exit
#---------------------------------------#
TEST_PASS:
la  x1, __exit 
jr  x1


#---------------------------------------#
#fail
#---------------------------------------#
TEST_FAIL:
la  x1, __fail
jr x1
