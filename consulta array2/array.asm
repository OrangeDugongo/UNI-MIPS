### DATA ###
.data 
	arr: .space 80
	str1: .asciiz "array riempito"
	str2: .asciiz "\ninserischi il valore di i(0-19, -1 per terinare): "
	str3: .asciiz "l'elemento richiesto vale: "
### TEXT ###
.text
### GLOBL ###
.globl main
### MAIN ###
main:
	la $a0, arr
	jal array_init

	li $v0, 4
	la $a0, str1
	syscall

loop:
	li $v0, 4
	la $a0, str2
	syscall

	li $v0, 5
	syscall

	beq $v0, -1, exit

	la $a0, arr
	move $a1, $v0
	jal array_element

	move $s0, $v0
	
	li $v0, 4
	la $a0, str3
	syscall

	li $v0, 1
	move $a0, $s0
	syscall

	j loop

exit:
	li $v0, 10
	syscall


### ARRAY_INIT ###
array_init:
	li $t0, 0

loop_array_init:
	beq $t0, 20, exit_array_init
	sll $t1, $t0, 2		# i*4
	sll $t2, $t0, 1		# i*2
	add $t1, $t1, $t2	# i*4+i*2
	addi $t1, $t1, 1	# i*4+i*2+1
	sw $t1, ($a0)
	addi $t0, $t0, 1
	addi $a0, $a0, 4
	j loop_array_init

exit_array_init:
	jr $ra


### ARRAY_ELEMENT ###
array_element:
	sll $a1, $a1, 2
	add $a1, $a1, $a0
	lw $v0, ($a1)
	jr $ra
