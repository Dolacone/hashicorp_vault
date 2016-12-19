import json
import requests
import ConfigParser
import os, sys
import glob

tokenFile = '../conf/token.conf'
policyFilePath = '../policy'

config = ConfigParser.ConfigParser()
config.read(tokenFile)

VAULT_ADDR = config.get('vault', 'server')
VAULT_TOKEN = config.get('token', 'root')

headers = { "X-Vault-Token": VAULT_TOKEN }

def process_policy_file(policy_file):
    print("process policy file: %s" % (policy_file))
    policyname = policy_file.split('/')[-1].split('.')[0]
    policy_content = load_json_from_file(policy_file)
    update_secret_from_content(policy_content)
    update_policy_from_content(policyname, policy_content)
    generate_token_for_new_policy(policyname)

def load_json_from_file(filename):
    with open(filename) as f:
        content = json.load(f)
    return content

def update_secret_from_content(input_json):
    for secret in input_json['secret']:
        for secret_path in secret:
            vault_update_secret(secret_path, secret[secret_path])

def vault_update_secret(secret_path, secret_content):
    request_path = VAULT_ADDR + '/v1' + secret_path
    r = requests.post(request_path, headers=headers, data=json.dumps(secret_content))
    if r.status_code == 204:
        print("secret updated")
    else:
        print(r.text)

def update_policy_from_content(policyname, input_json):
    rule_path = {}
    rule_path['path'] = {}
    for policy in input_json['policy']:
        for policy_path in policy:
            rule_path['path'][policy_path] = {"policy": policy[policy_path]}
    policy_rule = {}
    policy_rule['rules'] = json.dumps(rule_path)
    vault_update_policy(policyname, policy_rule)

def vault_update_policy(policyname, policy_rule):
    request_path = VAULT_ADDR + '/v1/sys/policy/' + policyname
    r = requests.put(request_path, headers=headers, data=json.dumps(policy_rule))
    if r.status_code == 204:
        print("policy updated")
    else:
        print(r.text)

def generate_token_for_new_policy(policyname):
    if not config.has_option('token', policyname):
        print("new policy: %s" % (policyname))
        token = vault_create_token(policyname)
        config.set('token', policyname, token)
        with open(tokenFile, 'w') as f:
            config.write(f)

def vault_create_token(policyname):
    request_path = VAULT_ADDR + '/v1/auth/token/create'
    data = {'policies': [policyname]}
    r = requests.post(request_path, headers=headers, data=json.dumps(data))
    return r.json()['auth']['client_token']

def main(policyname = None):
    if not policyname:
        policy_file_list = glob.glob('../policy/*.json')
    else:
        policy_file = "%s/%s.json" % (policyFilePath, policyname)
        if not os.path.isfile(policy_file):
            print("policy file (%s) not found." % (policy_file))
            return
        policy_file_list = [policy_file]

    for policy_file in policy_file_list:
        process_policy_file(policy_file)

if __name__ == '__main__':
    if len(sys.argv) == 1:
        main()
    else:
        main(sys.argv[1])
