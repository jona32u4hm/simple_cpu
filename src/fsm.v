`include "include/cpu_defines.vh"
`include "include/alu_defines.vh"

module FSM#(
        parameter pALU_WIDTH =  `ALU_OP_WIDTH,      // size of operation bus (2^1)
        parameter pDATA_WIDTH = 8
    )(
        input  CLK, RESET,
        input [7:0] OP_ADDR,
        input [3:0] OPCODE,
        output reg EQUAL, MEM_CONTROL,
        output reg [11:0] PROG_ADDR, MEM_ADDR,
        inout [7:0] MEM_DATA,
        //ALU
        output reg [pALU_WIDTH-1:0]  alu_op,   // (Opcode)
        input  [pDATA_WIDTH-1:0] result, 
        input z_flag,
        //REGFILE 
        input [pDATA_WIDTH-1:0]   data_rs1,
        output reg register_write_enable,
        output reg [pDATA_WIDTH-1:0]   register_data_in  // Data to write
    );

    // states:
    localparam _DECODE     = 2'b0,
               _EXECUTE    = 2'b1;

    reg _state, _next_state;


    initial begin
        MEM_CONTROL <= 1;
    end

    // state machine combinational logic:
    always @(*) begin 

        case (_state)
            _DECODE:  begin
                case(OPCODE) 
                    `CPU_ADD: begin
                        alu_op = `ALU_ADD;
                    end
                    `CPU_SUB, `CPU_CMP: begin
                        alu_op = `ALU_SUB;
                    end
                    `CPU_AND: begin
                        alu_op = `ALU_AND;
                    end
                    `CPU_IOR: begin
                        alu_op = `ALU_IOR;
                    end
                    `CPU_LDR, `CPU_STR: begin
                        MEM_ADDR = OP_ADDR;
                    end
                endcase
                MEM_CONTROL = 1; // read only
                register_write_enable = 0;
                _next_state      = _EXECUTE;
            end
            _EXECUTE: begin
                case(OPCODE) 
                    `CPU_ADD, `CPU_SUB, `CPU_AND, `CPU_IOR: begin
                        register_write_enable = 1; //enable reg write
                        register_data_in = result;
                    end
                    `CPU_LDR: begin
                        register_write_enable = 1; //enable reg write
                        register_data_in = MEM_DATA;
                    end
                    `CPU_STR: MEM_CONTROL = 0; // write
                endcase
                _next_state      = _DECODE;

            end
        endcase
    end 


    // state machine secuential logic:
    always @(posedge CLK) begin //when reset is inactive (1) 
        if (!RESET) begin
        PROG_ADDR   <= 0;
        MEM_ADDR    <= 0;
        EQUAL       <= 0;
        MEM_CONTROL <= 1; // read only
        _next_state      <= _DECODE;
        end else begin
            _state <= _next_state;
            if (_state == _EXECUTE) begin
                PROG_ADDR <= PROG_ADDR + 1; // PC inc
            end else begin
                if (OPCODE == `CPU_ADD || OPCODE == `CPU_CMP || OPCODE == `CPU_SUB || OPCODE == `CPU_AND || OPCODE == `CPU_IOR) begin
                    EQUAL <= z_flag;
                end
            end
        end
    end 
    assign MEM_DATA = (MEM_CONTROL == 1'b0) ? data_rs1 : 8'bz;



endmodule