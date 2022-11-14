FROM htcondor/cm:9.12.0-el7
COPY pre-exec.sh /root/config/pre-exec.sh
# It is important to keep this "kbase.conf" filename for $OVERWRITE_CONFIG_FILEPATH
# The values here may overwrite values in /etc/condor/config.d/*
COPY kbase_central_manager.conf /etc/condor/condor_config.local
