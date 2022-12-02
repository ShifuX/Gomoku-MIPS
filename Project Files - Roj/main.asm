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
invalidMsg: .asciiz "Illegal Move. Another piece already occupies that space.\n"
colorInputMsg: .asciiz "Black or White? (Enter B or W): "
userColor: .space 2
winBit: .word 0
aiTurnBit: .word 0
winMsg: .asciiz "You win!"
aiWinMsg: .asciiz "The computer wins..."
invalidColorMsg: .asciiz "\nInvalid color. Try again.\n"
invalid_letter_mssg: .asciiz "\n Not a valid column, pick a column displayed on the board \n"

.text

.globl main
.globl board
.globl board_letters
.globl space
.globl sub_counter
.globl nl
.globl board_num
.globl dist
.globl star_piece
.globl circle_piece
.globl blank_piece
.globl AI_col
.globl AI_row
.globl col
.globl row
.globl test_col
.globl test_row
.globl buffer
.globl invalidMsg
.globl colorInputMsg
.globl userColor
.globl winBit
.globl invalidColorMsg
.globl aiTurnBit
.globl invalid_letter_mssg

main:
	addi $t0, $zero, 0
	addi $t1, $zero, 360	# Space of array
	lb $t2, blank_piece
	jal fill_board
	jal call_display
	
	jal color_input # Calls function to get color of user


	main_loop:
		lw $t0, winBit
		beq $t0, 1, exit 
		jal user_input	# Calls funciton to get user input
	 	j main_loop
		
	
exit:
	
	li $v0, 4
	la $a0, winMsg
	syscall
	
	li $v0, 10
	syscall
