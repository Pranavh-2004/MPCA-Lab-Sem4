@ Write an ALP using ARM7TDMI to perform multiplication of 16X25 without using mul instruction
@ Hint barrel shifter instructions
@ Store n in R0 and result in R1
@ 16 is considered as multiplier

.text
MOV R0, #25
MOV R1, #16
MOV R2, R1, LSL#4
ADD R3, R1, R1, LSL#3
ADD R4, R2, R3
SWI 0x011
