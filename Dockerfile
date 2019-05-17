FROM postgres:9.6-alpine

RUN apk add --no-cache --virtual .build-deps gcc git make musl-dev pkgconf
COPY . /wal2json
RUN cd wal2json && make && make install && rm -rf wal2json

COPY /docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
