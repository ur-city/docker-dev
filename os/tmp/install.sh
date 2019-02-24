#!/bin/bash



function INIT_USER {
groupadd -g $2 $1
useradd -u $2 -g $2 -s /bin/bash -m $1
echo -e "$1 ALL=(ALL) NOPASSWD: ALL\n" >> /etc/sudoers ;
rsync -av /tmp/docker_home/home/  /home/$1/
chown -R $1:$1 /home/$1/*
}

INIT_USER ol 5188
INIT_USER dev 6188
INIT_USER u88 7188

if [[ -a /etc/supervisor/conf.d/supervisord.conf ]]; then
exit 0
fi

mkdir -p /var/log/supervisor/

#supervisor
cat > /etc/supervisor/conf.d/supervisord.conf <<EOF
[supervisord]
nodaemon=true

[include]
files = /etc/supervisor/conf.d/*.conf

[supervisord]
logfile=/var/log/supervisor/supervisord.log
pidfile=/var/run/supervisord.pid
childlogdir=/var/log/supervisor
EOF

