                .global am_or_fm

                .text
am_or_fm:
                # your code goes here
                li  t0, 535                     #load 535 into temp regerister 0
                li  t1, 1605                    #load 1605 into temp regerister 0
                blt a0, t0, 1f                  #branch to 1 if t0 > a0  
                blt t1, a0, 1f                  #branch to 1 if t1 < a0
                li  a0, 1                       #set a0 equal to 1
                ret                             #return
1:
                li t0, 88
                li t1, 108
                blt a0, t0, 2f                  #branch to 2 if t0 > a0  
                blt t1, a0, 2f                  #branch to 2 if t1 < a0
                li a0, 2                       #load -1 into a0
                ret                             #return

2:  
                li a0, 0                        #if all statements above == false, return 0
                ret