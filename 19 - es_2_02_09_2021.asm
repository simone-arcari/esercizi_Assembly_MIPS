.data
B:    .word   0 0 0 0 0
A:    .word   1 2 3 4 5
n:    .word   5

.text

.globl main



foo:
        addi    $sp, $sp, -12
        sw      $s0, 0($sp)
        sw      $s1, 4($sp)
        sw      $s2, 8($sp)

        add     $s0 , $zero, $zero      # i = 0

loop1:
        slt     $t0, $s0, $a2           # $t0 = (i<n)? 1:0
        beq     $t0, $zero, exit1

        srl     $t0, $s0, 1             # $t0 = i/2
        add     $s2 , $zero, $zero      # sum = 0 

        add     $s1 , $zero, $zero      # j = 0


loop2:
        beq     $s1, $t0, continue      # (j==i/2) --> continue
        slt     $t1, $s1, $t0           # $t1 = (j<i/2)? 1:0
        beq     $t1, $zero, exit2

continue:
        sll     $t1, $s1, 3             # $t1 = (4*j)*2 = j*8
        add     $t1, $t1, $a0           # $t1 = &A[2*j]
        lw      $t1, 0($t1)             # $t1 = A[2*j]

        add     $s2, $s2, $t1           # sum += A[2*j]

        addi    $s1, $s1, 1             # j++
        j       loop2

exit2:
        sll     $t0, $s0, 2             # $t0 = i*4
        add     $t0, $t0, $a1           # $t0 = &B[i]
        
        sw      $s2, 0($t0)             # B[i] = sum

        addi    $s0, $s0, 1             # i++
        j       loop1

exit1:
        lw      $s0, 0($sp)
        lw      $s1, 4($sp)
        lw      $s2, 8($sp)
        addi    $sp, $sp, 12

        jr      $ra


main:
        addi    $sp, $sp, -4
        sw      $ra, 0($sp)

        la      $a0, A                  # load A base address
        la      $a1, B                  # load B base address
        la      $t0, n                  # load in $t0 n address
        lw      $a2, 0($t0)             # $a2 = n

        jal     foo

        lw      $ra, 0($sp)      
        addi    $sp, $sp, 4

        jr      $ra


