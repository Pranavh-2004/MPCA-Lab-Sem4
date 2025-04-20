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

    SUB R3, R1, #1      @ Set R3 to (size - 1), used as the reverse index

start:
    CMP R3, #0          @ Check if reverse index (R3) is less than 0
    BLT end             @ If R3 < 0, we are done

    LDR R4, [R0], #4    
    STR R4, [R2, R3, LSL #2] @ Store R4 into B at offset (R3 * 4)
    SUB R3, R3, #1      

    B start             

end:
    SWI 0x011            


@ .text

@  init:
@     LDR R0, =A 
@     LDR R0, [R0]
@     LDR R1, =size
@     LDR R1, [R1]
@     LDR R2, =B
@     LDR R2, [R2]
@     MOV R3, #4
@     MLA R3, R3, R1

@ init_loop:    

@ start:
@     CMP R1, #0
@     BEQ end

@ loop:
@     STR R2, 

@ end:
@     SWI 0x011
