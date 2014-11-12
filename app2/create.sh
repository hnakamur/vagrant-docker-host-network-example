#!/bin/sh
docker create --name app2 --link mysql:mysql -p 3002:3000 -v /vagrant/app2/src:/data/app2 -w /data/app2 -t hnakamur/app2
