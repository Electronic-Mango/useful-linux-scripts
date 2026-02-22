#!/usr/bin/env bash

function link() {
    local target_path="${1}"
    local source_path="${2}"
    local additional_info="${3}"

    read -p "Replace '${target_path}'? ${additional_info}" replace_confirm
    if [[ "${replace_confirm,,}" != "y" && "${replace_confirm,,}" != "yes" ]]; then
        return
    fi

    local script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    local full_source_path="${script_dir}/${source_path}"
    if [[ -e "${target_path}" ]]; then
        echo "Removing old '${target_path}' ..."
        rm -ri "${target_path}"
    fi
    echo "Linking $(basename "${target_path}") from '${full_source_path}' to '${target_path}' ..."
    ln -s "${full_source_path}" "${target_path}"
}

link "${HOME}/.bash_aliases" "templates/source_bashrcd_dir.sh" "CHECK .bashrc IF THIS IS NEEDED! "
echo
link "${HOME}/.bashrc.d" "sourced"

