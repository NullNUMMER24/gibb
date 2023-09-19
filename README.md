# GIBB Aleitige
>[!IMPORTANT]
>Eventuell isch einiges scho widr verautet
## WMWare recivercer installiere
1. VMWare reciver vom GIBB Filestash abe lade: https://filestash.gibb.ch/files/IET-Share/sh-smartlearn/4_software/ 
2. Mit `sudo su -` usfüehre, da es süsch ni geit
3. I Downloads Ordner wächsle und d Datei usfüehre `./VMware`
4. License Agreemend düre läse, oder eifach `q` drücke. 
5. License Agreemend nomau mit `yes` bestätige.
6. Bi **System service scripts** `/etc/init.d` i tippe, da default nid agwändet wird.
7. Installation mit `ENTER` starte.
>[!Important]
>D Installation muess mit `sudo su -` usgfüert wärde, da es süsch nid geit.
## FTP ufe Filestash
Um de Filestash i Explorer i z binge, brucht me d Adrässe vom GIBB Filestash. Momentan isch es die:sftp://sftp.iet-gibb.ch/. 
>[!IMPORTANT]
>Wes mau Problem git, und es nid am Filestash ligt, de isch z Authentifizierigstoken verautet. Me cha das Token mit däm Command lösche:
> ```
>ssh-keygen -R sftp.iet-gibb.ch
> ```
