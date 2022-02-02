.data
V: .word 7 6 5 4 2
N: .word 5

.text

.globl main

main:
        la      $t0, V          # t0 = &V[0]
        la      $t1, n          # $t1 = &N
        lw      $t1, 0($t1)     # $t1 = N = 5

        addi    $t1, $t1, -1    # $t1 = N-1
        add     $t2, $0, $0     # $t2 = i = 0

loop:   
        slt     $t3, $t2, $t1   # $t3 = (i < N-1)
        beq     $t3, $0, end    # if i>=n-1 goto end

        lw      $t3, 0($t0)     # $t3 = V[i]
        lw      $t4, 4($t0)     # $t4 = V[i-1]
        slt     $t4, $t3, $t4   # $t4 = (V[i]<V[i-1])
        bne     $t4, $0, falso

        addi    $t2, $t2, 1     # i++
        addi    $t0, $t0, 1     # V++
        j loop


falso
