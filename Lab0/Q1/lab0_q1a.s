@ Write an ALP to perform addition for 2 nos of size 64bit

.text

init:
    MOV R0, #5
    MOV R1, #6
    MOV R2, #7
    MOV R3, #8

start:
    ADDS R0, R0, R2
    ADCS R1, R1, R3
    MOV R3, #0
    ADC R2, R3, #0

end:
    SWI 0x011
    