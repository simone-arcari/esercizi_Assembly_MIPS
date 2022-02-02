.data
A: .word 1 2 3 4 5
str: .asciiz "la somma delle radici è: "

.text

.globl main

radiceq:
        add     $v0, $a0, $zero         # è solo per debug, non abbiamo veramente una funzione per calcolare la radice (facciamo la somma dei numeri e basta)
        jr      $ra                     # ritorno alla procedura chiamante


somma_radici:
        addi    $sp, $sp, -16           # alloco 4 byte
        sw      $ra, 0($sp)             # carico $ra sullo stack
        sw      $s0, 4($sp)             # carico $s0 sullo stack
        sw      $s1, 8($sp)             # carico $s1 sullo stack
        sw      $s2, 12($sp)            # carico $s2 sullo stack

        add     $s0, $zero, $zero       # $s0 = sum = 0
        add     $s1, $zero, $zero       # $s1 = i = 0

loop:
        slt     $t0, $s1, $a1           # $t0 = (i < m)         $a1 = m
        beq     $t0, $zero, exit        # if(i>=m) goto exit

        add     $s2, $a0, $zero         # salvo $a0 in $s2

        sll     $t0, $s1, 2             # $t0 = 4*i
        add     $t0, $a0, $t0           # $t0 = &A[0] + 4*i = &A[i]            $a0 = &A[0]  
        lw      $a0, 0($t0)             # $a0 = A[i]

        jal     radiceq                 # chiamo radiceq

        add     $s0, $s0, $v0           # sum = sum + radiceq(A[i])
        addi    $s1, $s1, 1             # i++

        add     $a0, $s2, $zero         # ripristino $a0 = $s2 = &A[0]
        j       loop                    # goto loop

exit:
        add     $v0, $s0, $zero         # return sum
        
        lw      $s2, 12($sp)            # prelevo $s2 dallo stack
        lw      $s1, 8($sp)             # prelevo $s2 dallo stack
        lw      $s0, 4($sp)             # prelevo $s2 dallo stack
        lw      $ra, 0($sp)             # prelevo $s2 dallo stack
        addi    $sp, $sp, 16            # dealloco 4 byte  

        jr      $ra                     # ritorno al chiamante


main:
        addi    $sp, $sp, -4    # alloco 1 byte per $ra
        sw      $ra, 0($sp)     # carico $ra sullo stack


        la      $a0, A          # $a0 = &A[0]
        addi    $a1, $zero, 5   # $a1 = m = 5

        jal     somma_radici    # chiama somma_radici(A, m)
        add     $t0, $v0, $zero # $t0 = $v0 = somma_radici(A, m)


        la      $a0, str        # $a0 = &str[0]
        addi    $v0, $0, 4      # carica codice print_string
        syscall                 # printf("%s", str)

        add     $a0, $t0, $zero # $a0 = somma_radici(A, m)
        addi    $v0, $0, 1      # carica codice syscall print_int
        syscall                 # printf("%d", N)

        lw      $ra, 0($sp)     # prelevo $ra dallo stack
        addi    $sp, $sp, 4     # dealloco 1 byte
        jr      $ra             # ritorno al chimante del main
