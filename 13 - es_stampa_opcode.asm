# l'OPCODE sono i 6 bit più significativi delle istruzioni macchina



.data

.text

.globl main

main:
        add $t0, $zero, $zero
        la      $t0, main
        lw      $t0, 4($t0)

        srl     $a0, $t0, 26
        