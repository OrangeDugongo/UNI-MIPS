		### DATA ###
.data
	str1: .asciiz "dammi un numero (-2^31<= x <2^31): "
	str2: .asciiz "il numero di 1 nella rappresentazione binaria è: "

		### TEXT ###
.text

		### GLOBL ###
.globl main

		### MAIN ###
main:
	addi $sp, $sp, -4	#faccio spazio sullo stake

	li $v0, 4	#stampa richiesta input
	la $a0, str1
	syscall

	li $v0, 5	#lettura input
	syscall
	
	sw $v0, ($sp)	#salvataggio dell'intero

	move $a0, $sp	#passaggio dei parametri
	jal count_ones

	move $t0, $v0	

	li $v0, 4	#stampa output
	la $a0, str2
	syscall

	li $v0, 1	#stampa output
	move $a0, $t0
	syscall

	li $v0, 10	#exit
	syscall


		### COUNT_ONES ###
count_ones:
	li $v0, 0	#imposto a zero il contatore
	lw $t0, ($sp)	#carico in t0 l'intero
	abs $t0, $t0	#valore assoluto del numero

loop_count:
	beq $t0, 0, exit_count
	andi $t1, $t0, 1	#isolo l'ultima cifra del numero in binario
	beq $t1, 1, count	#se l'ultima cifra è un 1 aumento il contatore
	srl $t0, $t0, 1		#elimino l'ultima cifra spostando tutte le cifre di una posizione a destra 
	j loop_count

exit_count:
	jr $ra


count:
	addi $v0, $v0, 1	#incremento il contatore
	srl $t0, $t0, 1		#elimino l'ultima cifra spostando tutte le cifre di una posizione a destra 
	j loop_count
