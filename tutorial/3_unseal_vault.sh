#!/bin/bash
source env_variables.sh

# vault unseal
cat ${VAULT_INIT_OUTPUT} | grep '^Unseal' | awk '{print $4}' | for key in $(cat -); do
  ${VAULT_BIN} unseal $key
done
