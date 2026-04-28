module RAM (
    input   MEM_CONTROL, CLK,
    input   [11:0] MEM_ADDR,
    input   [7:0] MEM_DATA_in,
    output   [7:0] MEM_DATA_out
    );
    // Memory size
    reg [7:0] _memory [0:(1 << 12)-1];

    initial begin 
        //for the simulation, initialize memory using last four digits of student ID 
        _memory[0] = 8'd4; 
        _memory[1] = 8'd0;
        _memory[2] = 8'd8;
        _memory[3] = 8'd3;

        //used in ROM simulation
        _memory['h05] = 8'd4; 
        _memory['h10] = 8'd0;
        _memory['h15] = 8'd8;
        _memory['h25] = 8'd3;

        //used in second ROM simulation
        _memory['h030] = 8'd0; 
        _memory['h031] = 8'd1;
        _memory['h032] = 8'd2;
        _memory['h033] = 8'd3;
        _memory['h034] = 8'd4; 
        _memory['h035] = 8'd5;
        _memory['h036] = 8'd6;
        _memory['h037] = 8'd7;
        _memory['h038] = 8'd8; 
        _memory['h039] = 8'd9;
        _memory['h03a] = 8'd10;
        _memory['h03b] = 8'd11;
        _memory['h03c] = 8'd12;
        _memory['h03d] = 8'd13;
        _memory['h03e] = 8'd14;
        _memory['h03f] = 8'd15;
    end



    assign MEM_DATA_out =  _memory[MEM_ADDR];
    always @(posedge CLK) begin
        if (MEM_CONTROL == 0) begin
            _memory[MEM_ADDR] <= MEM_DATA_in;
        end 
    end

endmodule