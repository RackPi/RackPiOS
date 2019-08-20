#!/bin/bash

# Copyright 2019 by RackPi
# File:         install.sh
# Description:  Installs all needed software and daemons for RackPi
# Date:         2019-08-20
# Version:      1.1
# Author:       Ediz Turcan <ediz.turcan@gmail.com>
# License:      MIT

if [ "$(whoami)" != "root" ]; then
  echo "Script must be run as root or with sudo"
  exit -1
fi

apt update
apt upgrade -y
apt install wiringpi -y

mkdir temp_rackpi
cd temp_rackpi

wget https://github.com/RackPi/PiLEDlights/releases/download/v1.0/PiLEDlights_v1.0.tar.gz
tar xvfz PiLEDlights_v1.0.tar.gz
cd PiLEDlights
cp * /usr/local/bin/
chmod +x /usr/local/bin/actledPi
chmod +x /usr/local/bin/hddledPi
chmod +x /usr/local/bin/netledPi
cd ..

wget https://raw.githubusercontent.com/RackPi/RackPiOS/master/services/hddled.service
wget https://raw.githubusercontent.com/RackPi/RackPiOS/master/services/netled.service

cp *.service /etc/systemd/system/
systemctl enable hddled.service
systemctl enable netled.service

cd ..
rm -rf temp_rackpi
rm install.sh

echo "dtoverlay=act_led_trigger=heartbeat" >> /boot/config.txt
echo "dtoverlay=pi3-act-led,gpio=26" >> /boot/config.txt
reboot now
