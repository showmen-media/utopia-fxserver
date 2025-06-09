#!/bin/bash
CONTAINER_NAME=utopia-develop-$USER
echo ""
echo -e "Use \e[7m\033[1m Ctrl-D \033[0m\e[0m to detach from the container without stopping it."
echo ""

# Count down from 3
for i in {3..1}; do
	echo -ne "\r\e[7m\033[1m $i \033[0m\e[0m"
	sleep 1
done

echo -ne "\rAttaching…\n"
docker logs --tail 5 $CONTAINER_NAME
#TODO: send SPACE, Ctrl-C and ENTER before attaching to ensure the console is ready
docker attach --detach-keys="ctrl-d" $CONTAINER_NAME
