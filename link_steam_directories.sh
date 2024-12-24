#!/usr/bin/env bash

function link_installation_dir() {
    local install_path="${1}"
    local install_dir_name="$(basename "${install_path}")"
    if [[ ! -e "./${install_dir_name}" ]]; then
        ln -s "${install_path}" .
    fi
}

function link_data_in_installation_dir() {
    local app_id="${1}"
    local install_path="${2}"
    local data_dir_name="${3}"
    local source_data_relative_path="../../${data_dir_name}/${app_id}"
    local source_data_full_path="${install_path}/${source_data_relative_path}"
    local target_link_path="${install_path}/${data_dir_name}"
    if [[ -d "${source_data_full_path}" ]] && [[ ! -e "${target_link_path}" ]]; then
        ln -s "${source_data_relative_path}" "${target_link_path}"
    fi
}

function find_in_manifest() {
    local manifest_file_path="${1}"
    local field_name="${2}"
    grep "${field_name}" "${manifest_file_path}" | awk -F'"' '{print $4}'
}

function link_directories() {
    local manifest_file_path="${1}"
    local app_id=$(find_in_manifest "${manifest_file_path}" "appid")
    local install_dir_name=$(find_in_manifest "${manifest_file_path}" "installdir")
    local apps_path="$(dirname "${manifest_file_path}")"
    local install_path="${apps_path}/common/${install_dir_name}"
    if [[ ! -d "${install_path}" ]]; then
        return
    fi
    link_data_in_installation_dir "${app_id}" "${install_path}" "compatdata"
    link_data_in_installation_dir "${app_id}" "${install_path}" "shadercache"
    link_installation_dir "${install_path}"
}

function main() {
    find . -type f -name "appmanifest_*.acf" -print0 | while IFS= read -r -d '' manifest_file_path; do
        link_directories "${manifest_file_path}"
    done
}

main
