### MAx e min in un array ###
### DATA ###
.data
	str1: .asciiz "dammi il valore di arr["
	str2: .asciiz "]: "
	str3: .asciiz "\nil max è: "
	str4: .asciiz "\nil min è: "
### TEXT ###
.text
### GLOBL ###
.globl main
### MAIN ###
main:
	addi $sp, $sp, -20
	
	move $a0, $sp
	jal riempi_array
	
	move $a0, $sp
	jal trova_max_min
	
	move $t0, $v0
	
	li $v0, 4	# stampa max
	la $a0, str3
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4	# stampa min
	la $a0, str4
	syscall
	
	li $v0, 1
	move $a0, $v1
	syscall
	
	li $v0, 10
	syscall
	

### RIEMPI_ARRAY ###
riempi_array:
	li $t0, 0
	move $t1, $a0
loop_riempi_array:
	beq $t0, 5, exit_riempi_array
	
	li $v0, 4	# inizio stampa richiesta I/O
	la $a0, str1
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, str2
	syscall		# fine stampa I/O
	
	li $v0, 5
	syscall
	
	sw $v0, ($t1)
	addi $t0, $t0, 1
	addi $t1, $t1, 4
	j loop_riempi_array
	
exit_riempi_array:
	jr $ra
	
	
	
### TROVA_MAX_MIN ###
trova_max_min:
	lw $v0, ($a0)	# max=arr[0]
	lw $v1, ($a0)	# min=arr[0]
	
	li $t0, 1
	addi $a0, $a0, 4
	
loop_trova_max_min:
	beq $t0, 5, exit_trova_max_min
	lw $t1, ($a0)
	bgt $t1, $v0, set_max
	blt $t1, $v1, set_min
add_trova_max_min:
	addi $a0, $a0, 4
	addi $t0, $t0, 1
	j loop_trova_max_min
	
exit_trova_max_min:
	jr $ra
	

	
set_max:
	move $v0, $t1
	j add_trova_max_min
	
set_min:
	move $v1, $t1
	j add_trova_max_min
	
	
