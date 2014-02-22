#
# Cookbook Name:: openlexington
# Recipe:: ruby
#

if node['openlexington']['ruby']['enable_brightbox_apt']
  apt_repository 'ppa_brightbox_ruby-ng' do
    uri          'http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu'
    distribution node['lsb']['codename']
    components   ['main']
    keyserver 'keyserver.ubuntu.com'
    key 'C3173AA6'
    action :add
  end
end

node['openlexington']['ruby']['packages'].each do |p|
  package p do
    action :install
  end
end
