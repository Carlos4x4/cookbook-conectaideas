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

apt_repository 'newrelic' do
  uri 'http://apt.newrelic.com/debian/'
  distribution 'newrelic'
  key 'https://download.newrelic.com/548C16BF.gpg'
  components ['non-free']
end

package 'libpq-dev'
package 'git-core'
package 'libxml2'
package 'libxslt-dev'
package 'libmagickwand-dev'
package 'postgresql-client-9.3'
package 'monit'
package 'imagemagick'
#package 'wkhtmltopdf'
package 'sendmail'
package 'mutt'
package 'htop'
package 'newrelic-sysmond'
package 'language-pack-UTF-8'

#dependencias wkthmltopdf 0.12
#package 'libfontenc1'
#package 'libxfont1'
#package 'xfonts-75dpi'
#package 'xfonts-base'
#package 'xfonts-encodings'
#package 'xfonts-utils'

#remote_file "/tmp/wkhtmltox-0.12.2.1_linux-trusty-amd64" do
#  source "http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb"
#  mode 0644
#  checksum "1cf47ab83a3352e7df95f2973061e8c90daabb1333f00e2385cb8b2b0ff22a90"
#end

#dpkg_package "wkthmltox" do
#  source "/tmp/wkhtmltox-0.12.2.1_linux-trusty-amd64"
#  action :install
#end

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


# script 'create swapfile' do
#   interpreter 'bash'
#   not_if { File.exists?('/var/swapfile') }
#   code <<-eof
#     mem_size=$(free -b | grep "Mem:" | awk '{print $2}') &&
#     sudo dd if=/dev/zero of=/var/swapfile bs=1M count=$((${mem_size}/1024/1024)) &&
#     chmod 600 /var/swapfile &&
#     mkswap /var/swapfile
#   eof
# end

# mount '/dev/null' do  # swap file entry for fstab
#   action :enable  # cannot mount; only add to fstab
#   device '/var/swapfile'
#   fstype 'swap'
# end
#
# script 'activate swap' do
#   interpreter 'bash'
#   code 'swapon -a'
# end

node[:deploy].keys.each do |app|
  execute 'mkdir' do
    command "mkdir -p #{node[:deploy][app][:deploy_to]}/shared/config/"
  end
  template "#{node[:deploy][app][:deploy_to]}/shared/config/application.yml" do
    owner 'deploy'
    group 'deploy'
    mode 0750
    source 'application.yml.erb'
    variables({:env => node[:deploy][app][:environment]})
  end
end


execute 'config newrelic' do
  command "nrsysmond-config --set license_key=#{node[:newrelic]}; /etc/init.d/newrelic-sysmond start"
end