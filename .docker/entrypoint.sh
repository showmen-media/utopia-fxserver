#!/bin/sh

# Terminate as soon as any command fails
set -e

SCRIPT_DIR=$(readlink -f "$0")
if [ $SCRIPT_DIR != "/config/.docker/entrypoint.sh" ]; then
	# If /config/.docker/entrypoint.sh exists, run it instead
	if [ -f /config/.docker/entrypoint.sh ]; then
		/bin/sh /config/.docker/entrypoint.sh
		exit 0
	fi
fi

/bin/sh /config/.docker/autodownload.sh

echo "Starting Utopia FXServer"
/sbin/tini -- /usr/bin/entrypoint
