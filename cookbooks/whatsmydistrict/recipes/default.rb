#
# Cookbook Name:: whatsmydistrict
# Recipe:: default
#

include_recipe 'apt'
include_recipe 'git'
include_recipe 'nginx'
include_recipe 'postgis'

app_root = node['whatsmydistrict']['app_root']
database_password = node['whatsmydistrict']['database_password']

gem_package 'bundler' do
  options '--no-ri --no-rdoc'
end

package 'libpq-dev'

[app_root, "#{app_root}/shared/log", "#{app_root}/shared/tmp", "#{app_root}/shared/models"].each do |d|
  directory d do
    recursive true
    action :create
  end
end

template "#{node['nginx']['dir']}/sites-available/whatsmydistrict.conf" do
  source 'whatsmydistrict.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables :app_root => app_root
end

template "#{app_root}/shared/models/database_model.rb" do
  source 'database_model.rb.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables :database_password => database_password
end

template "#{app_root}/shared/unicorn.rb" do
  source 'unicorn.rb.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables :app_root => app_root
end

nginx_site 'default' do
  action :disable
end

nginx_site 'whatsmydistrict.conf'
