#!/bin/sh
data=''
log=''
count=0
mkdir -p logs/all
while true; do
        for i in 0 1 2 3
        do
                count=`sudo timeout 2 cat -u /dev/ttyUSB$i 2>/dev/null | wc -l`
		#echo "$count \n"
		if [ $count != "0" ]
		then
			datetime=`date +%Y-%m-%d:%H:%M:%S`
			data=`timeout 2 cat /dev/ttyUSB$i`
			echo "$datetime : $data" > logs/log_last_ttyUSB$i.log
			echo "$datetime : $data" >> logs/all/log_ttyUSB$i.log
			log=`head -n 1 logs/log_last_ttyUSB$i.log`

               		echo "$log\n"
		else
			echo "Can't connect ttyUSB$i\n"
		fi
        done
	echo "========================= \n"
done

