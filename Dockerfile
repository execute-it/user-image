FROM alpine:latest

# Server deps
RUN apk add nodejs npm bash

# User programs
RUN apk add gcc g++ python3

RUN apk add make

COPY package.json /server/

WORKDIR /server/

RUN npm i

COPY . /server/

ARG USER=user11
ARG UID=111
ARG GID=111
ARG PW=passgbcibeli
ENV UID=${UID}

RUN adduser --disabled-password -u ${UID} ${USER}

USER ${UID}:${GID}

ENTRYPOINT bash