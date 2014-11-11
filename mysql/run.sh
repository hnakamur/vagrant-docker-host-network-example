#!/bin/sh
docker run -i --net=host -p 3306:3006 -v /var/host_lib/mysql:/var/lib/mysql -t hnakamur/mysql /bin/bash
