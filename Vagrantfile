# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

# Load up our vagrant config files -- vagrantconfig.yml first
_config = YAML.load(File.open(File.join(File.dirname(__FILE__), "vagrantconfig.yml"), File::RDONLY).read)
CONF = _config

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(2) do |config|
  config.ssh.insert_key = false
  config.vm.box_check_update = false
  config.vm.network "private_network", ip: CONF["ipaddress"]
  config.vm.provider "virtualbox" do |v|
    config.vm.box = "ubuntu/trusty64"
    v.memory = CONF["ram"]
    v.cpus = CONF["cpus"]
  end
  config.vm.provider "vmware_fusion" do |v|
    config.vm.box = "puphpet/ubuntu1404-x64"
    v.vmx["memsize"] = CONF["ram"]
    v.vmx["numvcpus"] = CONF["cpus"]
  end
  config.vm.synced_folder ".", "/mnt/docker", type: "nfs", mount_options: ['rw', 'vers=3', 'tcp', 'fsc', 'actimeo=1']
end
