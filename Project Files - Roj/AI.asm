.text
.globl generate_col_and_row
.globl place_AI_piece

############# AI Code
generate_col_and_row:
	li $v0, 42 #Generate random int
	li $a1, 19 #Set upper bound
	syscall
	addi $a0, $a0, 3
	sw $a0, AI_col #Store random num
	
	li $v0, 42 #Generate random int
	li $a1, 19 #Set upper bound
	syscall
	sw $a0, AI_row #Store random num
	
	jr $ra
	
place_AI_piece:
	move $t6, $ra
	lw $a0, AI_row
	lw $a1, AI_col

	jal calculate_place
	jal place_piece
	move $ra, $t6
	addi $t6, $zero, 0
	jr $ra

#############
