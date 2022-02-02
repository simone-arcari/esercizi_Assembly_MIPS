.data 
dato: .word 12

.text

.globl main
#n registro a0
fib:
                addi    $sp, $sp, -16   # per salvare 4 registri nello stack
                sw      $ra, 12($sp)    # push di $ra nello stack
                sw      $s0, 8($sp)     # push di $s0 nello stack
                sw      $s1, 4($sp)     # push di $s1 nello stack
                sw      $s2, 0($sp)     # push di $s2 nello stack
        
                bne	$a0, $0, Else1  # se n!=0 vai a Else1

                add     $v0, $0, $0     # $v0 = 0
                j       Exit

        Else1:  addi    $t0, $0, 1      # imposto t0=1 
                bne     $a0, $t0, Else2 # se n1!=1 vai a Else2
                
                addi    $v0, $0, 1      # $v0 = 1
                j       Exit	
                
        Else2:  add	$s0, $a0, $0    # copiamo in $s0 il valore di $a0
                
                addi    $a0, $s0, -1    # a0 = n-1
                jal     fib             # chiama fib
                add     $s1, $v0, $0    # $t0 = fib(n-1)

                addi    $a0, $s0, -2    # a0 = n-2
                jal     fib             # chiama fib
                add     $s2, $v0, $0    # $t1 = fib(n-2)

                add     $v0, $s1, $s2   # $v0 = fib(n-1) + fib(n-2)
        
        Exit:   lw      $s2, 0($sp)     # pop di %s2 dallo stack
                lw      $s1, 4($sp)     # pop di %s1 dallo stack
                lw      $s0, 8($sp)     # pop di %s0 dallo stack
                lw      $ra, 12($sp)    # pop di $ra dallo stack
                addi    $sp, $sp, 16    # dealloco lo stack 
                
                jr      $ra             # indirizzo di chi ha chiamato la funzione


main:           
                addi    $sp, $sp, -4    # per salvare un registro nello stack
                sw      $ra, 0($sp)     # push di $ra nello stack 

                la      $t0, dato       # $t0 = &dato
                lw      $a0, 0($t0)     # $a0 = dato =  12

                jal     fib             # chiama fib

                add     $a0, $v0, $0    # $a0 = fib(n)
                addi    $v0, $0, 1      # carica codice syscall print_int
                syscall                 # printf("%d", fib(n))


                lw      $ra, 0($sp)     # pop di $ra dallo stack
                addi    $sp, $sp, 4     # dealloco lo stack 
                j       $ra             # return
