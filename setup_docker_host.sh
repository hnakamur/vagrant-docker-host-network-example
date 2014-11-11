#!/bin/sh
yum install -y bind-utils

# configure firewall
if ! (iptables-save | grep '^-A IN_public_allow -p tcp -m tcp --dport 3000 -m conntrack --ctstate NEW -j ACCEPT$'); then
  firewall-cmd --permanent --add-port=3000/tcp
  systemctl restart firewalld.service

  # NOTE: Without restarting docker service, I could not resolve hostnames on the Internet
  # within a container.
  systemctl restart docker.service
fi
