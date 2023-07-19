#!/bin/bash

echo "[Inception-Ftp] Init vsftpd config..."  

service vsftpd start

# Add the USER, change his password and declare him as the owner of wordpress folder and all subfolders

adduser $FTP_USR --disabled-password

echo "$FTP_USR:$FTP_PWD" | /usr/sbin/chpasswd

echo "$FTP_USR" | tee -a /etc/vsftpd.userlist


mkdir /home/$FTP_USR/ftp


chown nobody:nogroup /home/$FTP_USR/ftp
chmod a-w /home/$FTP_USR/ftp

mkdir /home/$FTP_USR/ftp/files
chown $FTP_USR:$FTP_USR /home/$FTP_USR/ftp/files

chown $FTP_USR:$FTP_USR -R /var/www/html

sed -i -r "s/#write_enable=YES/write_enable=YES/1"   /etc/vsftpd.conf
sed -i -r "s/#chroot_local_user=YES/chroot_local_user=YES/1"   /etc/vsftpd.conf

echo "
local_enable=YES
allow_writeable_chroot=YES
pasv_enable=YES
local_root=/var/www/html/
pasv_min_port=40000
pasv_max_port=40005
userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf

service vsftpd stop

echo "[Inception-Ftp] Done. Starting service" 

/usr/sbin/vsftpd
