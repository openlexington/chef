#
# Cookbook Name:: whatsmydistrict
# Recipe:: database
#

include_recipe 'database::postgresql'

attr = node['whatsmydistrict']['database']

postgresql_database_user(attr['user']) do
  action :create
  password attr['password']
  connection {username: 'postgres', host: 'localhost'}
end

postgresql_database(attr['db_name']) do
  action :create
  owner attr['user']
  connection {username: 'postgres', host: 'localhost'}
end

postgresql_database_user(name) do
  action :grant
  database_name attr['db_name']
  privileges [:all]
  connection {username: 'postgres', host: 'localhost'}
end
