# set vault token in env variable
source env_variables.sh

export VAULT_TOKEN=`cat ${VAULT_INIT_OUTPUT} | grep '^Initial Root Token' | awk '{print $4}'`

# vault write
${VAULT_BIN} write /secret/path/for/demo demo_key=demo_value
# vault read
${VAULT_BIN} read /secret/path/for/demo
