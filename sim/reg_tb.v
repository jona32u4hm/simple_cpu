`timescale 1ns/1ps

module reg_file_tb;
    parameter ADDR_WIDTH = 1;
    parameter DATA_WIDTH = 8;

    // REGFILE I/O
    reg CLK, write_enable;
    reg  [ADDR_WIDTH-1:0] addr_rs1, addr_rs2, addr_rd;
    reg  [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_rs1, data_rs2;

    // Instance
    REG_FILE uut (
        .CLK(CLK),
        .write_enable(write_enable),
        .addr_rs1(addr_rs1),
        .addr_rs2(addr_rs2),
        .addr_rd(addr_rd),
        .data_in(data_in),
        .data_rs1(data_rs1),
        .data_rs2(data_rs2)
    );

    // (100MHz aprox)
    always #5 CLK = ~CLK;

    initial begin
        // GTKwave
        $dumpfile("reg_file_test.vcd");
        $dumpvars(0, reg_file_tb);

        // Initialize
        CLK = 0;
        write_enable = 0;
        addr_rs1 = 0; addr_rs2 = 1; // only two regs anyway
        addr_rd = 0;
        data_in = 0;
        #15 
        
        $display("--- Test Register File ---");

        // write reg A
        @(posedge CLK); 
        write_enable = 1;
        addr_rd = 1'b0; 
        data_in = 8'hA5; //value to write
        #10;
        write_enable = 0;
        $display("Wrote A: %h | Out RS1: %h", data_in, data_rs1);

        // Write reg B
        @(posedge CLK);
        write_enable = 1;
        addr_rd = 1'b1;
        data_in = 8'h3C; // value to write
        #10;
        write_enable = 0;
        $display("Wrote B: %h | Out RS2: %h", data_in, data_rs2);

        data_in = 8'h26; // value to write (shouldnt be written because write is disabled)
        $display("Write disbled, tried B: %h | Out RS2: %h should be different", data_in, data_rs2);
        // Simultaneous read
        #10;
        if (data_rs1 == 8'hA5 && data_rs2 == 8'h3C)
            $display("SUCCESS: Correct reading of A y B.");
        else
            $display("FAIL: Wrong data. A:%h B:%h", data_rs1, data_rs2);
            

        #20;
        $finish;
    end
endmodule