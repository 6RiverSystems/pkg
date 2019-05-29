FROM node:10

WORKDIR /builder

COPY . /builder
RUN npm install && npm run-script prepare

RUN mkdir -p ~/.pkg-cache/ && wget https://github.com/robertsLando/pkg-binaries/raw/master/arm64/fetched-v10.4.1-alpine-arm64 -O ~/.pkg-cache/fetched-v10.4.1-alpine-arm64

FROM node:10-alpine
RUN apk --no-cache add curl tar ca-certificates bluez-dev ruby-dev ruby-rake ruby-rdoc libffi-dev make bash gcc g++ python bash &&\
    gem update --no-rdoc --system &&\
    gem install  --no-document fpm etc &&\
    apk del ruby-rdoc
WORKDIR /root/
COPY --from=0 /.pkg-cache/ /.pkg-cache
COPY --from=0 /builder/ /builder
