`include "include/alu_defines.vh"
module ALU#(
        parameter pALU_WIDTH =  `ALU_OP_WIDTH,      // size of operation bus (2^1)
        parameter pDATA_WIDTH = 8
    )(
        input  [pDATA_WIDTH-1:0] operand_1, operand_2,
        input  [pALU_WIDTH-1:0]  alu_op,   // (Opcode)
        output reg [pDATA_WIDTH-1:0] result, 
        output z_flag
    );

    // mapping:
    localparam _ADD    = `ALU_ADD,
               _SUB    = `ALU_SUB,
               _AND    = `ALU_AND, 
               _IOR    = `ALU_IOR, 
               _BYPASS = `ALU_BYPASS;

    always @(*) begin
        case (alu_op)
            _ADD:       result = operand_1 + operand_2;
            _SUB:       result = operand_1 - operand_2;
            _AND:       result = operand_1 & operand_2;
            _IOR:       result = operand_1 | operand_2;
            default: result = 0;
        endcase
    end

    assign z_flag = (result==0)? 1 : 0;

endmodule