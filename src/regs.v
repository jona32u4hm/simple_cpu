module REG_FILE #(
        parameter pADDR_WIDTH = 1,      // 2 registers (2^1)
        parameter pDATA_WIDTH = 8
    )(
        input CLK, RESET, write_enable,
        input  [pADDR_WIDTH-1:0]   addr_rs1, // Read addr 1
        input  [pADDR_WIDTH-1:0]   addr_rs2, // Read addr 2
        input  [pADDR_WIDTH-1:0]   addr_rd,  // Write addr
        input  [pDATA_WIDTH-1:0]   data_in,  // Data to write
        output [pDATA_WIDTH-1:0]   data_rs1, // Data to read 1
        output [pDATA_WIDTH-1:0]   data_rs2  // Data to read 2
    );
    reg [pDATA_WIDTH-1:0] _registers [0:(1 << pADDR_WIDTH)-1];

    assign data_rs1 = _registers[addr_rs1];
    assign data_rs2 = _registers[addr_rs2];

    always @(negedge CLK) begin
        if (RESET) begin
            
        end else if (write_enable) begin 
            _registers[addr_rd] <= data_in;
        end
    end
endmodule
