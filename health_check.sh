#!/usr/bin/env bash
# This can be run by postStart to see if required variables have been set

: "${UID_DOMAIN:?Variable not set or empty}"
: "${CONDOR_JWT_TOKEN:?Variable not set or empty}"
