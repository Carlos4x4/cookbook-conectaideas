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

apt_repository "postgres" do
  uri "http://apt.postgresql.org/pub/repos/apt/"
  distribution "precise-pgdg"
  key "https://www.postgresql.org/media/keys/ACCC4CF8.asc"
  components ["main"]
end

package 'libpq-dev'
package "git-core"
package "libxml2"
package "libxslt-dev"
package "libmagickwand-dev"
package "postgresql-client-9.3"
package "monit"
package 'imagemagick'
package 'wkhtmltopdf'

template "/etc/environment" do
  source "environment.sh.erb"
  mode 0555
end

node[:deploy].each do |application, deploy|
  template "/etc/monit/conf.d/sidekiq_#{application}.monitrc" do
    owner 'root'
    group 'root'
    mode 0644
    source "monitrc.conf.erb"
    variables({
      :worker_count => 1,
      :app_name => application,
      :deploy => deploy
    })
  end

  execute "ensure-sidekiq-is-setup-with-monit" do
    command %Q{
      monit reload
    }
  end

  execute "restart-sidekiq" do
    command %Q{
      echo "sleep 20 && monit -g sidekiq_#{application} restart all" | at now
    }
  end
end

cron_d 'cerrar-sesiones-abiertas' do
  minute  '*/10'
  hour    '*'
  command "cd #{node[:deploy][:conectaideas][:deploy_to]}/current && bundle exec rake sagde:cerrar_sesiones_alerta_inactivas"
  user    'deploy'
end

