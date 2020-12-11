# Use ubuntu imgae as base
FROM docker.io/ubuntu:18.04

# Install holdingnuts_server from repository
RUN apt-get update && apt-get install -y holdingnuts-server && rm -rf /var/lib/apt/lists/*

# Create configuration folder and add default setup 
RUN mkdir -p /root/.holdingnuts
COPY ./HoldingnutsServerCfg /root/.holdingnuts/server.cfg

# Start holdingnuts_server as entrypoint
ENTRYPOINT "/usr/games/holdingnuts-server"
