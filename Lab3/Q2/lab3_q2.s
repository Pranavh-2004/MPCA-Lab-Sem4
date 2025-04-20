@ Write an ALP using ARM7TDMI to search for an element in an array of 16 bit each using Linear search technique
@ Store -1 in R4 if not found, else 1

.data
B:.word 5
A:.hword 1,2,3,4,5,6,7,8,9

.text

init:
    LDR R0, =A
    LDR R1, =B
    LDR R2, [R1]
    MOV R3, #9
    MOV R4, #-1

start:
    CMP R3, #0
    BNE loop
    B end

loop:
    LDRH R5, [R0]
    CMP R2, R5 
    MOVEQ R4, #1
    ADD R0, R0, #2
    SUB R3, R3, #1
    B start

end:
    SWI 0x011
