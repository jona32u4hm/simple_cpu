
TB = sim/testbench.v
OUT = build/salida.out

RAM_TB = sim/ram_tb.v
RAM_OUT = build/ram_salida.out


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