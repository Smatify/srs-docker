FROM ubuntu:bionic

# Update system
RUN apt update \
    && apt full-upgrade -y \
    && apt install -y sudo build-essential software-properties-common

# Add ffmpeg repository and install it
RUN add-apt-repository ppa:jonathonf/ffmpeg-4 \
    && apt update \
    && apt install -y ffmpeg

RUN apt install -y git python

RUN git clone https://github.com/ossrs/srs.git /srs

RUN cd /srs/ \
    && git fetch && git checkout 2.0release

RUN mkdir -p /srs/trunk/objs

RUN cd /srs/trunk \
    && ./configure --without-nginx --without-hds --without-hls --without-stream-caster --without-ffmpeg --without-utest --without-ssl --without-research --without-gperf --without-arm-ubuntu12 \
    && make

COPY config /srs/trunk/conf
COPY docker/docker-entrypoint.sh /srs

RUN chmod +x /srs/docker-entrypoint.sh

RUN mkdir -p /srs/trunk/logs

EXPOSE 1935

ENTRYPOINT ["/srs/docker-entrypoint.sh"]
CMD [ "master" ]

