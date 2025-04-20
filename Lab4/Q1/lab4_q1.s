@ Write an ALP using ARM7TDMI to add n numbers bytewise using BL.

.data

size: .word 10
A: .byte 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

.text

init:
    LDR R0, =A
    LDR R1, =size
    LDR R1, [R1]
    MOV R3, #0

start:
    BL add_func

end: 
    SWI 0x011

add_func:
    CMP R1, #0
    BXEQ LR

loop:
    LDRB R2, [R0]
    ADD R3, R3, R2
    ADD R0, R0, #1
    SUB R1, R1, #1
    B add_func
