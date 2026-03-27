#!/usr/bin/env zsh

path+=(
    "${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin"  # coreutils
    "${HOMEBREW_PREFIX}/opt/python/libexec/bin"  # Python
    "${HOMEBREW_PREFIX}/opt/findutils/libexec/gnubin"  # findutils
    "${HOMEBREW_PREFIX}/opt/grep/libexec/gnubin"  # grep
)
export PATH
