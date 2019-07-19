# Proyecto de deteccion de bordes
	
Desarrollado por Mario Marin y Jaime Guzmán

## Requerimientos

- Una tarjeta Nexys 4 DDR
- Pantalla con puerto VGA
- Cable VGA
- Cable micro USB para programacion/comunicacion serial 

## Configuracion

Una vez programada la tarjeta, se puede utilizar el programa [serial_image_loader](https://github.com/gcarvajalb/ELO212-reference-modules/tree/master/serial_image_loader) para cargar una imagen de dimensiones 512 x 328 a la memoria de la tarjeta.

## Instrucciones

Para aplicar los distintos efectos a la imagen se utilizan los switches:

* Para aplicar el efecto dither se activa el switch SW[0]
	* El switch SW[15] aplica el efecto dither sobre el canal rojo de la imagen
	* El switch SW[14] aplica el efecto dither sobre el canal verde de la imagen
	* El switch SW[13] aplica el efecto dither sobre el canal azul de la imagen

* Para ver la imagen en escala de grises se activa el switch SW[1]

* Para aplicar el efecto de deteccion de bordes se activa el switch SW[2]
