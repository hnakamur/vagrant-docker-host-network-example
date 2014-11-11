FROM centos:centos7
MAINTAINER Hiroaki Nakamura <hnakamur@gmail.com>

RUN yum install -y http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm && \
    yum install -y mysql-community-server && \
    yum clean all

VOLUME ["/var/lib/mysql"]
ADD my.cnf /etc/my.cnf
ADD init_db.sh /root/init_db.sh

EXPOSE 3306
CMD ["/usr/bin/mysqld_safe"]
