# has installed oidc client
FROM docker.io/dvrbanec/rucio-client:latest   
#FROM docker.io/rucio/rucio-clients:release-33.0.0 # cannot install oidc client on rootless docker

USER root

#install necessary packages

# install gfal
RUN yum install -y python3-gfal2 gfal2-plugin-file gfal2-plugin-gridftp gfal2-plugin-http gfal2-plugin-srm gfal2-plugin-xrootd xrootd-client gfal2-util

# install voms-proxy
RUN yum install -y voms-clients

# install oidc-agent
#RUN yum install -y oidc-agent oidc-agent-cli

# add files
COPY ./rucio.cfg /home/user/rucio.cfg
COPY ./virgo.voms /home/user/virgo.voms
COPY ./getToken.sh /home/user/getToken.sh
COPY ./data-kit-edu-rockylinux9.repo /etc/yum.repos.d/data-kit-edu-rockylinux9.repo

ENV OIDC_SOCK=/tmp/oidc-forward
ENV RUCIO_CONFIG=/home/user/rucio.cfg



