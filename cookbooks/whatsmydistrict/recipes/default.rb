#
# Cookbook Name:: whatsmydistrict
# Recipe:: default
#

include_recipe 'apt'
include_recipe 'git'

app_root = node['whatsmydistrict']['app_root']
db_attr = node['whatsmydistrict']['database']

gem_package 'bundler' do
  options '--no-ri --no-rdoc'
end

group 'whatsmydistrict' do
  action :create
end

user 'whatsmydistrict' do
  gid 'whatsmydistrict'
  shell '/bin/bash'
  home '/home/whatsmydistrict'
  supports manage_home: true
  action :create
end

git '/home/whatsmydistrict/WhatsMyDistrict' do
  repository 'https://github.com/openlexington/WhatsMyDistrict.git'
  user 'whatsmydistrict'
  group 'whatsmydistrict'
  action :checkout
end

[app_root, "#{app_root}/shared/log", "#{app_root}/shared/tmp", "#{app_root}/shared/models"].each do |d|
  directory d do
    recursive true
    action :create
  end
end

template "#{app_root}/shared/models/database_model.rb" do
  source 'database_model.rb.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables :db_name => db_attr['db_name']
  variables :user => db_attr['user']
  variables :password => db_attr['password']
  variables :host => db_attr['host']
end

template "#{app_root}/shared/unicorn.rb" do
  source 'unicorn.rb.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables :app_root => app_root
end
