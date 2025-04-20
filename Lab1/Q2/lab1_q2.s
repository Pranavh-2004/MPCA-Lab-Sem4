@ Write an ALP to add only even numbers stored in memory location for a given set of numbers and store sum in memory location
@ Array: .WORD 15, 10, 12, 13, 9, 45, 16, 8, 25, 33
@ evensum: .WORD

.data
array: .word 15, 10, 12, 13, 9, 45, 16, 8, 25, 33
evensum: .word 0

.text

init: 
    LDR R0, =array
    LDR R1, =evensum
    MOV R4, #0
    MOV R5, #10

start: 
    CMP R5, #0
    BNE loop
    B end

loop:
    LDR R3, [R0]
    ADD R0, R0, #4
    TST R3, #1
    ADDEQ R4, R4, R3
    SUB R5, R5, #1
    B start

end: 
    STR R4, [R1]
    SWI 0x011
