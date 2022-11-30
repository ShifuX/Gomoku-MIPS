.text
.globl calculate_place
.globl place_piece

# ((row - 1) * 19) + col
calculate_place: # $a0 is row $a1 is col
	#lw $t0, row		# $t0 has row value
	#lw $t2, col		# $t2 has value of col
	sub $t1, $a0, 1		#(row - 1)
	mul $t1, $t1, 19	# $t1 * 19
	add $t1, $t1, $a1	# ($t1 + col)

	sw $t1, dist	# Store result into dist
	
	# Reset registers
	addi $t1, $zero, 0

	jr $ra

place_piece:
	lw $t0, dist
	lb $t3, board($t0) 
	
	bne $t3, '.', invalid # check if space is empty - (check validity of move) FIXME: AI placement occurs twice, causing validity check to branch to invalid.

	sb $t4, board($t0) # stores star or circle depending on color (stored before place_piece is called)
	j check_for_win

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

	#branch if its the AIs turn or the user turn
	#beq

	beq $s1, 'W', returnTwo # Returns to user input
	j returnOne # Returns to user input
	


#Everytime a piece is placed check up down left right and diagonal for a row of 5	TODO: add left checking and diagonal checking
check_for_win:
	move $s7, $ra
	addi $t1, $zero, 1
	addi $t6, $zero, 5
	addi $t7, $zero, 0
	lw $t5, dist
	NLoop:
		addi $t1, $t1, 1
		subi $t5, $t5, 19 #Go up 1 roq
		bgt $t5, 361, SLoop
		slt $t2, $t5, $zero
		beq $t2, 1, SLoop
		lb $t3, board($t5)
		bne $t3, $t4, SLoop # if current piece != user piece

		beq $t1, $t6, Win # if its looped 4 times
		

		j NLoop
		
	SLoop:
		lw $t5, dist #Reset required registers
		addi $t1, $zero, 1
	
		addi $t1, $t1, 1
		addi $t5, $t0, 19 #Go up 1 roq
		bgt $t5, 361, ELoop
		slt $t2, $t5, $zero
		beq $t2, 1, SLoop
		lb $t3, board($t5)
		bne $t3, $t4, ELoop # if current piece != user piece

		beq $t1, $t6, Win # if its looped 4 times
		
		j SLoop
		
	ELoop:
		lw $t5, dist #Reset required registers
		addi $t1, $zero, 1
		
		addi $t1, $t1, 1
		addi $t5, $t0, 1 #Go right in the row
	
		lb $t3, board($t5)
		bne $t3, $t4, WLoop # if current piece != user piece

		beq $t1, $t6, Win # if its looped 4 times

		j ELoop
		
	WLoop:
		lw $t5, dist #Reset required registers
		addi $t1, $zero, 1
	
	
		j Exit
	Win:
		addi $t7, $zero, 1
		sw $t7, winBit

	Exit:
		addi $t0, $zero, 0	# Reset registers
		#addi $t1, $zero, 0
		addi $t2, $zero, 0
		addi $t3, $zero, 0
		addi $t4, $zero, 0
		addi $t5, $zero, 0
		addi $t6, $zero, 0
		addi $t7, $zero, 0
		addi $t8, $zero, 0
		move $ra, $s7
		addi $s7, $zero, 0
		jr $ra
