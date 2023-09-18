#!/bin/bash

# Netzwerkkonfiguration
echo "network:
  ethernets:
    eth0:
      addresses:
        - 192.168.110.61/24
      nameservers:
        addresses:
          - 192.168.110.2
      search:
        - sam159.iet-gibb.ch
      routes:
        - to: default
          via: 192.168.110.2
  version: 2" > /etc/netplan/00-eth0.yaml

# Anpassen von /etc/hosts
echo "127.0.0.1 localhost.localdomain localhost
127.0.1.1 vmLS1.sam159.iet-gibb.ch vmLS1
192.168.110.61 vmLS1.sam159.iet-gibb.ch vmLS1
::1 ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters" > /etc/hosts

# Anpassen von /etc/hostname
echo "vmLS1.sam159.iet-gibb.ch" > /etc/hostname

# Rechner updaten
sudo apt update && sudo apt upgrade -y

# Samba und erforderliche Pakete installieren
sudo apt install -y samba smbclient heimdal-clients acl attr build-essential libacl1-dev libattr1-dev libblkid-dev libgnutls28-dev libreadline-dev python2-dev python2 python-dev-is-python3 python3-dnspython gdb pkg-config libpopt-dev libldap2-dev libbsd-dev krb5-user docbook-xsl libcups2-dev acl ntp ntpdate net-tools git winbind libpam0g-dev dnsutils lsof

# Sichern Sie das ursprüngliche smb.conf-Datei
mv /etc/samba/smb.conf /etc/samba/smb.conf.orig

# Setup Samba als KDC und DC
samba-tool domain provision --use-rfc2307 --realm=SAM159.IET-GIBB.CH --domain=SAM159 --server-role=dc --dns-backend=SAMBA_INTERNAL --adminpass=SmL12345**

# Deaktivieren Sie den DNS-Resolver und erstellen Sie eine neue resolv.conf-Datei
systemctl disable systemd-resolved
systemctl stop systemd-resolved
rm /etc/resolv.conf
echo "nameserver 192.168.110.61
search sam159.iet-gibb.ch" > /etc/resolv.conf

# Konfigurieren Sie die smb.conf-Datei
echo "[global]
dns forwarder = 8.8.8.8
netbios name = VMLS1
realm = SAM159.IET-GIBB.CH
server role = active directory domain controller
workgroup = SAM159

[sysvol]
path = /var/lib/samba/sysvol
read only = No

[netlogon]
path = /var/lib/samba/sysvol/sam159.iet-gibb.ch/scripts
read only = No" > /etc/samba/smb.conf

# Samba beim Systemstart automatisch starten
systemctl unmask samba-ad-dc
systemctl enable samba-ad-dc
systemctl start samba-ad-dc

# Überprüfen Sie die Samba-Dienststatus
systemctl status samba-ad-dc
