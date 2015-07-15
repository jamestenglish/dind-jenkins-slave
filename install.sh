#!/bin/bash
set -e

# sshd configure
cat > /etc/supervisor/conf.d/sshd.conf <<EOF
[program:sshd]
directory=/
command=/usr/sbin/sshd -D
user=root
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
