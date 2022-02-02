.data


.text

.globl main

main:
	addi $s0, $zero, 5
	add $s1, $s0, $s0

	jr $ra			# return 
