                .global gcd
                .text

gcd                                 # def gcd(a, b):
1:                      
            bge a1, a0, 2f          #if(b >= a) 2f 
            sub a0, a0, a1          #a=a-b j 3f
            j 3f                    #jump to loop check
2:                                  #else
            sub a1, a1, a0          #b=b-a
            j 3f                    #jump to loop check
3:                                  #loop condition 
            beq a0, a1, 4f          #while a != b:
            j 1b                    #jump to start
4:
            ret                     # return a