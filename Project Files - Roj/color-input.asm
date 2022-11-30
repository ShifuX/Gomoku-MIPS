
.text
.globl color_input

color_input: # gets color from user
	
	la $a0, colorInputMsg # ask user for color
	li $v0, 4
	syscall
	
	li $v0, 8 # gets user color
	la $a0, userColor
	la $a1, 2
	syscall
	
	lb $s1, ($a0) # store color in $s1 to check if user/AI moves first
	
	beq $s1, 'B', valid  # check if user inputs a valid color
	bne $s1, 'W', invalidColor
	
valid:
	la $a0, nl # new line
	li $v0, 4
	syscall

	jr $ra
	
invalidColor: # loop back to color input if input was invalid

	la $a0, invalidColorMsg
	li $v0, 4
	syscall
	
	j color_input
