Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision :shell, path: "bootstrap_root.sh"
  config.vm.provision :shell, path: "bootstrap.sh", privileged: false
  config.vm.provision :shell, path: "boot.sh", privileged: false, run: "always"
  
  config.vm.network "forwarded_port", guest:8888, host:8888, auto_correct:true
  config.vm.network "forwarded_port", guest:3000, host:3000, auto_correct:true
  config.vm.network "forwarded_port", guest:80, host:8080, auto_correct:true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "8092"
  end
  config.ssh.password = "vagrant"

end
