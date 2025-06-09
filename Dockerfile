
#TODO: Update FXServer to the newest recommended version, 7290, or higher.
# 		It includes a fix for a Denial Of Service vulnerability.
FROM spritsail/fivem:latest
COPY .docker/entrypoint.sh /entrypoint.sh
COPY server.cfg.template resources /config/
# EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
