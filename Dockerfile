FROM spritsail/fivem:latest
COPY server.cfg.template resources /config/
# EXPOSE 80

# TODO: make server.cfg file on start using env vars + server.cfg.template
