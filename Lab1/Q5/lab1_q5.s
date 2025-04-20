@ Write an ALP using ARM7TDMI to find whether the given number is even parity.
@ Set 0 on even parity and 1 on odd parity

.text 

init:
    MOV R0, #6
    MOV R1, #1
    MOV R2, #0

start:
    CMP R0, #0
    BNE loop
    B end

loop:
    MOVS R0, R0, LSR#1
    ADDCS R2, R2, #1
    B start

end:
    TST R2, #1
    MOVEQ R1, #0
    SWI 0x011
