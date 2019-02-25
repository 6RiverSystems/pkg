#!/bin/bash 

cd examples/express || exit 1

npm install 

export BUILD_CPUS=$(grep -c ^processor /proc/cpuinfo)

node /builder/lib-es5/bin.js --targets node8-linux-amd64,node10-linux-amd64 --build .