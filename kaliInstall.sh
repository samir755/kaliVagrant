#!/usr/bin/env bash

echo "
    ##------------------------------------------------------//
    ##       Script d'installation de la VM Kali Linux      //
    ##                  V1.0.1 by Sa33rix                   //
    ##------------------------------------------------------//
"

# Nettoyage des dépendences
export UCF_FORCE_CONFFNEW=YES
ucf --purge /boot/grub/menu.lst

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -o Dpkg::Options::="--force-confnew" --force-yes -fuy dist-upgrade

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
adduser --disabled-password --gecos "" kali
echo "kali:vagrant" | chpasswd
sudo usermod -aG sudo kali

#Install XRDP
apt-get install xrdp -y
cp /etc/xrdp/xrdp.ini /etc/xrdp/xrdp.ini.bak
sed -i 's/max_bpp=32/#max_bpp=32\nmax_bpp=128/g' /etc/xrdp/xrdp.ini
sed -i 's/xserverbpp=24/#xserverbpp=24\nxserverbpp=128/g' /etc/xrdp/xrdp.ini

cp /vagrant/45-allow-colord.pkla /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla

apt-get remove xorgxrdp
systemctl enable xrdp
service xrdp start

# Set keyboard to French
sed -i "s/us/fr/g" /etc/default/keyboard

# Keyboard config for macbook pro
cp /vagrant/Xmodmap /home/kali/.Xmodmap

# Changement de la résolution
echo "xrandr --output Virtual1 --mode 1920x1440" > /home/vagrant/.Xprofile
chmod +x /home/vagrant/.Xprofile

# Fix bug
sed -i "s/bin\/sh/bin\/bash/g" /etc/xrdp/startwm.sh


echo "Congrats, Kali linux is install !"
exit
