node[:deploy].keys.each do |app|
  template "#{node[:deploy][app][:deploy_to]}/shared/config/application.yml" do
    owner 'deploy'
    group 'deploy'
    mode 0750
    source 'application.yml.erb'
    variables({:env => node[:deploy][app][:environment]})
  end
end