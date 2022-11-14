FROM htcondor/cm:9.12.0-el7
COPY pre-exec.sh /root/config/pre-exec.sh
# It is important to keep this "kbase.conf" filename for $OVERWRITE_CONFIG_FILEPATH
COPY kbase_cm.conf /etc/condor/kbase.conf