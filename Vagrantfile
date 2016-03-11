VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.ssh.insert_key = false
  config.ssh.pty = true
  config.vm.network "private_network", ip: "10.0.0.10"
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
  end
  config.vm.synced_folder ".", "/mnt/docker", type: "nfs", mount_options: ['rw', 'vers=3', 'tcp', 'fsc', 'actimeo=2']

  if Vagrant.has_plugin?("HostManager")
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
  end
end
