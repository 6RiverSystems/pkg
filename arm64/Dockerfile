FROM arm64v8/node:10

WORKDIR /builder

COPY . /builder
RUN npm install && npm run-script prepare

RUN amd64/build_node.sh


FROM arm64v8/node:10-alpine

COPY arm64/qemu/bin/  /usr/bin/

RUN apk --no-cache add curl tar ca-certificates ruby-dev ruby-rake ruby-rdoc libffi-dev make bash gcc g++ python bash &&\
    gem update --no-rdoc --system &&\
    gem install  --no-document fpm etc &&\
    apk del ruby-rdoc
WORKDIR /root/
COPY --from=0 /root/.pkg-cache /root/.pkg-cache
COPY --from=0 /builder/ /builder