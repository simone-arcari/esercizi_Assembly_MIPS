.data
A:              .word 2 3 0 5 1 5 4 1 0 2 3 5
dimensioni:     .word 3 4


.text


.globl main


main:
        addi    $sp, $sp, -4
        sw      $ra, 0($sp);

        # invoco procedura modificaMat

        la      $a0, A                  # carico indirizzo base matrice
        la      $t0, dimensioni
        lw      $a1, 0($t0)             # carico M
        lw      $a2, 4($t0)             # carico N

        jal     modificaMat             # 

        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        jr      $ra



# $a0 <- ind. base matrice
# $a1 <- num righe (M)
# $a2 <- num colonne (N)
modificaMat:
        addi    $sp, $sp -20     
        sw      $ra, 0($sp)
        sw      $s0, 4($sp)
        sw      $s1, 8($sp)
        sw      $s2, 12($sp)
        sw      $s3, 16($sp)

        add     $s0, $zero, $a0         # $s0 <- &A[0][0]
        add     $s1, $zero, $a1         # $s1 <- M
        add     $s2, $zero, $a2         # $s2 <- N
        add     $s3, $zero, $zero       # i = 0

loop:
        slt     $t0, $s3, $s1           # $t0 = (i < M)
        beq     $t0, $zero, exit

        add     $a0, $zero, $s0         # $a0 <- &A[i][0]
        add     $a1, $zero, $s2         # $a1 <- N
        jal     trovaMax                # $v0 <- trovaMax(&A[i][0], N)

        sw      $v0, 0($s0)             # A[i][0] <- massimo della riga

        addi    $s3, $s3, 1             # i++
        sll     $t0, $s2, 2             # $t0 <- 4*N
        add     $s0, $s0, $t0           # $s0 <- &A[i][0]

        j       loop

exit:
        lw      $ra, 0($sp)
        lw      $s0, 4($sp)
        lw      $s1, 8($sp)
        lw      $s2, 12($sp)
        lw      $s3, 16($sp)
        addi    $sp, $sp, 20
        jr      $ra



# $a0 <- ind. base riga
# $a1 <- lunghezza riga
# $v0 <- elemento massimo
trovaMax:
        lw      $v0, 0($a0)             # max <- B[0]
        addi    $t0, $zero, 1           # $t0 <- j = 1
        addi    $a0, $a0, 4

loop2:
        slt     $t1, $t0, $a1           # $t1 = (j < N)
        beq     $t1, $zero, ret

        lw      $t1, 0($a0)             # $t1 <- B[j]
        slt     $t2, $v0, $t1           # $t2 = (max < B[j])
        beq     $t2, $zero, cont

        add     $v0, $zero, $t1         # max <- B[j]

cont:
        addi    $t0, $t0, 1             # j++
        addi    $a0, $a0, 4             # $a0 <- &B[j]
        j       loop2

ret:    
        jr      $ra




