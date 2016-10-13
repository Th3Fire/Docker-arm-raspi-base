FROM resin/rpi-raspbian:jessie
MAINTAINER WUTTINAN SUT <wuttinan.wch@gmail.com>
RUN apt-get -y update \
	&& apt-get install -y git python-pip screen\
	&& pip install -U platformio
RUN mkdir -p /root/nodemcu
WORKDIR /root/nodemcu
RUN /bin/bash -c 'echo -e "y\n" | platformio init --board nodemcuv2'
RUN /bin/bash -c 'echo -e "y\n" | platformio lib -g install https://github.com/milesburton/Arduino-Temperature-Control-Library/archive/3.7.6.zip'
RUN /bin/bash -c 'echo -e "y\n" | platformio lib -g install https://github.com/PaulStoffregen/OneWire/archive/v2.3.2.zip'
ADD code/temperature.ino /root/nodemcu/src
ADD run.sh /root/nodemcu
ADD log.sh /root/nodemcu
ADD env/platformio.ini /root/nodemcu
RUN /bin/bash -c 'echo -e "y\n" | platformio run'
CMD ["./run.sh"]
