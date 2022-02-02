.data



.text


.globl main



T:
        slti    $t0, $a0, 2
        beq     $t0, $zero, else

        slti    $t0, $a1, 4
        beq     $t0, $zero, else

        addi    $v0, $zero, 1
        jr      $ra

else:
        addi    $sp, $sp, -16
        sw      $ra, 0($sp)
        sw      $s0, 4($sp)
        sw      $s1, 8($sp)
        sw      $s2, 12($sp)

        add     $s0, $a0, $zero
        add     $s1, $a1, $zero
        add     $s2, $zero, $zero

        addi    $a0, $s0, -1
        addi    $a1, $s0, -2

        jal     T 

        add     $s2, $v0, $zero

        srl     $a0, $s1, 2
        srl     $a1, $s1, 1

        jal     T 

        add     $v0, $s2, $v0

        sll     $t0, $s0, 1
        add     $v0, $v0, $t0
        add     $v0, $v0, $s1

        lw      $ra, 0($sp)
        lw      $s0, 4($sp)
        lw      $s1, 8($sp)
        lw      $s2, 12($sp)
        addi    $sp, $sp, 16

        jr      $ra

        



main:
        addi    $sp, $sp, -4
        sw      $ra, 0($sp)


        addi    $a0, $zero, 3
        addi    $a1, $zero, 45

        jal     T

        add     $a0, $v0, $zero
        addi    $v0, $0, 1      # carica codice syscall print_int
        syscall                 # printf("%d", N)

        lw      $ra, 0($sp)
        addi    $sp, $sp, 4

        jr      $ra