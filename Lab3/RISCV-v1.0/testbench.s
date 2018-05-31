# Teste bech OAC 2018/1 grupo 6
.data
NUM20: .word 20
NUM30: .word 30
NUM1:  .word 1
NUM10: .word 10
NUM2:  .word 2
NUMHex: .word 0XFFFFFFFF
NUMHex2: .word 0X00001000
.text
BLOCO1:
#BLOCO 1
# test instruction: add, lw e bne
lw  t1, NUM20
lw t2,NUM10
lw t3,NUM30
add t1,t2,t1  # t1 = 5 +20
bne t3,t1,ErrorB1 # if t3!= t1 : pc=ErrorB1 ? pc=pc+4
BLOCO2:
#bloco 2
# test instruction: sub, lw, bne
lw t1,NUM20
lw t2,NUM30
lw t3,NUM10
sub t1,t2,t1 # t1 = 30 - 20
bne t3,t1,ErrorB2 # if t3!= t1 : pc=ErrorB2 ? pc=pc+4
BLOCO3:
#bloco 3
# test instruction:  lw,and,bne 
lw t1, NUMHex
and t2,t1,zero # 0xFFFFFFFF and 0X0000000
bne t2,zero,ErrorB3 # if t2 != 0 : pc=ErrorB3 ? pc=pc+4
BLOCO4:
#bloco 4
# test instruction: or,lw, bne
lw t1,NUMHex  
or t2,t1,zero  # 0xFFFFFFFF or 0X0000000
bne t2,t1,ErrorB4 # if t2 != t1 : pc=ErrorB4 ? pc=pc+4
BLOCO5:
#bloco 5
# test instruction: xor, lw, bne
lw t1,NUMHex
lw t2,NUMHex
xor t3,t1,t2  # 0xFFFFFFFF xor 0xFFFFFFFF
bne zero,t3,ErrorB5 # if t3 != t2 : pc=ErrorB5 ?pc=pc+4
BLOCO6:
# bloco 6
# test instruction: lw, add, slt, beq
lw t1,NUM30
lw t2,NUM10
add t0,zero,zero
slt t0,t2,t1 # if t2 <  t1 : t0=1 ? t0=0
beq t0,zero,ErrorB6 # if t0==zero : pc=ErrorB6 ? pc=pc+4
BLOCO7:
#bloco 7
# test instruction: lw, add, sltu,beq
lw t1,NUM30
lw t2,NUM20
add t0,zero,zero
sltu t0,t2,t1 # t2 < t1: t0=1 ? t0=0
beq  t0,zero,ErrorB7 #if t0==zero : pc=ErrorB7 ? pc=pc+4
BLOCO8:
#bloco 8
# test instruction: lw, sll, bne
lw t1,NUM20
lw t2, NUM10
lw t3, NUM1
sll t4,t2,t3 #t4:=10 *2
bne t1,t4,ErrorB8 # if t4 == 20 : pc=ErrorB8 ? pc=pc+4
BLOCO9l:
#bloco 9
# test instruction: lw,srl,bne
lw t1,NUM20
lw t2,NUM10
lw t3, NUM1
srl t4,t1,t3 #t4:= 20/2
bne t2,t4,ErrorB9# if t4 == 20 : pc=ErrorB9 ? pc=pc+4
BLOCO10:
#blobo 10
# teste isntruction: lw, sra, bne
lw t1,NUM10
lw t2, NUM2
sra t3,t1,t2
bne t3,t2,ErrorB10 # if t3 != 2 : pc=ErrorB10 ? pc=pc+4
BLOCO11:
#bloco 11
# teste instruction: lw, addi, bne
lw t1,NUM10
lw t2,NUM30
addi t3,t1,20
bne t3,t2,ErrorB11 # if t3 != 30 : pc=ErrorB11 ? pc=pc+4
BLOCO12:
#bloco 12
# test instruction: lw, andi, bne
lw t1, NUMHex
lw t4,NUM1
andi t2,t1,0X00000001 # 0xFFFFFFFF andi 0X0000001 
bne t4,t2,ErrorB12 # if t2 != 1 : pc=ErrorB2 ?  pc=pc+4
BLOCO13:
# bloco 13
# test instruction: lw ,ori, bne
lw t1,NUMHex
ori t2,t1,0x0 # 0xFFFFFFFF ori 0X0000000
bne t2,t1,ErrorB13 # if  t2 != 0xFFFFFFFF : pc=ErrorB13 ? pc=pc+4
BLOCO14:
#blobo 14
# test instruction: lw, xori, bne
lw t1,NUMHex
xori t2,t1,0xFFFFFFFF #  0xFFFFFFFF xori  0xFFFFFFFF
bne t2,zero,ErrorB14 # if t2  != zero : pc=ErrorB14 ? pc=pc+4
BLOCO15:
#bloco 15
# test instruction: lw, slti, bne, sltiu
lw t1,NUM1
slti t2,t1,100 # if t1 < 100 : t2:=1 ? t2:=0
bne t2,t1,ErrorB15 # if t2 != 1 : pc=ErrorB15 ? pc=pc+4
sltiu t2,t1,100
bne t2,t1,ErrorB15
BLOCO16:
#bloco 16
# test instruction: lw, slli, bne
lw t2,NUM20
lw t1,NUM10
slli t3,t1,1 # t3:= 10*2
bne t2,t3,ErrorB16 # if t3 != 20 : pc=ErrorB16 ? pc=pc+4
BLOCO17:
# bloco 17
# test instruction: lw,srli,bne
lw t1,NUM10
lw t2,NUM20
srli t3,t2,1 # t3:=20/2
bne t3,t1,ErrorB17 # if t3 != 10 : pc=ErrorB17 ? pc=pc+4
BLOCO18:
#bloco 18
# test instruction: lw, srai, bne
lw t1,NUM20
lw t2,NUM10
srai t3,t1,1 # t3 := 20/2
bne t3,t2,ErrorB18 # if t3 != 10 : pc=ErrorB18 ? pc=pc+4
BLOCO19:
#bloco 19
# test  instruction: auipc,
auipc t1,0X0000000a # fazer auipc depois
lw t2,NUM20
lw t3,NUM10
BLOCO20:
#bloco 20
# test instruction : lui,lw, bne
lui t1,1
lw t2,NUMHex2 
bne t1,t2,ErrorB20 #if t2 != 0X00001000 : pc=ErrorB20 : pc=pc+4
BLOCO21:
#bloco 21
#test instruction: lw,beq
lw t1,NUM10
lw t2,NUM20
beq t1,t2,ErrorB21 # t1 == t2 : pc=Error21 ? pc=pc+4
BLOCO22:
#bloco22
# test instruction: lw,bge,bgeu
lw t1,NUM10
lw t2,NUM20
bge t1,t2,ErrorB22 # t1>= t2 : pc=Error22 ? pc=pc+4
bgeu t1,t2,ErrorB22 # |t1 >= t2| : pc=Error22 ?´pc=pc+4
BLOCO23:
#bloco 23
#test instruction:
lw t1,NUM10
lw t2,NUM20
blt t2,t1,ErrorB23 # t2 < t1 : pc=Error23 ? pc=pc+4
bltu t2,t1,ErrorB23 # t2 < t1 : pc=Error23 ? pc=pc+4
BLOCO24:
#bloco24
# test instruction:

ErrorB1:
ErrorB2:
ErrorB3:
ErrorB4:
ErrorB5:
ErrorB6:
ErrorB7:
ErrorB8:
ErrorB9:
ErrorB10:
ErrorB11:
ErrorB12:
ErrorB13:
ErrorB14:
ErrorB15:
ErrorB16:
ErrorB17:
ErrorB18:
ErrorB19:
ErrorB20:
ErrorB21:
ErrorB22:
ErrorB23:
