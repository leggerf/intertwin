# intertwin

## Setup EGI authentication to access Intertwin resources

### First time: setup oidc account

- install oidc-agent
```
sudo yum install -y oidc-agent-cli
sudo apt-get install -y oidc-agent-cli
```
- you might need to set ```export OIDC_SOCK=/tmp/oidc-forward```
- add *egi* identity with: (NB:  use encryption password "intertwin")
```
eval `oidc-agent`
oidc-gen --pub --issuer https://aai-demo.egi.eu/auth/realms/egi --scope=max  --flow=device egi
```
- [Documentation](https://indigo-dc.gitbook.io/oidc-agent/)

### Get openid token and setup env

- If egi account is correctly setup, you can just run:
```
source ./getToken.sh
```

## Use Intertwin Rucio server at DESY

### Build rucio client image

```
./build.sh
```

### Run rucio client image and enter bash

```
./run.sh
```

## Access Virgo resources

Provided you have a valid x509 certificate and belong to [virgo voms](https://voms.cnaf.infn.it:8443/voms/virgo) (link requires a valid x509 certificate installed in your browser)

### create virgo proxy

```
voms-proxy-init -voms virgo --vomses virgo.voms 
```
