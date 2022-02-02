.data
n: .word 8      # int n = 8;

.text
.globl main

fib: 
        addi $sp, $sp, -12
        sw $ra, 8($sp)
        sw $s1, 4($sp)          # s1 = ris
        sw $s0, 0($sp)
        
        add $s0, $0, $a0        # s0 = a0 = n
        add $s1, $0, $0         # Inizializzo ris
        
        slti $t0, $s0, 2        
        beq $t0, $0, else       # if n>=2
        
        slti $t0, $s0, 1        # If n >= 1
        beq $t0, $0, else2
        
        add $v0, $0, $0
        
        j exit
else:
        addi $a0, $s0, -1
        jal fib
        add $s1, $v0, $0
        
        addi $a0, $s0, -2
        jal fib
        add $v0, $v0, $s1

        j exit
else2: 
        addi $v0, $0, 1
        j exit
exit:
        lw $s0, 0($sp)
        lw $s1, 4($sp)
        lw $ra, 8($sp)
        addi $sp, $sp, 12
        
        jr $ra

main:
        addi $sp, $sp, -4
        sw $ra, 0($sp)
        
        
        la $a0, n       # $a0 = &n
        lw $a0, 0($a0)
        jal fib

        add $t0, $v0, $0        # $t0 = fib(n)
        
        
        lw $ra, 0($sp)
        addi $sp, $sp, 4
        
        jr $ra
