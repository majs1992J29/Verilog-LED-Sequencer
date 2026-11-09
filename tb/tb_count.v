/*

Nombre del archivo: tb_count.v
Descripción: 
Se presentan 4 casos de prueba para verificar el funcionamiento del
contador parametrizable fijando los valores de fin_cuenta a 20 y 
periodo igual a 20.
- 1 Caso de prueba: Verificacion del contador ascendente
- 2 Caso de prueba: Verificacion del contador descendente
- 3 Caso de prueba: Verificacion del Reset sincrono
- 4 Caso de prueba: Verificacion del Enable 

Unit Under Test (UUT): Simulacion
*/

`timescale 1ns/1ps

module tb_count ();
	localparam T = 20;
	
	reg               CLK, RST_n;
	reg               ENABLE, UP_DOWN;
	wire    [ 4:0]    COUNT;
	wire              TC;


	count_param #(.fin_cuenta(20)) CONT( .iCLK(CLK),
												  .iRST_n(RST_n),
												  .iENABLE(ENABLE),
												  .iUP_DOWN(UP_DOWN),
												  .oCOUNT(COUNT),
												  .oTC(TC));
	
 
	initial
		 begin
			  CLK = 1'b0;
		 //Caso 1:  Contador Sincrono Ascendente
			  $display("Inicio Caso 1");
			  $display("Precondiciones");
			  RST_n = 1'b0;
			  
			  ENABLE = 1'b0;
			  UP_DOWN = 1'b1;
			  #(T*2)
			  $display("Acciones");
			  RST_n = 1'b1;
			  #(T*2)
			  ENABLE = 1'b1;
			  #(T*22)
			  $display("PostCondiciones");
			  ENABLE = 1'b0;
			  #(T*2)
			  RST_n = 1'b0;
			  #(T*2)
			  $display("Fin Caso 1");
			//  $stop;
		//Caso 2:  Contador Sincrono Descendente
			  $display("Inicio Caso 2");
			  $display("Precondiciones");
			  RST_n = 1'b0;
			  ENABLE = 1'b0;
			  UP_DOWN = 1'b0;
			  #(T*2)
			  $display("Acciones");
			  RST_n = 1'b1;
			  #(T*2)
			  ENABLE = 1'b1;
			  #(T*22)
			  $display("PostCondiciones");
			  ENABLE = 1'b0;
			  #(T*2)
			  RST_n = 1'b0;
			  #(T*2)
			  $display("Fin Caso 2");
			 // $stop;
		//Caso 3:  Reset
			  $display("Inicio Caso 3");
			  $display("Precondiciones");
			  RST_n = 1'b0;
			  ENABLE = 1'b0;
			  UP_DOWN = 1'b1;
			  #(T*2)
			  $display("Acciones");
			  RST_n = 1'b1;
			  #(T*2)
			  ENABLE = 1'b1;
			  #(T*2)
			  RST_n = 1'b0;
			  #(T*4)
			  UP_DOWN = 1'b0;
			  #(T*4)
			  RST_n = 1'b1;
			  #(T*2)
			  RST_n = 1'b0;
			  #(T*4)
			  UP_DOWN = 1'b1;
			  #(T*2)
			  RST_n = 1'b1;
			  #(T*2)
			  $display("PostCondiciones");
			  ENABLE = 1'b0;
			  #(T*2)
			  RST_n = 1'b0;
			  #(T*2)
			  $display("Fin Caso 3");
			  
			  //Caso 4:  Enable
			  $display("Inicio Caso 3");
			  $display("Precondiciones");
			  RST_n = 1'b0;
			  ENABLE = 1'b0;
			  UP_DOWN = 1'b1;
			  #(T*2)
			  $display("Acciones");
			  RST_n = 1'b1;
			  #(T*2)
			  ENABLE = 1'b1;
			  #(T*4)
			  ENABLE = 1'b0;
			  #(T*2)
			  UP_DOWN = 1'b0;
			  #(T)
			  ENABLE = 1'b1;
			  #(T*2)
			  ENABLE = 1'b0;
			  #(T*2)
			  $display("PostCondiciones");
			  ENABLE = 1'b0;
			  #(T*2)
			  RST_n = 1'b0;
			  #(T*2)
			  $display("Fin Caso 4");
			  $stop;
			 			 	 
		 end
	always
		 begin
			  #(T/2) CLK <= ~CLK;
		 end

 
endmodule
