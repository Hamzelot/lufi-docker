FROM debian:buster

MAINTAINER Dirk Reher <dirk@reher.me>

USER root

RUN apt update \
	&& apt install -y \
	sqlite \
	curl \
	libmojo-sqlite-perl \
	libpq-dev \
	git \
	build-essential \
	libssl-dev \
	libio-socket-ssl-perl \
	liblwp-protocol-https-perl \
	&& apt-get clean -y

RUN cpan Carton

RUN git clone https://framagit.org/fiat-tux/hat-softwares/lufi.git --depth 1
WORKDIR /lufi

RUN carton install --deployment --without=test --without=postgresql --without=mysql --without=ldap --without=htpasswd
RUN mkdir -p /files/database

COPY lufi.conf /lufi/
COPY run.sh .

VOLUME ["/files"]

CMD /bin/bash run.sh

ENV contact "<a href= "example.com">here</a>"
ENV report "abc@example.com"
ENV site_name "lufi"
ENV url_length 4
ENV max_file_size 104857600
ENV max_delay 0
ENV use_proxy 0

HEALTHCHECK CMD curl --fail http://127.0.0.1:8081/ || exit 1
