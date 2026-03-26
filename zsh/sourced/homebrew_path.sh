#!/usr/bin/env zsh

path=(
    "${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:${PATH}"  # coreutils
    "${HOMEBREW_PREFIX}/opt/python/libexec/bin:${PATH}"  # Python
    $path
)
export PATH
