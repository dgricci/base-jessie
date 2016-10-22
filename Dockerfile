# Dockerfile for jessie based images
FROM debian:jessie
MAINTAINER Didier Richard <didier.richard@ign.fr>

ARG GOSU_VERSION
ENV GOSU_VERSION ${GOSU_VERSION:-1.10}
ARG GOSU_DOWNLOAD_URL
ENV GOSU_DOWNLOAD_URL ${GOSU_DOWNLOAD_URL:-https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64}

RUN \
    apt-get -qy update && \
    apt-get -qy --no-install-suggests --no-install-recommends install \
        ca-certificates \
        curl \
        wget \
        git \
        openssh-client \
        locales \
        procps && \
    rm -rf /var/lib/apt/lists/* && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    curl -fsSL "$GOSU_DOWNLOAD_URL" -o /usr/bin/gosu && \
    curl -fsSL "${GOSU_DOWNLOAD_URL}.asc" -o /usr/bin/gosu.asc && \
    gpg --verify /usr/bin/gosu.asc && \
    rm -f /usr/bin/gosu.asc && \
    chmod +x /usr/bin/gosu

## ensure locale is set during build
#ENV LANG            fr_FR.UTF-8
ENV LANG             C.UTF-8
RUN dpkg-reconfigure locales

# Cf. https://github.com/docker-library/golang/blob/master/1.6/wheezy/Dockerfile
COPY adduserifneeded.sh /usr/local/bin/adduserifneeded.sh

# always launch this when starting a container (and then execute CMD ...)
ENTRYPOINT ["adduserifneeded.sh"]

#
CMD ["/bin/bash"]

