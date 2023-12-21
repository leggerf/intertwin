FROM docker.io/rucio/rucio-clients:release-33.0.0

USER root

# add certificates
#COPY ./rucio.tkn /etc/rucio/rucio.tkn
#COPY ./ca-bundle.crt /etc/ssl/certs/ca-bundle.crt

RUN yum install -y git #&&  yum clean all &&  rm -rf /var/cache/yum

# install gfal
RUN yum install -y python3-gfal2 gfal2-plugin-file gfal2-plugin-gridftp gfal2-plugin-http gfal2-plugin-srm gfal2-plugin-xrootd xrootd-client gfal2-util

# install voms-proxy
RUN yum install -y voms-clients

