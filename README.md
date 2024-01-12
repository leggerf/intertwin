# Intertwin

## Access Intertwin resources through EGI authentication

You will need to:

- [install the oidc-agent](#install-oidc-agent) if it is not available in your system. **NB:** with Ubuntu based distros you cannot install/use gfal commands. Might be better to use [docker image](#use-docker-image) if docker is available on your system. 
- [first time setup](#first-time-add-identity): create your egi identity for authentication
- get valid token



### Setup oidc account

### First time: Add identity

- add *egi* identity with [add-egi.sh](./add-egi.sh) (**NB**  the hardcoded encryption password is "intertwin")
```
./add-egi.sh
```
- [Documentation](https://indigo-dc.gitbook.io/oidc-agent/)

### Get openid token and setup env

- If egi account is correctly setup, you can just run:
```
source ./get-token.sh
```
- This will allow you to have a valid token that can be used to see the storage at CNAF with:
```
gfal-ls davs://xfer-intertwin.cr.cnaf.infn.it:8443/intertwin/virgo
```
- or access the Intertwin Rucio server at DESY, for example:
```
rucio list-rses
```
- [oidc-agent documentation](https://indigo-dc.gitbook.io/oidc-agent/)
- [Rucio documentation](https://rucio.cern.ch/documentation/user/setting_up_the_rucio_client)

## Use docker image

### Build rucio client docker image

```
./build.sh
```
In the last build step you need to follow the instructions to setup you egi identity.
This is equivalent to this [step](#first-time-add-identity).

### Run rucio client image and enter bash

```
./run.sh
```

-  [get the token](#get-openid-token-and-setup-env) to use rucio and gfal commands 

## Access Virgo resources

Provided you have a valid x509 certificate and belong to [virgo voms](https://voms.cnaf.infn.it:8443/voms/virgo) (link requires a valid x509 certificate installed in your browser)

### create virgo proxy

```
voms-proxy-init -voms virgo --vomses virgo.voms 
```


## Install oidc-agent

If oidc-agent commands are not available on your system, you need to install them. See [instructions](http://repo.data.kit.edu/) 

For apt-get based distributions like Ubuntu, add repo from KIT
```
sudo su
curl repo.data.kit.edu/repo-data-kit-edu-key.gpg  | gpg --dearmor > /etc/apt/trusted.gpg.d/kitrepo-archive.gpg
```
then add repo to
```
vi /etc/apt/sources.list
apt-get update
```

For RockyLinux/alma run something like (check  [instructions](http://repo.data.kit.edu/) for precise syntax)
 ```
cd /etc/yum.repos.d; wget https://repo.data.kit.edu//data-kit-edu-rockylinux9.repo
```

Install with 
``` 
sudo yum install -y oidc-agent-cli oidc-agent
```
or 
```
sudo apt-get install -y oidc-agent-cli  oidc-agent
```
Check that the version is at least
```
oidc-agent --version
oidc-agent 5.0.1
```
You might need to set ```export OIDC_SOCK=/tmp/oidc-forward```

