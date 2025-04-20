@ Write an ALP using ARM7TDMI to convert hexadecimal to decimal.
@ Input: 0x0124(Hex)
@ Conversion Process:
@ 0x124→ Extract 4→ 0 * 16 + 4 = 4
@ 0x124 → Extract 2 → 2 * 16^1 + 4 = 36
@ 0x124 → Extract 1 → 1* 16^2 + 36 =292
@ Output: 292(Decimal)

.data
hex: .word 0x0124      
decimal: .word 0       

.text

init:
    LDR R0, =hex       
    LDR R0, [R0]       
    MOV R2, #0         
    MOV R3, #1         

loop:
    CMP R0, #0         
    BEQ end            

    AND R4, R0, #0xF   @ Extract the least significant digit (last 4 bits)
    MUL R4, R3, R4     @ Multiply the extracted digit by the current multiplier (16^0, 16^1, etc.)
    ADD R2, R2, R4     

    MOV R0, R0, LSR #4 @ Shift R0 right by 4 bits to process the next digit

    MOV R4, #16        
    MUL R3, R4, R3     @ Update the multiplier for the next place value (16^1, 16^2, etc.)

    B loop             

end:
    LDR R1, =decimal   
    STR R2, [R1]       
    SWI 0x011          
