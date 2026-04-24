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
            // Asumiendo opcode 4'h5 para EQUAL/CMP
            12'h007: {OPCODE, AB_SELECT, OP_ADDR} = {4'h5, 1'b0, 8'h00}; 

            default: {OPCODE, AB_SELECT, OP_ADDR} = 13'h0;
        endcase
    end


endmodule