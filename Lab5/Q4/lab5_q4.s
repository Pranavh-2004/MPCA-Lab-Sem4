@ Write an ALP using ARM7TDMI to swap the first and last character of a given string.
@ Example:
@ Input: 'dog'
@ Output: 'god'

.data
STR:    .asciz "dog"   @ (Null terminated)

.text

start:
    LDR R0, =STR      
    MOV R1, #0        @ Initialize counter to find length

find_length:
    LDRB R2, [R0, R1] @ Load byte from string at offset R1
    CMP R2, #0        
    BEQ swap_chars    
    ADD R1, R1, #1    
    B find_length     

swap_chars:
    CMP R1, #1        @ Check if string length is 1 or less (no swap needed)
    BLE end           

    SUB R2, R1, #1    @ Get last character index (R2 = length - 1)

    LDR R3, =STR      @ Reload base address of string
    LDRB R4, [R3]     
    LDRB R5, [R3, R2] 

    STRB R5, [R3]     @ Store last character at first position
    STRB R4, [R3, R2] @ Store first character at last position

end:
    SWI 0x011         
    