#!/bin/bash

echo "Downloading pact_ruby_ffi"
echo "=> downloading consumer project"
git clone -b test --depth 1 --shallow-submodules https://github.com/pact-foundation/pact-plugins
cd examples/gRPC/area_calculator
apt update && \
echo "Installing apt dependencies & golang"
apt --yes install curl g++ gcc autoconf automake bison libc6-dev \
        libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool \
        libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev \
        libreadline-dev libssl-dev jq golang-go \
echo "Installing OpenJDK 11"
mkdir -p /usr/java
cd /usr/java
wget -c https://download.java.net/java/ga/jdk11/openjdk-11_linux-x64_bin.tar.gz
tar -xf openjdk-11_linux-x64_bin.tar.gz \
clear && git checkout test && echo "Welcome. The repo is download, ruby is installed, you are good to go!"