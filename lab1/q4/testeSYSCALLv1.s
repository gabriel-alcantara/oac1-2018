# Teste dos syscalls 1xx que usam o SYSTEMv1.s
# Conectar o BitMap Display e o KD MMIO para executar
# na DE1-SoC e no Rars deve ter o mesmo comportamento sem alterar nada!


.include "macros.s"

.data
FLOAT: .float 3.14159265659
msg1: .string "Organizacao Arquitetura de Computadores 2017/2 !"
msg2: .string "Digite seu Nome:"
msg3: .string "Digite sua Idade:"
msg4: .string "Digite seu peso:"
msg5: .string "Numero Randomico:"
msg6: .string "Tempo do Sistema:"
buffer: .string "                                "

.text	
	M_SetEcall(exceptionHandling)	# Macro de SetEcall			
	jal CLS	
	
	M_SetEcall(exceptionHandling)	# Macro de SetEcall
	jal PRINTSTR1
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal INPUTSTR
	
	M_SetEcall(exceptionHandling)	# Macro de SetEcall
	jal READSTR
	
	M_SetEcall(exceptionHandling)	# Macro de SetEcall
	jal PRINTSTR
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal INPUTINT
	
	#M_SetEcall(exceptionHandling)   # Macro de SetEcall
	#jal READINT
	
	#M_SetEcall(exceptionHandling)   # Macro de SetEcall
	#jal PRINTINT
	
	M_SetEcall(exceptionHandling)
	jal INPUTFP
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal READFP
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal PRINTFP
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal RAND
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal SYSCALLRAND
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal PRINTRAND
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal TIME
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal PRINTTIME1
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal PRINTTIME2
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal TOCAR0
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal TOCAR1
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal TOCAR2
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal TOCAR3
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal TOCAR4
	
	M_SetEcall(exceptionHandling)   # Macro de SetEcall
	jal SLEEP
	
	#M_SetEcall(exceptionHandling)
	#jal PRINTSLEEP
	
	j M_Exit

M_Exit:
	li a7,10
	ecall
	
			
# CLS Clear Screen
CLS:	
	li a0,0x07
	li a7,148
	ecall
	ret
				
# syscall print string
PRINTSTR1: li a7,104
	la a0,msg1
	li a1,0
	li a2,0
	li a3,0xFF00
	ecall
	ret		
	
INPUTSTR: 
	li a7,104
	la a0,msg2
	li a1,0
	li a2,24
	li a3,0xFF00
	ecall
	
# syscall read string
READSTR:
	li a7,108
	la a0,buffer
	li a1,32
	ecall

# syscall print string
PRINTSTR:
	li a7,104
	la a0,buffer
	li a1,144
	li a2,24
	li a3,0xFF00
	ecall	
	ret
	
# syscall read int
	# syscall print string	
INPUTINT: li a7,104
	la a0,msg3
	li a1,0
	li a2,32
	li a3,0xFF00
	ecall

READINT:
	# syscall read int
	li a7,105
	ecall
	mv t0,a0

#PI:	li $t0,-123456
	# syscall print int	
PRINTINT: li a7,101
	mv a0,t0
	li a1,152
	li a2,32
	li a3,0xFF00
	ecall
	ret
	
# syscall read float
	# syscall print string	
INPUTFP: li t0,0 
	la t1,FLOAT
	flw f0,0(t1)
	fmv.x.s t0,f0
	beq t0,zero,FORAFP  # testa para ver se tem a FPU
 
  	li a7,104
	la a0,msg4
	li a1,0
	li a2,40
	li a3,0xFF00
	ecall

READFP:	
	li a7,106
	ecall

PRINTFP:
	# syscall print float
	li a7,102
	li a1,144
	li a2,40
	li a3,0xFF00
	ecall
	
FORAFP:	ret
	
	# Contatos imediatos do terceiro grau
TOCAR0:	li a0,62
	li a1,500
	li a2,16
	li a3,127
	li a7,133
	ecall
	
TOCAR1:	li a0,64
	li a1,500
	li a2,16
	li a3,127
	li a7,133
	ecall
	
TOCAR2:	li a0,61
	li a1,500
	li a2,16
	li a3,127
	li a7,133
	ecall
	
TOCAR3:	li a0,50
	li a1,500
	li a2,16
	li a3,127
	li a7,133
	ecall
	
	
TOCAR4:	li a0,55
	li a1,800
	li a2,16
	li a3,127
	li a7,131
	ecall
	
	ret
			
# syscall rand
	# syscall print string	
RAND:	li a7,104
	la a0,msg5
	li a1,0
	li a2,48
	li a3,0xFF00
	ecall

	# syscall Rand
SYSCALLRAND:
	li a7,141
	ecall

PRINTRAND:	
	# print int em hex
	li a7,134  #134
	li a1,148
	li a2,48
	li a3,0xFF00
	ecall
	
	ret
	
		
# syscall time
	# syscall print string	
TIME:	li a7,104
	la a0,msg6
	li a1,0
	li a2,56
	li a3,0xFF00
	ecall

SYSCALLTIME:
	li a7,130
	ecall
	
	mv t0,a0
	mv t1,a1

PRINTTIME1:	
	#print int
	mv a0,t0
	li a7,101
	li a1,148
	li a2,56
	li a3,0xFF00
	ecall

PRINTTIME2:	
	#print int
	mv a0,t1
	li a7,101
	li a1,244
	li a2,56
	li a3,0xFF00
	ecall
	
	ret
	
# syscall sleep
SLEEP:	li t0,5
LOOPHMS:li a0,1000   # 1 segundo
	li a7,132
	ecall

PRINTSLEEP:		
	addi t0,t0,-1
	#print seg
	mv a0,t0
	li a7,101
	li a1,120
	li a2,120
	li a3,0xFF00
	ecall
	
	bne t0,zero, LOOPHMS
		
	ret
	
# no rars o autor ainda nao implementou as regioes de memoria .kdata .ktext para as rotinas de sistem
# desse modo temos que as rotinas de sequencias devem fiar em sequencia por isso o include eh feito abaixo.
.include "SYSTEMv1.s"
