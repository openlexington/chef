# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_plugin 'vagrant-berkshelf'
Vagrant.require_plugin 'vagrant-cachier'

Vagrant.configure('2') do |config|
  config.vm.define 'wmd' do |wmd|
    wmd.vm.box = 'opscode-ubuntu-12.04'
    wmd.vm.box_url = 'https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box'

    wmd.vm.network :private_network, ip: '192.168.33.100'
    wmd.vm.network :forwarded_port, guest: 80, host: 8080

    wmd.vm.provider 'virtualbox' do |v|
      v.customize ['modifyvm', :id, '--memory', 512]
      v.customize ['modifyvm', :id, '--name', 'whatsmydistrict']
    end

    # plugin configuration
    wmd.berkshelf.enabled = true
    wmd.cache.enable :apt
    wmd.cache.enable :chef
    wmd.cache.enable :gem

    wmd.vm.provision :chef_solo do |chef|
      chef.log_level = :debug
      chef.run_list = [
        'recipe[apt]',
        'recipe[openlexington::ruby]',
        'recipe[openlexington::postgis]',
        'recipe[whatsmydistrict::default]',
        'recipe[whatsmydistrict::database]',
        'recipe[whatsmydistrict::nginx]'
      ]
      chef.json = {
        build_essential: { compiletime: true },
        postgresql: { password: { postgres: 'password' } },
        openlexington: { ruby: { version: '1.9.1' } }
      }
    end
  end
end
