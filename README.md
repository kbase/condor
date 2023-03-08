# Condor Central Manager and Schedd

* KBase specific condor scheduler image.
* Based on the htcondor/cm:9.X images
* DEVOPS: For each new environment you must create tokens as per `generate_ids.sh`


## New behavior
* Copy credentials from environment into correct place as per the [docs](https://github.com/htcondor/htcondor/tree/main/build/docker/services#providing-additional-configuration)
* Enabled the `SCHEDD` to run in the same container as the `COLLECTOR` 

# Supported ENV Variables used by [pre-exec.sh](deployment/bin/pre-exec.sh)
- `CONDOR_SIGNING_KEY` - A path to a signing key that all other tokens are validated from. This must be created one time, and then mounted into the container thereafter
- `UID_DOMAIN` - This gives the URL, such as staging.kbase.us, to be passed into the ALLOW_WRITE and ALLOW_ADVERTISE_STARTD condor parameters to enable ee2 job submission and for condor-workers to start up.

# Supported ENV Variables for Testing
- `OVERWRITE_CONFIG_FILEPATH` - Overwrite condor config for testing
- `COLLECTOR_HOST` - If set to anything, converts this image into a worker, useful for testing

 
 
# ENV Vars used by [start.sh](https://github.com/htcondor/htcondor/blob/fa22cbcdc2c66c63d1f5a78a45606125aa44e165/build/docker/services-rhel/base/start.sh)

* `CONDOR_SERVICE_HOST` "${CONDOR_SERVICE_HOST:-${CONDOR_HOST:-\$(FULL_HOSTNAME)}}" 
* `CONDOR_HOST` "${CONDOR_SERVICE_HOST:-${CONDOR_HOST:-\$(FULL_HOSTNAME)}}" 
* `NUM_CPU` "${NUM_CPUS:-1}" \
* `MEMORY` "${MEMORY:-1024}" \
* `RESERVED_DISK` "${RESERVED_DISK:-1024}" \
* `USE_POOL_PASSWORD` "${USE_POOL_PASSWORD:-no}"

