#!/bin/sh
docker run -d --net=host -p 3306:3006 -v /var/host_lib/mysql:/var/lib/mysql -t hnakamur/mysql
