# Trovare Max e min

### DATA ###
.data
	str1: .asciiz "Inserisci tre numeri interi: "
	strmax: .asciiz "\nIl max è: "
	strmin: .asciiz "Il min è: "
### TEXT ###
.text
### GLOBL ###
.globl main

### MAIN ###

main: 
	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0 5
	syscall
	
	move $s0, $v0
	
	li $v0 5
	syscall
	
	move $s1, $v0
	
	li $v0 5
	syscall
	
	move $s2, $v0
	
	move $a0, $s0	# copia dei parametri e chiamata della funzione trova_min
	move $a1, $s1
	move $a2, $s2
	
	jal trova_min
	
	move $t0, $v0	# Stampa valore min
	li $v0, 4	
	la $a0, strmin
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	move $a0, $s0	# copia dei parametri e chiamata della funzione trova_max
	move $a1, $s1
	move $a2, $s2
	
	jal trova_max
	
	move $t0, $v0	# Stampa valore max
	li $v0, 4	
	la $a0, strmax
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 10
	syscall
	
	
#### trova_min ###
trova_min:
	move $v0, $a0
	blt $a1, $v0, setmin
secondo_confronto_min:
	blt $a2, $v0, setmin2
return_min:
	jr $ra
setmin:
	move $v0, $a1
	j secondo_confronto_min
setmin2: 
	move $v0, $a2
	j return_min
	
	

### trova_max ###
#### trova_min ###
trova_max:
	move $v0, $a0
	bgt $a1, $v0, setmax
secondo_confronto_max:
	bgt $a2, $v0, setmax2
return_max:
	jr $ra
setmax:
	move $v0, $a1
	j secondo_confronto_max
setmax2: 
	move $v0, $a2
	j return_max
	