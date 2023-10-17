#!/bin/bash

echo "Downloading pact plugins repo"
git clone --depth 1 --shallow-submodules https://github.com/pact-foundation/pact-plugins.git
sudo -E add-apt-repository --yes ppa:longsleep/golang-backports && apt update --yes && \
echo "Installing apt dependencies & golang"
apt --yes install curl g++ gcc autoconf automake bison libc6-dev \
        libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool \
        libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev \
        libreadline-dev libssl-dev jq golang cargo protobuf-compiler && \
echo "Installing OpenJDK 11" && \
mkdir -p /usr/java && \
cd /usr/java && \
wget -c https://download.java.net/java/ga/jdk11/openjdk-11_linux-x64_bin.tar.gz && \
tar -xf openjdk-11_linux-x64_bin.tar.gz && \
export JAVA_HOME="/usr/java/jdk-11" && \
export PATH="/usr/java/jdk-11/bin:${PATH}" && \
clear && cd ~/pact-plugins/examples/gRPC/area_calculator && echo "Welcome. The repo is downloaded, dependencies are installed, you are good to go!"
