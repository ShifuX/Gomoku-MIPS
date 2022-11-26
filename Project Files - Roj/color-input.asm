
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
	
	lb $s1, ($a0) # check which color user inputs
	
	la $a0, nl # ask user for color
	li $v0, 4
	syscall
	
	#lb $s1, ($a0) # check which color user inputs
	#sb $s1, userColor # store user color - check for black/white when deciding user/AI color
			  # color decides if user or AI goes first (black goes first)
	jr $ra
