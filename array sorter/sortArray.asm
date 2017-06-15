# riempi e ordina un array
### DATA ###
.data
	arr: .space 40
	str1: .asciiz "vettore originale\n"
	str2: .asciiz "\nvettore ordinato\n"
### TEXT ###
.text
### GLOBL ###
.globl main
### MAIN ###
main:
	la $a0, arr
	li $a1, 10
	
	jal riempi_array
	
	# stampa array
	li $v0, 4
	la $a0, str1
	syscall
	
	la $t0, arr
	li $t1, 0
print:
	beq $t1, 10, exit
	lw $a0, ($t0)
	li $v0, 1
	syscall
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	j print
	
exit:
	la $a0, arr
	li $a1, 10
	
	jal sort_array
	
	# stampa array
	li $v0, 4
	la $a0, str2
	syscall
	
	la $t0, arr
	li $t1, 0
print2:	
	beq $t1, 10, exit2
	lw $a0, ($t0)
	li $v0, 1
	syscall
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	j print2

exit2:
	li $v0, 10
	syscall
	
### riempi_array ###
riempi_array:
	li $t0, 0
inserisci:
	beq $t0, $a1, exit3
	andi $t1, $t0, 1	#controllo pari dispari
	beq $t1, 1, dispari
	sw $t0, ($a0)	# se è pari
	j incrementa
dispari:
	subu $t2, $a1, $t0
	sw $t2, ($a0)
incrementa:
	addiu $t0, $t0, 1
	addiu $a0, $a0, 4
	j inserisci
	
exit3:
	jr $ra

### sort_array ###
sort_array:
loop_esterno:
	beq $a1, 0, exit_loop_esterno
	li $t0, 0
	la $t1, ($a0)
	
loop_interno:
	beq $t0, $a1, exit_loop_interno
	lw $t2, ($t1)
	addi $t1, $t1, 4
	lw $t3, ($t1)
	bgt $t2, $t3, swap
exit_swap:
	addi $t0, $t0, 1
	j loop_interno
exit_loop_interno:

	addi $a1, $a1, -1
	j loop_esterno
exit_loop_esterno:
	jr $ra
	
swap:
	sw $t2, ($t1)
	addi $t4, $t1, -4
	sw $t3, ($t4)
	j exit_swap

