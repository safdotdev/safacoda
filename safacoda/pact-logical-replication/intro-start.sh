#!/bin/bash
echo "setup node 16"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && source ~/.bashrc && nvm install 16
echo "Downloading projects"
echo "=> downloading consumer project"
git clone https://github.com/YOU54F/pact-logical-replication
cd pact-logical-replication
# echo "Installing Pact CLI Tools"
# echo "=> downloading Pact CLI Tools"
# os='linux-x86_64'
# tag=$(basename $(curl -fs -o/dev/null -w %{redirect_url} https://github.com/pact-foundation/pact-ruby-standalone/releases/latest))
# filename="pact-${tag#v}-${os}.tar.gz"
# standalone_download_path=https://github.com/pact-foundation/pact-ruby-standalone/releases/download/${tag}/${filename}
# echo "from ${standalone_download_path}"
# curl -LO ${standalone_download_path}
# tar xzf ${filename}
# rm ${filename}
# export PATH="${PATH}:/root/pact/bin/"
# apt --yes install jq && clear && echo "Welcome. All the dependencies are installed, and you should be good to go!"
