# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "kalilinux/rolling"
  config.vm.box_check_update = true

  config.vm.network "public_network", ip: "192.168.1.61"

  config.vm.provision :shell, path: "kaliInstall.sh"

  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--cpus", "4"]
    vb.customize ["modifyvm", :id, "--memory", "8192"]
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    vb.name = "dev.kali.local"
  end

end

