@ b) Write an ALP using ARM7TDMI to perform Convolution using MLA instruction 
@ (Addition of multiplication of respective numbers of loc A and loc B).

.data
A:      .word 1,2,3,4
B:      .word 2,3,4,5
C: 	.WORD 0

.text

init:
    LDR R0, =A
    LDR R1, =B
	MOV R3, #4
    MOV R2, #0

start:
    CMP R3, #0
    BNE loop
    B end

loop:
    LDR R5,[R0],#4
	LDR R6,[R1],#4
	MLA R2,R5,R6,R2
    SUB R3,R3,#1
    B start

end:
    LDR R1,=C
	STR R2,[R1]
    SWI 0x011
