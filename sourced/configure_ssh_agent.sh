#! /bin/bash

eval "$(ssh-agent -s)" > /dev/null

for ssh_key in $(find ~/.ssh/ | grep "id_" | grep -v "\.pub$"); do
    ssh-add -q "${ssh_key}"
done

trap "kill ${SSH_AGENT_PID}" 0
