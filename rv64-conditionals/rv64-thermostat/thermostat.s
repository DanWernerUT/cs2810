                .global thermostat

                .text
thermostat:
                # your code goes here
                li  t0, 68                      #load 68 into temp regerister 0
                bge a0, t0, 1f                  #branch if a0 >= t0(68)
                li  a0, 1                       #set a0 equal to 1
                ret                             #return
1:
                li  t0, 75                      #load 75 into temp reg 0
                ble a0, t0, 2f                  #branch to 2f if a0 <= 75
                li a0, -1                       #load -1 into a0
                ret                             #return

2:  
                li a0, 0                        #if both statements above == false, return 0
                ret