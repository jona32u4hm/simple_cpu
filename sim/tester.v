module tester (
    output reg clk,
    output reg reset
);
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Period: 10ns
    end

    initial begin
        reset = 0;        // Reset
        #20 reset = 1;    
        
        // Processor executes ROM
        #1000; 
        
        $display("end of simulation");
        $finish;
    end
endmodule