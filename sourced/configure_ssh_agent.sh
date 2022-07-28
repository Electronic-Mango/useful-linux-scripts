#! /bin/bash

eval "$(ssh-agent -s)"

for ssh_key in $(find ~/.ssh/ | grep "id_" | grep -v "\.pub$"); do
    ssh-add "${ssh_key}"
done

trap "kill ${SSH_AGENT_PID}" 0
