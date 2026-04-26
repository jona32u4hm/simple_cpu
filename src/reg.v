module REG_FILE (
        input CLK, 
        input  select, write_enable,
        input  [7:0]   data_in,  // Data to write
        output [7:0]   data_r1, // Data to read 1
        output [7:0]   data_r2  // Data to read 2
    );
    reg [7:0] _registers [0:1];


    assign data_r1 = _registers[select];
    assign data_r2 = _registers[!select];

    always @(negedge CLK) begin
        if (write_enable) begin 
            _registers[select] <= data_in;
        end
    end

endmodule