#! /bin/bash

ssh-add -lq &> /dev/null
if [ "$?" == 2 ]; then
    eval "$(ssh-agent -s)" > /dev/null
fi

for ssh_key in $(find ~/.ssh/ | grep "id_" | grep -v "\.pub$"); do
    ssh-add -q "${ssh_key}"
done

trap "kill ${SSH_AGENT_PID}" 0
