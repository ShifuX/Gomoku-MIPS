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
invalidMsg: .asciiz "Illegal Move\n"
colorInputMsg: .asciiz "Black or White? (Enter B or W): "
userColor: .space 2

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

main:
	addi $t0, $zero, 0
	addi $t1, $zero, 360	# Space of array
	lb $t2, blank_piece
	jal fill_board
	jal call_display
	
	jal color_input # Calls function to get color of user
	jal user_input	# Calls funciton to get user input
	jal user_input	# Calls funciton to get user input
	
	li $v0, 10
	syscall
	
