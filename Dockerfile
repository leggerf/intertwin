# has installed oidc client
FROM docker.io/dvrbanec/rucio-client:latest   
#FROM docker.io/rucio/rucio-clients:release-33.0.0 # cannot install oidc client on rootless docker

USER root

#install necessary packages

# install gfal
RUN yum install -y python3-gfal2 gfal2-plugin-file gfal2-plugin-gridftp gfal2-plugin-http gfal2-plugin-srm gfal2-plugin-xrootd xrootd-client gfal2-util

# install voms-proxy
RUN yum install -y voms-clients

# install CA files
COPY ./egi-trustanchors.repo /etc/yum.repos.d/egi-trustanchors.repo
RUN yum install -y ca-policy-egi-core

# install oidc-agent
COPY ./data-kit-edu-rockylinux9.repo /etc/yum.repos.d/data-kit-edu-rockylinux9.repo
RUN yum install -y oidc-agent oidc-agent-cli

# add files
COPY ./get-token.sh /root/get-token.sh
COPY ./add-egi.sh /root/add-egi.sh
COPY ./refresh-egi.sh /root/refresh-egi.sh
COPY ./delete-egi.sh /root/delete-egi.sh
COPY ./setup.sh /root/setup.sh
COPY ./rucio.cfg /root/rucio.cfg

COPY ./virgo.voms /root/virgo.voms
COPY ./usercert.pem /root/.globus/usercert.pem
COPY ./userkey.pem /root/.globus/userkey.pem

ENV OIDC_SOCK=/tmp/oidc-forward
ENV RUCIO_CONFIG=/root/rucio.cfg
ENV OIDC_ENCRYPTION_PW=intertwin

WORKDIR /root/
RUN oidc-agent --version
RUN ./add-egi.sh

