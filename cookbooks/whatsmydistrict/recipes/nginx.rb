#
# Cookbook Name:: whatsmydistrict
# Recipe:: nginx
#

include_recipe 'nginx'

template "#{node['nginx']['dir']}/sites-available/whatsmydistrict.conf" do
  source 'whatsmydistrict.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables :app_root => node['whatsmydistrict']['app_root']
end

nginx_site 'default' do
  action :disable
end

nginx_site 'whatsmydistrict.conf' do
  action :enable
end
