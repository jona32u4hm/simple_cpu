
TB = sim/testbench.v
OUT = build/salida.out

RAM_TB = sim/ram_tb.v
RAM_OUT = build/ram_salida.out

ROM_TB = sim/rom_tb.v
ROM_OUT = build/rom_salida.out

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