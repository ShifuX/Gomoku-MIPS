.text
.globl letter_val
.globl val

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
