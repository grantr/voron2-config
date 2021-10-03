#!/bin/bash

set -xeuo pipefail

rm -f .config
ln -s pi.config .config
make clean
make -j5
sudo systemctl stop klipper_mcu
sudo cp out/klipper.elf /usr/local/bin
sudo systemctl start klipper_mcu

rm -f .config
ln -s spider-v1.config .config
make clean
make -j5
sudo systemctl stop klipper
scripts/flash-sdcard.sh /dev/ttyACM0 fysetc-spider-v1
sudo systemctl start klipper

# TODO QT Py

rm -f .config
