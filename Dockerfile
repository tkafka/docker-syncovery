FROM centos:latest

ENV SYNCOVERY_HOME=/config
ENV SETUP_TEMP=/tmp/syncovery.tar.gz

ADD ./docker-entrypoint.sh /podman/entrypoint.sh

# https://techglimpse.com/failed-metadata-repo-appstream-centos-8/
RUN pushd /etc/yum.repos.d/ && sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && popd
RUN yum update -y

RUN yum -y install wget openssl-devel
RUN mkdir /syncovery && wget -O "$SETUP_TEMP" 'https://www.syncovery.com/release/SyncoveryCL-x86_64-10.14.3-Web.tar.gz' && tar -xvf "$SETUP_TEMP" --directory /syncovery && rm -f "$SETUP_TEMP" && chmod +x /syncovery/SyncoveryCL && chmod +x /podman/entrypoint.sh

EXPOSE 8999
EXPOSE 8943

VOLUME "/config"

ENTRYPOINT [ "/podman/entrypoint.sh" ]
