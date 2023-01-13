#!/usr/bin/env bash
# Example of how to generate ids using the autogenerated signing key
UID_DOMAIN=condor.staging.kbase.us
condor_token_create -identity kbase_workers@${UID_DOMAIN} -token kbase_workers
condor_token_create -identity nersc_workers@${UID_DOMAIN} -token nersc_workers
condor_token_create -identity rest_api@${UID_DOMAIN} -token rest_api
condor_token_create -identity condor_stats@${UID_DOMAIN} -token condor_stats

#Used in EE2 Submit
condor_token_create -identity condor_pool@${UID_DOMAIN} -token kbase_submit

