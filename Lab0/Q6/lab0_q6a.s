@ Write an ALP to find factorial of a gien number

@ Done without conditional checking for ops

.text

init:
    MOV R0, #5
    MOV R1, #1

factorial:
    CMP R0, #0
    BEQ end
    MUL R2, R1, R0      @ cant do MUL R1, R1, R0 as Rd and Rm should be different in mul
    MOV R1, R2
    SUB R0, R0, #1
    B factorial

end:
    SWI 0x011
