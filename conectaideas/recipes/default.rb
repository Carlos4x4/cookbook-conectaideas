#
# Cookbook Name:: conectaideas
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apt'

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

# template "/etc/environment" do
#   source "environment.sh.erb"
#   mode 0555
# end
# 
# application 'conectaideas' do
#     path node[:conectaideas][:path]
#     revision 'HEAD'
#     repository node[:conectaideas][:scm]
#     deploy_key node[:conectaideas][:key]
#     rails do
#       bundler true
#       gems ['bundler']
#     end
#     unicorn do
#       worker_processes 2
#     end
# end