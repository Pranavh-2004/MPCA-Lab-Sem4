@ Write an ALP to find factorial of a gien number

@ Done with conditional checking for ops

.text

init:
    MOV R0, #5
    MOV R1, #1

factorial:
    CMP R0, #0
    MULNE R2, R1, R0
    MOV R1, R2
    SUBNE R0, R0, #1
    BNE factorial

end:
    SWI 0x011
