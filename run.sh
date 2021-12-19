#!/bin/bash
export SECRET=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

groupadd -g $GID -o lufi
useradd -g $UID -g lufi lufi
chown -R lufi:lufi /lufi
chown -R lufi:lufi /files
chmod -R 700 /lufi
chmod -R 600 /files
chmod u+x $(find /files -type d)

gosu lufi carton exec hypnotoad script/lufi

while :
do
	gosu lufi tail -f ./log/production.log
done