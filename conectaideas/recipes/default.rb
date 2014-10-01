#
# Cookbook Name:: conectaideas
# Recipe:: default
#
# Copyright 2014, AutoMind
#
# All rights reserved - Do Not Redistribute
#

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

#template '/etc/cron.d/cerrar-sesiones-abiertas' do
#  owner 'root'
#  group 'root'
#  mode 0644
#  source 'crontab.erb'
#end

node[:deploy].keys.each do |app|
  execute 'mkdir' do
    command "mkdir -p #{node[:deploy][app][:deploy_to]}/shared/config/"
  end
  template "#{node[:deploy][app][:deploy_to]}/shared/config/application.yml" do
    owner 'deploy'
    group 'www-data'
    mode 0750
    source 'application.yml.erb'
    variables({:env => node[:deploy][app][:environment]})
  end
end

#execute 'config newrelic' do
#  command "nrsysmond-config --set license_key=#{node[:newrelic]}; /etc/init.d/newrelic-sysmond start"
#end