#!/bin/bash


if [ "$#" == 1 ]; then
    domain=$1
    echo $domain
else
	echo "Enter the domain, for which ssh authentication is to be done [user@domain]"
	read domain
fi

if [ ! -f $HOME/.ssh/id_rsa.pub ]; then
	echo "Creating authentication key pairs.. (when asked, press enter)"
	mkdir -p $HOME/.ssh
    ssh-keygen -t rsa
    echo "Key pairs generated."
fi
echo "Creating .ssh folder for remote host (password of remote host will be asked)"
ssh $domain mkdir -p .ssh
echo "Copying your public key to the authorized_keys of the remote machine"
cat $HOME/.ssh/id_rsa.pub | ssh $domain 'cat >> .ssh/authorized_keys'
echo "Copying done."