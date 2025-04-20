@ Write an ALP using ARM7TDMI to find the substring present or not

.data
STR: .asciz "hello world"   @ (Null terminated)
SUB: .asciz "world"         @ Substring to find

.text

start:
    LDR R0, =STR      
    LDR R1, =SUB      
    MOV R3, #0        @ 0 = not found 1 = found

outer_loop:
    LDRB R2, [R0]     
    CMP R2, #0        
    BEQ end           

    PUSH {R0, R1}      @ Save current positions for backtracking
    BL check_substring 
    POP {R0, R1}       @ Restore positions

    CMP R3, #1        
    BEQ end

    ADD R0, R0, #1     @ Move to next character in main string
    B outer_loop      

end:
    SWI 0x011         

check_substring:
    PUSH {LR}         @ Save return address
    MOV R4, R0        @ Copy main string pointer to R4
    MOV R5, R1        @ Copy substring pointer to R5

compare_loop:
    LDRB R6, [R4], #1 @ Load byte from main string
    LDRB R7, [R5], #1 @ Load byte from substring
    CMP R7, #0        @ If end of substring is reached
    BEQ found         @ Substring is found

    CMP R6, R7        @ Compare characters
    BNE not_found     

    B compare_loop    

found:
    MOV R3, #1        @ Set found flag
    POP {LR}          @ Restore return address
    BX LR             

not_found:
    MOV R3, #0        @ Set not found flag
    POP {LR}          @ Restore return address
    BX LR             
