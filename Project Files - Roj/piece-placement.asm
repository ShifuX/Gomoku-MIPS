.text
.globl calculate_place
.globl place_piece

# ((row - 1) * 19) + col
calculate_place: # $a0 is row $a1 is col
	#lw $t0, row		# $t0 has row value
	#lw $t2, col		# $t2 has value of col
	sub $t2, $a0, 1		#(row - 1)
	mul $t2, $t2, 19	# $t1 * 19
	add $t2, $t2, $a1	# ($t1 + col)

	sw $t2, dist	# Store result into dist
	
	#addi $t0, $zero, 0	# Reset registers
	#addi $t1, $zero, 0
	addi $t2, $zero, 0

	jr $ra

place_piece:
	lw $t0, dist
	lb $t3, board($t0) 

	bne $t3, '.', invalid # check if space is empty - (check validity of move) FIXME: AI placement occurs twice, causing validity check to branch to invalid.

	sb $t1, board($t0) # stores star or circle depending on color (stored before place_piece is called)
	j clear

clear:
	addi $t0, $zero, 0	# Reset registers
	#addi $t1, $zero, 0
	addi $t2, $zero, 0
	addi $t3, $zero, 0

	jr $ra
	
invalid: # outputs message if move is illegal

	li $v0, 4 
	la $a0, invalidMsg
	syscall

	addi $t0, $zero, 0	# Reset registers
	#addi $t1, $zero, 0
	addi $t2, $zero, 0
	addi $t3, $zero, 0

	jr $ra
