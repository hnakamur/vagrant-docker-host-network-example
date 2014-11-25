#!/bin/sh
docker create --name app1 --link mysql:mysql -p 3001:3000 -v /vagrant/app1/src:/data/app -w /data/app -t hnakamur/rails
