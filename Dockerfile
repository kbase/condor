FROM andypohl/htcondor:stable

# These ARGs values are passed in via the docker build command
ARG BUILD_DATE
ARG VCS_REF
ARG BRANCH=develop

COPY deployment/conf /etc/condor/
COPY deployment/bin/start-condor.sh /usr/sbin/start-condor.sh

RUN curl -o /tmp/dockerize.tgz https://raw.githubusercontent.com/kbase/dockerize/dist/dockerize-linux-amd64-v0.5.0.tar.gz && \
    cd /usr/bin && \
    tar xvzf /tmp/dockerize.tgz && \
    rm /tmp/dockerize.tgz && \
    adduser condor_pool

RUN cd /root && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py && \
    pip install htcondor  && \
    rm /root/get-pip.py

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
