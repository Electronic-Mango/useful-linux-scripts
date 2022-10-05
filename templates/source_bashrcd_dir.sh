#!/bin/bash

# Source files in "~/.bashrc.d/" subdirectory.
# You may want to put all your additions into a separate files
# in "~/.bashrc.d/", instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -d "${HOME}/.bashrc.d" ]; then
    for file in $(find -L ~/.bashrc.d -mindepth 1); do
        . "${file}"
    done
fi
