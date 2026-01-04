#!/bin/bash

log_info "Installing basic development tools..."
apt-get update \
&& apt-get install -y \
    git

mkdir -p /usr/local/config/git

touch /usr/local/config/git/.gitconfig

ln -sf /usr/local/config/git/.gitconfig /root/.gitconfig