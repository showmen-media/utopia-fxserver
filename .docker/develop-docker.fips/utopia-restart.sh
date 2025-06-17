#!/bin/bash
CONTAINER_NAME=utopia-develop-$USER
docker restart $CONTAINER_NAME && echo 'Restart sent'
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${__dir}/utopia-console.sh
