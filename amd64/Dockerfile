FROM node:10

WORKDIR /builder

COPY . /builder
RUN npm install && npm run-script prepare

RUN amd64/build-node.sh

FROM node:10-alpine
RUN apk --no-cache add curl tar ca-certificates bluez-dev ruby-dev ruby-rake ruby-rdoc libffi-dev make bash gcc g++ python bash &&\
    gem update --no-rdoc --system &&\
    gem install  --no-document fpm etc &&\
    apk del ruby-rdoc
WORKDIR /root/
COPY --from=0 /root/.pkg-cache /root/.pkg-cache
COPY --from=0 /builder/ /builder
