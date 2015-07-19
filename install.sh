#!/bin/bash
set -e

# sshd configure
cat > /etc/supervisor/conf.d/swarm-client.conf <<EOF
[program:swarm-client]
directory=/
command=${JENKINS_WORKSPACE}/swarm-client
user=${JENKINS_WORKUSER}
autostart=true
autorestart=true
EOF

# docker configure
cat > /etc/supervisor/conf.d/wrapdocker.conf <<EOF
[program:wrapdocker]
directory=/
command=/usr/local/bin/wrapdocker
user=root
autostart=true
autorestart=true
EOF
