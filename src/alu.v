module ALU#(
        parameter pOP_COUNT, //number of operations
        parameter pALU_WIDTH = $clog2(pOP_COUNT),      // size of operation bus (2^1)
        parameter pDATA_WIDTH = 8
    )(
        input  [pDATA_WIDTH-1:0] operand_1,
        input  [pDATA_WIDTH-1:0] operand_2,
        input  [pALU_WIDTH-1:0]  alu_op,   // (Opcode)
        output [pDATA_WIDTH-1:0] result, 
        output z_flag
    );

    

endmodule