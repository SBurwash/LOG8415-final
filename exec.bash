#!/bin/bash

while getopts u:t: option; do
        case "${option}" in
                u)
                        username=${OPTARG};;
                t)
                        token=${OPTARG};;
        esac
done


ip=$(terraform output -raw vm_public_ip)
git clone git@github.com:SBurwash/Discord_bot_project.git
echo "DISCORD_TOKEN=$token" > Discord_bot_project/.env
echo "SHOULD BE CREATED"
cat Discord_bot_project/.env
scp -r -i "~/.ssh/id_rsa" Discord_bot_project $username@$ip:~/.
scp -i "~/.ssh/id_rsa" remote_exec.bash $username@$ip:~/.
ssh $username@$ip ./remote_exec.bash