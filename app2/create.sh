#!/bin/sh
docker create --name app2 --link mysql:mysql -p 3002:3000 -v /vagrant/app2/src:/data/app -w /data/app -t hnakamur/rails
