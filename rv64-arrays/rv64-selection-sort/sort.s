.global sort
.text

# sort(begin_address, end_address)
sort:
        mv   t0, a0                  # t0 = current (start of unsorted portion)
        mv   t1, a1                  # t1 = end_address (used for bounds checking)

1:      bge  t0, t1, 6f              # while current < end:
        mv   t2, t0                  #      t2 = smallest = current
        ld   a2, 0(t2)               #      a2 = *smallest
        addi t3, t0, 8               #      t3 = next = current + 8

2:      bge  t3, t1, 4f              # while next < end:
        ld   a3, 0(t3)               #      a3 = *next
        bge  a3, a2, 3f              #          if *next < *smallest:
        mv   t2, t3                  #              smallest = next
        ld   a2, 0(t2)               #              update *smallest
3:      addi t3, t3, 8               #              next += 8
        j    2b                      # continue inner loop

4:      beq  t0, t2, 5f              # if smallest != current:
        ld   a4, 0(t0)               #      a4 = *current
        ld   a5, 0(t2)               #      a5 = *smallest
        sd   a5, 0(t0)               #      *current = *smallest
        sd   a4, 0(t2)               #      *smallest = *current

5:
        addi t0, t0, 8               # current += 8
        j    1b                      # continue outer loop

6:
        ret                          # return