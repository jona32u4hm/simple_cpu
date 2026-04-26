`include "inc/cpu.vh"
`include "inc/alu.vh"

module FSM(
        input  CLK, RESET,
        input [7:0] OP_ADDR,
        input [3:0] OPCODE,
        output reg EQUAL, MEM_CONTROL,
        output reg [11:0] PROG_ADDR, MEM_ADDR,
        output  [7:0] MEM_DATA_in,
        input [7:0] MEM_DATA_out,
        //ALU
        output reg [2:0]  alu_op,   // (Opcode)
        input  [7:0] result, 
        input z_flag,
        //REGFILE 
        input [7:0]   data_r1,
        output reg register_write_enable,
        output [7:0]   register_data_in  // Data to write
    );


    // combinational logic:
    always @(*) begin 
        // Default values
        register_write_enable = 0;
        MEM_CONTROL = 1; // Default to Read
        MEM_ADDR = {4'b0000, OP_ADDR};
        case(OPCODE) 
            `CPU_ADD: begin
                alu_op = `ALU_ADD;
                register_write_enable = 1;
            end
            `CPU_SUB: begin
                alu_op = `ALU_SUB;
                register_write_enable = 1;
            end
            `CPU_CMP: begin
                alu_op = `ALU_SUB;
            end
            `CPU_AND: begin
                alu_op = `ALU_AND;
                register_write_enable = 1;
            end
            `CPU_IOR: begin
                alu_op = `ALU_IOR;
                register_write_enable = 1;
            end
            `CPU_LDR: begin
                register_write_enable = 1;
            end
            `CPU_STR: begin
                MEM_CONTROL = 0; 
            end
        endcase
    end
    assign MEM_DATA_in = data_r1;
    assign register_data_in = (OPCODE == `CPU_LDR)? MEM_DATA_out : result;
    // state machine secuential logic:
    always @(posedge CLK) begin 
        if (!RESET) begin //active reset (0)
            PROG_ADDR   <= 0;
            EQUAL   <= 0;
        end else begin
            PROG_ADDR <= PROG_ADDR + 1; // PC inc
            if (OPCODE == `CPU_ADD || OPCODE == `CPU_CMP || OPCODE == `CPU_SUB || OPCODE == `CPU_AND || OPCODE == `CPU_IOR) EQUAL <= z_flag;
        end
    end


endmodule
