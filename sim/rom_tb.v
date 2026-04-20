`timescale 1ns/1ps

module ROM_tb;

    // ROM I/O
    reg  [11:0] PROG_ADDR;
    wire        AB_SELECT;
    wire [7:0]  OP_ADDR;
    wire [3:0]  OPCODE;

    // ROM Instance
    ROM uut (
        .PROG_ADDR(PROG_ADDR),
        .AB_SELECT(AB_SELECT),
        .OP_ADDR(OP_ADDR),
        .OPCODE(OPCODE)
    );


    initial begin

        $dumpfile("rom_test.vcd");
        $dumpvars(0, ROM_tb);

        // Monitor automatically prints whenever a value changes...
        $monitor("Time=%0t | Addr=%h | Opcode=%h | AB=%b | OpAddr=%h", 
                 $time, PROG_ADDR, OPCODE, AB_SELECT, OP_ADDR);

        // Test Step 0
        PROG_ADDR = 12'h000;
        #10; // Wait 10ns

        // Test Step 1
        PROG_ADDR = 12'h001;
        #10;

        // Test Step 2
        PROG_ADDR = 12'h002;
        #10;

        // Test an address that doesn't exist (should trigger 'default')
        PROG_ADDR = 12'hFFF;
        #10;

        $finish; // End the simulation
    end

endmodule