# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "bento/centos-6.7"
  config.vm.box_version = "2.2.3"
  config.vm.provision :shell, path: "provision.sh", privileged: false
end
