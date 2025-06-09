#!/bin/bash
CONTAINER_NAME=utopia-develop-$USER
docker logs --tail 100 --timestamps -f $CONTAINER_NAME
