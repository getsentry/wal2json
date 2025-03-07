FROM postgres:14-alpine as build
RUN apk add --no-cache --virtual .build-deps gcc git make musl-dev pkgconf diffutils clang llvm
COPY . /wal2json
WORKDIR /wal2json
RUN make && make install

FROM postgres:14-alpine
COPY --from=build /usr/local/lib/postgresql/wal2json.so /usr/local/lib/postgresql/
COPY /docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
