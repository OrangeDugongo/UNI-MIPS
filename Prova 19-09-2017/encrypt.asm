### DATA ###
.data
	str1: .asciiz "Inserisci una stringa: "
	str2: .asciiz "Inserisci un numero tra 0 e 255: "
	str4: .asciiz "L'intero non è valido"
	str5: .asciiz "testo cifrato: "
	str3: .space 400 
	
### TEXT ###
.text

### GLOBL ###
.globl main

### MAIN ###
main:
	la $a0, str1
	li $v0, 4
	syscall
	
	la $a0, str3
	li $a1, 400
	li $v0, 8
	syscall
	
	la $a0, str2
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0
	
	blt $s0, 0, error
	bgt $s0, 255, error
	
	la $a0, str5
	li $v0, 4
	syscall
	
	la $a0, str3
	move $a1, $s0
	jal encrypt
	
	li $v0, 10
	syscall
	
error:
	la $a0, str4
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
	
	
### ENCRYPT ###
encrypt:
	move $t0, $a0
loop:
	lbu $t1, ($t0)
	beq $t1, 0, exit_encrypt
	#beq $t1, 10, exit_encrypt	# Se resta commentato cripta anche l'andata a capo finale, se lo decommenti non la cripta, il prof non l'ha criptato
	xor $t1, $t1, $a1
	sb $t1, ($t0)
	addi $t0, $t0, 1
	j loop
	
exit_encrypt:
	
	li $v0, 4
	syscall
	
	jr $ra
	