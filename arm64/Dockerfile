FROM arm64v8/node:10.4.1-stretch

COPY arm64/qemu/bin/  /usr/bin/

WORKDIR /builder

COPY . /builder
RUN npm install && npm run-script prepare

RUN arm64/build_node.sh
