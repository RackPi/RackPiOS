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

button = Button(3)
jumper = DigitalInputDevice(24)

def shutdown():
    call("sudo shutdown -h now", shell=True)

while True:
    if not button.is_pressed and jumper.value:
        shutdown()
        break