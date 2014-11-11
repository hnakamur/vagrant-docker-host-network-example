#!/bin/sh
docker run -i --net=host -p 192.168.33.11:3000:3000 -v /vagrant/app1/src:/data/app1 -t hnakamur/app1 /bin/bash
