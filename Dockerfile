FROM nginx:alpine

# Server deps
RUN apk add nodejs npm bash make grep

# User programs
RUN apk add gcc g++ py3-pip python3 curl py-pip python2 nano vim git

RUN apk add bind

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
COPY image-addon-files/.bashrc /home/
COPY image-addon-files/setup.sh /home/
COPY image-addon-files/nginx.conf /etc/nginx/
COPY image-addon-files/502.html /usr/share/nginx/html/

# Remote User restrictions

# Don't allow bashrc modification (deletion is allowed)
RUN chmod 444 /home/.bashrc

RUN chown -R user /home/user/

EXPOSE 80

ENTRYPOINT sleep infinity
