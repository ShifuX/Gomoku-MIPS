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