import requests
import os, json

VAULT_ADDR  = os.environ['VAULT_ADDR']
VAULT_TOKEN = os.environ['VAULT_TOKEN']

headers = { "X-Vault-Token": VAULT_TOKEN }

# write with python
data = {'demo_python_key': 'demo_python_value'}
r = requests.post(VAULT_ADDR + '/v1/secret/path/for/demo_python', headers=headers, data=json.dumps(data))

# read with python
r = requests.get(VAULT_ADDR + '/v1/secret/path/for/demo_python', headers=headers)
json_response = r.json()

if r.status_code == 200:
    print json_response.get('data', {})
