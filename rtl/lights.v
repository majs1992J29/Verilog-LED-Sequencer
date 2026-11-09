/*
Nombre del archivo: lights.v
El módulo lights representa una unidad de control diseñada para supervisar 
y gestionar un conjunto de luces LED. Para lograr esta funcionalidad, hace 
uso de dos módulos auxiliares: shift7 y count_param. El patrón de iluminación
de las luces LED se define a partir de los valores de una señal de salida 
llamada oParalelo, generada por el módulo shift7. Este último módulo, a su vez, 
depende de una señal de salida generada por el módulo count_param para habilitar 
o deshabilitar su funcionamiento. En conjunto, estos módulos permiten controlar 
y sincronizar las luces LED de acuerdo con los valores de entrada y parámetros configurados.

Entradas:
-iCLK: señal de reloj que controla todo los módulos.
-iRST_n: señal de reinicio síncrona con alta prioridad y se activa a nivel bajo, 
			en todos los módulos.
-iENABLE: señal que habilita o deshabilita un módulo auxiliar "count_param"

Salidas:
-oLED: es la salida del módulo y representa un registro de 8bits que controla las luces LED.

Wire(señal interna): 
-TC1: señal que marcar el final del proceso de conteo, y su estado se determina 
		en función del valor configurado en el parámetro "Cuenta".
-oParalelo: es una señal de 7 bits que proviene del módulo shift7 y representa un 
				registro paralelo que se utiliza para controlar las luces LED.
-oSerial: señal de registro y desplazamiento inversa generada por el módulo shift7. 

*/


module lights(iCLK,iRST_n,iENABLE,oLED);

	parameter Cuenta = 12500000;

	input iCLK, iRST_n, iENABLE;
	output reg  [7:0] oLED;
	wire TC1;
	wire [6:0] oParalelo;
	wire oSerial;
	
	// Instanciación del DUT (Device Under Test)
	count_param #(.fin_cuenta(Cuenta)) CONTADOR 
	(    .iCLK(iCLK),
		  .iRST_n(iRST_n),
		  .iENABLE(iENABLE),
		  .iUP_DOWN(1'b1),
		  .oCOUNT(),
		  .oTC(TC1)
	);
	
	
	// Instanciación del DUT (Device Under Test)
	shift7 REGISTRO 
	(    .iCLK(iCLK),
		  .iRST_n(iRST_n),
		  .iENABLE(TC1),
		  .iSR(~oSerial),
		  .oSR(oSerial),
		  .oPR(oParalelo)
   );
	
	always @(oParalelo)
		begin
			case (oParalelo)
				7'b0000000 : oLED = 8'b10000000;//1	
				7'b1000000 : oLED = 8'b01000000;//2
				7'b1100000 : oLED = 8'b00100000;//3
				7'b1110000 : oLED = 8'b00010000;//4
				7'b1111000 : oLED = 8'b00001000;//5
				7'b1111100 : oLED = 8'b00000100;//6
				7'b1111110 : oLED = 8'b00000010;//7
				7'b1111111 : oLED = 8'b00000001;//8
				7'b0111111 : oLED = 8'b00000010;//9
				7'b0011111 : oLED = 8'b00000100;//10
				7'b0001111 : oLED = 8'b00001000;//11
				7'b0000111 : oLED = 8'b00010000;//12
				7'b0000011 : oLED = 8'b00100000;//13
				7'b0000001 : oLED = 8'b01000000;//14	
				
			default
				oLED = 8'b00000000;
		endcase
		end
		
endmodule
