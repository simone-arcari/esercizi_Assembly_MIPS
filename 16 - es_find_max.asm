.data
A: .word        2 3 6 8 1
N: .word        5

.text



.globl main


max:
        slt     $t0, $a0, $a1           # $t0 = ( A[n-1] < find_max(A, n-1) )? 1:0
        bne     $t0, $zero, max1

        add     $v0, $a0, $zero         # $v0 = A[n-1] (max)
        jr      $ra                     # ritorna al chiamante

max1:
        add     $v0, $a1, $zero         # $v0 = find_max(A, n-1) (max)
        jr      $ra                     # ritorna al chiamante di max(non di max1)


##############################################################################



find_max:
        slti    $t0, $a1, 2             # $t0 = (n<2)? 1:0
        bne     $t0, $zero, base        # se n<2 vai a base(return A[0])


        addi    $sp, $sp, -8            # alloca stack
        sw      $ra, 0($sp)             # salva $ra
        sw      $s0, 4($sp)             # salva $s0

        addi    $a1, $a1, -1            # $a1 = n-1
        sll     $t0, $a1, 2             # $t0 = 4*n-1
        add     $t0, $a0, $t0           # $t0 = &A[n-1]
        lw      $s0, 0($t0)             # $s0 = A[n-1]

        jal find_max                    # chiama find_max(A, n-1)

        add     $a0, $s0, $zero         # $a0 = A[n-1]
        add     $a1, $v0, $zero         # $a1 = find_max(A, n-1)

        jal max

        lw      $ra, 0($sp)             # preleva $ra
        lw      $s0, 4($sp)             # preleva $s0
        addi    $sp, $sp, 8             # dealloca stack

        j       end
base:
        lw      $va, 0($a0)             # $v0 = A[0]
end:
        jr      $ra                     # ritorna al chiamante


##############################################################################


main:
        addi    $sp, $sp, -4    # alloca stack
        sw      $ra, 0($sp)     # salva $ra


        la      $a0, A          # $a0 = &A[0] (indirizzo base)
        la      $t0, N          # $t0 = &N (indirizzo)
        lw      $a1, 0($t0)     # $a0 = N  
        
        jal     find_matrix     # chiama find_max(int A[], int n)


        add     $a0, $zero, $v0 # $a0 = find_max()
        addi    $v0, $0, 1      # carica codice syscall print_int
        syscall                 # printf("%d", N)


        lw      $ra, 0($sp)     # preleva $ra
        addi    $sp, $sp, 4     # dealloca stack

        jr      $ra             # ritorna al chiamante
