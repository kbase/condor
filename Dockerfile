FROM htcondor/cm:9.12.0-el7
COPY deployment/bin/pre-exec.sh /root/config/pre-exec.sh
RUN adduser condor_pool
