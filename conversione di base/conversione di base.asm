# Il programma converte e stampa un carattere ascii in decimale, binario e esadecimale
### DATA ###
.data
	char: .space 2
	out: .space 9
	str1: .asciiz "Inserisci un carattere: "
	strd: .asciiz "\nIl carattere in decimale è: "
	strb: .asciiz "\nIl carattere in binario è: "
	strh: .asciiz "\nIl carattere in esadecimale è: "
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
	la $a0, char
	li $a1, 3	# un carattere in più altrimenti si da invio da solo
	syscall

	lbu $s1, char	# prelevo il carattere dalla stringa
	
	
	li $v0, 4
	la $a0, strd
	syscall
	
	move $a0, $s1
	jal print_decimal

	li $v0, 4
	la $a0, strb
	syscall
	
	move $a0, $s1
	jal print_binary

	li $v0, 4
	la $a0, strh
	syscall
	
	move $a0, $s1
	jal print_hex

	li $v0, 10
	syscall


### PRINT_DECIMAL ###
print_decimal:
	li $v0, 1
	syscall

	jr $ra



### PRINT_BINARY ###
print_binary:
	la $t2, out
	li $t0, 128
loop_binary:
	beq $t0, 0, exit_loop_binary
	and $t1, $a0, $t0	# isolo il bit di interesse
	beq $t1, 0, put_zero
	li $t1, 49	# 49 valore ascii del carattere 1
	sb $t1, ($t2)
	addi $t2, $t2, 1
	srl $t0, $t0, 1
	j loop_binary

exit_loop_binary:
	sb $zero, ($t2)	# inserimento dello 0 terminatore
	li $v0, 4
	la $a0, out
	syscall

	jr $ra

put_zero:
	addi, $t1, $t1, 48	# 48 valore ascii del carattere 0
	sb $t1, ($t2)
	addi $t2, $t2, 1
	srl $t0, $t0, 1
	j loop_binary


### PRINT_HEX ###
print_hex:
	la $t0, out
	li $t1, 240	# maschera di bit. 11110000
	and $t2, $a0, $t1
	srl $t2, $t2, 4	# porto il gruppo di 4 bit nelle posizioni meno significative
	bgt $t2, 9, print_char
	addi $t2, $t2, 48	# n + 48 = carattere ascii di n
store_1:
	sb $t2, ($t0)
	srl $t1, $t1, 4	# maschera di bit. 00001111
	and $t2, $a0, $t1
	bgt $t2, 9, print_char
	addi $t2, $t2, 48
store_2:
	sb $t2, 1($t0)
	sb $zero, 2($t0)	# inserisco lo 0 terminatore
	
	li $v0, 4
	la $a0, out
	syscall
	
	jr $ra
	
print_char:
	addi $t2, $t2, 55	# n + 55 = carattere ascii delle cifre extradecimali. 55 per le lettere minuscole, 87 per le maiuscole
	beq $t1, 240, store_1	# il branch serve per capire se va inserita la prima o la seconda cifra
	j store_2
	

