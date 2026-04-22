
TB = sim/testbench.v
OUT = build/output.out

RAM_TB = sim/ram_tb.v
RAM_OUT = build/ram.out

ROM_TB = sim/rom_tb.v
ROM_OUT = build/rom.out

REG_TB = sim/reg_tb.v
REG_OUT = build/reg.out

ALU_TB = sim/alu_tb.v
ALU_OUT = build/alu.out

all: sim

sim:
	@mkdir -p build
	iverilog -o $(OUT) $(TB)
	vvp $(OUT)
	gtkwave resultados.vcd

syn:
	@mkdir -p build
	yosys -s syn/synth.ys

ram_test:
	@mkdir -p build
	iverilog -o $(RAM_OUT) $(RAM_TB) src/ram.v
	vvp $(RAM_OUT)
	gtkwave ram_test.vcd

rom_test:
	@mkdir -p build
	iverilog -o $(ROM_OUT) $(ROM_TB) src/rom.v 
	vvp $(ROM_OUT) 
	gtkwave rom_test.vcd

reg_test:
	@mkdir -p build
	iverilog -o $(REG_OUT) $(REG_TB) src/regs.v
	vvp $(REG_OUT)
	gtkwave reg_file_test.vcd


alu_test:
	@mkdir -p build
	iverilog -o $(ALU_OUT) $(ALU_TB) src/alu.v
	vvp $(ALU_OUT)
	gtkwave alu_test.vcd