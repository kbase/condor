#!/bin/bash

# If there is an environment variable "POOL_PASSWORD" write it out to the pool
# condor pool password
if [ "$POOL_PASSWORD" ] ; then
    /usr/sbin/condor_store_cred -p "$POOL_PASSWORD" -f `condor_config_val SEC_PASSWORD_FILE`
fi

if [ "$CONDOR_CONFIG_FILEPATH" ] ; then
    cp $CONDOR_CONFIG_FILE /etc/condor/condor_config.local
fi

$(condor_config_val MASTER) -f -t
