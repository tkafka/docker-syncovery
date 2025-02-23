FROM linuxcontainers/debian-slim

ENV SYNCOVERY_HOME=/config
ENV SETUP_TEMP=/tmp/syncovery.tar.gz

ADD ./docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN apt update && apt upgrade -y
RUN apt install wget libssl-dev ca-certificates -y

RUN mkdir /syncovery && wget -O "$SETUP_TEMP" 'https://www.syncovery.com/release/SyncoveryCL-x86_64-10.16.11-Web.tar.gz' && tar -xvf "$SETUP_TEMP" --directory /syncovery && rm -f "$SETUP_TEMP" && chmod +x /syncovery/SyncoveryCL

EXPOSE 8999
EXPOSE 8943

VOLUME "/config"

RUN ls -la /syncovery
RUN ls -la /
ENTRYPOINT [ "/entrypoint.sh" ]
