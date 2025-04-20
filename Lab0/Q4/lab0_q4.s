@ Write an ALP to subtract if numbers are equal and add them otherwise

.text

init:
    MOV R0, #5
    MOV R1, #5

@ start:                @ Both the following methods work
@    CMP R0, R1
@    SUBEQ R2, R1, R0
@    ADDNE R2, R1, R0

start:
    CMP R0, R1
    MOVEQ R2, #0
    ADDNE R2, R1, R0

end:
    SWI 0x011
