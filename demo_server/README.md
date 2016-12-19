Put this demo folder under `/opt/vault/` and it can be directly used.

Otherwise the `VAULT_DIR` in `~/conf/env_variables.sh` must be set in correct path.

# Configuration

### env_variables.sh

Defines the working directory.

>   Usually you will only need to change the `VAULT_DIR` and `VAULT_LOG_DIR`

### server.hcl

Defines the server information.

### token.conf

Contains the vault server address and token information.

Whenever a new policy is set, new token will be added to this file automatically.

# Start Vault Server

``` bash
sudo bash ./bin/install.sh
```

This script will install vault (and also consul), start vault, and unseal it.

Root token will be added into `~/conf/token.conf`.

# Create New Policy

Create policy file for each policy group under `~/policy/` with naming format: `{policy name}.json`.

``` bash
python update_policy.py [policy name]
```

This python tool will parse the setting in `~/policy/{policy name}.json` and update the related information into vault.

>   If the policy name is not provided, it will process all json files in policy folder.

After the policy is updated, it will generate a new token and store it in `~/conf/token.conf`.

# Remove Vault Server

``` bash
sudo bash ./bin/uninstall.sh
```

This script will stop the vault process and remove the things created by `install.sh`.