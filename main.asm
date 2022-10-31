.data
board: .space 361
blank_piece: .ascii "."
nl: .ascii "\n"
sub_counter: .word 1
sub_counter2: .word 18
test: .asciiz "INNNN"
.text
main:
	addi $t0, $zero, 0
	addi $t1, $zero, 360	# Space of array
	lb $t2, blank_piece
	jal fill_board
	addi $t8, $zero, 1
	jal display_board
	
	
	li $v0, 10
	syscall
	
fill_board:	# Fills the board with a loop
	bgt $t0, $t1, exit_fill
	sb $t2, board($t0)
	addi, $t0, $t0, 1
	j fill_board
		
exit_fill:
	addi $t0, $zero, 1
	addi $t2, $zero, 0
	jr $ra	
	
display_board:	# Displays the board through a loop
	beq $t0, 361, exit_board
	
	beq $t0, $t8, add_num_to_board
	add_num_return:
	
	lb $t2, board($t0)
	
	addi $t3, $zero, 19
	div $t0, $t3
	mfhi $t4	# Gets the remainder
	
	beq $t4, 0, add_nl
	nl_return:
	
	li $v0, 11
	move $a0, $t2
	syscall
	
	addi, $t0, $t0, 1
	j display_board
exit_board:
	lw $t5, sub_counter2
	sub $t6, $t0, $t5
	addi $t5, $zero, 0
	addi $t5, $zero, 18
	sw $t5, sub_counter2
	
	li $v0, 1
	la $a0, ($t6)
	syscall
	
	addi $t0, $zero, 0
	addi $t2, $zero, 0
	jr $ra

add_num_to_board:
	lw $t5, sub_counter
	sub $t6, $t0, $t5
	sub $t7, $t0, $t6
	addi $t5, $t5, 1
	sw $t5, sub_counter
	
	li $v0, 1
	la $a0, ($t7)
	syscall
	
	addi $t5, $zero, 0
	addi $t6, $zero, 0
	addi $t7, $zero, 0
	addi $t8, $t8, 19
	j add_num_return
			
add_nl:	# Adds a new line to create a row
	bgtz $t0, add_num_to_board2
	add2_return:
	li $v0, 4
	la $a0, nl
	syscall
	j nl_return

add_num_to_board2: # Displays the number on the right side of the board
	lw $t5, sub_counter2
	sub $t6, $t0, $t5
	addi $t5, $t5, 18
	sw $t5, sub_counter2
	
	li $v0, 1
	la $a0, ($t6)
	syscall
	
	addi $t5, $zero, 0
	addi $t6, $zero, 0
	j add2_return
	
