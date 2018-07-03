Juego PONG, desarrollado por: Mario Marin

Requerimientos: 
	-2 tarjetas Nexys 4 DDR
	-1 pantalla 1080p VGA
	-2 jumpers largos (o cables compatibles con conector pmod)
	
Configuración:
	Una de las tarjetas sera cargada con el .bit "Maestro". Esta tarjeta controlará el monitor VGA y toda la logica del juego,
	ademas de proporcionar el mando del jugador 1.
	La otra tarjeta sera cargada con el .bit "Cliente", el cual corresponde al mando del jugador 2. Los movimientos en la tarjeta cliente
	e envian por comunicacion serial a la tarjeta maestra, actualizando el estado de la pantalla.
	
	Conetar el jumper de la siguiente manera:
	
		+-------------------------------------------+                    +-----------------------------------------+
		|                                           |                    |                                         |
		|              FPGA CLIENTE                 |                    |              FPGA MAESTRO               |
		|                                           |                    |                                         |
		|                                           |                    |                                         |
		|                                           |                    |                                         |
		|                                           |                    |                                         |
		|                                   PMOD JA |                    | PMOD JD                                 |
		|                                 +---------+      JUMPER        +---------+                               |
		|                                 |       1 +--------------------+ 1       |                               |
		|                                 |       2 +--------------------+ 2       |                               |
		|                                 |       3 |                    | 3       |                               |
		|                                 |       4 |                    | 4       |                               |
		|                                 |       5 |                    | 5       |                               |
		|                                 |       6 |                    | 6       |                               |
		|                                 +---------+                    +---------+                               |
		|                                           |                    |                                         |
		|                                           |                    |                                         |
		|                                           |                    |                                         |
		|                                           |                    |                                         |
		+-------------------------------------------+                    +-----------------------------------------+


Instrucciones:
	Las barras (Paddles) de cada jugador son controladas usando el acelerómetro integrado en la tarjeta de desarrollo.
	
	El objetivo del juego es lograr que la bola (cuadrado) que se mueve en pantalla llege al extremo de la pantalla del oponente.
	
	El puntaje del juego es desplegado en los LED de la tarjeta Maestra, donde los LED[7:0] corresponden a el puntaje del jugador 1,
	y los LED[15:8] corresponden a el puntaje del jugador 2.