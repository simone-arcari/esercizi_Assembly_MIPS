.data
A: .word 1 2 3 4
M: .word 4
K: .word 4
H: .word 0

.text

.globl main

sos_conta:
        



main:   
        addi    $ap, $sp, -4
        sw      $ra, 0($sp)


        # carcia valori da memomaria in registri $a
        jal     sost_conta


        lw      $ra, 0($sp)
        addi    $sp, $sp, 4

        jr      $ra