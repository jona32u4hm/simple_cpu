`include "include/cpu_defines.vh"
`include "include/alu_defines.vh"

module CPU(
    input  CLK, RESET, AB_SELECT, 
    input [7:0] OP_ADDR,
    input [3:0] OPCODE,
    output EQUAL, MEM_CONTROL,
    output   [11:0] PROG_ADDR, MEM_ADDR,
    inout [7:0] MEM_DATA
    );

    // internal modules I/O
    // regFile
    wire   register_write_enable;
    wire  addr_rs1, addr_rs2, addr_rd;
    wire  [7:0] register_data_in;
    wire  [7:0] data_rs1, data_rs2;
    // alu
    wire  [`ALU_OP_WIDTH-1:0]  alu_op; // (Opcode)
    wire [7:0] result;
    wire z_flag;



    // internal modules:
    ALU alu (
        .operand_1(data_rs1),
        .operand_2(data_rs2),
        // cpu-controlled:
        .alu_op(alu_op),
        .result(result),
        .z_flag(z_flag)
    );
    REG_FILE regFile (
        .CLK(CLK),
        .addr_rs1(AB_SELECT),
        .addr_rs2(!AB_SELECT),
        .addr_rd(AB_SELECT),
        // cpu-controlled:
        .write_enable(register_write_enable),
        .data_in(register_data_in),
        .data_rs1(data_rs1),
        .data_rs2(data_rs2)
    );
    FSM control(
        .CLK(CLK), .RESET(RESET),
        .OP_ADDR(OP_ADDR),
        .OPCODE(OPCODE),
        .EQUAL(EQUAL), .MEM_CONTROL(MEM_CONTROL),
        .PROG_ADDR(PROG_ADDR), .MEM_ADDR(MEM_ADDR),
        .MEM_DATA(MEM_DATA),
        //ALU
        .alu_op(alu_op),   // (Opcode)
        .result(result), 
        .z_flag(z_flag),
        //REGFILE 
        .data_rs1(data_rs1),
        .register_write_enable(register_write_enable),
        .register_data_in(register_data_in)  // Data to write
    );



endmodule