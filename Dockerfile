# Dockerfile for The Onion Box
FROM python:3.6
MAINTAINER Josh josh.gaby@gmail.com

ENV config_file=/theonionbox-config/theonionbox.cfg
ENV port=8080
ENV cc_enabled=false

# Update pip and install the onion box
RUN pip install pip --upgrade && pip install 'theonionbox @ git+https://github.com/josh-gaby/theonionbox@17414882a8133fccf1e2144829e4a62d16f0765f'

# Install required version of ConfigUpdater to allow us to start the ControlCenter
RUN pip install 'configupdater>=1.0,<2.0' --force-reinstall

# Copy docker-entrypoint
COPY ./scripts/docker-entrypoint /usr/local/bin/

# Create the confid directory
RUN mkdir /theonionbox-config

# Copy config file
COPY ./scripts/theonionbox.cfg /theonionbox-config

RUN touch /theonionbox-config/cc.cfg

EXPOSE ${port}

ENTRYPOINT ["docker-entrypoint"]
