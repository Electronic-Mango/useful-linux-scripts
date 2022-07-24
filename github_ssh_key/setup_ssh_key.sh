#!/bin/bash

source ./ssh_constants.sh

ssh-keygen -t "${KEY_ALGORITHM}" -C "${KEY_DESCRIPTION}" -f "${KEY_PATH=}" -N ""

echo
cat "${PUB_KEY_PATH}"

