@ PROGRAM 3 Move a string left to right, right to left on LCD in Embest Board

.text
    mov r0, #30   @ r0 = x position
    mov r1, #7    @ r1 = y position
    mov r7, #0    @ Counter variable

    ldr r8, =num  @ Load address of delay value
    ldr r8, [r8]  @ Load delay value into r8
    ldr r2, =str  @ Load string address into r2

loop:
    swi 0x204     @ Display string on LCD

    cmp r0, #0
    subne r0, r0, #1
    swieq 0x11    @ If x reaches 0, reset position
    b loop

sum:
    cmp r7, r8
    addne r7, r7, #1
    bne sum

    swi 0x206     @ Clear one line on LCD (r0 - line no(y))
    mov r7, #0
    mov pc, lr    @ Return

.data
str:  .asciz "HELLO WORLD"
num:  .word 15000
