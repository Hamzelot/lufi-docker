FROM debian
USER root

RUN apt-get update && \
apt-get install -y sqlite curl libmojo-sqlite-perl libpq-dev git build-essential libssl-dev libio-socket-ssl-perl liblwp-protocol-https-perl && \
apt-get clean -y
RUN cpan Carton

RUN git clone https://framagit.org/fiat-tux/hat-softwares/lufi.git
WORKDIR \lufi

RUN carton install --deployment --without=test --without=postgresql --without=mysql --without=ldap --without=htpasswd
RUN mkdir -p /files/database

COPY lufi.conf /lufi/
COPY run.sh .

RUN chmod +x run.sh

VOLUME ["/files"]

CMD /bin/bash run.sh

ENV contact "<a href= "example.com">here</a>"
ENV report "abc@example.com"
ENV site_name "lufi"
ENV url_length 8
ENV max_file_size 104857600
ENV max_delay 0

HEALTHCHECK CMD curl --fail http://127.0.0.1:8081/ || exit 1
