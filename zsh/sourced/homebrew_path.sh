#!/usr/bin/env zsh

path=(
    $HOMEBREW_PREFIX/opt/*/libexec/*bin
    $path
)
export PATH
