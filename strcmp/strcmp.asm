# Trovare tra le quattro stringhe ricevute in ingresso la prima e l'ultima in ordine alfabetico

### DATA ###
.data
	str1: .asciiz "dammi la stringa n."
	str2: .asciiz ": "
	str3: .asciiz "first string: "
	str4: .asciiz "last string: "
### TEXT ###
.text
### GLOBL ###
.globl main
### MAIN ###
main:
	addi $sp, $sp, -100	# alloco spazio sullo stake
	move $t1, $sp		# puntatore alla prima stringa	
	li $t0, 1

loop:
	beq $t0, 5, exit_loop

	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 4
	la $a0, str2
	syscall

	li $v0, 8
	move $a0, $t1
	li $a1, 25
	syscall

	addi $t0, $t0, 1
	addi $t1, $t1, 25	# puntatore alla prossima stringa

	j loop

exit_loop:
	move $a0, $sp
	jal first_string

	move $a0, $sp
	jal last_string

	li $v0, 10
	syscall




### STRCMP ###

strcmp:
	lb $t0, ($a0)
	lb $t1, ($a1)
	sub $t2, $t0, $t1
	bne $t2, 0, return 
	beq $t0, 0, return	# se $t0, $t1 sono uguali e sono entrambi lo 0 terminatore
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	j strcmp

return:
	move $v0, $t2
	jr $ra



### FIRST_STRING ###

first_string:
	addi $sp, $sp, -16	# salvataggio dei parametri
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	li $s2, 0
	move $s1, $a0		# $s1 stringa più piccola
	addi $s0, $a0, 25	# $s0 stringa da consfrontare
	
loop_first_string:
	beq $s2, 3, exit_loop_first	
	
	move $a0, $s1
	move $a1, $s0
	jal strcmp
	
	bgt $v0, 0, swap_first
	
	addi $s0, $s0, 25	# salto alla prossima stringa da confrontare 
	addiu $s2, $s2, 1
	j loop_first_string

exit_loop_first:
	li $v0, 4
	la $a0, str3
	syscall
	
	li $v0, 4
	move $a0, $s1
	syscall
	

	lw $ra, ($sp)	# ripristino dei registri
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addi $sp, $sp, 16
	
	jr $ra
	
swap_first:
	move $s1, $s0
	addi $s0, $s0, 25
	addiu $s2, $s2, 1
	j loop_first_string
	
	
	
### LAST_STRING ###
# come la last_string cambia solo lo swap che si esegue se il risultato della strcmp è minore di zero
last_string:
	addi $sp, $sp, -16
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	li $s2, 0
	move $s1, $a0		# $s1 stringa più grande
	addi $s0, $a0, 25	# $s0 stringa da consfrontare
	
loop_last_string:
	beq $s2, 3, exit_loop_last	
	
	move $a0, $s1
	move $a1, $s0
	jal strcmp
	
	blt $v0, 0, swap_last
	
	addi $s0, $s0, 25
	addiu $s2, $s2, 1
	j loop_last_string

exit_loop_last:
	li $v0, 4
	la $a0, str4
	syscall
	
	li $v0, 4
	move $a0, $s1
	syscall
	

	lw $ra, ($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addi $sp, $sp, 16
	
	jr $ra
	
swap_last:
	move $s1, $s0
	addi $s0, $s0, 25
	addiu $s2, $s2, 1
	j loop_last_string
	




