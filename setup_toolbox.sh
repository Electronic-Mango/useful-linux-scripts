#!/usr/bin/env bash

sudo dnf --setopt=install_weak_deps=False install \
    eza fzf bat ripgrep neovim fd zoxide tealdeer kitty fish
