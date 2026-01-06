#!/bin/bash

# install latest nvim
if [ "$(uname -m)" = "x86_64" ]; then
    ARCH="x86_64"
elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH="arm64"
else
    log_error "Unsupported architecture: $(uname -m)"
    exit 1
fi

if ! curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$ARCH.tar.gz; then
    log_error "Failed to download latest Neovim"
    exit 1
fi
if [ -d /opt/nvim-linux-$ARCH ]; then
    log_info "Removing existing Neovim directory"
    rm -rf /opt/nvim-linux-$ARCH
fi
tar -C /opt -xzf nvim-linux-$ARCH.tar.gz

# install tree-sitter CLI
if ! apt-get install -y nodejs npm; then
    log_error "Failed to install Node.js and npm"
    exit 1
fi
npm install -g tree-sitter-cli@0.25.10

# move to /usr/local/config/nvim
mkdir -p /usr/local/config/nvim

# copy all files from MyNeovimSetting/ to /usr/local/config/nvim
if ! cp -r MyNeovimSetting/* /usr/local/config/nvim; then
    log_error "Failed to copy Neovim settings"
    exit 1
fi

# change permissions for all moved files
if ! chmod -R 777 /usr/local/config/nvim; then
    log_error "Failed to set permissions for /usr/local/config/nvim"
    exit 1
fi

mkdir -p /root/.config/
ln -sf /usr/local/config/nvim /root/.config/

# set path for nvim config in bash.bashrc
mv /opt/nvim-linux-$ARCH /opt/nvim
add_path_of /opt/nvim/bin