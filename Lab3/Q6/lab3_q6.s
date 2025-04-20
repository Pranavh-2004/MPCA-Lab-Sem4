@ Write an ALP using ARM7TDMI to find the sum of all the BCD digits of a given 32 bit number.
@ (hint:788 =7+8+8)

.data
num: .word 0x00000788
sum: .word 0

.text

init:
    LDR R0, =num
    LDR R1, [R0]
    MOV R2, #0
    MOV R3, #4  

start:
    CMP R3, #0
    BEQ end

loop:
    AND R4, R1, #0xF
    ADD R2, R2, R4
    MOV R1, R1, LSR #4
    SUB R3, R3, #1 
    B start

end:
    LDR R0, =sum
    STR R2, [R0]
    SWI 0x011
