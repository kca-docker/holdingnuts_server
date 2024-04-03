# Holdingnuts Server <!-- omit in toc -->

HoldingNuts is an open source multi-platform poker server to play the popular Texas Hold'em variant on your own network.

# Content <!-- omit in toc -->

- [Getting Started](#getting-started)
  - [Prerequisities](#prerequisities)
  - [Usage](#usage)
    - [Container Parameters](#container-parameters)
    - [Environment Variables](#environment-variables)
    - [Volumes](#volumes)
    - [Useful File Locations](#useful-file-locations)
  - [Using Podman instead of Docker](#using-podman-instead-of-docker)
  - [Compose-File](#compose-file)
    - [Docker compose](#docker-compose)
    - [Podman compose](#podman-compose)
- [Find Us](#find-us)
- [Contributing](#contributing)
- [Versioning](#versioning)
- [Authors](#authors)
- [License](#license)


# Getting Started

These instructions will cover usage information and for the docker container 

## Prerequisities

In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

## Usage

### Container Parameters

The image could be started by the following command.  

```shell
docker run -d bksolutions/holdingnuts
```

By default the container uses the TCP port 40888 for the HoldingNuts server. 

```shell
docker run -d -p <port>:40888 bksolutions/holdingnuts
```

The HoldingNuts server configuration is stored at `/root/.holdingnuts/server.cfg`.

```shell
docker run -d -v <path>:/root/.holdingnuts:ro bksolutions/holdingnuts
```

### Environment Variables

* `PORT` - The HoldingNuts server uses port 40888 tcp in the standard configuration.

### Volumes

* `/root/.holdingnuts` - Configuration folder

### Useful File Locations

* `/root/.holdingnuts/server.cfg` - HoldingNuts Server configuration file

## Using Podman instead of Docker

If using `podman` Version >=1.9 instead of `docker` it should be possible to use the `auto-update` feature with `systemd`.

First create the container (pod) than run `generate` command. The systemd service files will be created within the same folder.
These .service file(s) should be moved to a systemd folder. 
If the system uses SELinux the new files must be updated with the correct labels. 
Then the systemd daemon must reload the service files.

```shell
$ podman create --name <container_name> \
 -p [host]:8080 \
 -v [host]:/opt/picapport:Z \
 -l "io.containers.autoupdate=registry" \
 -t bksolutions/holdingnuts:latest

$ podman generate systemd --new --name <container_name> --files
$ mv *.service /usr/lib/systemd/
$ restorecon -Rv /usr/lib/systemd/
$ systemctl daemon-reload

$ systemctl start <service> --now
```

## Compose-File

### Docker compose

```yaml
version: "3.8"
services:
  holdingnuts:
    container_name: holdingnuts
    image: docker.io/bksolutions/holdingnuts:latest
    environment:
      - TZ=Europe/Berlin
    volumes:
      - ${PWD}/hn.conf.d:/root/.holdingnuts:Z
```

### Podman compose

```yaml
version: "3.8"
services:
  holdingnuts:
    container_name: holdingnuts
    image: docker.io/bksolutions/holdingnuts:latest
    environment:
      - TZ=Europe/Berlin
    volumes:
      - ${PWD}/hn.conf.d:/root/.holdingnuts:Z
    labels:
      - "PODMAN_SYSTEMD_UNIT=podman-compose@container-holdingnuts.service"
      - "io.containers.autoupdate=registry"
```

# Find Us

* [GitHub](https://github.com/kca-docker/holdingnuts_server)

# Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

# Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the 
[tags on this repository](https://github.com/kca-docker/holdingnuts_server/tags). 

# Authors

* **Briezh Khenloo** - *Project* - [B.Khenloo](https://github.com/KruseCarsten)

See also the list of [contributors](https://github.com/kca-docker/holdingnuts_server/contributors) who 
participated in this project.

# License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
