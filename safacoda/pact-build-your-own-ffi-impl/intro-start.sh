#!/bin/bash
echo "setup node 16"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && source ~/.bashrc && nvm install 16
echo "Downloading pact_ruby_ffi"
echo "=> downloading consumer project"
git clone https://github.com/YOU54F/pact-ruby-ffi
cd pact-ruby-ffi
apt update && \
apt --yes install curl g++ gcc autoconf automake bison libc6-dev \
        libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool \
        libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev \
        libreadline-dev libssl-dev && \
        curl -sSL https://rvm.io/mpapis.asc | gpg --import - && \
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import - && \
curl -sSL https://get.rvm.io | bash -s stable && \
source ~/.rvm/scripts/rvm && rvm install 2.7.6