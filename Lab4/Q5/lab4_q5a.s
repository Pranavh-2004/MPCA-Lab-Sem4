@ Write an ALP using ARM7TDMI to reverse the elements stored in location A with location B  
@ Before:
@ A:.word 1,2,3,4,5,6,7,8,9,10
@ After :
@ A:.word 10,9,8,7,6,5,4,3,2,1

.data
A:    .word 1,2,3,4,5,6,7,8,9,10   
B:    .word 0,0,0,0,0,0,0,0,0,0   
size: .word 10                    

.text

init:
    LDR R0, =A          
    LDR R1, =size       
    LDR R1, [R1]        
    LDR R2, =B          

    ADD R2, R2, R1, LSL #2 @ Move R2 to the end of array B (size * 4)
    SUB R2, R2, #4      @ Adjust R2 to point to the last element of B

start:
    CMP R1, #0          
    BEQ end             @ If size (R1) == 0, we're done

    LDR R3, [R0], #4    @ Load current element from A into R3 and increment R0
    STR R3, [R2], #-4   @ Store R3 into B and decrement R2 to move backward
    SUB R1, R1, #1      @ Decrement the size counter

    B start             

end:
    SWI 0x011           
    