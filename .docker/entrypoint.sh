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

endinit() {
	echo "Starting Utopia FXServer"
	/sbin/tini -- /usr/bin/entrypoint
	exit 0
}


# TODO: automatically make server.cfg file on start using env vars + server.cfg.template


CONFIG_AUTODOWNLOAD="/config/autodownload"
AUTODOWNLOAD_HASH=$(find $CONFIG_AUTODOWNLOAD -type f -exec md5sum {} + | sort | md5sum | awk '{ print $1 }')
LOCAL_AUTODOWNLOAD="/config/resources/[local]/[autodownload]"

if [ -f "$LOCAL_AUTODOWNLOAD/hash" ]; then
	LOCAL_HASH=$(cat $LOCAL_AUTODOWNLOAD/hash)
	if [ "$AUTODOWNLOAD_HASH" == "$LOCAL_HASH" ]; then
		endinit
	fi
fi

rm -rf $LOCAL_AUTODOWNLOAD
mkdir -p $LOCAL_AUTODOWNLOAD

if [ -f "$CONFIG_AUTODOWNLOAD/download-list.yml" ]; then
	while IFS= read -r line; do
		if [ -n "$line" ] && [[ ! "$line" =~ ^# ]]; then

			# Skip empty lines and comments
			if [ -z "$line" ] || [[ "$line" =~ ^# ]]; then
				continue
			fi

			RESR_NAME=$(echo "$line" | awk -F': ' '{print $1}')
			RESR_ZIP_URL=$(echo "$line" | awk -F': ' '{print $2}' | cut -d'#' -f1)
			RESR_ZIPD_FOLDER=$(echo "$line" | awk -F': ' '{print $2}' | awk -F'#' '{print $2}')

			echo "Downloading resource $RESR_NAME from $RESR_ZIP_URL"

			wget -q $RESR_ZIP_URL -O "$LOCAL_AUTODOWNLOAD/$RESR_NAME.zip"
			unzip -q "$LOCAL_AUTODOWNLOAD/$RESR_NAME.zip" -d "$LOCAL_AUTODOWNLOAD/$RESR_NAME"

			if [ -n "$RESR_ZIPD_FOLDER" ]; then
				mv "$LOCAL_AUTODOWNLOAD/$RESR_NAME/$RESR_ZIPD_FOLDER" "$LOCAL_AUTODOWNLOAD/${RESR_NAME}_temp"
				rm -rf "$LOCAL_AUTODOWNLOAD/$RESR_NAME"
				mv "$LOCAL_AUTODOWNLOAD/${RESR_NAME}_temp" "$LOCAL_AUTODOWNLOAD/$RESR_NAME"
			fi

			rm "$LOCAL_AUTODOWNLOAD/$RESR_NAME.zip"

		fi
	done < "$CONFIG_AUTODOWNLOAD/download-list.yml"
fi

#TODO: replace files in /config/resources/[local]/[autodownload] with the ones from /config/autodownload


echo "$AUTODOWNLOAD_HASH" > $LOCAL_AUTODOWNLOAD/hash

endinit
