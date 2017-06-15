# to upper case
### DATA ###
.data 
	str1: .asciiz "Inserisci la stringa: "
	str2: .asciiz "Stringa finale: "
### TEXT ####
.text
### GLOBL ###
.globl main
### MAIN ####
main:
	addi $sp, $sp, -100	# spazzio per la stringa
	
	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0, 8
	la $a0, ($sp)
	li $a1, 100
	syscall
	
	la $a0, ($sp)
	jal Toupper
	
	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0, 4
	la $a0, ($sp)
	syscall
	
	li $v0, 10
	syscall
	
### Toupper ###
Toupper:
	lbu $t0, ($a0)
	beq $t0, 0, exit
	blt $t0, 97, add1
	bgt $t0, 122, add1
	addi $t0, $t0, -32
	sb $t0, ($a0)
	
add1:
	addi $a0, $a0, 1
	j Toupper

exit:
	jr $ra