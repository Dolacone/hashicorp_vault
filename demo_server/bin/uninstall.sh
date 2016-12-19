#!/bin/bash
source ../conf/env_variables.sh

# kill process
ps aux | grep consul | awk '{print $2}' | xargs kill
ps aux | grep vault  | awk '{print $2}' | xargs kill

# delete folder
rm -rf ${VAULT_LOG_DIR}
rm -rf ${CONSUL_DATA_DIR}
rm -f consul
rm -f vault
