#!/bin/sh

# build and run mysql container
if [ ! `docker images -q hnakamur/mysql` ]; then
  /vagrant/mysql/build.sh
fi

if [ ! `docker images -q hnakamur/ruby` ]; then
  /vagrant/ruby/build.sh
fi

if [ ! `docker images -q hnakamur/rails` ]; then
  /vagrant/rails/build.sh
fi

if [ ! `docker images -q hnakamur/app1` ]; then
  /vagrant/app1/build.sh
fi
if [ ! `docker images -q hnakamur/app2` ]; then
  /vagrant/app2/build.sh
fi

# configure mysql container autostart
if [ ! -f /etc/systemd/system/mysql.container.service ]; then
  cat <<EOF > /etc/systemd/system/mysql.container.service
[Unit]
Description=MySQL container
Author=Me
After=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker start -a mysql
ExecStop=/usr/bin/docker stop -t 10 mysql

[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload
  systemctl enable mysql.container
  /vagrant/mysql/create.sh
  systemctl start mysql.container
fi
