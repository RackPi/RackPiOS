#!/usr/bin/python

# Copyright 2019 by RackPi
# File:         RackPiPower.py
# Description:  Service for shutting down Raspberry Pi inside a RackPi
# Date:         2019-04-04
# Version:      1.0
# Author:       Ediz Turcan <ediz.turcan@icloud.com>
# License:      MIT

from gpiozero import Button, DigitalInputDevice
from subprocess import call

# Connect button and LED for boot/shutdown activity on GPIO3
button = Button(3)

# Connect a short-circuit between GPIO 24 and 3V (e.g. pin 17+18)
jumper = DigitalInputDevice(24)

def shutdown():
    call("sudo shutdown -h now", shell=True)

# Shutdown is only called when jumper is set (to be sure it's a rackpi)
# and button is not pressed (because it's a switch)
while True:
    if not button.is_pressed and jumper.value:
        shutdown()
        break
