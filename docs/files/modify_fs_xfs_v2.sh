#!/bin/bash

# Note.. this is an updated version of the script that I was previously using. You no longer need to pass in the 
# volume size.. Documentation can be found here on the chagnes I made to the script. It was based on some information that
# Jim Conallen gave me. 
#
# https://ducakedhare.co.uk/?p=1504   <-- Good documentation

sudo yum install -y yum-utils device-mapper-persistent-data lvm2 rsync

#Create Physical Volumes
pvcreate /dev/xvdc
pvcreate /dev/xvde

#Create Volume Groups
vgcreate opt-vg /dev/xvdc
vgcreate var-vg /dev/xvde

#Create Logical Volumes
# Jim Conallen gave me a tip on how to get all available space. 
#lvcreate -L $1G -n opt-lv opt-vg
lvcreate -l 100%FREE -n opt-lv opt-vg
#lvcreate -L $2G -n var-lv var-vg
lvcreate -l 100%FREE -n var-lv var-vg  

#Create Filesystems
mkfs.xfs /dev/opt-vg/opt-lv
mkfs.xfs /dev/var-vg/var-lv

vgchange -ay

mkdir /mnt/newopt ; mount /dev/xvdc /mnt/newopt
mkdir /mnt/newvar ; mount /dev/xvde /mnt/newvar

#copy all files to new dir
rsync -aqxP /var/* /mnt/newvar
rsync -aqxP /opt/* /mnt/newopt

#move dir to old - so we can remove it later
mv /var /var.old ; mkdir /var
mv /opt /opt.old ; mkdir /opt

#Add mount in /etc/fstab
cat <<EOL | tee -a /etc/fstab
/dev/mapper/opt--vg-opt--lv /opt xfs defaults 0 2
/dev/mapper/var--vg-var--lv /var xfs defaults 0 2
EOL

#Mount Filesystems
mount -a

#copy all files back 
rsync -aqxP /mnt/newvar/* /var
rsync -aqxP /mnt/newopt/* /opt

systemctl restart sshd

