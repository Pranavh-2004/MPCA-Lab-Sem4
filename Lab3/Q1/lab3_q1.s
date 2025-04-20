@ Write an ALP using ARM7TDMI to find the remainder of a number.(ie 10/3, remainder is 1)

.data
    A: .word 10          
    B: .word 3           
    R: .word 0           

.text

init:
    LDR R0, =A           
    LDR R1, [R0]         
    LDR R0, =B           
    LDR R2, [R0]         

start:
    MOV R3, R1           
    MOV R4, #0           

Division_Loop:
    CMP R3, R2           
    BLT Store_Result     
    SUB R3, R3, R2       
    ADD R4, R4, #1       

    B Division_Loop      

Store_Result:
    STR R3, [R0]         

end:
    SWI 0x011
    