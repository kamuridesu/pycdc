FROM debian:11-slim
RUN apt update
RUN apt install -y python3 cmake make build-essential
WORKDIR /build
COPY . .
RUN cmake .
RUN make

FROM python:3-slim as pycdc
WORKDIR /app
COPY --from=0 /build/pycdc /usr/bin/
ENTRYPOINT [ "pycdc" ]

FROM python:3-slim as pycdas
WORKDIR /app
COPY --from=0 /build/pycdas /usr/bin/
ENTRYPOINT [ "pycdas" ]

