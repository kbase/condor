#!/bin/bash
# See documentation at https://github.com/htcondor/htcondor/tree/main/build/docker/services#providing-additional-configuration

# If there is an environment variable "POOL_PASSWORD" write it out to the pool
# condor pool password
if [ "$CONDOR_SIGNING_KEY" ] ; then
    echo "$CONDOR_SIGNING_KEY" > /etc/condor/passwords.d/POOL
    chmod 600 /etc/condor/passwords.d/POOL
fi

# Allow Starting up workers, and submitting jobs to queue 
if [ "$UID_DOMAIN" ] ; then
    echo "ALLOW_ADVERTISE_STARTD = \$(ALLOW_ADVERTISE_STARTD) kbase_workers@${UID_DOMAIN} nersc_workers@${UID_DOMAIN}" >> /etc/condor/condor_config.local
    echo "ALLOW_WRITE = \$(ALLOW_WRITE) kbase_workers@${UID_DOMAIN} nersc_workers@${UID_DOMAIN}" >> /etc/condor/condor_config.local  
    /update-config
fi

# Overwrite the default config file that comes with this image
if [ "$OVERWRITE_CONFIG_FILEPATH" ] ; then
    cp "$CONDOR_CONFIG_FILEPATH" /etc/condor/condor_config.local
    /update-config
fi



# FOR TESTING PURPOSES ONLY
# Hacks to enable worker for testing using this same image
if [ "$COLLECTOR_HOST" ] ; then
    echo "COLLECTOR_HOST = $COLLECTOR_HOST" >> /etc/condor/condor_config.local
    echo "DAEMON_LIST = MASTER STARTD" >> /etc/condor/condor_config.local
    
    /update-config

    if [ "$CONDOR_JWT_TOKEN" ] ; then
        echo "$CONDOR_JWT_TOKEN" > /etc/condor/tokens.d/JWT
        chmod 600 /etc/condor/tokens.d/JWT
    fi
fi
