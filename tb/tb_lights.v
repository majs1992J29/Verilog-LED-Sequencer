/*
Nombre del archivo: tb_lights.v
Descripción: 
Se presentan 3 casos de prueba para verificar el funcionamiento del
coche fantástico
- 1 Caso de prueba: Verificacion del registro de desplazamiento de 7 Bits
- 2 Caso de prueba: Verificacion del Reset sincrono
- 3 Caso de prueba: Verificacion del Enable 
*/

`timescale 1ns/1ps

module tb_lights ();
	localparam T = 2;
	
	reg               CLK, RST_n;
	reg               ENABLE;
	wire  [7:0] oLED1;
	// Instanciación del DUT (Device Under Test)
	lights #(.Cuenta(10)) l1 (   .iCLK(CLK),
                                .iRST_n(RST_n),
                                .iENABLE(ENABLE),
                                .oLED(oLED1));
										  
initial
		 begin
//Caso 1:  Coche fantastico 
			  CLK =1'b0;
			  $display("Inicio Caso 1");
			  $display("Precondiciones");
			  RST_n = 1'b0;
			  
			  ENABLE = 1'b0;
			  #(T*2)
			  $display("Acciones");
			  RST_n = 1'b1;
			  #(T*2)
			  ENABLE = 1'b1;
			  #(T*700)
			  $display("PostCondiciones");
			  ENABLE = 1'b0;
			  #(T*2)
			  RST_n = 1'b0;
			  #(T*2)
			  $display("Fin Caso 1");
			  //Caso 2:  Reset
			  $display("Inicio Caso 2");
			  $display("Precondiciones");
			  RST_n = 1'b0;
			  ENABLE = 1'b0;
			  #(T*2)
			  $display("Acciones");
			  RST_n = 1'b1;
			  #(T*2)
			  ENABLE = 1'b1;
			  #(T*100)
			  RST_n = 1'b0;
			  #(T*20)
			  RST_n = 1'b1;
			  #(T*150)
			  RST_n = 1'b0;
			  #(T*20)
			  	RST_n = 1'b1;
			  #(T*250)
			  $display("PostCondiciones");
			  ENABLE = 1'b0;
			  #(T*2)
			  RST_n = 1'b0;
			  #(T*2)
			  $display("Fin Caso 2");
			  //Caso 3:  Enable
			  $display("Inicio Caso 3");
			  $display("Precondiciones");
			  RST_n = 1'b0;
			  ENABLE = 1'b0;
			  #(T*2)
			  $display("Acciones");
			  RST_n = 1'b1;
			  #(T*2)
			  ENABLE = 1'b1;
			  #(T*100)
			  ENABLE = 1'b0;
			  #(T*20)
			  ENABLE = 1'b1;
			  #(T*150)
			  ENABLE = 1'b0;
			  #(T*20)
			  ENABLE = 1'b1;
			  #(T*250)
			  $display("PostCondiciones");
			  ENABLE = 1'b0;
			  #(T*2)
			  RST_n = 1'b0;
			  #(T*2)
			  $display("Fin Caso 3");
			  $display("Fin Simulacion!!!");
			  $stop;

		 end
	always
		 begin
			  #(T/2) CLK <= ~CLK;
		 end

 
endmodule