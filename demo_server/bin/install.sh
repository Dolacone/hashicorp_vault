#!/bin/bash
source ../conf/env_variables.sh

apt-get install unzip

mkdir -p ${VAULT_DIR}
mkdir -p ${VAULT_LOG_DIR}
mkdir -p ${VAULT_CONF_DIR}
mkdir -p ${VAULT_BIN_DIR}
mkdir -p ${VAULT_ROLE_DIR}

# install consul
curl -O https://releases.hashicorp.com/consul/0.7.1/consul_0.7.1_linux_amd64.zip
unzip -o -d ${VAULT_BIN_DIR} consul_0.7.1_linux_amd64.zip
rm -f consul_0.7.1_linux_amd64.zip

# start consul
${CONSUL_BIN} agent -server -bootstrap-expect 1 -data-dir ${CONSUL_DATA_DIR} > ${CONSUL_STDOUT} 2>&1 &
sleep 10

# install vault
curl -O https://releases.hashicorp.com/vault/0.6.3/vault_0.6.3_linux_amd64.zip
unzip -o -d ${VAULT_BIN_DIR} vault_0.6.3_linux_amd64.zip
rm -f vault_0.6.3_linux_amd64.zip

# start vault
sudo ${VAULT_BIN} server -config=${VAULT_CONF_DIR}/server.hcl > ${VAULT_STDOUT} 2>&1 &
sleep 10

# vault init
${VAULT_BIN} init | tee ${VAULT_INIT_OUTPUT} > /dev/null

# output config file for python usage
VAULT_TOKEN=`cat ${VAULT_INIT_OUTPUT} | grep '^Initial Root Token' | awk '{print $4}'`
echo "root = ${VAULT_TOKEN}" >> ${VAULT_TOKEN_CONFIG}

# unseal vault
cat ${VAULT_INIT_OUTPUT} | grep '^Unseal' | awk '{print $4}' | for key in $(cat -); do
  ${VAULT_BIN} unseal $key
done
