#!/bin/bash

echo "Installing Pact CLI Tools"
echo "=> downloading Pact CLI Tools"
os='linux-x86_64'
tag=$(basename $(curl -fs -o/dev/null -w %{redirect_url} https://github.com/pact-foundation/pact-ruby-standalone/releases/latest))
filename="pact-${tag#v}-${os}.tar.gz"
standalone_download_path=https://github.com/pact-foundation/pact-ruby-standalone/releases/download/${tag}/${filename}
echo "from ${standalone_download_path}"
curl -LO ${standalone_download_path}
tar xzf ${filename}
rm ${filename}
export PATH="${PATH}:/root/pact/bin/"

echo "=> testing Pact CLI Tools"
pact-broker --help publish
