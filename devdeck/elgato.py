import argparse
import leglight

parser = argparse.ArgumentParser()
parser.add_argument('operation', choices=['toggle', 'plus', 'minus'])
args = parser.parse_args()

myLight = leglight.LegLight('192.168.1.240', 9123)

def toggle():
  if bool(myLight.info()['on']):
    myLight.off()
  else:
    myLight.on()

def plus():
  brightness = myLight.info()['brightness']
  if brightness < 100:
    myLight.incBrightness(min(5, 100-brightness))

def minus():
  brightness = myLight.info()['brightness']
  if brightness > 0:
    myLight.decBrightness(min(5, brightness))

if args.operation == 'toggle':
  toggle()
elif args.operation == 'plus':
  plus()
elif args.operation == 'minus':
  minus()
