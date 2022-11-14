FROM htcondor/cm:9.12.0-el7
COPY pre-exec.sh /root/config/pre-exec.sh
# It is important to keep this "kbase.conf" filename for $OVERWRITE_CONFIG_FILEPATH
COPY kbase_central_manager.conf /etc/condor/kbase.conf
