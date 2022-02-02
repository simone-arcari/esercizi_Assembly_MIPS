.data
N: .word 33
str: .asciiz "Calcolatori"
msg1: .asciiz "inserisci intero: "
msg2: .asciiz "inserisci stringa: "
buf: .space 10

.text

.globl main

main:
        la      $t0, N          # $t0 = &N
        lw      $a0, 0($t0)     # $a0 = N
        addi    $v0, $0, 1      # carica codice syscall print_int
        syscall                 # printf("%d", N)

        addi $a0, $0, 10        # $a0 = \n
        addi    $v0, $0, 11     # carica codice print_charcter
        syscall                 # printf("\n")


        la      $a0, str        # $a0 = &str[0]
        addi    $v0, $0, 4      # carica codice print_string
        syscall                 # printf("%s", str)

        addi $a0, $0, 10        # $a0 = \n
        addi    $v0, $0, 11     # carica codice print_charcter
        syscall                 # print("\n")


        la      $a0, str        # $a0 = &str[0]
        addi    $v0, $0, 4      # carica codice print_string
        syscall                 # printf("%s", str)

        addi $a0, $0, 10        # $a0 = \n
        addi    $v0, $0, 11     # carica codice print_charcter
        syscall                 # print("\n")


        la      $a0, msg1       # $a0 = &msg1[0]
        addi    $v0, $0, 4      # carica codice print_string
        syscall                 # printf("%s", msg1)

        addi    $v0, $0, 5      # carica codice read_int
        syscall                 # scanf()
        la      $t0, N          # $t0 = &N
        sw      $v0, 0($t0)     # scanf("%d", &N)

        lw      $a0, 0($t0)     # $a0 = N
        addi    $v0, $0, 1      # carica codice syscall print_int
        syscall                 # printf("%d", N)

        addi $a0, $0, 10        # $a0 = \n
        addi    $v0, $0, 11     # carica codice print_charcter
        syscall                 # print("\n")


        la      $a0, msg2        # $a0 = &msg2[0]
        addi    $v0, $0, 4      # carica codice print_string
        syscall                 # printf("%s", msg2)

        la      $a0, buf        # $a0 = &buf
        addi    $v0, $0, 8      # carica codice read_string
        syscall


        jr $ra
