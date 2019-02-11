#!/bin/bash 

cd /app || exit 1 

find ./node_modules/ -type f -name "*.node"
echo "## Check for .node files to include in executable folder"

mapfile -t TO_INCLUDE < <(find ./node_modules/ -type f -name "*.node")

echo "TO INCLUDE ${TO_INCLUDE[*]}"
TOTAL_INCLUDE=${#TO_INCLUDE[@]}


echo "## Found $TOTAL_INCLUDE files to include"

PKG_FOLDER=pkg_folder
mkdir -p ${PKG_FOLDER}

i=0

node /builder/lib-es5/bin.js package.json -t node10-linux --out-path ${PKG_FOLDER}

while [ "$i" -lt "$TOTAL_INCLUDE" ]
do
  IFS='/' path=(${TO_INCLUDE[$i]})
  echo "${TO_INCLUDE[$i]}"
  file=${path[-1]}
  echo "## Copying $file to $PKG_FOLDER folder"
  cp "${TO_INCLUDE[$i]}" "./$PKG_FOLDER"
  let "i = $i + 1"
done

VERSION="$(node -p "require('./package.json').version")"
NAME="$(node -p "require('./package.json').name" |  rev | cut -d/ -f1 | rev)"

fpm -s dir -t deb -n "${NAME}" -v "${VERSION}" ./${PKG_FOLDER}/=/opt/mfp_cli/