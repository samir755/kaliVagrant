**Objectifs**

Build your own VM Kali Linux in Windows with Vagrant, and access in RDP from your Macbook pro (FR).

Ok with a VPS it's simple but i'm tight...

**Configuration**
>>>

* **OS** : Kali linux
* **Xrdp** : ??
* **IP** : 127.0.0.1:4567

* **Nom machine**: kali.local

>>>

**prerequisite**

Windows Environment + [Vagrant](https://www.vagrantup.com/intro/getting-started/install.html)
Macbook Pro > 2017 + Microsoft Remote Desktop 

# Setting up Kali linux

Create the repository `C:\workspaces\kali` and include files from this repository inside.

Depend on the configuration of your PC, You'll probably need to custom the folowing values in `Vagrantfile`.

Keep in mind that your pentest lab need BIG resources.

```bash
vb.customize ["modifyvm", :id, "--ioapic", "on"] # Set "on" if you need more than 1 CPU
vb.customize ["modifyvm", :id, "--cpus", "3"] // Core 
vb.customize ["modifyvm", :id, "--memory", "4096"] // RAM
```

## File kaliInstall.sh

```bash
#!/usr/bin/env bash

echo "
    ##------------------------------------------------------//
    ##       Script d'installation de la VM Kali Linux      //
    ##                  V1.0.1 by Sa33rix                   //
    ##------------------------------------------------------//
"

# Nettoyage des dépendences
apt-get -y update
rm -rf /var/lib/apt/lists/*
apt-get -y update

# MAJ et Installation des paquets
apt-get -y upgrade
apt-get -y install htop zip iotop iptraf tree

# Paramètrage du nom d'hôte: hostname
echo "kali.local" > /etc/hostname
sed -i '/^127.0.1.1/d' /etc/hosts
echo "127.0.1.1 kali.local" >> /etc/hosts
hostname kali.local

# Changement du MDP vagrant
echo "kali:vagrant" | chpasswd

# Ajout du compte Kali pour la connexion rdp
useradd -m -p vagrant -s /bin/bash kalirdp
sudo usermod -aG sudo kalirdp

#Install XRDP
apt-get install xrdp -y
cp /etc/xrdp/xrdp.ini /etc/xrdp/xrdp.ini.bak
sed -i 's/max_bpp=32/#max_bpp=32\nmax_bpp=128/g' /etc/xrdp/xrdp.ini
sed -i 's/xserverbpp=24/#xserverbpp=24\nxserverbpp=128/g' /etc/xrdp/xrdp.ini

systemctl enable xrdp
service xrdp start

cp /vagrant/45-allow-colord.pkla /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla

# Set keyboard to French
sed -i "s/en/fr/g" /etc/default/keyboard

# Keyboard config for macbook pro
cp /vagrant/Xmodmap /home/kalirdp/.Xmodmap

echo "Congrats, Kali linux is install !"

exit
```

## Start your Kali VM
In PowerShell **administrator mode**, go to your kali folder and execute: 
```shell
vagrant up
```

Once everything is done, you can connect with RDP, folowing this information:
```
Host: 127.0.0.1
Port: 3400

Login/Mdp: kalirdp/vagrant
```
