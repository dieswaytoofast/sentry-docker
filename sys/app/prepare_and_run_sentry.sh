#!/usr/bin/env bash

SENTRY_CONF_FILE=${SENTRY_CONF_FILE:-/conf/sentry_docker_conf.py}
# export env var for other scripts to work
export SENTRY_CONF=$SENTRY_CONF_FILE

# Prepare sentry
echo "Preparing Sentry..."
/usr/local/bin/sentry_run prepare

# Initialize the data
echo "Initializing data"
/conf/init_sentry_data.sh

# Run sentry
/usr/local/bin/sentry_run "run web"