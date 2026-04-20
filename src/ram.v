module RAM #(
    parameter pADDR_WIDTH = 12, 
    parameter pDATA_WIDTH = 8   
    )(
    input   MEM_CONTROL,
    input   [pADDR_WIDTH-1:0] MEM_ADDR,
    inout   [pDATA_WIDTH-1:0] MEM_DATA
    );

    initial begin //for the simulation, initialize memory using last four digits of student ID 
        _memory[0] = 8'd4; 
        _memory[1] = 8'd0;
        _memory[2] = 8'd8;
        _memory[3] = 8'd3;
    end

    // Memory size
    reg [pDATA_WIDTH-1:0] _memory [0:(1 << pADDR_WIDTH)-1];


    assign MEM_DATA = (MEM_CONTROL == 1'b1)? _memory[MEM_ADDR] : pDATA_WIDTH'bz ;
    always @(*) begin
        if (MEM_CONTROL == 0) begin
            _memory[MEM_ADDR] <= MEM_DATA;
        end 
    end

endmodule