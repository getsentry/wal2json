#!/bin/bash

if [ "${DOCKER_ARCH}" = "amd64" ]; then
  BUILD_ARCH="x86_64"
else
  echo "Invalid architecture: ${DOCKER_ARCH}"
  exit 1
fi

make
mv wal2json.so /workspace/wal2json-Linux-$BUILD_ARCH-$LIBC_VERSION.so
