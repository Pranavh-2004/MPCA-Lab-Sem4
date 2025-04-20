@ Write an ALP using ARM7TDMI to generate a square given matrix with A 

@ If (i==j) then A[i][j]=5 
@ Otherwise A[i][j]=0                    
@ (Note:Any size of matrix can be given as input)

@ Considering 4X4 matrix

@ Example :     5 0 0 0
@               0 5 0 0 
@               0 0 5 0
@               0 0 0 0

@Before:
@A:.word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16

@After:
@A:.word 5,0,0,0,0,5,0,0,0,0,5,0,0,0,0,5

.data
A: .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16

.text

init:
    LDR R0, =A       
    MOV R1, #5       // Value to store in the diagonal
    MOV R2, #0       // Value to store for non-diagonal elements
    MOV R3, #4       // Size of the matrix (4x4)
    MOV R4, #0       // Row index

start:
    CMP R4, R3       
    BEQ end          
    MOV R7, #0       

loop:
    MLA R5, R4, R3, R7  
    MOV R6, R5, LSL #2  
    ADD R8, R0, R6      
    CMP R4, R7          // Check if row index == column index
    STREQ R1, [R8]      
    STRNE R2, [R8]      
    ADD R7, R7, #1      
    CMP R7, R3          
    BNE loop            
    ADD R4, R4, #1      
    B start             

end: 
    SWI 0x011           
