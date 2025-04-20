.data
A:.word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16

.text

init:
    LDR R9, =A
    MOV R10, #5
    MOV R2, #0
    MOV R7, #4
    MOV R1, #0

start:
    CMP R1, R7
    BEQ end
    MOV R4, #0

loop:
    MLA R5, R1, R7, R4
    MOV R6, R5, LSL #2
    ADD R8, R9, R6
    CMP R1, R4
    STREQ R10, [R8], #0
    STRNE R2, [R8], #0
    ADD R4, R4, #1
    CMP R4, R7
    BNE loop
    ADD R1, R1, #1
    B start

end: 
    SWI 0X011


@ .text
@
@ init:
@    LDR R0, =A
@    MOV R1, #5
@    MOV R2, #0
@    MOV R3, #4
@    MOV R4, #0
@
@ start:
@    CMP R4, R3
@    BEQ end
@    MOV R3, #0
@
@loop:
@    MLA R5, R4, R7, R3
@    MOV R6, R5, LSL #2
@    ADD R8, R0, R6
@    CMP R4, R3
@    STREQ R1, [R8], #0
@    STRNE R2, [R8], #0
@    ADD R3, R3, #1
@    CMP R3, R7
@    BNE loop
@    ADD R4, R4, #1
@    B start
@
@ end: 
@    SWI 0X011
