### DATA ###
.data
	str1: .asciiz "inserisci un numero: "
	str2: .asciiz "la somma delle cifre è: "
## TEXT ###
.text
### GLOBL ###
.globl main
### MAIN ###
main:
	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0, 5
	syscall
	
	move $a0, $v0
	
	jal somma_cifre
	move $t0, $v0
	
	li $v0, 4
	la $a0, str2
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 10
	syscall
	

### SOMMA_CIFRE ###
somma_cifre:
	li $t1, 10
	li $v0, 0
loop:
	beq $a0, 0, exit_somma_cifre
	div $a0, $t1
	mflo $a0	# il numero inserito diviso 10
	mfhi $t0	# resto della diisione
	add $v0, $v0, $t0
	j loop
	
exit_somma_cifre:
	jr $ra
	