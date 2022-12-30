FROM centos:latest

ENV SYNCOVERY_HOME=/config
ENV SETUP_TEMP=/tmp/syncovery.tar.gz

ADD ./docker-entrypoint.sh /podman/entrypoint.sh

RUN yum -y install wget openssl-devel
RUN mkdir /syncovery && \
    wget -O "$SETUP_TEMP" 'https://www.syncovery.com/release/SyncoveryCL-x86_64-9.49i-Web.tar.gz' && \
    tar -xvf "$SETUP_TEMP" --directory /syncovery && \
    rm -f "$SETUP_TEMP" && \
    chmod +x /syncovery/SyncoveryCL && \
    chmod +x /podman/entrypoint.sh
    
EXPOSE 8999
EXPOSE 8943

VOLUME "/config" 

ENTRYPOINT [ "/podman/entrypoint.sh" ]
