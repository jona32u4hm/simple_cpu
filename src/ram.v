module RAM #(
    parameter pADDR_WIDTH = 12, 
    parameter pDATA_WIDTH = 8   
    )(
    input   [pADDR_WIDTH-1:0] MEM_ADDR,
    output  [pDATA_WIDTH-1:0] MEM_DATA
    );

    // Memory size
    reg [pDATA_WIDTH-1:0] _memory [0:(1 << pADDR_WIDTH)-1];

    always @(*) begin 
        if (MEM_CONTROL == 0) begin //store in memory
            _memory[MEM_ADDR] <= MEM_DATA;
        end else begin // load from memory
            MEM_DATA = _memory[MEM_ADDR];
        end
    end

endmodule