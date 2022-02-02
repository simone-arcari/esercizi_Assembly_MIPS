.data


.text



.globl main


T:
        slti    $t0, $a0, 3             # $t0 = (n<3)? 1:0
        bne     $t0, $zero, base        # se n<3 vai a base(return 1)

        addi    $sp, $sp, -12            # alloca stack
        sw      $ra, 0($sp)             # salva $ra
        sw      $s0, 4($sp)             # salva $s0
        sw      $s1, 8($sp)             # salva $s1

        add     $s0, $a0, $zero         # $s0 = n
        srl     $a0, $s0, 1             # $a0 = n/2

        jal	T			# chiama T(n/2)

        add     $s1, $v0, $v0           # $s1 = 2*T(n/2)
        add     $s1, $s1, $v0           # $s1 = 3*T(n/2)

        srl     $a0, $s0, 2             # $a0 = n/4   ( (n/2)/2 )

        jal     T                       # chiama T(n/4)

        add     $v0, $v0, $v0           # $v0 = 2*T(n/4)

        add     $v0, $v0, $s1           # $v0 = 2*T(n/4) + 3*T(n/2)


        lw      $ra, 0($sp)             # preleva $ra
        lw      $s0, 4($sp)             # preleva $s0
        lw      $s1, 8($sp)             # preleva $s1
        addi    $sp, $sp, 12            # dealloca stack
        jr      $ra

base:
        addi    $v0, $zero, 1           # $v0 = 1
        jr      $ra                     # ritorna al chiamante


##############################################################################


main:
        addi    $sp, $sp, -4            # alloca stack
        sw      $ra, 0($sp)             # salva $ra

        addi    $a0, $zero, 5           # $a0 = 5

        jal     T                       # chiama T(5)

        add     $a0, $zero, $v0         # $a0 = (5)
        addi    $v0, $0, 1              # carica codice syscall print_int
        syscall                         # printf("%d", N)

        lw      $ra, 0($sp)             # preleva $ra
        addi    $sp, $sp, 4             # dealloca stack

        jr      $ra                     # ritorna al chiamante