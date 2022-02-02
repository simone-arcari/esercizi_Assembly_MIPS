Scrivere un programma in assembler MIPS che, dato l’array di
interi A di 100 elementi, effettua la somma solamente degli
elementi di A minori di 10

	sum = 0;
	for (i=0; i<100; i++)
		if (A[i] < 10)
			sum = sum + A[i];



# $s0 = &A[0]
# $s1 = sum
# $s2 = i

	
	
		add $s1, $zero, $zero		# sum = 0;
		add $s2, $zero, $zero		# i = 0; 
	
Start_for:	slti $t0, $s2, 100		# $t0=0 se i>=100, $t0=1 se i < 100
		beq $t0, $zero, Exit		# if(i>=100) goto Exit
		
		add $t1, $s0, $s2		# $t1 = &A[i]
		lw $t1, 0($t1)			# $t1 = A[i]
		
		slti $t0, $t1, 10		# $t0=0 se A[i]>=10, $t0=1 se A[i]<10
		beq $t0, $zero, Exit_if		# if(A[i]>=10) goto Start_for
		
		add $s1, $s1, $t1		# sum = sum + A[i]
		
Exit_if:	addi $s2, $s2, 1		# i = i+1
		j Start_for			# goto Start_for

Exit:		...
