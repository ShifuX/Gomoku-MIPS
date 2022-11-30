.text
.globl letter_val
.globl val
.globl letter_val2
.globl val2

letter_val:	# Uses the letter from user input and gives it a corresponding numerical val
	la $t0, board_letters
	addu $t0, $t0, 3
	addi $t3, $zero, 0
	
	find_match:	# Loops through the character array and looks for a match with user input
		lbu $t1, ($t0)
		lbu $t2, ($t8)
		beq $t1, $t2, val
		beq $t3, 20, not_found	# This will branch if the user inputs an invalid letter (letter not found)
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

not_found:
	li $v0, 4
	la $a0, invalid_letter_mssg
	syscall

	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	addi $t3, $zero, 0
	addi $t8, $zero, 0
	
	j returnOne


########## When user goes 2nd ###################################

letter_val2:	# Uses the letter from user input and gives it a corresponding numerical val
	la $t0, board_letters
	addu $t0, $t0, 3
	addi $t3, $zero, 0
	
	find_match2:	# Loops through the character array and looks for a match with user input
		lbu $t1, ($t0)
		lbu $t2, ($t8)
		beq $t1, $t2, val2
		beq $t3, 20, not_found2	# This will branch if the user inputs an invalid letter (letter not found)
		addu $t0, $t0, 2
		addi $t3, $t3, 1

		j find_match2

val2:	# Stores the val of the col
	sw $t3, col
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	addi $t3, $zero, 0
	addi $t8, $zero, 0

	jr $ra

not_found2:
	li $v0, 4
	la $a0, invalid_letter_mssg
	syscall

	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	addi $t3, $zero, 0
	addi $t8, $zero, 0
	
	j returnTwo