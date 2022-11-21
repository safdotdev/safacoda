#!/bin/bash

echo "=> Downloading pact-python-ffi"
git clone https://github.com/YOU54F/pact-python-ffi
cd ~/pact-python-ffi
echo "setup python 3.10"
apt update && \
apt --yes install jq && \
clear && echo "Welcome. The repo is download, ruby is installed, you are good to go!"