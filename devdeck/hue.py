import argparse
from phue import Bridge

parser = argparse.ArgumentParser()
parser.add_argument('operation', choices=['toggle', 'plus', 'minus'])
args = parser.parse_args()

b = Bridge('192.168.1.241')
b.connect()

def toggle():
  if b.get_light(1, 'on') and b.get_light(4, 'on'):
    b.set_light([1, 4], 'on', False)
  else:
    b.set_light([1, 4], 'on', True)

def plus(lamp):
  brightness = b.get_light(lamp, 'bri')
  b.set_light(lamp, 'bri', min(brightness + 25, 254))

def minus(lamp):
  brightness = b.get_light(lamp, 'bri')
  b.set_light(lamp, 'bri', max(brightness - 25, 0))

if args.operation == 'toggle':
  toggle()
elif args.operation == 'plus':
  plus(1)
  plus(4)
elif args.operation == 'minus':
  minus(1)
  minus(4)
