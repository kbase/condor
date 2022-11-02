FROM htcondor/cm:9.12.0-el7
COPY deployment/bin/pre-exec.sh /root/config/pre-exec.sh
COPY deployment/conf/condor_config.local /etc/condor/condor_config.local
RUN adduser condor_pool
