                .global _start
                .equ    sys_exit, 93
                .equ    array_max_args, 2

                .data
newline:        .asciz "\n"

                # each element is stored as a 64 value
                .balign 8
test_array_1:   .8byte  5
                .equ    test_len_1, 1
test_array_2:   .8byte  -2, 13, 16, -24, 5, 7, 11, 10, 6, 13
                .equ    test_len_2, 10
test_array_3:   .8byte  17, 13, 16, -24, 5, 7, 11, 10, 6, 13
                .equ    test_len_3, 10
test_array_4:   .8byte  17, 13, 16, -24, 5, 7, 11, 10, 6, 18
                .equ    test_len_4, 10
test_array_5:   .8byte  1700, 1300, 1600, -2400, 500, 700, 1100, 1000, 600, 1800
                .equ    test_len_5, 10
test_array_6:   .8byte  -1700, -1300, -1600, -2400, -500, -700, -1100, -1000, -600, -1800
                .equ    test_len_6, 10
test_array_7:   .8byte  0, 255, 65280, 65535, 16777215, 72057594037927936, -1
                .equ    test_len_7, 7


                .text
_start:
                .option push
                .option norelax
                la      gp, __global_pointer$
                .option pop

                # test the function with each of the arrays above
                la      a0, test_array_1
                li      a1, test_len_1
                jal     array_max
                jal     print_int
                la      a0, newline
                jal     print_string

                la      a0, test_array_2
                li      a1, test_len_2
                jal     array_max
                jal     print_int
                la      a0, newline
                jal     print_string

                la      a0, test_array_3
                li      a1, test_len_3
                jal     array_max
                jal     print_int
                la      a0, newline
                jal     print_string

                la      a0, test_array_4
                li      a1, test_len_4
                jal     array_max
                jal     print_int
                la      a0, newline
                jal     print_string

                la      a0, test_array_5
                li      a1, test_len_5
                jal     array_max
                jal     print_int
                la      a0, newline
                jal     print_string

                la      a0, test_array_6
                li      a1, test_len_6
                jal     array_max
                jal     print_int
                la      a0, newline
                jal     print_string

                la      a0, test_array_7
                li      a1, test_len_7
                jal     array_max
                jal     print_int
                la      a0, newline
                jal     print_string

                # jal  the exit system jal
                li      a0, 0
                li      a7, sys_exit
                ecall
