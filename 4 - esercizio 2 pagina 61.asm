Scrivere un programma in assembler MIPS che, dato l’array di 
interi A di 100 elementi, effettua la somma solamente degli 
elementi di A minori di 10 e maggiori di 5

	sum = 0;
	for (i=0; i<100; i++)
		if ((A[i] > 5) && (A[i] < 10))
			sum = sum + A[i];


# $s0 = sum
# $s1 = i
# $s2 = &A[0]




		add $s0, $zero, $zero		# sum = 0
		add $s1, $zero, $zero		# i = 0

Start_for:	slti $t0, $s1, 100		# $t0=0 se i>=100
		beq $t0, $zero, Exit		# if($t0==0) goto Exit

		sll $t0, $s1, 2			# $t0 = i*4
		add $t0, $s2, $t0		# $t0 = &A[i]
		lw $t0, 0($t0)			# $t0 = A[i]

		addi $t1, $zero, 5		# $t1 = 5
		slti $t1, $t1, $t0		# $t1=0 se A[i]<=5
		beq $t1, $zero, Exit_if		# if($t1==0) goto Exit_if

		slti $t1, $t0, 10		# $t1=0 se A[i]>=10
		beq $t1, $zero, Exit_if		# if($t1==0) goto Exit_if

		add $s0, $s0, $t0		# sum = sum + A[i]

Exit_if:	addi $s1, $s1, i		# i++
		j Start_for			# goto Start_for

Exit:		...
