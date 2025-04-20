@ Write an ALP to perform 2's complement only using MOV and RSB instruction

.text
MOV R0, #5
RSB R0, R0, #0
SWI 0x011
