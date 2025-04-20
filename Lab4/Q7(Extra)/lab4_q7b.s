@ Write an ALP using ARM7TDMI to  copy a block 400 bytes of data from location A to location B 
@if the rate of data transfer rate is 40 bytes, LDM and STM instructions.
@ and 
@ For the same transfer the block with auto-indexing.

@ Using Auto-Indexing (with LDM and STM)

.data
A: .skip 400      @ 400 bytes of data at location A (source)
B: .skip 400      @ 400 bytes of data at location B (destination)

.text
init:
    LDR R0, =A      
    LDR R1, =B      
    MOV R2, #40     @ Set the data transfer rate to 40 bytes (one LDM/STM operation)
    MOV R3, #10     @ Set the number of transfers 

loop:
    LDMIA R0!, {R4-R11} @ Load 8 registers (40 bytes) from source (A) into R4-R11, incrementing R0
    STMIA R1!, {R4-R11} @ Store the 8 registers (40 bytes) to destination (B), incrementing R1
    SUBS R3, R3, #1     
    CMP R3, #0          
    BNE loop            

end:
    SWI 0x11            
