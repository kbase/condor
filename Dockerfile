FROM htcondor/cm:9.12.0-el7
COPY pre-exec.sh /root/config/pre-exec.sh
COPY kbase_config.conf /etc/condor/condor_config.local
RUN adduser condor_pool
RUN adduser kbase
