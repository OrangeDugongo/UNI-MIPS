# riempire un array e calcolo della media
### DATA ###
.data
	strn: .asciiz "inserisci n: "
	strm: .asciiz "inserisci m: "
	str1: .asciiz "array inizializzato.\n"
	str2: .asciiz "la media è: "
### TEXT ###
.text
### GLOBL ###
.globl main
### MAIN ###
main:
	addi $sp, $sp, -64

	li $v0, 4
	la $a0, strn
	syscall

	li $v0, 5
	syscall

	move $a1, $v0	# $a1 = n

	li $v0, 4
	la $a0, strm
	syscall

	li $v0, 5
	syscall

	move $a2, $v0	# $a2 = m

	move $a0, $sp
	jal array_init
	
	move $a0, $sp
	jal media_array
	
	li $v0, 4
	la $a0, str2
	syscall

	li $v0, 2
	syscall

	li $v0, 10
	syscall



### ARRAY_INIT ###
array_init:
	li $t0, 0
	sll $t1, $a1, 2
	add $t1, $t1, $a1	# n*5
	sll $t2, $a2, 1
	add $t2, $t2, $a2	# m*3
	add $t1, $t1, $t2	# n*5+m*3
loop_array_init:
	beq $t0, 16, exit_array_init
	add $t2, $t1, $t0	# n*5+m*3+i
	sw $t2, ($a0)
	addi $a0, $a0, 4
	addi $t0, $t0, 1
	j loop_array_init

exit_array_init:
	jr $ra
	



### MEDIA_ARRAY ###
media_array:
	li $t0, 0
	li $t2, 0
loop_media_array:
	beq $t0, 16, exit_media_array
	lw $t1, ($a0)
	addu $t2, $t2, $t1	# accumulatore
	addi $t0, $t0, 1
	addi $a0, $a0, 4
	j loop_media_array
	
exit_media_array:
	mtc1 $t2, $f0
	cvt.s.w $f2, $f0	# conversione in float
	mtc1 $t0, $f0
	cvt.s.w $f0, $f0	# conversione in float
	div.s $f12, $f2, $f0
	
	jr $ra
