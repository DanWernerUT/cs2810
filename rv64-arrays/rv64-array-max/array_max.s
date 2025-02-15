                .global array_max
                .text

array_max:                                  #def array_max(array, count):
        ld t1, 0(a0)                        #max = array[0]
        li t0, 1                            #i = 1
1:      bge t0, a1, 2f                      #while i < count:
        slli t3, t0, 3                      #   set t3 = i*8
        add t3, a0, t3                      #   set t3 = a0 + i*8
        ld t2, 0(t3)                        #   elt = array[i]
        addi t0, t0, 1                      #   i += 1

        bge t1, t2, 1b                      #if elt > max:
        mv t1, t2                           #max = elt
        j 1b                                #forgot to jump back accidentally, resulted in half passing the tests

 2:     mv a0, t1                           #return max
        ret
