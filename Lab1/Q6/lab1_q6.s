@ Write an ALP using ARM7TDMI  to multiplication of 38X72  without using MUL instructions.
@ (Hint: barrel shifter instructions.)
@ (Note :any number can be considered as multiplier)

@ Logic used: break 38 into 32 + 4 + 2

.text
MOV R0, #38
MOV R1, #72
MOV R2, R1, LSL#5
ADD R3, R2, R1, LSL#2
ADD R4, R3, R1, LSL#1
SWI 0x011
