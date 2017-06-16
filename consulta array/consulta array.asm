### riempi e consulta array ###
### DATA ###
.data
	arr: .space 400
	str1: .asciiz "array riempito correttamente"
	str2: .asciiz "\nche componente dell'array vuoi leggere(-100 per terminare): "
	str3: .asciiz "\nindice out-of-bounds"
	str4: .asciiz "\nla componente vale: "
### TEXT ###
.text
### GLOBL ###
.globl main
### MAIN ###
main:
	la $a0, arr
	jal riempi_array
	
	li $v0, 4
	la $a0, str1
	syscall

loop:
	li $v0, 4
	la $a0, str2
	syscall
	
	li $v0, 5
	syscall
	
	beq $v0, -100, exit
	
	la $a0, arr
	move $a1, $v0
	jal consulta_array
	
	beq $v1, 0, print_risultato
	
	li $v0, 4	# Se l'indice non è ammisibile
	la $a0, str3
	syscall
	
	j loop
	
exit:
	li $v0, 10
	syscall
	



print_risultato:	# se l'indice è ammisibile
	move $t0, $v0
	
	li $v0, 4
	la $a0, str4
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	j loop
	
	
### RIEMPI_ARRAY ###
# inserisce nella posizione i il valore i*2+3 #
riempi_array:
	li $t0, 0
loop_riempi:
	beq $t0, 100, exit_loop_riempi
	sll $t1, $t0, 1
	addiu $t1, $t1, 3
	sw $t1, ($a0)
	addiu $t0, $t0, 1
	addiu $a0, $a0, 4
	j loop_riempi
	
exit_loop_riempi:
	jr $ra
	

### CONSULTA_ARRAY ###
consulta_array:
	blt $a1, 0, exit_1
	bgt $a1, 99, exit_1
	sll $a1, $a1, 2
	add $a0, $a0, $a1
	lw $v0, ($a0)
	li $v1, 0
	jr $ra
	
exit_1:
	li $v1, 1
	jr $ra