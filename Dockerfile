FROM htcondor/cm:9.12.0-el7
COPY pre-exec.sh /root/config/pre-exec.sh
COPY postStart.sh /postStart.sh
# See https://www-auth.cs.wisc.edu/lists/htcondor-users/2014-August/msg00044.shtml
COPY kbase_central_manager.conf /etc/condor/condor_config.local
