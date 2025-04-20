@ Write and ALP to perform NOT operation using MOV and bitwise logical instruction

.text

init:
    MOV R0, #5
    MOV R1, #0xFFFFFFFF     @ can also do: MOV R1, #-1

start:
    XOR R0, R0, R1

end:
    SWI 0x011
