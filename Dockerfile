FROM alpine/git AS git

RUN git clone https://framagit.org/fiat-tux/hat-softwares/lufi.git --depth 1 /lufi && \
rm -r /lufi/.git

FROM debian:bullseye-slim

LABEL org.opencontainers.image.authors="dirk@reher.me"
LABEL reher.pro.version="1.1"
LABEL reher.pro.release-date="18.12.2021"
LABEL org.label-schema.build-date=$BUILD_DATE

ARG UID=5666
ARG GID=5666

RUN apt-get update \
	&& apt-get install --no-install-recommends -y \
	libpq-dev \
	build-essential \
	libssl-dev \
	libio-socket-ssl-perl \
	curl \
	liblwp-protocol-https-perl \
	zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN cpan Carton

COPY --from=git /lufi /lufi

WORKDIR /lufi

RUN carton install --deployment --without=test --without=postgresql --without=mysql --without=ldap --without=htpasswd --without=swift-storage

RUN mkdir -p /files/database

COPY lufi.conf /lufi/
COPY run.sh .

RUN groupadd -g $GID -o lufi && \
    useradd -g $GID -r lufi -g lufi && \
	chown -R lufi:lufi /lufi && \
	chown -R lufi:lufi /files && \
	chmod -R 700 /lufi && \
	chmod -R 600 /files && \
	chmod u+x $(find /files -type d) &&\
	chmod 500 run.sh 
	
USER lufi

VOLUME ["/files"]

CMD ./run.sh

ENV CONTACT_HTML "<a href= 'example.com'>here</a>"
ENV REPORT_EMAIL "abc@example.com"
ENV SITE_NAME "lufi"
ENV URL_LENGTH 4
ENV MAX_FILE_SIZE 104857600
ENV MAX_DEALY 0
ENV USE_PROXY 0
ENV ALLOW_PWD 1
ENV THEME "default"
ENV PROVIS_STEP 5
ENV PROVISIONING 100
ENV TOKEN_LENGTH 32
ENV PIWIK_IMAGE_TRACKER ""
ENV BROADCAST_MESSAGE ""
ENV LIMIT_FILE_DESTROY_DAYS 0
ENV URL_PREFIX "/"
ENV FORCE_BURN_AFTER_READING 0
ENV X_FRAME "DENY"
ENV X_CONTENT_TYPE "nosniff"
ENV X_XSS_PROTECTION "1; mode=block"
ENV KEEP_IP_DURING 365

HEALTHCHECK CMD curl --fail http://127.0.0.1:8081/ || exit 1
