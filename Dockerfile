FROM resin/rpi-raspbian:jessie
MAINTAINER WUTTINAN SUT <wuttinan.wch@gmail.com>
RUN apt-get -y update \
	&& apt-get install -y git python-pip screen\
	&& pip install -U platformio
RUN mkdir -p /root/nodemcu
RUN /bin/bash -c 'echo -e "y\n" | platformio init -d /root/nodemcu --board nodemcuv2'
ADD code/temperature.ino /root/nodemcu/src
ADD run.sh /root/nodemcu
ADD log.sh /root/nodemcu
ADD lib* /root/nodemcu
ADD env/platformio.ini /root/nodemcu
WORKDIR /root/nodemcu
RUN /bin/bash -c 'echo -e "y\n" | platformio run'
CMD ["./run.sh"]
