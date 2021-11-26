#!/bin/bash

nginx

cd /opt/manager
if [ -z $1 ]; then
ansible-playbook -e 'host_key_checking=False' upstart.yaml
else
ansible-playbook -e 'host_key_checking=False' upstart.yaml --tags $1
fi

# Not sure if this is correct