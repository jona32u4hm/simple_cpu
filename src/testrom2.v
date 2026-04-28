`include "inc/cpu.vh"


module ROM(
    input [11:0] PROG_ADDR,
    output reg   AB_SELECT, 
    output reg  [7:0] OP_ADDR,
    output reg  [3:0] OPCODE
    );

localparam  LDR = `CPU_LDR,
            STR = `CPU_STR,
            ADD = `CPU_ADD,
            SUB = `CPU_SUB,
            AND = `CPU_AND,
            IOR = `CPU_IOR,
            CMP = `CPU_CMP,
            NOP = 0,
            A   =  1'b0,
            B   =  1'b1;

 always @(*) begin
        case(PROG_ADDR)
            //load register
            12'h000: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, A, 8'h00}; 
            12'h001: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h31};
            12'h002: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, A, 8'h30}; 
            12'h003: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h32};
            12'h004: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h31}; 
            12'h005: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h31};
            12'h006: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, B, 8'h30}; 
            12'h007: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h32};
            12'h008: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h31}; 
            12'h009: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, B, 8'h30};
            12'h008: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h33}; 
            12'h009: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h34}; 
            12'h00a: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h35}; 
            12'h00b: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h36}; 
            12'h00c: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, A, 8'h30}; 
            12'h00d: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, A, 8'h30}; 
            12'h00e: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, A, 8'h30}; 
            12'h00f: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, A, 8'h30}; 
            //store
            12'h010: {OPCODE, AB_SELECT, OP_ADDR} = {STR, A, 8'h40}; 
            12'h011: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h30}; 
            12'h012: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, A, 8'h40}; 
            12'h013: {OPCODE, AB_SELECT, OP_ADDR} = {STR, A, 8'h41}; 
            12'h014: {OPCODE, AB_SELECT, OP_ADDR} = {STR, A, 8'h42}; 
            12'h015: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h41}; 
            12'h016: {OPCODE, AB_SELECT, OP_ADDR} = {STR, B, 8'h43}; 
            12'h017: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h37}; 
            12'h018: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, B, 8'h43}; 
            12'h019: {OPCODE, AB_SELECT, OP_ADDR} = {STR, B, 8'h44}; 
            12'h01a: {OPCODE, AB_SELECT, OP_ADDR} = {STR, B, 8'h45}; 
            12'h01b: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h44}; 
            12'h01c: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, A, 8'h30}; 
            12'h01d: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, A, 8'h30}; 
            12'h01e: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, A, 8'h30}; 
            //add and sub (compare used sparingly)
            12'h01f: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h30}; 
            12'h020: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h35}; 
            12'h021: {OPCODE, AB_SELECT, OP_ADDR} = {ADD, B, 8'h30}; 
            12'h022: {OPCODE, AB_SELECT, OP_ADDR} = {ADD, A, 8'h30}; 
            12'h023: {OPCODE, AB_SELECT, OP_ADDR} = {CMP, A, 8'h30}; //equal
            12'h024: {OPCODE, AB_SELECT, OP_ADDR} = {ADD, B, 8'h30}; 
            12'h025: {OPCODE, AB_SELECT, OP_ADDR} = {CMP, A, 8'h30}; 
            12'h026: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h30}; 
            12'h027: {OPCODE, AB_SELECT, OP_ADDR} = {SUB, A, 8'h30}; //not equal
            12'h028: {OPCODE, AB_SELECT, OP_ADDR} = {ADD, A, 8'h30}; // equal
            12'h029: {OPCODE, AB_SELECT, OP_ADDR} = {SUB, A, 8'h30}; 
            12'h02a: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h3f}; 
            12'h02b: {OPCODE, AB_SELECT, OP_ADDR} = {ADD, A, 8'h30}; 
            12'h02c: {OPCODE, AB_SELECT, OP_ADDR} = {ADD, B, 8'h30}; 
            12'h02d: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h33}; 
            12'h02e: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h33}; 
            12'h02f: {OPCODE, AB_SELECT, OP_ADDR} = {SUB, A, 8'h30}; //equal 
            12'h030: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h33}; 
            12'h031: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h32}; 
            12'h032: {OPCODE, AB_SELECT, OP_ADDR} = {SUB, B, 8'h30}; 
            12'h033: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, B, 8'h30}; 
            12'h034: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, B, 8'h30}; 
            12'h035: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, A, 8'h30}; 
            //and & or
            12'h036: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h35}; 
            12'h037: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h3a}; 
            12'h038: {OPCODE, AB_SELECT, OP_ADDR} = {IOR, A, 8'h30}; 
            12'h039: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, A, 8'h30}; 
            12'h03a: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h3a}; 
            12'h03b: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h35}; 
            12'h03c: {OPCODE, AB_SELECT, OP_ADDR} = {AND, B, 8'h30}; 
            12'h03d: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, B, 8'h30}; 
            12'h03e: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h3a}; 
            12'h03f: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h3f}; 
            12'h040: {OPCODE, AB_SELECT, OP_ADDR} = {AND, A, 8'h30}; 
            12'h041: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, A, 8'h30}; 
            12'h042: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h3a}; 
            12'h043: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h3e}; 
            12'h044: {OPCODE, AB_SELECT, OP_ADDR} = {IOR, B, 8'h30}; 
            12'h045: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, B, 8'h30}; 
            12'h046: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, B, 8'h30}; 
            12'h047: {OPCODE, AB_SELECT, OP_ADDR} = {NOP, B, 8'h30}; 
            // CMP
            12'h048: {OPCODE, AB_SELECT, OP_ADDR} = {CMP, B, 8'h30}; 
            12'h049: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h30}; 
            12'h04a: {OPCODE, AB_SELECT, OP_ADDR} = {ADD, A, 8'h30}; 
            12'h04b: {OPCODE, AB_SELECT, OP_ADDR} = {CMP, A, 8'h30}; 
            12'h04c: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, B, 8'h3f}; 
            12'h04d: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h3e}; 
            12'h04e: {OPCODE, AB_SELECT, OP_ADDR} = {CMP, B, 8'h30}; 
            12'h04f: {OPCODE, AB_SELECT, OP_ADDR} = {LDR, A, 8'h3f}; 
            12'h050: {OPCODE, AB_SELECT, OP_ADDR} = {CMP, A, 8'h3f}; 



            default: {OPCODE, AB_SELECT, OP_ADDR} = 13'h0;
        endcase
    end


endmodule