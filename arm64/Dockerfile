FROM arm64v8/node:10.4.1-stretch

COPY arm64/qemu/bin/  /usr/bin/

WORKDIR /builder

COPY . /builder
RUN npm install && npm run-script prepare

RUN mkdir -p ~/.pkg-cache/ && wget https://github.com/robertsLando/pkg-binaries/raw/master/arm64/fetched-v10.4.1-alpine-arm64 -O ~/.pkg-cache/uploaded-v2.5-node-v10.4.1-linux-arm64

RUN apt-get update &&\
    apt-get install -y\
    libffi-dev \
    libbluetooth-dev \
    ruby \
    ruby-dev \
    rubygems &&\
    gem install --no-ri --no-rdoc rake && \
    gem install --no-ri --no-rdoc fpm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
