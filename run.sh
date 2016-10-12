#!/bin/sh
/usr/local/bin/platformio run -t upload
for i in 0 1 2 3 4 5 6 7
do
	screen -S ttyUSB -d -m /dev/ttyUSB$i
done
while true;do
	device=`platformio device list`
	echo "$device" > device.log
	sleep 5s
done
