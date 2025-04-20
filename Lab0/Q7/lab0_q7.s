@ Write a program to find GCD of two numbers

.text

init:
    MOV R0, #12
    MOV R1, #18

gcd:
    CMP R0, R1
    SUBGT R0, R0, R1
    SUBLT R1, R1, R0    @ or we can do: RSBLT R1, R0, R1
    MOVEQ R2, R0
    BNE gcd

end:
    SWI 0x011
    