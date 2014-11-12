#!/bin/sh
docker run -i --name app1 --link mysql:mysql -p 3001:3000 -v /vagrant/app1/src:/data/app1 -w /data/app1 -t hnakamur/app1 /bin/bash
