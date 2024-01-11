# intertwin

## create virgo proxy

```
voms-proxy-init -voms virgo --vomses intertwin/virgo.voms 
```

## First time: setup oidc account

- install oidc-agent
```
sudo yum install -y oidc-agent-cli
sudo apt-get install -y oidc-agent-cli
```
- 
```
```

## Get openid token and setup env

```
source ./getToken.sh
```

## Build rucio client image

```
./build.sh
```

## Run rucio client image and enter bash

```
./run.sh
```
