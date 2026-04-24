module tester (
    output reg clk,
    output reg reset
);
    // Generador de Reloj (Frecuencia de 100MHz simulada)
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de 10ns
    end

    // Secuencia de Reset y Fin de Simulación
    initial begin
        reset = 0;        // Iniciamos en Reset
        #20 reset = 1;    // Soltamos Reset tras 2 ciclos
        
        // Dejamos que el procesador corra por un tiempo
        #1000; 
        
        $display("Simulacion finalizada a los %t", $time);
        $finish;
    end
endmodule