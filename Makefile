
TB = sim/testbench.v
OUT = build/salida.out

all: sim

sim:
	@mkdir -p build
	iverilog -o $(OUT) $(TB)
	vvp $(OUT)
	gtkwave resultados.vcd

syn:
	@mkdir -p build
	yosys -s syn/synth.ys