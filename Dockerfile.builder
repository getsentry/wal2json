ARG DOCKER_ARCH=amd64

# Used to build the wal2json library in a GHA. This image should 
# almost never change. We do not need to build it every time.
# We would mount the working directory with the source (that's the
# part that changes) and run the build process on a running container

FROM $DOCKER_ARCH/postgres:9.6-alpine
RUN apk add --no-cache --virtual .build-deps gcc git make musl-dev pkgconf diffutils

WORKDIR /wal2json
