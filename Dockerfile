FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

# apt update
RUN apt update

# Nginx and executeit dependencies
RUN apt install -y nginx bind9 sudo

# General Utilities
RUN apt install -y curl wget nano vim git

# User programs
RUN apt install -y --no-install-recommends gcc g++ python3 python3-pip python python openjdk-8-jdk openjdk-8-jre

WORKDIR /home/user/


ARG USER=user
ARG UID=111
ARG GID=111
ENV UID=${UID}
ENV GID=${GID}
ENV USER=${USER}

# Create a user non-root for remote terminal
RUN adduser --disabled-password -u ${UID} ${USER}
RUN adduser ${USER} sudo

# Copy addon files
COPY image-addon-files/.bashrc /home/
COPY image-addon-files/setup.sh /home/
COPY image-addon-files/nginx.conf /etc/nginx/
COPY image-addon-files/502.html /usr/share/nginx/html/
COPY image-addon-files/sudoers /etc/

# Remote User restrictions

# Don't allow bashrc modification (deletion is allowed)
RUN chmod 444 /home/.bashrc

RUN chown -R user /home/user/
RUN chmod +x /home/setup.sh

EXPOSE 80

ENTRYPOINT sleep infinity
