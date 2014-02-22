#
# Cookbook Name:: whatsmydistrict
# Recipe:: database
#

include_recipe 'database::postgresql'

attr = node['whatsmydistrict']['database']
con = {username: 'postgres', host: 'localhost'}

postgresql_database_user(attr['user']) do
  action :create
  password attr['password']
  connection con
end

postgresql_database(attr['db_name']) do
  action :create
  owner attr['user']
  connection con
end

postgresql_database_user(attr['user']) do
  action :grant
  database_name attr['db_name']
  privileges [:all]
  connection con
end
