#!/bin/bash

echo "Downloading pact_ruby_ffi"
echo "=> downloading consumer project"
git clone https://github.com/YOU54F/pact-ruby-ffi
cd pact-ruby-ffi
echo "setup ruby 2.7.6"
apt update && \
apt --yes install curl g++ gcc autoconf automake bison libc6-dev \
        libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool \
        libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev \
        libreadline-dev libssl-dev jq && \
        curl -sSL https://rvm.io/mpapis.asc | gpg --import - && \
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import - && \
curl -sSL https://get.rvm.io | bash -s stable && \
source /etc/profile.d/rvm.sh && rvm install 2.7.6 && \
clear && echo "Welcome. The repo is download, ruby is installed, you are good to go!"