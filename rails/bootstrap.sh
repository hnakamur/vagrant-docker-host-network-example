#!/bin/sh
su app -c "(bundle install --jobs 4 --path /var/app/vendor/bundle --binstubs /var/app/vendor/bin && bundle exec rake db:create && bundle exec rake db:migrate && mkdir -p /data/tmp/pids) >> /data/app/log/bundle_stdout.log 2>> /data/app/log/bundle_stderr.log"

exec /bin/supervisord -n -c /etc/supervisord.conf
