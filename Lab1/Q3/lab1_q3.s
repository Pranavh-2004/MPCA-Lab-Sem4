@ Write a ALP using ARMTDMI-ISA to store odd and even numbers in separate memory locations starting from LOCA and LOCB respectively
@ ARRAY: .word 10,50,41,55,30,20,11,5,100,77
@ LOCA: .word 0,0,0,0,0,0
@ LOCB: .word 0,0,0,0,0,0

.data 
array: .word 10, 50, 41, 55, 30, 20, 11, 5, 100, 77
oddarray: .word 0, 0, 0, 0, 0, 0 
evenarray: .word 0, 0, 0, 0, 0, 0 

init:
    LDR R0, =array
    LDR R1, =oddarray
    LDR R2, =evenarray
    MOV R3, #10

start:
    CMP R3, #0
    BNE loop
    B end

loop: 
    LDR R4, [R0]
    TST R4, #1
    STREQ R4, [R2]
    ADDEQ R2, R2, #4
    STRNE R4, [R1]
    ADDNE R1, R1, #4
    ADD R0, R0, #4
    SUB R3, R3, #1
    B start

end:
    SWI 0x011
