                .global pencil_marks, get_used, clear_used, count_bits
                .text

# count_bits(n) -> # of bits set in n (only counting bits 0-9 inclusive)
count_bits:
                li   t0, 0              #count = 0
                li   t1, 0              #i = 0
                li   t3, 10
1:                                      #loop
                srl  t2, a0, t1         #temp = n>>index
                andi a1, t2, 1          #bit = temp&1
                addi t1, t1, 1          #index += 1
                add  t0, t0, a1         #count += a1
                blt  t1, t3, 1b         #while index > 10:
                mv   a0, t0             #a0 = count
                ret                     #return

# get_used(board, group) -> used
get_used:
                addi sp, sp, -48
                sd   ra, 40(sp)         #return address
                sd   s0, 32(sp)         #board
                sd   s1, 24(sp)         #group
                sd   s2, 16(sp)         #used
                sd   s3, 8(sp)          #group_index
                sd   s4, (sp)           #element

                mv   s0, a0             #move imported value into board
                mv   s1, a1             #move imported value into group
                li   s2, 0              #used = 0
                li   s3, 0              #group_index = 0
1:
                add  t0, s1, s3         #group_element_address = group + group_index
                lb   t1, 0(t0)          #board_index = lb (group_element_address)
                slli t2, t1, 1          #scaled_board_index = board_index << 1
                add  t3, s0, t2         #board_element_address = board + scaled_board_index
                lh   s4, 0(t3)          #elememnt = lh (board_element_address)
                mv   a0, s4             #move element to return
                jal  ra, count_bits     #count = count_bits(element)
                li   t4, 1              #resets the value so it remains after function calls
                bne  a0, t4, 2f         #If returned value != 1 skip the or step
                or   s2, s2, s4
2:
                addi s3, s3, 1          #group_index++
                li   t5, 9              #resets the value so it remains after function calls
                blt  s3, t5, 1b         #while group_index < 9, 1b

                mv   a0, s2             #move used into a0
                ld   ra, 40(sp)
                ld   s0, 32(sp)
                ld   s1, 24(sp)
                ld   s2, 16(sp)
                ld   s3, 8(sp)
                ld   s4, (sp)
                addi sp, sp, 48
                ret

# clear_used(board, group, used) -> 0 or 1:
clear_used:
                addi sp, sp, -64
                sd   ra, 56(sp)         #return address
                sd   s0, 48(sp)         #board
                sd   s1, 40(sp)         #group
                sd   s2, 32(sp)         #change_made
                sd   s3, 24(sp)         #group_index
                sd   s4, 16(sp)         #element
                sd   s5, 8(sp)          #not_used
                sd   s6, (sp)           #board_index

                not  s5, a2             # notused = ~used (flip the bits)
                li   s2, 0              # change_made = 0         
                li   s3, 0                      
1:
                add  t0, s1, s3         #group_element_address = group + group_index
                lb   t1, 0(t0)          #board_index = lb (group_element_address)
                slli t2, t1, 1          #scaled_board_index = board_index << 1
                add  s6, s0, t2         #board_element_address = board + scaled_board_index

                lh   s4, 0(s6)          #elememnt = lh (board_element_address)
                mv   a0, s4             #move element to return
                jal  ra, count_bits     #count = count_bits(element)
                li   t1, 1              #resets the value so it remains after function calls
                beq  a0, t1, 2f         #count != 1 (indicating an unsolved square):
                and  t0, s4, s5         #new_elt = elt & notused (clear the bits indicated by used)
                beq  t0, s4, 2f
                sh   t0, 0(s6)          #board[board_index] = new_elt # use the address from earlier 
                li   s2, 1              #change_made = 1                                        
2:
                addi s3, s3, 1          #group_index++
                li   t5, 10             #resets the value so it remains after function calls
                blt  s3, t5, 1b         #while group_index < 9, 1b
                mv   a0, s2             #move used into a0

                ld   ra, 56(sp)
                ld   s0, 48(sp)
                ld   s1, 40(sp)
                ld   s2, 32(sp)
                ld   s3, 24(sp)
                ld   s4, 16(sp)
                ld   s5, 8(sp)
                ld   s6, (sp)
                addi sp, sp, 64
                ret                     #return change_made


# pencil_marks(board, table) -> 0: no changes, 1: something changed
pencil_marks:
                addi sp, sp, -48
                sd   ra, 40(sp)         #return address
                sd   s0, 32(sp)         #board
                sd   s1, 24(sp)         #group
                sd   s2, 16(sp)         #used
                sd   s3, 8(sp)          #group_index
                sd   s4, (sp)           #element
                                        
                                        # changed = 0
                                        # for group_start = 0; group_start < 27*9; group_start += 9
                                        #     used = get_used(board, table+group_start)
                                        #     delta = clear_used(board, table+group_start, used)
                                        #     if delta != 0:
                                        #         changed = 1
                                        # return changed
                ld   ra, 40(sp) 
                ld   s0, 32(sp)
                ld   s1, 24(sp)
                ld   s2, 16(sp)
                ld   s3, 8(sp)
                ld   s4, (sp)
                addi sp, sp, 48
                ret

