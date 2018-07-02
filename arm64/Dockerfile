FROM arm64v8/node:8.11-stretch

COPY qemu/bin/  /usr/bin/

WORKDIR /builder

COPY . /builder
RUN npm install && npm run-script prepare

RUN arm64/build_node.sh
