# Intertwin

Needed interactive steps:

- setup identity in oidc-agent
- get token from egi (password is now hardcoded in file) - solved
- authorise token with Rucio


## Setup EGI authentication to access Intertwin resources

### install oidc-agent

If oidc-agent commands are not available on your system, you need to install them. See [instructions](http://repo.data.kit.edu/) 

**NB:** with Ubuntu based distros you cannot install/use gfal commands. Might be better to use [docker image](#build-rucio-client-image) if docker is available on your system.

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

### First time: setup oidc account

- add *egi* identity with (**NB**  use encryption password "intertwin")
```
./addIdentity.sh
```
- [Documentation](https://indigo-dc.gitbook.io/oidc-agent/)

### Get openid token and setup env

- If egi account is correctly setup, you can just run:
```
source ./getToken.sh
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

### Run rucio client image and enter bash

```
./run.sh
```

- the first time you still need to [setup your egi identity](#add-identity-for-egi-authentication), necessary to obtain the authorization token
- then [get the token](#get-openid-token-and-setup-env) to use rucio and gfal commands 

## Access Virgo resources

Provided you have a valid x509 certificate and belong to [virgo voms](https://voms.cnaf.infn.it:8443/voms/virgo) (link requires a valid x509 certificate installed in your browser)

### create virgo proxy

```
voms-proxy-init -voms virgo --vomses virgo.voms 
```
