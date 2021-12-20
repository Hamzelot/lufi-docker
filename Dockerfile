FROM alpine/git AS git

RUN git clone https://framagit.org/fiat-tux/hat-softwares/lufi.git --depth 1 /lufi && \
rm -r /lufi/.git

FROM debian:bullseye-slim

LABEL org.opencontainers.image.authors="dirk@reher.me"
LABEL reher.pro.version="1.1"
LABEL reher.pro.release-date="18.12.2021"
LABEL org.label-schema.build-date=$BUILD_DATE

RUN apt-get update \
	&& apt-get install --no-install-recommends -y \
	libpq-dev \
	build-essential \
	libssl-dev \
	gosu \
	libio-socket-ssl-perl \
	curl \
	liblwp-protocol-https-perl \
	zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN cpan Carton

COPY --from=git /lufi /usr/lufi

WORKDIR /usr/lufi

RUN carton install --deployment --without=test --without=postgresql --without=mysql --without=ldap --without=htpasswd --without=swift-storage

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
ENV LIMIT_FILE_DESTROY_DAYS 0
ENV URL_PREFIX "/"
ENV FORCE_BURN_AFTER_READING 0
ENV X_FRAME "DENY"
ENV X_CONTENT_TYPE "nosniff"
ENV X_XSS_PROTECTION "1; mode=block"
ENV KEEP_IP_DURING 365
ENV WORKER 30
ENV CLIENTS 1
ENV DISABLE_MAIL_SENDING 1
ENV UID=1000
ENV GID=1000

COPY lufi.conf .
COPY docker-entrypoint.sh .

RUN chmod u+x docker-entrypoint.sh

VOLUME ["/usr/lufi/files"]

CMD ["carton", "exec", "hypnotoad", "/usr/lufi/script/lufi"]

ENTRYPOINT ["/usr/lufi/docker-entrypoint.sh"]

HEALTHCHECK CMD curl --fail http://127.0.0.1:8081/ || exit 1
EXPOSE 8081
