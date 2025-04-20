@ Write an ALP using ARM7TDMI, for the given matrix arranged in Column major order, find the index of an element 
@ if coordinates of a matrix is given and also find the address of the indexed element. (Using MLA instruction)
@ . DATA
@  
@ A:.WORD 1,2,3,4,5,6,7,8,9 
@ .Index for the column major=  y*no of rows+x

.data
A: .word 1,2,3,4,5,6,7,8,9  

.text

init:
    LDR R0, =A         
    MOV R1, #3         @ Number of rows 
    MOV R4, #1         @ x-coordinate (row index, assuming 1-based indexing)
    MOV R5, #2         @ y-coordinate (column index, assuming 1-based indexing)

    SUB R4, R4, #1     @ Convert x to 0-based index
    SUB R5, R5, #1     @ Convert y to 0-based index

start:
    MLA R6, R5, R1, R4 
    MOV R7, R6, LSL #2 
    ADD R8, R0, R7     

end:
    LDR R9, [R8]       
    SWI 0x011          
