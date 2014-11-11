#!/bin/sh
docker build -t hnakamur/mysql /vagrant/mysql
docker run -d --name mysql -p 3306:3306 -t hnakamur/mysql

docker build -t hnakamur/ruby /vagrant/ruby
