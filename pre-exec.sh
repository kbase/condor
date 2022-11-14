#!/bin/bash

# See documentation at https://github.com/htcondor/htcondor/tree/main/build/docker/services#providing-additional-configuration

# If there is an environment variable "POOL_PASSWORD" write it out to the pool
# condor pool password
if [ "$CONDOR_SIGNING_KEY" ] ; then
    echo "$CONDOR_SIGNING_KEY" > /etc/condor/passwords.d/POOL
    chmod 600 /etc/condor/passwords.d/POOL
fi

if [ "$CONDOR_JWT_TOKEN" ] ; then
    echo "$CONDOR_JWT_TOKEN" > /etc/condor/tokens.d/JWT
    chmod 600 /etc/condor/tokens.d/JWT
fi

# Hacks to add in schedd and collector from ENV
if [ "$SCHEDD_HOST" ] ; then
    echo "SCHEDD_HOST = $SCHEDD_HOST" >> /etc/condor/condor_config.local
fi

if [ "$COLLECTOR_HOST" ] ; then
    echo "COLLECTOR_HOST = $COLLECTOR_HOST" >> /etc/condor/condor_config.local
fi

# Overwrite the default config file that comes with this image
if [ "$OVERWRITE_CONFIG_FILEPATH" ] ; then
    cp "$CONDOR_CONFIG_FILEPATH" /etc/condor/condor_config.local
    /update-config
fi
