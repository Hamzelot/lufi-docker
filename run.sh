#!/bin/bash
export SECRET=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

groupadd -g $GID -o lufi
useradd -g $UID -g lufi lufi
chown -R lufi:lufi /lufi
chown -R lufi:lufi /files
chmod -R 700 /lufi
chmod -R 600 /files
chmod u+x $(find /files -type d)

# If the ENV variable is defined directly in the lufi.conf configuration, there is a PERL error, so it is written in fixed.
# PERL ERROR - Can't use string ("'10000000' => 90, '50000000' => "...) as a HASH ref
if [ ! -z ${DELAY_FOR_SIZE+x} ]
then 
    sed -i -e "s/#delay_for_size  => {/delay_for_size  => {${DELAY_FOR_SIZE}},/g" /lufi/lufi.conf
fi
if [ ! -z ${ABUSE+x} ]
then 
    sed -i -e "s/#abuse => {/abuse  => {${ABUSE}},/g" /lufi/lufi.conf
fi
if [ ! -z ${MAIL+x} ]
then 
    sed -i -e "s/#mail => {/mail => {${MAIL}},/g" /lufi/lufi.conf
fi

gosu lufi carton exec hypnotoad script/lufi

while :
do
	gosu lufi tail -f ./log/production.log
done