`timescale 1ns/1ps
`include "include/aludefines.vh"
module alu_tb;
    parameter ALU_WIDTH =  `ALU_OP_WIDTH;      // size of operation bus (2^1)
    parameter DATA_WIDTH = 8;
    
    // ALU I/O
    reg  [DATA_WIDTH-1:0] operand_1, operand_2;
    reg  [ALU_WIDTH-1:0]  alu_op; // (Opcode)
    wire [DATA_WIDTH-1:0] result;
    wire z_flag;

    // Instance
    ALU uut (
        .operand_1(operand_1),
        .operand_2(operand_2),
        .alu_op(alu_op),
        .result(result),
        .z_flag(z_flag)
    );

    // mapping:
    localparam _ADD    = `ALU_ADD,
               _SUB    = `ALU_SUB,
               _AND    = `ALU_AND, 
               _OR     = `ALU_OR, 
               _BYPASS = `ALU_BYPASS;




    initial begin

        // GTKwave
        $dumpfile("alu_test.vcd");
        $dumpvars(0, alu_tb);

        //test operations:

        alu_op = _ADD;

        operand_1 = 0; operand_2 = 0;
        #5
        $display("%d + %d = %d", operand_1, operand_2, result);
        $display("result is zero? %h", z_flag);
        #15 
        operand_1 = 3; operand_2 = 4;
        #5
        $display("%d + %d = %d", operand_1, operand_2, result);
        $display("result is zero? %h", z_flag);
        #15 
        operand_1 = 4; operand_2 = 3;
        #5
        $display("%d + %d = %d (commutative)", operand_1, operand_2, result);
        $display("result is zero? %h", z_flag);
        #15 
        operand_1 = 200; operand_2 = 30;
        #5
        $display("%d + %d = %d", operand_1, operand_2, result);
        $display("result is zero? %h", z_flag);
        #15 
        operand_1 = 128; operand_2 = 128;
        #5
        $display("%d + %d = %d (overflow)", operand_1, operand_2, result);
        $display("result is zero? %h", z_flag);
        #15 

        alu_op = _SUB;

        operand_1 = 0; operand_2 = 0;
        #5
        $display("%d - %d = %d", operand_1, operand_2, result);
        #15 
        operand_1 = 3; operand_2 = 4;
        #5
        $display("%d - %d = %d wraps arround", operand_1, operand_2, result);
        #15 
        operand_1 = 4; operand_2 = 3;
        #5
        $display("%d - %d = %d", operand_1, operand_2, result);
        #15 
        operand_1 = 64; operand_2 = 64;
        #5
        $display("%d - %d = %d", operand_1, operand_2, result);
        $display("result is zero? %h", z_flag);
        #15 
        operand_1 = 65; operand_2 = 64;
        #5
        $display("%d - %d = %d", operand_1, operand_2, result);
        $display("result is zero? %h", z_flag);
        #15 


        alu_op = _AND;

        operand_1 = 0; operand_2 = 0;
        #5
        $display("____________");
        $display("%b", operand_1);
        $display("&&&&&&&&");
        $display("%b", operand_2);
        $display("========");
        $display("%b", result);
        $display("result is zero? %h", z_flag);
        #15 
        operand_1 = 8'b01100101; operand_2 = 8'b00110110;
        #5
        $display("____________");
        $display("%b", operand_1);
        $display("&&&&&&&&");
        $display("%b", operand_2);
        $display("========");
        $display("%b", result);
        $display("result is zero? %h", z_flag);
        #15 
        operand_1 = 8'b11100001; operand_2 = 8'b00010110;
        #5
        $display("____________");
        $display("%b", operand_1);
        $display("&&&&&&&&");
        $display("%b", operand_2);
        $display("========");
        $display("%b", result);
        $display("result is zero? %h", z_flag);
        #15 

        alu_op = _OR;

        operand_1 = 0; operand_2 = 0;
        #5
        $display("____________");
        $display("%b", operand_1);
        $display("||||||||");
        $display("%b", operand_2);
        $display("========");
        $display("%b", result);
        $display("result is zero? %h", z_flag);
        #15 
        operand_1 = 8'b01100101; operand_2 = 8'b00110110;
        #5
        $display("____________");
        $display("%b", operand_1);
        $display("||||||||");
        $display("%b", operand_2);
        $display("========");
        $display("%b", result);
        $display("result is zero? %h", z_flag);
        #15 
        operand_1 = 8'b11100001; operand_2 = 8'b00010110;
        #5
        $display("____________");
        $display("%b", operand_1);
        $display("||||||||");
        $display("%b", operand_2);
        $display("========");
        $display("%b", result);
        $display("result is zero? %h", z_flag);
        #15 
        
        alu_op = _BYPASS;
        operand_1 = 0; operand_2 = 0;
        #5
        $display("%d , %d ...  bypass result= %d", operand_1, operand_2, result);
        $display("result is zero? %h", z_flag);
        #15 
        operand_1 = 5; operand_2 = 4;
        #5
        $display("%d , %d ...  bypass result= %d", operand_1, operand_2, result);
        $display("result is zero? %h", z_flag);
        #15 
        operand_1 = 8; operand_2 = 8;
        #5
        $display("%d , %d ...  bypass result= %d", operand_1, operand_2, result);
        $display("result is zero? %h", z_flag);
        #15 
        operand_1 = 0; operand_2 = 1;
        #5
        $display("%d , %d ...  bypass result= %d", operand_1, operand_2, result);
        $display("result is zero? %h", z_flag);
        #15 
        operand_1 = 10; operand_2 = 0;
        #5
        $display("%d , %d ...  bypass result= %d", operand_1, operand_2, result);
        $display("result is zero? %h", z_flag);
        #15 


        #20;
        $finish;

    end
endmodule
