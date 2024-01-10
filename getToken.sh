#/bin/bash

### run with: source ./getToken.sh
###
### This script 
### - gets the necessary authentication token from EGI using oidc-agent
### - sets the environment to access the endpoint at CNAF with gfal
### - sets the environment for the intertwin rucio instance at DESY

eval `oidc-agent`

#token obtained with
# oidc-gen --pub --issuer https://aai-demo.egi.eu/auth/realms/egi --scope=max  --flow=device egi

#oidc-token legger
export BEARER_TOKEN="$(oidc-token egi --time 3600 --scope 'openid profile offline_access eduperson_entitlement')"
export EXPIRES_AT="$(date -d @$(oidc-token egi --expires-at))"

#for rucio

export RUCIO_CONFIG="/afs/cern.ch/user/l/leggerf/intertwin/rucio.cfg"
echo $BEARER_TOKEN | tr -cd '[:print:]' > rucio.tkn
cat rucio.tkn

printf "\n\nExpires at $EXPIRES_AT"

printf "\n\ngfal-ls davs://xfer-intertwin.cr.cnaf.infn.it:8443/intertwin/virgo \n"
gfal-ls davs://xfer-intertwin.cr.cnaf.infn.it:8443/intertwin/virgo
