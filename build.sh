#!/bin/bash
# Dockerfile for jessie based images

apt-get -qy update
apt-get -qy --no-install-suggests --no-install-recommends install \
    ca-certificates \
    curl \
    wget \
    git \
    openssh-client \
    locales \
    procps
rm -rf /var/lib/apt/lists/*
gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
curl -fsSL "$GOSU_DOWNLOAD_URL" -o /usr/bin/gosu
curl -fsSL "${GOSU_DOWNLOAD_URL}.asc" -o /usr/bin/gosu.asc
gpg --verify /usr/bin/gosu.asc
rm -f /usr/bin/gosu.asc
chmod +x /usr/bin/gosu

## ensure locale is set during build
locale-gen "fr_FR.UTF-8"
export LANG="C.UTF-8"
dpkg-reconfigure -fnoninteractive locales <<- EOF
221
2
EOF

exit 0

