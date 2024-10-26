#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

TARGET_BASH_ALIASES="${HOME}/.bash_aliases"
TARGET_BASHRCD="${HOME}/.bashrc.d"

SOURCE_BASH_ALIASES="${SCRIPT_DIR}/templates/source_bashrcd_dir.sh"
SOURCE_BASHRCD="${SCRIPT_DIR}/sourced"

echo "Removing old configuration files..."
[[ -f "${TARGET_BASH_ALIASES}" ]] && rm -ri "${TARGET_BASH_ALIASES}"
[[ -f "${TARGET_BASHRCD}" ]] && rm -ri "${TARGET_BASHRCD}"

echo "Linking .bash_aliases from '${SOURCE_BASH_ALIASES}' to '${TARGET_BASH_ALIASES}'..."
ln -s "${SOURCE_BASH_ALIASES}" "${TARGET_BASH_ALIASES}"

echo "Linking .bashrc.d from '${SOURCE_BASHRCD}' to '${TARGET_BASHRCD}'..."
ln -s "${SOURCE_BASHRCD}" "${TARGET_BASHRCD}"
