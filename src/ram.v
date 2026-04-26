module RAM (
    input   MEM_CONTROL, CLK,
    input   [11:0] MEM_ADDR,
    input   [7:0] MEM_DATA_in,
    output   [7:0] MEM_DATA_out
    );
    // Memory size
    reg [7:0] _memory [0:(1 << 12)-1];

    initial begin //for the simulation, initialize memory using last four digits of student ID 
        _memory[0] = 8'd4; 
        _memory[1] = 8'd0;
        _memory[2] = 8'd8;
        _memory[3] = 8'd3;

        //used in ROM simulation
        _memory['h05] = 8'd4; 
        _memory['h10] = 8'd0;
        _memory['h15] = 8'd8;
        _memory['h25] = 8'd3;
    end



    assign MEM_DATA_out =  _memory[MEM_ADDR];
    always @(negedge CLK) begin
        if (MEM_CONTROL == 0) begin
            _memory[MEM_ADDR] <= MEM_DATA_in;
        end 
    end

endmodule