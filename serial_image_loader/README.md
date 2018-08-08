# serial_image_loader.py

Script para envío de imágenes por interfaz serial

## Dependencias

Para ejecutar este script se requieren los siguientes paquetes:

* Pillow
* pyserial

### Instalación con pipenv

Para crear un ambiente virtual e instalar los paquetes necesarios ocupe el siguiente comando dentro de esta carpeta

```
$ pipenv install
```

Si no tiene instalado el paquete pipenv, lo puede hacer utilizando pip

```
$ pip3 install pipenv
```

### Instalación con pip (no recomendado)

Si no desea utilizar un ambiente virtual puede instalar las depencias directamente con pip

```
$ pip3 install Pillow pyserial
```

## Utilización

```
$ python3 serial_image_loader.py <port> <file>
```

Si se utiliza un ambiente virtual, recordar ejecutarlo dentro de éste

```
$ pipenv run python serial_image_loader.py <port> <file>
```

o

```
$ pipenv shell
$ python3 serial_image_loader.py <port> <file>
```

Para más información acerca del uso, ejecutar el script con la opción `-h`
