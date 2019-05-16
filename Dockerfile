FROM postgres:9.6

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        git \
        postgresql-server-dev-9.6 && \
    rm -rf /var/lib/apt/lists/*

COPY . /wal2json

RUN cd wal2json && make && make install && rm -rf wal2json

COPY /docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
