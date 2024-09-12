#!/bin/bash

echo "Installing apt dependencies"
apt --yes install jq maven && \
echo "setup node 20" && \
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash && source ~/.bashrc && nvm install 20 && \
echo "Installing OpenJDK 11" && \
mkdir -p /usr/java && \
cd /usr/java && \
wget -c https://download.java.net/java/ga/jdk11/openjdk-11_linux-x64_bin.tar.gz && \
tar -xf openjdk-11_linux-x64_bin.tar.gz && \
export JAVA_HOME="/usr/java/jdk-11" && \
export PATH="/usr/java/jdk-11/bin:${PATH}" && \
cd ~ && \
clear && echo "Welcome. The repo is downloaded, dependencies are installed, you are good to go."