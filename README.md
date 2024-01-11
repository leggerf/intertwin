# intertwin

## Setup EGI authentication to access Intertwin resources

### First time: setup oidc account

#### install oidc-agent

- If oidc-agent commands are not available on your system, you need to install them
- add repo from kit, see [instructions](http://repo.data.kit.edu/)
```
sudo su
curl repo.data.kit.edu/repo-data-kit-edu-key.gpg  | gpg --dearmor > /etc/apt/trusted.gpg.d/kitrepo-archive.gpg
```
- add repo to ```/etc/apt/sources.list``` (for apt-get based distributions like Ubuntu). For RockyLinux/alma run something like cd /etc/yum.repos.d; wget ```https://repo.data.kit.edu//data-kit-edu-rockylinux9.repo```. Check  [instructions](http://repo.data.kit.edu/) for precise syntax.
``` 
sudo apt-get update
sudo yum install -y oidc-agent-cli
sudo apt-get install -y oidc-agent-cli
```
- check that the version is at least
```
oidc-agent --version
oidc-agent 5.0.1
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
