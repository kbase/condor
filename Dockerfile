FROM centos:7
ENV container docker

# These ARGs values are passed in via the docker build command
ARG BUILD_DATE
ARG VCS_REF
ARG BRANCH=develop

COPY deployment/conf /etc/condor/
COPY deployment/bin/start-condor.sh /usr/sbin/start-condor.sh

# Get commonly used utilities
RUN yum -y update && yum -y install -y wget which git deltarpm && \
yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel 

#INSTALL DOCKERIZE
RUN wget -N https://github.com/kbase/dockerize/raw/master/dockerize-linux-amd64-v0.6.1.tar.gz && tar xvzf dockerize-linux-amd64-v0.6.1.tar.gz && cp dockerize /kb/deployment/bin && rm dockerize*

# Install Condor
RUN cd /etc/yum.repos.d && \
wget http://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-development-rhel7.repo && \
wget http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor && \
rpm --import RPM-GPG-KEY-HTCondor && \
yum -y install condor

# Install HTCondor Python Bindings
RUN cd /root && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py && \
    pip install htcondor  && \
    rm /root/get-pip.py

RUN mkdir -p /usr/local/condor/run/condor /usr/local/condor/log/condor /usr/local/condor/lock/condor /usr/local/condor/lib/condor/spool /usr/local/condor/lib/condor/execute

ENV KB_DEPLOYMENT_CONFIG /kb/deployment/conf/deployment.cfg

# The BUILD_DATE value seem to bust the docker cache when the timestamp changes, move to
# the end
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/kbase/condor.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1" \
      us.kbase.vcs-branch=$BRANCH \
      maintainer="Steve Chan sychan@lbl.gov"

ENTRYPOINT [ "/kb/deployment/bin/dockerize" ]
CMD [ "-template", "/etc/condor/.templates/condor_config.local.templ:/etc/condor/condor_config.local", \
      "-stdout", "/var/log/condor/SchedLog", \
      "/usr/sbin/start-condor.sh" ]
