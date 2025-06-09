FROM spritsail/fivem:latest
COPY .docker/entrypoint.sh /entrypoint.sh
COPY server.cfg.template resources /config/
# EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
