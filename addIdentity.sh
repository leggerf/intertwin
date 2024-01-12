#/bin/bash

### run with: ./addIdentity.sh
###
### This script 
### - setup the necessary oidc identity to get the authorization token from EGI using oidc-agent


eval `oidc-agent`

export OIDC_ENCRYPTION_PW="intertwin"

echo "Adding identity egi ... "
echo "Please follow instructions and use intertwin as encryption password"

# Identity egi added with:
oidc-gen --pub --issuer https://aai-demo.egi.eu/auth/realms/egi --scope=max  --flow=device egi
# Use encryption password "intertwin" !!!!

