#!/bin/bash
export SECRET=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

carton exec hypnotoad script/lufi

while :
do
	tail -f ./log/production.log
done