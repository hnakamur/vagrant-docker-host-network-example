FROM hnakamur/ruby
MAINTAINER Hiroaki Nakamura <hnakamur@gmail.com>

ENV NODE_VERSION 0.10.33

# * Install mysql-community-devel, mysql-community-client and ImageMagick-devel for a rails app
# * Install python-devel for installing supervisor
# * Install node.js for asset pipeline
# * Install supervisord and unicornherder

RUN yum install -y http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm && \
    yum install -y mysql-community-devel mysql-community-client ImageMagick-devel \
                   python-devel && \
    yum clean all && \
    cd /usr/local/src && \
    curl -O http://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz && \
    tar xf node-v${NODE_VERSION}-linux-x64.tar.gz --strip-components 1 -C /usr/local && \
    curl -kL https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python && \
    pip install supervisor && \
    pip install git+https://github.com/kazuph/unicornherder.git && \
    useradd app && \
    mkdir -p /var/app && \
    chown app: /var/app

ADD reload_unicorn /usr/local/sbin/reload_unicorn
ADD bootstrap.sh /usr/local/sbin/bootstrap.sh
ADD supervisord.conf /etc/supervisord.conf
ADD unicorn.conf /etc/supervisor.d/unicorn.conf

VOLUME ["/data/app"]
WORKDIR "/data/app"

CMD ["/usr/local/sbin/bootstrap.sh"]
