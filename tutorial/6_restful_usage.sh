# set vault token in env variable
source env_variables.sh

export VAULT_TOKEN=`cat ${VAULT_INIT_OUTPUT} | grep '^Initial Root Token' | awk '{print $4}'`

# vault write
curl \
  -H "X-Vault-Token: ${VAULT_TOKEN}" \
  -H "Content-Type: application/json" \
  -X POST \
  -d '{"demo_restful_key": "demo_restful_value"}' \
  ${VAULT_ADDR}/v1/secret/path/for/demo_restful 

# vault read
curl \
  -H "X-Vault-Token: ${VAULT_TOKEN}" \
  -X GET \
  ${VAULT_ADDR}/v1/secret/path/for/demo_restful
