# Assumendo che l’indirizzo base di A (B) sia in $s3 ($s4), e che la 
# dimensione dell’array A sia memorizzata in $s5, scrivere in 
# assembler le due seguenti porzioni di codice C:

# Sommare tutti gli elementi di un array A di 100 interi che siano in 
# posizione pari

# $s3 = &A[0]
# $s5 = dim di A (100)
# $s0 = sum
# $s1 = i




		add $s0, $zero, $zero		# sum = 0;
		add $s1, $zero, $zero		# i = 0;

Start_for:	slt $t0, $s1, $s5		# $t0=0 se i>=100
		beq $t0, $zero, Exit		# if($t0==0) goto Exit
		
		sll $t0, $s1, 2			# $t0 = i*4
		add $t0, $s3, $t0		# $t0 = &A[i]			
		lw $t0, 0($t0)			# $t0 = A[i]
		
		add $s0, $s0, $t0		# sum = sum + A[i]
		
		addi $s1, $s1, 2		# i+=2
		j Start_for			# goto Start_if

Exit:		...
