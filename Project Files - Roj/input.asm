.text
.globl user_input
.globl returnOne
.globl returnTwo
.globl returnRowOne
.globl returnRowTwo

user_input:	# Gets the placement from the user and calls necessary functions to place the piece
	move $t9, $ra
	beq $s1, 'W', userSecond # check color of user - saved in s1 from color input
	
returnOne: # Jump label if user input is invalid

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

returnRowOne: # Jump label if row input was invalid

	li $v0, 4
	la $a0, test_row
	syscall

	li $v0, 5
	syscall
	sw $v0, row
	
	ble $v0, 0, invalidRow
	bge $v0, 20, invalidRow

	lw $a0, row
	lw $a1, col
	
	jal calculate_place #$a0 is row $a1 is col
	lb $t4, star_piece # user is black
	jal place_piece
	
	jal generate_col_and_row
	lb $t4, circle_piece # AI is white
	jal place_AI_piece
	#move $ra, $t9
	j Endif

	
userSecond: # AI goes first, user goes second if user is white

	jal generate_col_and_row
	lb $t4, star_piece # AI is black
	jal place_AI_piece
	
returnTwo: # Jump label if user input is invalid
		
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

returnRowTwo: #Jump label if row input was invalid

	li $v0, 4
	la $a0, test_row
	syscall

	li $v0, 5
	syscall
	sw $v0, row
	
	ble $v0, 0, invalidRow
	bge $v0, 20, invalidRow

	lw $a0, row
	lw $a1, col
	
	jal calculate_place #$a0 is row $a1 is col
	lb $t4, circle_piece # user is white
	jal place_piece
	j Endif 

Endif:
	jal call_display
	move $ra, $t9
	addi $t9, $zero, 0
	jr $ra
	
invalidRow: # loop back to column input

	li $v0, 4
	la $a0, invalid_row_msg
	syscall
	
	beq $s1, 'W', returnRowTwo # Returns to user input
	j returnRowOne # Returns to user input

	
