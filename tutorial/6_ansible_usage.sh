#!/bin/bash
source env_variables.sh

apt-get install python-pip python-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev zlib1g-dev -y
pip install ansible-modules-hashivault

export VAULT_TOKEN=`cat ${VAULT_INIT_OUTPUT} | grep '^Initial Root Token' | awk '{print $4}'`

ansible-playbook ansible_playbook.yml
