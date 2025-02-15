                .global _start
                .equ    sys_exit, 93
                .equ    count_bits_args, 1
                .equ    get_used_args, 2
                .equ    clear_user_args, 3

                .data
newline:        .asciz  "\n"
intro_msg:      .asciz  "Testing clear_used with the following board:\n\n"
test_row_msg:   .asciz  "\nTesting clear_used on row "
test_col_msg:   .asciz  "\nTesting clear_used on column "
test_box_msg:   .asciz  "\nTesting clear_used on 3x3 box "
get_used_msg:   .asciz  "Calling clear_used with the value returned by get_used: "
return_val_msg: .asciz  "Return value from clear_used: "
the_set_msg_1:  .asciz  " (the set "
the_set_msg_2:  .asciz  ")\n"
new_board_msg:  .asciz "After clear_used returned the board is now:\n\n"

                .text
_start:
                .option push
                .option norelax
                la      gp, __global_pointer$
                .option pop

                # s0: board
                # s1: table
                # s2: i
                # s3: result value

                # reserve stack space for a board
                # 81*2 = 162 so reserve 176
                addi    sp, sp, -176
                mv      s0, sp

                # reserve stack space for the table
                # 27*9 = 243 so reserve 256
                addi    sp, sp, -256
                mv      s1, sp

                # read a board from stdin
1:              mv      a0, s0
                jal     read_board
                bnez    a0, 1b

                # generate the lookup table
                mv      a0, s1
                jal     make_group_table

                # start by printing the test board
                la      a0, intro_msg
                jal     print_string
                mv      a0, s0
                jal     print_board

                # for i from [0, 7) step 11 mod 27
                li      s2, 0

                # 0-8 means a row
2:              li      t0, 9
                bge     s2, t0, 3f
                la      a0, test_row_msg
                jal     print_string
                mv      a0, s2
                jal     print_int
                j       5f

3:              li      t0, 18
                bge     s2, t0, 4f
                la      a0, test_col_msg
                jal     print_string
                addi    a0, s2, -9
                jal     print_int
                j       5f

4:              la      a0, test_box_msg
                jal     print_string
                addi    a0, s2, -18
                jal     print_int

5:              la      a0, newline
                jal     print_string

                # call get_used
                mv      a0, s0
                li      t0, 9
                mul     t1, s2, t0
                add     a1, s1, t1
                jal     get_used
                mv      s3, a0

                la      a0, get_used_msg
                jal     print_string
                mv      a0, s3
                jal     print_int
                la      a0, the_set_msg_1
                jal     print_string
                mv      a0, s3
                jal     print_set
                la      a0, the_set_msg_2
                jal     print_string

                # call clear_used
                mv      a0, s0
                li      t0, 9
                mul     t1, s2, t0
                add     a1, s1, t1
                mv      a2, s3
                jal     clear_used
                mv      s3, a0

                la      a0, return_val_msg
                jal     print_string
                mv      a0, s3
                jal     print_int
                la      a0, newline
                jal     print_string

                # print the updated board
                la      a0, new_board_msg
                jal     print_string
                mv      a0, s0
                jal     print_board

                # next i
                addi    s2, s2, 11
                li      t0, 27
                rem     s2, s2, t0
                li      t0, 7
                bne     s2, t0, 2b

                # clean up stack
                addi    sp, sp, 256
                addi    sp, sp, 176

                # exit
                li      a0, 0
                li      a7, sys_exit
                ecall
