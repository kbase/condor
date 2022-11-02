#!/bin/bash

# See documentation at https://github.com/htcondor/htcondor/tree/main/build/docker/services#providing-additional-configuration

# If there is an environment variable "POOL_PASSWORD" write it out to the pool
# condor pool password
if [ "$POOL_PASSWORD" ] ; then
    mkdir /etc/condor/passwords-orig.d/
    /usr/sbin/condor_store_cred -p "$POOL_PASSWORD" -f /etc/condor/passwords-orig.d/pool_password_from_env
fi

# JWT Token created by condor_token_create -identity condor-central-manager
if [ "$JWT_TOKEN "] ; then
    echo "$JWT_TOKEN" >  /etc/condor/tokens-orig.d/jwt_from_env
fi

if [ "$CONDOR_CONFIG_FILEPATH" ] ; then
    cp "$CONDOR_CONFIG_FILEPATH" /etc/condor/condor_config.local
fi

if [ "$SCHEDD_HOST" ] ; then
    echo "DAEMON_LIST = MASTER SCHEDD COLLECTOR NEGOTIATOR" > /etc/condor/config.d/daemon_list.conf
fi
