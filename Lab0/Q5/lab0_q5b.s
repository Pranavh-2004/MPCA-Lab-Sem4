@ Write an ALP to check if a number is even or odd.
@ Note at end of execution, R2 contains 0 if even, else 1

@ Done with RRX op

.text

init:
    MOV R0, #6

start:
    MOVS R1, R0, RRX
    MOVCC R2, #0
    MOVCS R2, #1

end:
    SWI 0x011
