FROM node:5

# Create app directory
COPY package.json /tmp
RUN cd /tmp && npm install
RUN mkdir -p /opt/app && cp -a /tmp/node_modules /opt/app/

# Install and setup haproxy
RUN apt-get update && apt-get install -y haproxy supervisor
COPY haproxy.cfg /etc/haproxy/haproxy.cfg

# Setup supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Bundle app source
COPY . /opt/app
WORKDIR /opt/app

EXPOSE 5000

CMD ["/bin/bash", "/opt/app/run"]
