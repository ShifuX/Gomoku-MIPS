.text
.globl user_input

user_input:	# Gets the placement from the user and calls necessary functions to place the piece
	move $t9, $ra
	li $v0, 4
	la $a0, test_col
	syscall

	li $v0, 8       # take in input
    la $a0, buffer  # load byte space into address
    li $a1, 2     # allot the byte space for string
    move $t8, $a0   # save string to t9
    syscall

	jal letter_val
	
	li $v0, 4
	la $a0, nl
	syscall

	li $v0, 4
	la $a0, test_row
	syscall

	li $v0, 5
	syscall
	sw $v0, row

	lw $a0, row
	lw $a1, col

	jal calculate_place #$a0 is row $a1 is col
	jal place_piece
	jal generate_col_and_row
	jal place_AI_piece
	jal call_display
	
	move $ra, $t9
	addi $t9, $zero, 0

	jr $ra
