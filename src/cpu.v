`include "inc/cpu.vh"
`include "inc/alu.vh"
`include "src/alu.v"
`include "src/reg.v"
`include "src/fsm.v"

module CPU(
    input  CLK, RESET, AB_SELECT, 
    input [7:0] OP_ADDR,
    input [3:0] OPCODE,
    output EQUAL, MEM_CONTROL,
    output   [11:0] PROG_ADDR, MEM_ADDR,
    input  [7:0] MEM_DATA_in,
    output [7:0] MEM_DATA_out
    );

    // internal modules I/O
    // regFile
    wire   register_write_enable;
    wire  [7:0] register_data_in;
    wire  [7:0] data_r1, data_r2;
    // alu
    wire  [2:0]  alu_op; // (Opcode)
    wire [7:0] result;
    wire z_flag;



    // internal modules:
    ALU alu (
        .operand_1(data_r1),
        .operand_2(data_r2),
        // cpu-controlled:
        .alu_op(alu_op),
        .result(result),
        .z_flag(z_flag)
    );
    REG_FILE regFile (
        .CLK(CLK),
        .select(AB_SELECT),
        // cpu-controlled:
        .write_enable(register_write_enable),
        .data_in(register_data_in),
        .data_r1(data_r1),
        .data_r2(data_r2)
    );
    FSM control(
        .CLK(CLK), .RESET(RESET),
        .OP_ADDR(OP_ADDR),
        .OPCODE(OPCODE),
        .EQUAL(EQUAL), .MEM_CONTROL(MEM_CONTROL),
        .PROG_ADDR(PROG_ADDR), .MEM_ADDR(MEM_ADDR),
        .MEM_DATA_in(MEM_DATA_in),
        .MEM_DATA_out(MEM_DATA_out),
        //ALU
        .alu_op(alu_op),   // (Opcode)
        .result(result), 
        .z_flag(z_flag),
        //REGFILE 
        .data_r1(data_r1),
        .register_write_enable(register_write_enable),
        .register_data_in(register_data_in)  // Data to write
    );



endmodule