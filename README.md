# Introduction

This is the unofficial Syncovery docker image, it's been compiled and prepared @ https://hub.docker.com/r/hlince/syncovery

This fork builds Syncovery 11.16.4 with the Web GUI for `linux/amd64`, using `debian:trixie-slim` (Debian 13) as its base. A separate download stage keeps download tools out of the final image; only CA certificates, OpenSSL, SQLite, and zlib runtime packages are installed.

# Upgrade the image

1. Update the syncovery version in `Dockerfile` script with a filename from [syncovery linux page](https://www.syncovery.com/syncovery11linux/) - look for `64-bit Intel (with Web GUI)` in `.tar.gz` section.
2. Build and tag with syncovery version: `docker build --platform linux/amd64 -t tomaskafka/syncovery:11.16.4-x86_64 .`
3. Add the major-version, latest, and plain aliases (all currently `linux/amd64`):
   ```
   docker tag tomaskafka/syncovery:11.16.4-x86_64 tomaskafka/syncovery:11-x86_64
   docker tag tomaskafka/syncovery:11.16.4-x86_64 tomaskafka/syncovery:latest-x86_64
   docker tag tomaskafka/syncovery:11.16.4-x86_64 tomaskafka/syncovery:11.16.4
   docker tag tomaskafka/syncovery:11.16.4-x86_64 tomaskafka/syncovery:11
   docker tag tomaskafka/syncovery:11.16.4-x86_64 tomaskafka/syncovery:latest
   ```
4. And push:

   ```
   docker push tomaskafka/syncovery:11.16.4-x86_64
   docker push tomaskafka/syncovery:11-x86_64
   docker push tomaskafka/syncovery:latest-x86_64
   docker push tomaskafka/syncovery:11.16.4
   docker push tomaskafka/syncovery:11
   docker push tomaskafka/syncovery:latest
   ```

   Or

   `docker push --all-tags tomaskafka/syncovery`

5. Go check on [tomaskafka/syncovery](https://hub.docker.com/repository/docker/tomaskafka/syncovery)
6. On the NAS, stop the existing container and back up its `/config` directory. Update the image tag to `tomaskafka/syncovery:11.16.4-x86_64`, pull it, and recreate the container with the existing volume mounts and ports. Check the version, license, and profiles in the Web GUI before resuming scheduled syncs.

# Usage

After accessing the interface the the user name is `default` and the password is `pass`.

# Docker-Compose Sample

The following sample is running against an unraid host. For other hosts it'll work the same but you'll likely want to change the mounts.

```
version: '2.2'
services:
  syncovery:
    cpu_shares: 256
    restart: unless-stopped
    image: tomaskafka/syncovery:11.16.4-x86_64
    volumes:
    - /mnt:/mnt
    - /boot:/boot
    - /mnt/user/appdata/syncovery:/config
    - /mnt/user/tmp/syncovery:/tmp
    ports:
    - 8999:8999
    - 8943:8943

```

Run Command docker-compose up -d
Go to http://your-docker-host:8999
Use the username default and the password pass

# Volume Mounts

You can mount any volumes you want to work with however this container needs one specific mount to store its configuration. Please mount a volume @ `/config` for persistent configuration.
