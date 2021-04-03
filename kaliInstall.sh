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

cp /vagrant/45-allow-colord.pkla /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla

systemctl enable xrdp
service xrdp start

# Set keyboard to French
sed -i "s/en/fr/g" /etc/default/keyboard

# Keyboard config for macbook pro
cp /vagrant/Xmodmap /home/kalirdp/.Xmodmap

echo "Congrats, Kali linux is install !"

exit
