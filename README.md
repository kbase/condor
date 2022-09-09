# condor
KBase specific Condor scheduler image. Based on the andypohl/htcondor image.

## Supported ENV Variables

* CONDOR_CONFIG_FILEPATH - A path to a configfile to be copied into /etc/condor/condor_config.local
* POOL_PASSWORD - The password for the condor pool (to be deprecated by token)
