#
# Cookbook Name:: conectaideas
# Recipe:: default
#
# Copyright 2013, AutoMind
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apt'
include_recipe 'cron'

apt_repository 'postgres' do
  uri 'http://apt.postgresql.org/pub/repos/apt/'
  distribution 'precise-pgdg'
  key 'https://www.postgresql.org/media/keys/ACCC4CF8.asc'
  components ['main']
end

package 'libpq-dev'
package 'git-core'
package 'libxml2'
package 'libxslt-dev'
package 'libmagickwand-dev'
package 'postgresql-client-9.3'
package 'monit'
package 'imagemagick'
package 'wkhtmltopdf'
package 'sendmail'
package 'mutt'

template "/etc/environment" do
  source "environment.sh.erb"
  mode 0555
end

template '/etc/monit/conf.d/sidekiq_conectaideas.monitrc' do
  owner 'root'
  group 'root'
  mode 0644
  source 'monitrc.conf.erb'
  variables({
    :worker_count => 1,
    :app_name => 'conectaideas',
    :deploy => node[:deploy][:conectaideas]
  })
end

execute 'ensure-sidekiq-is-setup-with-monit' do
  command 'monit reload'
end

execute 'restart-sidekiq' do
  command 'sleep 20 && monit -g sidekiq_conectaideas restart all | at now'
end

template '/etc/cron.d/cerrar-sesiones-abiertas' do
  owner 'root'
  group 'root'
  mode 0644
  source 'crontab.erb'
end

execute 'instalar loggly' do
  command "wget -q -O - https://www.loggly.com/install/configure-syslog.py | sudo python - setup --auth #{node[:loggly][:auth]} --account #{node[:loggly][:account]} --yes"
  cwd '/tmp'
  creates '/etc/rsyslog.d/22-loggly.conf'  
end

