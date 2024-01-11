FROM docker.io/rucio/rucio-clients:release-33.0.0

USER root

#install necessary packages
RUN yum install -y git #&&  yum clean all &&  rm -rf /var/cache/yum

# install gfal
RUN yum install -y python3-gfal2 gfal2-plugin-file gfal2-plugin-gridftp gfal2-plugin-http gfal2-plugin-srm gfal2-plugin-xrootd xrootd-client gfal2-util

# install voms-proxy
RUN yum install -y voms-clients

# install oidc-agent
RUN yum install -y oidc-agent-cli oidc-agent
 
# add certificates
COPY ./rucio.cfg /home/user/rucio.cfg
COPY ./virgo.voms /home/user/virgo.voms
COPY ./getToken.sh /home/user/getToken.sh
#COPY ./ca-bundle.crt /etc/ssl/certs/ca-bundle.crt

ENV OIDC_SOCK=/tmp/oidc-forward
ENV RUCIO_CONFIG=/home/user/rucio.cfg

RUN eval `oidc-agent`


