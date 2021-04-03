# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "kalilinux/rolling"
  config.vm.network "forwarded_port", guest: 3389, host: 3400, host_ip: "127.0.0.1"
  config.vm.box_check_update = true

  config.vm.provision :shell, path: "kaliInstall.sh"
  config.vm.communicator = "winrm"

  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--cpus", "3"]
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    vb.name = "dev.kali.local"
  end

end

