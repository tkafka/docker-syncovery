FROM debian:trixie-slim AS download

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /syncovery \
    && curl -fsSL -o /tmp/syncovery.tar.gz \
        'https://www.syncovery.com/release/SyncoveryCL-x86_64-11.16.4-Web.tar.gz' \
    && tar -xzf /tmp/syncovery.tar.gz --directory /syncovery \
    && chmod +x /syncovery/SyncoveryCL

FROM debian:trixie-slim

ENV SYNCOVERY_HOME=/config

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates libssl3t64 zlib1g \
    && rm -rf /var/lib/apt/lists/*

COPY --from=download /syncovery /syncovery
COPY --chmod=755 ./docker-entrypoint.sh /podman/entrypoint.sh

EXPOSE 8999
EXPOSE 8943

VOLUME "/config"

ENTRYPOINT [ "/podman/entrypoint.sh" ]
