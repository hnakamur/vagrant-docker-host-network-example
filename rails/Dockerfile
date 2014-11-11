FROM hnakamur/ruby
MAINTAINER Hiroaki Nakamura <hnakamur@gmail.com>

RUN yum install -y http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm && \
    yum install -y mysql-community-devel mysql-community-client ImageMagick-devel && \
    yum clean all && \
    cd /usr/local/src && \
    curl -O http://nodejs.org/dist/v0.10.33/node-v0.10.33-linux-x64.tar.gz && \
    tar xf node-v0.10.33-linux-x64.tar.gz --strip-components 1 -C /usr/local

CMD ["/bin/bash"]
