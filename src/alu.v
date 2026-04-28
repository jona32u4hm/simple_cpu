`include "inc/alu.vh"

module ALU(
        input  [7:0] operand_1, operand_2,
        input  [2:0]  alu_op,   // (Opcode)
        output reg [7:0] result, 
        output z_flag
);
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