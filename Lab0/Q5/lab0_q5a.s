@ Write an ALP to check if a number is even or odd.
@ Note at end of execution, R2 contains 0 if even, else 1

@ Done with AND op

.text

init:
    MOV R0, #6

start:
    AND R2, R0, #1

end:
    SWI 0x011
