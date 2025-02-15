                .global _start
                .equ    sys_exit, 93
                .equ    find_smallest_args, 2
                .equ    sort_args, 2

                .data
                .balign 8
msg_input:      .asciz  "input:  ["
msg_output:     .asciz  "output: ["
msg_sep:        .asciz  ", "
msg_end:        .asciz  "]\n"
string_end:

                .balign 8
lst1:           .8byte  -803, 518, -706, 415, -455, -688, -64, 978, 599, 923
                .8byte  880, -76, -125, -688, 974, -16, -368, -28, -274, -273
                .equ    lst1_len, 20

lst2:           .8byte  978, 974, 923, 880, 599, 518, 415, -16, -28, -64
                .8byte  76, -125, -273, -274, -368, -455, -688, -688, -706, -803
                .equ    lst2_len, 20
lst_end:


                .text
_start:
                .option push
                .option norelax
                la      gp, __global_pointer$
                .option pop

                # lst1
                la      a0, msg_input
                jal     print_string
                la      a0, lst1
                la      a1, lst2
                jal     print_list
                la      a0, msg_end
                jal     print_string

                la      a0, lst1
                la      a1, lst2
                jal     sort

                la      a0, msg_output
                jal     print_string
                la      a0, lst1
                la      a1, lst2
                jal     print_list
                la      a0, msg_end
                jal     print_string

                # lst1
                la      a0, msg_input
                jal     print_string
                la      a0, lst2
                la      a1, lst_end
                jal     print_list
                la      a0, msg_end
                jal     print_string

                la      a0, lst2
                la      a1, lst_end
                jal     sort

                la      a0, msg_output
                jal     print_string
                la      a0, lst2
                la      a1, lst_end
                jal     print_list
                la      a0, msg_end
                jal     print_string

                li      a0, 0
                li      a7, sys_exit
                ecall

print_list:     addi    sp, sp, -32
                sd      ra, 24(sp)
                sd      s5, 16(sp)
                sd      s6, 8(sp)

                mv      s5, a0
                addi    s6, a1, -8
1:              bgt     s5, s6, 3f
                ld      a0, (s5)
                jal     print_int
                beq     s5, s6, 2f
                la      a0, msg_sep
                jal     print_string
2:              addi    s5, s5, 8
                j       1b

3:              ld      ra, 24(sp)
                ld      s5, 16(sp)
                ld      s6, 8(sp)
                addi    sp, sp, 32
                ret
