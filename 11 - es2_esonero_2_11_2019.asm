.data
A: .word 2 0 8 0 4 9 0 7 0 0 0 0 0 0 0 0
str: .asciiz "numero di sostituzioni effetuate: "

.text

.globl main


sost_conta:
        addi    $t0, $zero, 1           # $t0 = 1
        bne     $a1, $t0, else_1        # if(m != 1) goto else_1

        lw      $t0, 0($a0)             # $t0 = A[0]
        bne     $t0, $a2, else_2        # if(A[0] != k) goto else_2

        sw      $a3, 0($a0)             # A[0] = h
        addi    $v0, $zero, 1           # return 1
        jr      $ra                     # ritorno al chiamante

else_2:
        add     $v0, $zero, $zero       # return 0
        jr      $ra                     # ritorno al chiamante

else_1:
        addi    $sp, $sp, -16           # alloco 4 parole
        sw      $ra, 0($sp)             # carico $ra
        sw      $s0, 4($sp)             # carico $s0
        sw      $s1, 8($sp)             # carico $s1
        sw      $s2, 12($sp)            # carico $s2


        add     $s0, $a0, $zero         # $s0 = &A[0]
        add     $s1, $a1, $zero         # $s1 = m
        srl     $a1, $a1, 1             # $a1 = m/2
        
        jal     sost_conta              # chiama $v0 = sost_conta(A, m/2, k, h)
        add     $s2, $v0, $zero         # $s2 = $v0 = sost_conta(A, m/2, k, h)

        sll     $t0, $s1, 1             # $t0 = 4*(m/2) = 2*m
        add     $a0, $s0, $t0           # $a0 = &A[m/2]
        srl     $a1, $s1, 1             # $a1 = m/2

        jal     sost_conta              # chiama $v0 = sost_conta(*(A+m/2), m/2, k, h)
        add     $v0, $v0, $s2           # return sost_conta(A, m/2, k, h) + sost_conta(*(A+m/2), m/2, k, h)

        lw      $s2, 12($sp)            # prelevo $s2 dallo stack
        lw      $s1, 8($sp)             # prelevo $s1 dallo stack
        lw      $s0, 4($sp)             # prelevo $s0 dallo stack
        lw      $ra, 0($sp)             # prelevo $ra dallo stack
        addi    $sp, $sp, 16            # dealloco 4 parole

        jr      $ra                     # ritorno al chiamante


main:
        addi    $sp, $sp, -8    # alloco 2 parole per
        sw      $ra, 0($sp)     # carico $ra sullo stack
        sw      $s0, 4($sp)     # carico $s0 sullo stack

        
        la      $a0, A          # $a0 = &A[0]
        addi    $a1, $zero, 16   # $a1 = m = 16
        addi    $a2, $zero, 0   # $a2 = k = 0
        addi    $a3,$zero, 9999 # $a3 = h = 9999

        jal     sost_conta      # chiama sost_cont(A, m, k, h)
        add     $s0, $v0, $zero # $s0 = $v0 = sost_cont(A, m, k, h)

        
        la      $a0, str        # $a0 = &str[0]
        addi    $v0, $zero, 4   # carica codice print_string
        syscall                 # printf("%s", str)
        
        add     $a0, $s0, $zero # $a0 = $s0 = sost_cont(A, m, k, h)
        addi    $v0, $0, 1      # carica codice syscall print_int
        syscall                 # printf("%d", N)


        lw      $ra, 0($sp)     # prelevo $ra dallo stack
        lw      $s0, 4($sp)     # prelevo $s0 dallo stack
        addi    $sp, $sp, 4     # dealloco 2 parole 
        jr      $ra             # ritorno al chiamnte del main