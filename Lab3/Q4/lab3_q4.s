@ Write an ALP using ARM7TDMI, for the given matrix arranged in row major order, 
@ find the index of an element if coordinates of a matrix is given and also find the address of the indexed element. 
@ (Using MLA instruction)

.data
A:.hword 1,2,3,4,5,6,7,8,9

.text

init:
    LDR R0, =A
    MOV R1, #1
    @ Lets assume [i,j] = [2,2] as an example
    MOV R4, #3  @ This is set to 3 and not 2 eventhough i = 2. This is because indexing starts from 0, we hv to correct for that
    MOV R5, #2

start:
    MLA R3, R1, R5, R1
    MLA R1, R3, R4, R0

end:
    LDRH R0, [R1]
    SWI 0x011
