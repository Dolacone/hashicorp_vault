#!/bin/bash
source env_variables.sh

apt-get install unzip

# install consul
curl -O https://releases.hashicorp.com/consul/0.7.1/consul_0.7.1_linux_amd64.zip
unzip -d ${CONSUL_FOLDER} consul_0.7.1_linux_amd64.zip
rm -f consul_0.7.1_linux_amd64.zip

# start consul
${CONSUL_BIN} agent -server -bootstrap-expect 1 -data-dir ${CONSUL_DATA_DIR} > ${CONSUL_STDOUT} 2>&1 &
sleep 10
