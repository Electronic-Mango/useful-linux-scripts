#!/bin/bash

source ./ssh_constants.sh

eval "$(ssh-agent -s)"
ssh-add "${KEY_PATH}"

echo
cat "${PUB_KEY_PATH}"
