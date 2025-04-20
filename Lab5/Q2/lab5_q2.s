@ Write an ALP using ARM7TDMI to find length of a string

.data
STR:    .asciz "hello"   @ (Null terminated )

.text

start:
    LDR R0, =STR      
    MOV R1, #0        

loop:
    LDRB R2, [R0], #1 
    CMP R2, #0        
    BEQ end          
    ADD R1, R1, #1    
    B loop            

end:    
    SWI 0x011         
