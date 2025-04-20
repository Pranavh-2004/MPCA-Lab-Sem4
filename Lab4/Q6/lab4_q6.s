@ Write an ALP using ARM7TDMI to find the largest of all the BCD digits of a given 32bit number.
@ (hint:If R1=17845374 the largest digit is 8

.data
num: .word 0x17845374  @ 32-bit number 

.text

init:
    LDR R0, =num     
    LDR R0, [R0]       
    MOV R1, #0         
    MOV R2, #8         @ number of digits in 32bit number
    MOV R3, #0         

loop:
    AND R3, R0, #0xF   @ Extract the lsb (last 4 bits)
    CMP R3, R1         
    MOVHI R1, R3       
    
    MOV R0, R0, LSR #4 @ Shift R0 right by 4 bits
    SUB R2, R2, #1     
    CMP R2, #0         
    BNE loop           

end:
    MOV R7, #1         
    SWI 0x011          
