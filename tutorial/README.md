# Tutorial

This tutorial provides some examples for using vault.

## 0_reset.sh

Remove all changes made by tutorial scripts.

## 1_setup_consul.sh

Install and start Consul server.

## 2_setup_vault.sh

Install and start vault server for local usage.

>   In order to make this server available for external access, change the `listener address` to `0.0.0.0:8200` in server.hcl.

## 3_unseal_vault.sh

Parse the unseal key from vault init output and unseal vault.

## 4_vault_read_write.sh

Example code for read/write secret with vault binary tool.

## 5_add_policy.sh

Example code for create policy and create token with vault binary tool.

## 6_restful_usage.sh

Example code for read/write secret via restful API.

## 7_ansible_usage

Example code for read secret via ansible playbook.

## 8_python_usage

Example code for read secret via python (requests).