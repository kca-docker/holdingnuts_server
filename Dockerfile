# Use ubuntu imgae as base
FROM docker.io/ubuntu:18.04

ARG VERSION="0.0.0.0"
ARG CREATED="RFC 3339 date-time"
ARG REVISION="sourceID"

## Fix information
LABEL org.opencontainers.image.url="https://hub.docker.com/r/bksolutions/holdingnuts" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/bksolutions/holdingnuts" \
      org.opencontainers.image.source="https://github.com/kca-docker/holdingnuts_server" \
      org.opencontainers.image.title="Holdingnuts" \
      org.opencontainers.image.description="Texas Hold'em Poker Server" \
      org.opencontainers.image.authors="bksolutions"

## 
LABEL org.opencontainers.image.revision="${REVISION}" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.created="${CREATED}" 


# Install holdingnuts_server from repository
RUN apt-get update && apt-get install -y holdingnuts-server && rm -rf /var/lib/apt/lists/*

# Create configuration folder and add default setup 
RUN mkdir -p /root/.holdingnuts
COPY ./HoldingnutsServerCfg /root/.holdingnuts/server.cfg

# Start holdingnuts_server as entrypoint
ENTRYPOINT "/usr/games/holdingnuts-server"
