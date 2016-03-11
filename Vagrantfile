_config = YAML.load(File.open(File.join(File.dirname(__FILE__), "vagrantconfig.yml"), File::RDONLY).read)
CONF = _config

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.ssh.insert_key = false
  config.vm.network "private_network", ip: CONF["ipaddress"]
  config.vm.provider "virtualbox" do |v|
    v.memory = CONF["ram"]
    v.cpus = CONF["cpus"]
  end
  config.vm.synced_folder ".", "/mnt/docker", type: "nfs", mount_options: ['rw', 'vers=3', 'tcp', 'fsc', 'actimeo=2']

  if Vagrant.has_plugin?("HostManager")
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
  end
end
