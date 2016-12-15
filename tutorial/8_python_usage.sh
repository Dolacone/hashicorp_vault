# set vault token in env variable
source env_variables.sh

export VAULT_TOKEN=`cat ${VAULT_INIT_OUTPUT} | grep '^Initial Root Token' | awk '{print $4}'`

sudo pip install requests

python sample_python.py
