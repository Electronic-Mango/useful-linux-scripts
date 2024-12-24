#!/usr/bin/env bash

ssh-add -lq &> /dev/null
if [ "$?" == 2 ]; then
    eval "$(ssh-agent -s)" > /dev/null
fi
find "${HOME}" -type f -path "${HOME}/.ssh/*" -name "id_*" -not -name "*.pub" -exec ssh-add -q {} \;
trap "kill ${SSH_AGENT_PID}" 0
