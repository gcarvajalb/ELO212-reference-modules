"""Serial image loader.

Script for loading and sending images through serial port.

Run using the -i flag to start a python interactive session after running the
script

    $ python -i serial_image_loader.py

Hans Lehnert Merino - UTFSM
Laboratorio de Sistemas Digitales
"""
import serial
import sys
import argparse
from PIL import Image

DEFAULT_IMAGE_SIZE = (512, 384)

# Parse command line arguments. At least a serial port name is needed
parser = argparse.ArgumentParser(
    description='Send and validate commands over serial port.')

parser.add_argument('port', help='serial port name')
parser.add_argument('img', nargs='?', default=None, help='image to load')
parser.add_argument('-b', default=115200, type=int, help='baudrate')
parser.add_argument('-t', nargs=1, default=1, type=float, help='timeout')
parser.add_argument('-p', choices=['O', 'E', 'N'], default='N', help='parity')

args = parser.parse_args(sys.argv[1:])

# Create and open the serial port
serial_port = serial.Serial()
serial_port.port = args.port
serial_port.baudrate = args.b
serial_port.timeout = args.t
serial_port.parity = args.p

serial_port.open()


def load_img(filename, size=DEFAULT_IMAGE_SIZE):
    """Send image data over a serial interface.

    Open and resize and image, and send the serizalized data through the serial
    port.
    """
    # Prepare data to send.
    image = Image.open(filename)
    image = image.convert('RGB')
    image = image.resize(size)

    data = bytes([byte for pixel in image.getdata() for byte in pixel])

    serial_port.write(data)


if args.img is not None:
    load_img(args.img)
