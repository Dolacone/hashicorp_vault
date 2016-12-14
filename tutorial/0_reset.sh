#!/bin/bash
source env_variables.sh

# kill process
ps aux | grep consul | awk '{print $2}' | xargs kill
ps aux | grep vault  | awk '{print $2}' | xargs kill

# delete folder
rm -rf ${CONSUL_FOLDER}
rm -rf ${VAULT_FOLDER}
