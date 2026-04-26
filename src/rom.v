`include "inc/cpu.vh"


module ROM(
    input [11:0] PROG_ADDR,
    output reg   AB_SELECT, 
    output reg  [7:0] OP_ADDR,
    output reg  [3:0] OPCODE
    );


 always @(*) begin
        case(PROG_ADDR)
            // STEP 0: LOAD A from 005
            12'h000: {OPCODE, AB_SELECT, OP_ADDR} = {4'h3, 1'b0, 8'h05}; 

            // STEP 1: LOAD B from 010
            12'h001: {OPCODE, AB_SELECT, OP_ADDR} = {4'h3, 1'b1, 8'h10}; 

            // STEP 2: ADD A plus B --> B
            // Asumiendo opcode 4'h0 para ADD y select_ab=1 para destino B
            12'h002: {OPCODE, AB_SELECT, OP_ADDR} = {4'h9, 1'b1, 8'h00}; 

            // STEP 3: STORE A at 015
            // Asumiendo opcode 4'h4 para STORE
            12'h003: {OPCODE, AB_SELECT, OP_ADDR} = {4'h4, 1'b0, 8'h15}; 

            // STEP 4: STORE B at 020
            12'h004: {OPCODE, AB_SELECT, OP_ADDR} = {4'h4, 1'b1, 8'h20}; 

            // STEP 5: LOAD A from 020
            12'h005: {OPCODE, AB_SELECT, OP_ADDR} = {4'h3, 1'b0, 8'h20}; 

            // STEP 6: LOAD B from 025
            12'h006: {OPCODE, AB_SELECT, OP_ADDR} = {4'h3, 1'b1, 8'h25}; 

            // STEP 7: EQUAL A to B (Comparación)
            12'h007: {OPCODE, AB_SELECT, OP_ADDR} = {4'h5, 1'b0, 8'h00}; 




            // ---------------------------------------- SECOND TEST SEQUENCE -------------------------------------------------


                // STEP  8: ldr a, [0] ;contains 4
                12'h008: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_LDR, 1'b0, 8'h00}; 
                // STEP  9: ldr b, [2] ;contains 8
                12'h009: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_LDR, 1'b1, 8'h02};  
                // STEP 10: sub b, a   ; 8 - 4 = 4
                12'h00A: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_SUB, 1'b1, 8'h00}; 
                // STEP 11: str [4], b  
                12'h00B: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_STR, 1'b1, 8'h04}; 
                // STEP 12: sub b, a   ; 4 - 4 = 0 , zero flag
                12'h00C: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_SUB, 1'b1, 8'h00}; 
                // STEP 13: ldr a, [2] ; zero flag not affected
                12'h00D: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_LDR, 1'b0, 8'h02}; 
                // STEP 14: sub b, a   ; 0 - 8 wraps arround, zero flag affected
                12'h00E: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_SUB, 1'b1, 8'h00}; 
                // STEP 15: ldr a, [1] ; contains 0
                12'h00F: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_LDR, 1'b0, 8'h01}; 
                // STEP 16: add a, b   ; load a with b
                12'h010: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_ADD, 1'b0, 8'h00}; 
                // STEP 17: ldr b. [4] ; b contains 4
                12'h011: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_LDR, 1'b1, 8'h04}; 
                // STEP 18: add a, b      
                12'h012: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_ADD, 1'b0, 8'h00}; 
                // STEP 19: add a, b   ; zero flag set
                12'h013: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_ADD, 1'b0, 8'h00}; 
                // STEP 20: ldr b, [0]
                12'h014: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_LDR, 1'b1, 8'h00}; 
                // STEP 21: ldr a, [0]
                12'h015: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_LDR, 1'b0, 8'h00}; 
                // STEP 22: add b, a   ; zero flag reset
                12'h016: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_ADD, 1'b1, 8'h00}; 
                // STEP 23: cmp        ; zero flag set because registers are equal
                12'h017: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_CMP, 1'b0, 8'h00}; 

                // ---------------------------------------- THIRD TEST SEQUENCE -------------------------------------------------

                // STEP 0x18: ldr a, [1] 
                12'h018: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_LDR, 1'b0, 8'h01}; 

                // STEP 0x18: str [$30], B 
                12'h019: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_STR, 1'b1, 8'h30}; 

                // STEP 0x19: ldr b, [1] ; Load the SAME value into B
                12'h01A: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_LDR, 1'b1, 8'h01};  

                // STEP 0x1A: sub b, a   ; b = b - a. Since a == b, b is now 0.
                12'h01B: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_SUB, 1'b1, 8'h00}; 

                // STEP 0x1B: ldr a, [4] ; Load any non-zero value into a
                12'h01C: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_LDR, 1'b0, 8'h04}; 

                // STEP 0x1C: and a, b   ; a = a & 0. Result MUST be 0, and EQUAL is set.
                12'h01D: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_AND, 1'b0, 8'h00}; 

                // STEP 0x1D: ldr a, [2] ; Load a known value 
                12'h01E: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_LDR, 1'b0, 8'h02}; 

                // STEP 0x1E: ior a, b   ; a = a | 0. Result should be the original value, zero flag reset
                12'h01F: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_IOR, 1'b0, 8'h00}; 

                // STEP 0x1F: ldr b, [2] ; Load the same value into b
                12'h020: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_LDR, 1'b1, 8'h02}; 

                // STEP 0x20: and a, b
                12'h021: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_AND, 1'b0, 8'h00}; 

                // STEP 23: cmp        ; zero flag set because registers are equal
                12'h022: {OPCODE, AB_SELECT, OP_ADDR} = {`CPU_CMP, 1'b0, 8'h00}; 


            default: {OPCODE, AB_SELECT, OP_ADDR} = 13'h0;
        endcase
    end


endmodule