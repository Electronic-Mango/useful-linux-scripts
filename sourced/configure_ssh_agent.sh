#! /bin/bash

if [[ -z "${SSH_AUTH_SOCK}" ]]; then
    eval "$(ssh-agent -s)"
fi > /dev/null

for ssh_key in $(find ~/.ssh/ | grep "id_" | grep -v "\.pub$"); do
    ssh-add -q "${ssh_key}"
done

trap "kill ${SSH_AGENT_PID}" 0
