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

RUN chgrp -R wheel /opt/rucio/etc 
RUN chmod -R ug+rwX /opt/rucio/etc

# Create airflow user and put it in root group

RUN useradd -ms /bin/bash airflow
RUN usermod -aG wheel airflow

USER airflow
WORKDIR /home/airflow

# add files
COPY ./get-token.sh /home/airflow/get-token.sh
COPY ./add-egi.sh /home/airflow/add-egi.sh
COPY ./refresh-egi.sh /home/airflow/refresh-egi.sh
COPY ./delete-egi.sh /home/airflow/delete-egi.sh
COPY ./setup.sh /home/airflow/setup.sh
COPY ./rucio.cfg /home/airflow/rucio.cfg

# add my certificates
COPY ./virgo.voms /home/airflow/virgo.voms
#COPY ./usercert.pem /home/airflow/.globus/usercert.pem
#COPY ./userkey.pem /home/airflow/.globus/userkey.pem

ENV OIDC_SOCK=/tmp/oidc-forward
ENV RUCIO_CONFIG=/home/airflow/rucio.cfg
ENV OIDC_ENCRYPTION_PW=intertwin

RUN oidc-agent --version
RUN ./add-egi.sh

