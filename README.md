# condor

KBase specific condor scheduler image.
Based on the htcondor/cm:9.X images

## New behavior
* Copy credentials from environment into correct place as per the [docs](https://github.com/htcondor/htcondor/tree/main/build/docker/services#providing-additional-configuration)
* Enabled the `SCHEDD` to run in the same container as the `COLLECTOR` 

# Supported ENV Variables used by [pre-exec.sh](deployment/bin/pre-exec.sh)


- `CONDOR_CONFIG_FILEPATH` - A path to a configfile to be copied into /etc/condor/condor_config.local 
- `POOL_PASSWORD` - The password for the condor pool (to be deprecated by token) 
- `JWT_TOKEN` - CM Token created by `condor_token_create -identity condor-central-manager`
- `SCHEDD_HOST` - If Present, then `SCHEDD` added to `DAEMON_LIST`
 
 
# ENV Vars used by [start.sh](https://github.com/htcondor/htcondor/blob/fa22cbcdc2c66c63d1f5a78a45606125aa44e165/build/docker/services-rhel/base/start.sh)

* `CONDOR_SERVICE_HOST` "${CONDOR_SERVICE_HOST:-${CONDOR_HOST:-\$(FULL_HOSTNAME)}}" 
* `CONDOR_HOST` "${CONDOR_SERVICE_HOST:-${CONDOR_HOST:-\$(FULL_HOSTNAME)}}" 
* `NUM_CPU` "${NUM_CPUS:-1}" \
* `MEMORY` "${MEMORY:-1024}" \
* `RESERVED_DISK` "${RESERVED_DISK:-1024}" \
* `USE_POOL_PASSWORD` "${USE_POOL_PASSWORD:-no}"

