#!/bin/bash
CONTAINER_NAME=utopia-develop-$USER
docker restart $CONTAINER_NAME && echo 'Restart sent'
# To detach the tty without exiting the shell, use the escape sequence Ctrl-p + Ctrl-q
