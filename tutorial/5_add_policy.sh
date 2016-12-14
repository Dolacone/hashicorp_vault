#!/bin/bash
source env_variables.sh

export VAULT_TOKEN=`cat ${VAULT_INIT_OUTPUT} | grep '^Initial Root Token' | awk '{print $4}'`
# vault create new policy
${VAULT_BIN} policy-write demo_policy policy.hcl

# vault create new token
VAULT_TOKEN_OUTPUT=${VAULT_FOLDER}/demo_token.out
${VAULT_BIN} token-create -policy="demo_policy" > ${VAULT_TOKEN_OUTPUT}
# test with new token
export VAULT_TOKEN=`cat ${VAULT_TOKEN_OUTPUT} | grep '^token ' | awk '{print $2}'`
# query secret via API with created token
${VAULT_BIN} read secret/path/for/demo
# check policy cannot write
${VAULT_BIN} write secret/path/for/demo test_key=test_value
