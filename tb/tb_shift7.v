/*
Nombre del archivo: tb_shift7.v
Descripción: desplazamiento de 7 bits
Se presentan 3 casos de prueba para verificar el funcionamiento del
registro de desplazamiento de 7 Bits
- 1 Caso de prueba: Verificacion del registro de desplazamiento de 7 Bits
- 2 Caso de prueba: Verificacion del Reset sincrono
- 3 Caso de prueba: Verificacion del Enable 
*/

`timescale 1ns/1ps

module tb_shift7 ();
	localparam T = 20;
	
	reg               CLK, RST_n;
	reg               ENABLE, iSerial;
	wire    [ 6:0]    oParalelo;
	wire              oSerial;

	// Instanciación del DUT (Device Under Test)
	shift7 i1 (   .iCLK(CLK),
					  .iRST_n(RST_n),
					  .iENABLE(ENABLE),
					  .iSR(iSerial),
					  .oSR(oSerial),
					  .oPR(oParalelo));

 
	initial
		 begin
			  CLK = 1'b0;
			  //Caso 1:  Funcionamiento Registro Desplazamiento
			  $display("Inicio Caso 1");
			  $display("Precondiciones");
			  RST_n = 1'b0;
			  ENABLE = 1'b0;
			  iSerial = 1'b1;
			  #(T*2)
			  $display("Acciones");
			  RST_n = 1'b1;
			  #(T*2)
			  ENABLE = 1'b1;
			  //Desplazamiento de 7 1s en 7T
			  #(T*7)
			  iSerial = 1'b0;
			  //Desplazamiento de 7 0s en 7T
			  #(T*7)
			  iSerial = 1'b1;
			  #(T*2)
			  //Desplazamiento de 2 1s en 2T
			  iSerial = 1'b0;
			  #(T*8)
			  //Desplazamiento de 8 0s en 2T
			  $display("PostCondiciones");
			  ENABLE = 1'b0;
			  #(T*2)
			  RST_n = 1'b0;
			  #(T*2)
			  $display("Fin Caso 1");
			  //Caso 2:  Funcionamiento del Reset
			  $display("Inicio Caso 2");
			  $display("Precondiciones");
			  RST_n = 1'b0;
			  ENABLE = 1'b0;
			  iSerial = 1'b1;
			  #(T*2)
			  $display("Acciones");
			  RST_n = 1'b1;
			  #(T*2)
			  ENABLE = 1'b1;
			  //Desplazamiento de 7 1s en 7T
			  #(T*7)
			 RST_n = 1'b0;
			  #(T*2)
			  iSerial = 1'b0;
			  #(T*2)
			  iSerial = 1'b1;
			  #(T*2)
			  $display("PostCondiciones");
			  ENABLE = 1'b0;
			  #(T*2)
			  RST_n = 1'b0;
			  #(T*2)
			  $display("Fin Caso 2");
			  //Caso 3:  Funcionamiento del Enable
			  $display("Inicio Caso 3");
			  $display("Precondiciones");
			  RST_n = 1'b0;
			  ENABLE = 1'b0;
			  iSerial = 1'b1;
			  #(T*2)
			  $display("Acciones");
			  RST_n = 1'b1;
			  #(T*2)
			  ENABLE = 1'b1;
			  //Desplazamiento de 7 1s en 7T
			  #(T*7)
			  ENABLE = 1'b0;
			  #(T*2)
			  iSerial = 1'b0;
			  #(T*2)
			  ENABLE = 1'b1;
			  //Desplazamiento de 7 0s en 7T
			  #(T*7)
			  ENABLE = 1'b0;
			  #(T*2)
			  iSerial = 1'b1;
			  #(T*2)
			  $display("Fin Caso 3");
			  $stop;

		 end
	always
		 begin
			  #(T/2) CLK <= ~CLK;
		 end

 
endmodule
