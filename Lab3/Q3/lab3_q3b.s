@ Write an ALP using ARM7TDMI to to copy a block 128 bytes of data from location A to location B 
@ if the rate of data transfer rate is 16 bytes, LDM and STM instructions. 
@ And For the same transfer the block with auto-indexing.

.data
array: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32
copy: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text

init:
    LDR R0, =array
    LDR R1, =copy
    MOV R6, R1
    MOV R3, #8

start:
    CMP R3, #0
    BNE loop
    B end

loop:
    @ LDMIA R0!, {R6, R7, R8, R9}
    @ STMIA R1!, {R6, R7, R8, R9}
    LDR R6, [R0], #4
    LDR R7, [R0], #4
    LDR R8, [R0], #4
    LDR R9, [R0], #4
    STR R6, [R1], #4
    STR R7, [R1], #4
    STR R8, [R1], #4
    STR R9, [R1], #4
    SUB R3, R3, #1  
    B start

end:
    SWI 0x011
