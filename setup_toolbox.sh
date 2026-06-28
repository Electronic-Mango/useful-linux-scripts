#!/usr/bin/env bash

if [[ "$(tail -n1 /etc/dnf/dnf.conf)" == "[main]" ]]; then
    sudo echo 'install_weak_deps=False' >> /etc/dnf/dnf.conf
fi

sudo dnf --setopt=install_weak_deps=False install \
    install eza fzf bat ripgrep neovim fd zoxide helix tealdeer \
    gnome-keyring libsecret
