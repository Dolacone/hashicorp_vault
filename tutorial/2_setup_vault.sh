#!/bin/bash
source env_variables.sh

# install vault
curl -O https://releases.hashicorp.com/vault/0.6.3/vault_0.6.3_linux_amd64.zip
unzip -o -d ${VAULT_FOLDER} vault_0.6.3_linux_amd64.zip
rm -f vault_0.6.3_linux_amd64.zip

# start vault
sudo ${VAULT_BIN} server -config=server.hcl > ${VAULT_STDOUT} 2>&1 &
sleep 10

# vault init
${VAULT_BIN} init | tee ${VAULT_INIT_OUTPUT} > /dev/null
