#!/bin/bash 

cd examples/express || exit 1

npm install 

node /builder/lib-es5/bin.js --build .