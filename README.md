# Kali + Vagrant with RDP

### Goal

Build your own VM Kali Linux in Windows with Vagrant, and access in RDP from your Macbook pro (FR).

Ok with a VPS it's quite simple, but if you prefer doing your business in local, it's a good solution !

**Prerequisite**
>>>

* Windows Environment + [Vagrant](https://www.vagrantup.com/intro/getting-started/install.html)
* Macbook Pro or equivalent + [Microsoft Remote Desktop](https://apps.apple.com/fr/app/microsoft-remote-desktop/id1295203466?mt=12) 

>>>

### Setting up Kali linux

Create `C:\workspaces\kali` and clone this repository inside.

Depend on the configuration of your PC, You'll probably need to custom the following values in `Vagrantfile`.

Keep in mind that your pentest lab need BIG resources.

```bash
vb.customize ["modifyvm", :id, "--ioapic", "on"] # Set "on" if you need more than 1 CPU
vb.customize ["modifyvm", :id, "--cpus", "4"] // Core 
vb.customize ["modifyvm", :id, "--memory", "8192"] // RAM
```

## Start your Kali VM
In PowerShell **administrator mode**, go to your kali folder and execute: 
```shell
vagrant up
```

Once the process is over, you should be able to connect in RDP with this information:
```
Pc Name: 192.168.1.61:3389
User account: kali:vagrant

Account in your host VM vagrant:vagrant
```

## Note

If your RDP connexion is slow, change your Color Quality in Microsoft Remote Desktop to 16 bit.

