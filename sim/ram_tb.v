`timescale 1ns/1ps

module ram_tb;
    // RAM I/O
    reg         MEM_CONTROL;
    reg  [11:0] MEM_ADDR;
    reg [7:0]  DRIVE_MEM_DATA;
    wire [7:0]  MEM_DATA;

    // RAM Instance
    RAM uut (
        .MEM_CONTROL(MEM_CONTROL),
        .MEM_ADDR(MEM_ADDR),
        .MEM_DATA(MEM_DATA)
    );

assign MEM_DATA = (MEM_CONTROL == 0) ? DRIVE_MEM_DATA : 8'bz;

    initial begin
        // GTKwave
        $dumpfile("ram_test.vcd");
        $dumpvars(0, ram_tb);

        // initialization
        MEM_CONTROL = 1; 
        MEM_ADDR = 0;
        DRIVE_MEM_DATA = 8'bz; 
        
        #10;
        // TEST 1: Read addr 0 and 1
        MEM_ADDR = 12'd0; #10; $display("Data @ addr 0: %d", MEM_DATA);
        MEM_ADDR = 12'd1; #10; $display("Data @ addr 1: %d", MEM_DATA);

        // TEST 2: Write
        MEM_CONTROL = 0;
        MEM_ADDR = 12'hABC;
        DRIVE_MEM_DATA = 8'h26; 
        #10; 
        DRIVE_MEM_DATA = 8'bz; 

        // TEST 3: Verify by reading
        MEM_CONTROL = 1;
        #10;
        if (MEM_DATA == 8'h26) $display("write successful!");
        else $display("fail: expected 26, obtained %h", MEM_DATA);

        #10;
        // TEST 1: Read addr 0 and 1
        MEM_ADDR = 12'd0; #10; $display("Data @ addr 0: %d", MEM_DATA);
        MEM_ADDR = 12'd1; #10; $display("Data @ addr 1: %d", MEM_DATA);
        #20;
        $finish;
    end
endmodule