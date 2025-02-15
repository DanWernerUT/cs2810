                .global fibonacci
                .text

fibonacci:
    li a1, 0            # a = 0
    li a2, 1            # b = 1
    li t0, 0            # i = 0 
1:
    add t1, a1, a2      #temp = a + b
    mv a1, a2           #a = b
    mv a2, t1           #b = temp
    addi t0, t0, 1      #i++
    blt t0, a0, 1b      #if(i < a0) 1f
    mv a0, a1
    ret 

