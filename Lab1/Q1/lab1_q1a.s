@ Write an ALP using ARM7TDMI to perform multiplication of 16X25 without using mul instruction
@ Hint barrel shifter instructions
@ Note: any number

.text
MOV R0, #25
MOV R1, R0, LSL#4
SWI 0x011
