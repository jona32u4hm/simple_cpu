`timescale 1ns/1ps

`include "build/cpu_synth.v" // Archivo generado por Yosys
`include "syn/cmos_cells.v"    // Celdas de la biblioteca para simulación


`include "src/ram.v"
`include "src/rom.v"
`include "sim/tester.v"




module cpu_tb();
    // CPU RAM and ROM connections
    wire clk, reset;
    wire ab_select;
    wire [7:0] op_addr;
    wire [3:0] opcode;
    wire equal, mem_control;
    wire [11:0] prog_addr, mem_addr;
    wire [7:0] mem_data_in, mem_data_out;

    CPU dut (
        .CLK(clk), .RESET(reset), .AB_SELECT(ab_select),
        .OP_ADDR(op_addr), .OPCODE(opcode),
        .EQUAL(equal), .MEM_CONTROL(mem_control),
        .PROG_ADDR(prog_addr), .MEM_ADDR(mem_addr),
        .MEM_DATA_in(mem_data_in),
        .MEM_DATA_out(mem_data_out)
    );
    ROM rom_inst (
        .PROG_ADDR(prog_addr),
        .AB_SELECT(ab_select), .OP_ADDR(op_addr), .OPCODE(opcode)
    );
    RAM ram_inst (
        .CLK(clk),
        .MEM_CONTROL(mem_control),
        .MEM_ADDR(mem_addr),
        .MEM_DATA_in(mem_data_in),
        .MEM_DATA_out(mem_data_out)
    );


    tester test_inst (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        $dumpfile("cpu_simulation.vcd");
        $dumpvars(0, cpu_tb);
    end
endmodule