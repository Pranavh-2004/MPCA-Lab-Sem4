@ Write an ALP using ARM7TDMI to find the largest number from a given set of numbers:
@ A: .word 10,50,41,55,30,20,11,5,100,77

.data 
array: .word 10, 50, 41, 55, 30, 20, 11, 5, 100, 77

init:
    LDR R0, =array
    LDR R1, [R0]
    MOV R2, #10

start:
    CMP R2, #0
    BNE loop
    B end

loop:
    LDR R3, [R0]
    CMP R1, R3
    MOVLT R1, R3
    ADD R0, R0, #4
    SUB R2, R2, #1
    B start

end:
    SWI 0x011
