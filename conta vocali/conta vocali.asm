# Conta vocali
### DATA ###
.data 
	strin: .space 41
	str1: .asciiz "inserisci la stringa: "
	str2: .asciiz "le vocali sono: "
### TEXT ###
.text
### GLOBL ###
.globl main
### MAIN ###
main:
	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0, 8
	la $a0, strin
	li $a1, 41
	syscall
	 
	la $a0, strin
	jal conta_vocali
	 
	move $s0, $v0
	 
	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	li $v0, 10
	syscall
	
	
	
### CONTA_VOCALI ###
conta_vocali:
	li $v0, 0
loop:
	lb $t0, ($a0)
	beq $t0, 0, exit
	ori $t0, $t0, 32	# controlla maiuscole e minuscole
	beq $t0, 'a', add1
	beq $t0, 'e', add1
	beq $t0, 'i', add1
	beq $t0, 'o', add1
	beq $t0, 'u', add1
	addi $a0, $a0, 1
	j loop
	
add1:
	addi $v0, $v0, 1
	addi $a0, $a0, 1
	j loop
	
exit:
	jr $ra
