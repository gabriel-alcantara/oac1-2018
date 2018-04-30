# Exemplo da rotina ECALL

.data
.align 2			# alinha o dado seguinte em word
	E_STR: .string "Isto e so para teste:"
	E_NL:  .string "\n"	
.text
ECALL: 	

	li t0,104		# carrega t0 = 104
	bne a7,t0,E_FIM		# Se n�o for o servi�o 104 ent�o FIM
	
	mv t0,a0		# salva argumento a0 em t0
	la a0,E_STR		# ponteiro para a STR
	li a7,4			# servi�o original de print string
	ecall
	
	mv a0,t0		# recupera o n�mero a ser impresso			
	li a7,1			# servi�o original print int
	ecall
	
	la a0,E_NL		# ponteiro para a NL
	li a7,4			# servi�o original de print string
	ecall

#finalizacao n precisa entender agora, soh quando formos mexer com interrupcoes
E_FIM:	csrrw t0, 65, zero	# le o valor de EPC salvo no registrador uepc (reg 65)
	addi t0, t0, 4		# soma 4 para obter a instru��o seguinte ao ecall
	csrrw zero, 65, t0	# coloca no registrador uepc
	uret			# retorna PC=uepc
