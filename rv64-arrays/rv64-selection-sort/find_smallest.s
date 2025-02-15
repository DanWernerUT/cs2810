                .global find_smallest
                .text

# find_smallest(begin_address, end_address) -> address_of_smallest
find_smallest:
#       a0 = begin_address
#       a1 = end_address
        ld t0, 0(a0)                         #get first element
        mv  t1, a0                           #get first address, index variable
1:      bge t1, a1, 3f                       #if i >= end_address: goto 2f
        ld t2, 0(a0)                         #get current address
        bge t2, t0, 2f
        mv t0, t2
        mv t1, a0

2:      addi a0, a0, 8                      #add 8 to addance to next address
        j 1b
 
3:      mv a0, t1   
        ret

