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

if [ ! -f /usr/local/sbin/enter_container ]; then
  cat <<'EOF' > /usr/local/sbin/enter_container
#!/bin/sh
sudo nsenter --target $(docker inspect --format '{{.State.Pid}}' $1) --mount --uts --ipc --net --pid
EOF
  chmod +x /usr/local/bin/enter_container
fi

if [ ! -f /usr/local/sbin/delayed_start_container ]; then
  cat <<'EOF' > /usr/local/sbin/delayed_start_container
#!/bin/sh
# NOTE: We need to wait till app source directories are mounted via Vagrant shared folder
sleep 10
/bin/docker start -a $1
EOF
  chmod +x /usr/local/bin/delayed_start_container
fi

# configure app1 container autostart
if [ ! -f /etc/systemd/system/app1.container.service ]; then
  cat <<EOF > /etc/systemd/system/app1.container.service
[Unit]
Description=app1 container
Author=Me
After=docker.service

[Service]
Restart=always
ExecStart=/usr/local/sbin/delayed_start_container app1
ExecStop=/bin/docker stop -t 10 app1

[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload
  systemctl enable app1.container
  /vagrant/app1/create.sh
  systemctl start app1.container
fi

# configure app2 container autostart
if [ ! -f /etc/systemd/system/app2.container.service ]; then
  cat <<EOF > /etc/systemd/system/app2.container.service
[Unit]
Description=app2 container
Author=Me
After=docker.service

[Service]
Restart=always
ExecStart=/usr/local/sbin/delayed_start_container app2
ExecStop=/bin/docker stop -t 10 app2

[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload
  systemctl enable app2.container
  /vagrant/app2/create.sh
  systemctl start app2.container
fi
