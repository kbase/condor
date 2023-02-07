#!/bin/bash

############################################################################### 
# See documentation at https://github.com/htcondor/htcondor/tree/main/build/docker/services#providing-additional-configuration
# Condor Signing Key (Required to create future tokens) is automatically created upon starting this container
# Once you have the key, you should provide it so it stays the same forever.
############################################################################### 
if [ "$CONDOR_SIGNING_KEY" ] ; then
    echo "$CONDOR_SIGNING_KEY" > /etc/condor/passwords.d/POOL
    chmod 600 /etc/condor/passwords.d/POOL
fi

############################################################################### 
# Give specific JWT tokens permissions for Running Workers, Schedd, And Jobs
############################################################################### 
if [ "$UID_DOMAIN" ] ; then
    echo "ALLOW_ADVERTISE_STARTD = \$(ALLOW_ADVERTISE_STARTD) kbase_workers@${UID_DOMAIN} nersc_workers@${UID_DOMAIN}" >> /etc/condor/condor_config.local
    echo "ALLOW_WRITE = \$(ALLOW_WRITE) kbase_workers@${UID_DOMAIN} nersc_workers@${UID_DOMAIN}" >> /etc/condor/condor_config.local  
fi

if [ "$CONDOR_JWT_TOKEN" ] ; then
     echo "$CONDOR_JWT_TOKEN" > /etc/condor/tokens.d/JWT
     chmod 600 /etc/condor/tokens.d/JWT
fi

####################### HOST PATHS ############################################
#TODO Possibly do these host paths based on condor variables
chmod 700 /var/log/condor/ /var/lib/condor/
/update-config
####################### HOST PATHS ############################################



############################################################################### 
# Overwrite the default config file that comes with this image
############################################################################### 
if [ "$OVERWRITE_CONFIG_FILEPATH" ] ; then
    cp "$CONDOR_CONFIG_FILEPATH" /etc/condor/condor_config.local
    /update-config
fi


############################################################################### 
# FOR TESTING PURPOSES ONLY
# SET COLLECTOR_HOST TO TURN THIS CONTAINER INTO A WORKER
############################################################################### 
if [ "$COLLECTOR_HOST" ] ; then
    echo "COLLECTOR_HOST = $COLLECTOR_HOST" >> /etc/condor/condor_config.local
    echo "DAEMON_LIST = MASTER STARTD" >> /etc/condor/condor_config.local
    /update-config
fi
