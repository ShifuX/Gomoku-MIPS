.data
board: .space 361
buffer: .space 1
blank_piece: .ascii "."
star_piece: .ascii "*"
circle_piece: .ascii "O"
board_letters: .asciiz "   A B C D E F G H J K L M N O P Q R S T"
space: .asciiz " "
nl: .asciiz "\n"
test_col: .asciiz "Enter Col: "
test_row: .asciiz "Enter Row: "
sub_counter: .word 18
board_num: .word 1
row: .word 0
col: .word 0
AI_row: .word 0
AI_col: .word 0
dist: .word 0

.text
main:
	addi $t0, $zero, 0
	addi $t1, $zero, 360	# Space of array
	lb $t2, blank_piece
	jal fill_board
	jal call_display
	
	jal user_input	# Calls funciton to get user input
	
	li $v0, 10
	syscall
	
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

fill_board:	# Fills the board with a loop
	bgt $t0, $t1, exit_fill
	sb $t2, board($t0)
	addi, $t0, $t0, 1
	j fill_board
		
exit_fill:
	addi $t0, $zero, 0
	addi $t2, $zero, 0
	jr $ra	

call_display:	# Begins the call to display the board with the necessary value in $t8 
	addi $t8, $zero, 0
	addi $t8, $zero, 1
	
	li $v0, 4	# Displays the letters at the top of the board
	la $a0, board_letters
	syscall
	
	j display_board
	display_return:
	jr $ra

display_board:	# Displays the board through a loop
	beq $t0, 361, exit_board
	
	lb $t2, board($t0)
	addi $t3, $zero, 19
	div $t0, $t3	# $t0 % 19
	mfhi $t4	# Gets the remainder
	
	beq $t4, 0, add_nl
	nl_return:
	
	li $v0, 11
	move $a0, $t2
	syscall
	
	li $v0, 11
	lb $a0, space
	syscall
	
	addi, $t0, $t0, 1
	j display_board
	
exit_board:
	lw $t5, sub_counter
	sub $t6, $t0, $t5
	addi $t5, $zero, 0
	addi $t5, $zero, 18
	sw $t5, sub_counter
	
	li $v0, 11
	lb $a0, space
	syscall
	
	li $v0, 1
	la $a0, ($t6)
	syscall
	
	li $v0, 4
	la $a0, nl
	syscall
	
	li $v0, 4	# Displays the letters at the bottom of the board
	la $a0, board_letters
	syscall
	
	li $v0, 4
	la $a0, nl
	syscall

	addi $t0, $zero, 0	# Resetting registers & labels
	addi $t2, $zero, 0
	addi $t3, $zero, 0
	addi $t4, $zero, 0
	addi $t5, $zero, 0
	addi $t6, $zero, 0
	addi $t0, $zero, 18
	sw $t0, sub_counter
	addi $t0, $zero, 0
	addi $t0, $zero, 1
	sw $t0, board_num
	addi $t0, $zero, 0
	
	j display_return
			
add_nl:	# Adds a new line to create a row
	bgtz $t0, add_num_to_board2
	add2_return:
	lw $t5, board_num

	li $v0, 4
	la $a0, nl
	syscall
	
	li $v0, 1
	la $a0, ($t5)
	syscall
	
	li $v0, 11
	lb $a0, space
	syscall
	
	ble $t5, 9, extra_space
	extra_space_return:
	
	addi $t5, $zero, 0
	addi $t8, $t8, 18	# Increment counter
	j nl_return

add_num_to_board2: # Displays the number on the right side of the board
	lw $t5, sub_counter	# ($t0 - ($t0 - i)) where i increments after each call
	sub $t6, $t0, $t5
	addi $t5, $t5, 18
	sw $t5, sub_counter
	
	li $v0, 11
	lb $a0, space
	syscall
	
	li $v0, 1
	la $a0, ($t6)
	syscall
	
	addi $t6, $t6, 1
	sw $t6, board_num
	
	addi $t5, $zero, 0	# Reset registers
	addi $t6, $zero, 0
	j add2_return

extra_space:
	li $v0, 11
	lb $a0, space
	syscall
	j extra_space_return

# ((row - 1) * 19) + col
calculate_place: # $a0 is row $a1 is col
	#lw $t0, row		# $t0 has row value
	#lw $t2, col		# $t2 has value of col
	sub $t1, $a0, 1		#(row - 1)
	mul $t1, $t1, 19	# $t1 * 19
	add $t1, $t1, $a1	# ($t1 + col)

	sw $t1, dist	# Store result into dist
	
	addi $t0, $zero, 0	# Reset registers
	addi $t1, $zero, 0
	addi $t2, $zero, 0

	jr $ra

place_piece:
	lw $t0, dist
	lb $t1, star_piece
	sb $t1, board($t0)

	addi $t0, $zero, 0	# Reset registers
	addi $t1, $zero, 0
	addi $t2, $zero, 0

	jr $ra

letter_val:	# Uses the letter from user input and gives it a corresponding numerical val
	la $t0, board_letters
	addu $t0, $t0, 3
	addi $t3, $zero, 0
	
	find_match:	# Loops through the character array and looks for a match with user input
		lbu $t1, ($t0)
		lbu $t2, ($t8)
		beq $t1, $t2, val
		addu $t0, $t0, 2
		addi $t3, $t3, 1

		j find_match

val:	# Stores the val of the col
	sw $t3, col
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	addi $t3, $zero, 0
	addi $t8, $zero, 0

	jr $ra


############# AI Code
generate_col_and_row:
	li $v0, 42 #Generate random int
	li $a1, 19 #Set upper bound
	syscall
	sw $a0, AI_col #Store random num
	
	li $v0, 42 #Generate random int
	li $a1, 19 #Set upper bound
	syscall
	sw $a0, AI_row #Store random num
	
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
