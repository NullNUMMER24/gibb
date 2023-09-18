#!/bin/bash

# Installation der ldap-tools und des LAM
sudo apt-get install smbldap-tools -y
sudo apt install ldap-account-manager -y

# Konfiguration des LAM-Profils
sudo -u www-data php /usr/share/ldap-account-manager/config/confi create-profile sam159Domain
sudo -u www-data php /usr/share/ldap-account-manager/config/confi set-profile-param sam159Domain Host ldap://vmls1.sam159.iet-gibb.ch
sudo -u www-data php /usr/share/ldap-account-manager/config/confi set-profile-param sam159Domain BaseDN dc=sam159,dc=iet-gibb,dc=ch
sudo -u www-data php /usr/share/ldap-account-manager/config/confi set-profile-param sam159Domain BindDN cn=Administrator,cn=users,dc=sam159,dc=iet-gibb,dc=ch
sudo -u www-data php /usr/share/ldap-account-manager/config/confi set-profile-param sam159Domain Password sml12345
sudo -u www-data php /usr/share/ldap-account-manager/config/confi set-profile-param sam159Domain AppTemplate windows_samba4

# Aktivieren des ldap server require strong auth in der smb.conf
sudo sed -i '/^\[global\]/a ldap server require strong auth = no' /etc/samba/smb.conf

# Neustart des Samba-Dienstes (oder entsprechender Dienst)
sudo systemctl restart smbd
