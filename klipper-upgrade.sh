#!/bin/bash

set -xeuo pipefail

pushd $(dirname "${BASH_SOURCE[0]}")/klipper

rm -f .config
ln -s pi.config .config
make clean
make -j5
sudo systemctl stop klipper_mcu
sudo scripts/flash-linux.sh
sudo systemctl start klipper_mcu

rm -f .config
ln -s spider-v1.config .config
make clean
make -j5
sudo systemctl stop klipper
scripts/flash-sdcard.sh /dev/ttyACM0 fysetc-spider-v1
sudo systemctl start klipper

# ERCF (Qt Py SAMD21, requires double clicking reset button. LED will light red then green)
#rm -f .config
#ln -s qtpy.config .config
#make clean
#make -j5
#sudo systemctl stop klipper
#make flash FLASH_DEVICE=/dev/ttyACM1

rm -f .config
popd
