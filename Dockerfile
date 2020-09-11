FROM alpine:latest

# Server deps
RUN apk add nodejs npm bash make grep

# User programs
RUN apk add gcc g++ py3-pip python3 curl py-pip python2 nano vim git

WORKDIR /home/user/


ARG USER=user
ARG UID=111
ARG GID=111
ENV UID=${UID}
ENV GID=${GID}
ENV USER=${USER}

# Create a user non-root for remote terminal
RUN adduser --disabled-password -u ${UID} ${USER}

# Copy addon files
COPY image-addon-files/.bashrc /home/${USER}/

# Remote User restrictions

# Don't allow bashrc modification (deletion is allowed)
RUN chmod 444 /home/${USER}/.bashrc

USER user

ENTRYPOINT bash
