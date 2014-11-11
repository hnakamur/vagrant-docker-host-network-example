#!/bin/sh
docker run -i --net=host -p 192.168.33.12:3000:3000 -v /vagrant/app2/src:/data/app2 -w /data/app2 -t hnakamur/rails
