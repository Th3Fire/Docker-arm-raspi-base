#!/bin/sh
/usr/local/bin/platformio run -t upload

while true;do
	device=`platformio device list`
	echo "$device" > device.log
	sleep 5s
done
