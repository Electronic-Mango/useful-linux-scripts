#!/usr/bin/env bash

KEY_DESCRIPTION="github"
KEY_ALGORITHM="ed25519"
KEY_PATH="${HOME}/.ssh/id_${KEY_ALGORITHM}_${KEY_DESCRIPTION}"

ssh-keygen -t "${KEY_ALGORITHM}" -C "${KEY_DESCRIPTION}" -f "${KEY_PATH=}" -N ""
echo
cat "${KEY_PATH}.pub"

unset KEY_DESCRIPTION
unset KEY_ALGORITHM
unset KEY_PATH
