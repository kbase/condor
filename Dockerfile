FROM htcondor/cm:9.11-el7

# These ARGs values are passed in via the docker build command
ARG BUILD_DATE
ARG VCS_REF
ARG BRANCH=develop


# Get commonly used utilities
RUN yum -y install deltarpm
RUN yum -y update && yum upgrade -y 
RUN yum -y install epel-release wget which git deltarpm gcc libcgroup libcgroup-tools stress-ng

# Install DOCKERIZE
RUN curl -o /tmp/dockerize.tgz https://raw.githubusercontent.com/kbase/dockerize/dist/dockerize-linux-amd64-v0.5.0.tar.gz && \
      cd /usr/bin && \
      tar xvzf /tmp/dockerize.tgz && \
      rm /tmp/dockerize.tgz

#ADD DIRS
RUN mkdir -p /var/run/condor && mkdir -p /var/log/condor && mkdir -p /var/lock/condor && mkdir -p /var/lib/condor/execute

COPY deployment/conf /etc/condor/
COPY deployment/bin/start-condor.sh /usr/sbin/start-condor.sh
RUN adduser condor_pool
RUN mkdir -p /usr/local/condor/run/condor /usr/local/condor/log/condor /usr/local/condor/lock/condor /usr/local/condor/lib/condor/spool /usr/local/condor/lib/condor/execute


# The BUILD_DATE value seem to bust the docker cache when the timestamp changes, move to
# the end
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/kbase/condor.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1" \
      us.kbase.vcs-branch=$BRANCH \
      maintainer="Steve Chan sychan@lbl.gov"

ENTRYPOINT [ "/usr/bin/dockerize" ]
CMD [ "-template", "/etc/condor/.templates/condor_config.local.templ:/etc/condor/condor_config.local", \
      "-stdout", "/var/log/condor/SchedLog", \
      "/usr/sbin/start-condor.sh" ]
