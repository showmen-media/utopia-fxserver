#!/bin/bash

# This script sets up a Docker container for the Utopia FXServer development environment.


# Check if .git directory exists and store the result in a variable
[ -d .git ]
IS_VALID=$?

# Check if `showmen-media/utopia-fxserver` is in the remote list and update IS_VALID accordingly
git remote -v | grep -q "showmen-media/utopia-fxserver"
IS_VALID=$((IS_VALID + $?))

if [ $IS_VALID -ne 0 ]; then
	echo "This script must be run in the root of the Utopia FXServer repository."
	exit 1
fi

# Check if server.cfg and .env.local files exist in the current directory
if [ ! -f server.cfg ] || [ ! -f .env.local ]; then
	echo "Please add \`server.cfg\` and \`.env.local\` to the directory."
	exit 1
fi

# Set up the Docker container
FIVEM_PORT=$(($UID+29120))
FXRPC_PORT=$(($UID+49051))
CONTAINER_NAME=utopia-develop-$USER

# Check if the container already exists
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
	CONTAINER_STATE=$(docker inspect -f '{{.State.Status}}' $CONTAINER_NAME)
	echo -e "Container \e[7m\033[1m $CONTAINER_NAME \033[0m\e[0m already exists and is \e[7m\033[1m $CONTAINER_STATE \033[0m\e[0m."
	echo "Proceed with replacing it? [y/N]"
	read -r REPLACE_CONTAINER
	echo ""
	if [[ ! "$REPLACE_CONTAINER" =~ ^[Yy]$ ]]; then
		echo "Exiting without changes."
		exit 0
	fi

	docker stop $CONTAINER_NAME > /dev/null 2>&1
	docker rm $CONTAINER_NAME > /dev/null 2>&1

	if [ "$CONTAINER_STATE" == "running" ]; then
		echo -e "Existing container $CONTAINER_NAME stopped and removed."
	else
		echo -e "Existing container $CONTAINER_NAME removed."
	fi

	echo ""
fi

CONTAINER_HASH=$(\
	docker run -it -d\
	 --env-file .env.local\
	 --name $CONTAINER_NAME\
	 -p $FIVEM_PORT:30120\
	 -p $FIVEM_PORT:30120/udp\
	 -p $FXRPC_PORT:50051\
	 -v $(pwd):/config\
	 utopia-fxserver
)

if [ $? -eq 0 ]; then
	CONTAINER_HASH=${CONTAINER_HASH:0:8}
	echo -e "New container \e[7m\033[1m $CONTAINER_NAME \033[0m\e[0m ($CONTAINER_HASH) started."
	echo -e "It will be accessible using \e[7m\033[1m develop-docker.fips:$FIVEM_PORT \033[0m\e[0m."
	echo -e "FxRPC available at \e[7m\033[1m develop-docker.fips:$FXRPC_PORT \033[0m\e[0m."
	echo ""
fi
