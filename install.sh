#!/bin/bash

echo "updating system"
sudo apt-get update
sudo apt-get upgrade -y

echo "installing system packages"
sudo apt-get install -y \
  clang \
  clangd \
  curl \
  wget \
  unzip \
  ripgrep \
  make \
  cmake \
  ninja-build \
  g++

echo "installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash || exit 1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo "installing latest node"
nvm install node || exit 1
nvm use node || exit 1

echo "installing Golang"
wget https://go.dev/dl/go1.21.0.linux-amd64.tar.gz -O go.tar.gz || exit 1
sudo tar -C /usr/local -xzf go.tar.gz || exit 1
rm go.tar.gz
touch $HOME/local_bashrc.sh
mkdir -p $HOME/local/bin

export GOROOT='/usr/local/go'
export GOPATH='$HOME/go'
export PATH='$GOPATH/bin:$GOROOT/bin:$PATH:$HOME/local/bin'

echo "export GOROOT='/usr/local/go'" >> $HOME/local_bashrc.sh
echo "export GOPATH='$HOME/go'" >> $HOME/local_bashrc.sh
echo "export PATH='$GOPATH/bin:$GOROOT/bin:$PATH:$HOME/local/bin'" >> $HOME/local_bashrc.sh
echo "source '$HOME/local_bashrc.sh'" >> $HOME/.bashrc


echo "installing Rust and Cargo"
curl https://sh.rustup.rs -sSf | sh

echo "Installing gopls"
go install golang.org/x/tools/gopls@latest || exit 1

echo "installing language servers"
npm i -g bash-language-server
npm i -g vscode-langservers-extracted
npm install -g dockerfile-language-server-nodejs
cargo install htmx-lsp
go get github.com/sqls-server/sqls
npm install -g typescript typescript-language-server
sudo apt-get install python3-pylsp

wget https://github.com/LuaLS/lua-language-server/releases/download/3.7.4/lua-language-server-3.7.4-linux-x64.tar.gz -O luals.tar.gz || exit 1
mkdir luals
tar -xzf luals.tar.gz -C luals || exit 1
mv luals/bin/* $HOME/local/bin
rm -rf luals/
rm luals.tar.gz



