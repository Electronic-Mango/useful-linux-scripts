#!/usr/bin/env bash

SERVER="${1}"
USER="${2}"
KEY_DESCRIPTION="${SERVER}"
KEY_ALGORITHM="ed25519"
KEY_PATH="${HOME}/.ssh/id_${KEY_ALGORITHM}_${KEY_DESCRIPTION}"

ssh-keygen -t "${KEY_ALGORITHM}" -C "${KEY_DESCRIPTION}" -f "${KEY_PATH=}" -N ""
ssh-copy-id -i "${KEY_PATH}" "${USER}@${SERVER}"
cat > "${HOME}/.ssh/config" <<- EOM
HOST ${SERVER}
    USER ${USER}
EOM

unset SERVER
unset USER
unset KEY_DESCRIPTION
unset KEY_ALGORITHM
unset KEY_PATH
