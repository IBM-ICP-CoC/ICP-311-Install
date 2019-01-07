#!/bin/bash

# This script takes 2 values that must be passed in. 
#  exzample:  make_fs.sh 199 499 
#  The first one is the space for the /opt drive (I have a 200GB disk), and the second one is for the /var drive (I have a 500GB)
#  Notice:  I had to subtract 1GB from the size, so the script doesn't fail. 

sudo yum install -y yum-utils device-mapper-persistent-data lvm2 rsync

#Create Physical Volumes
pvcreate /dev/xvdc
pvcreate /dev/xvde

#Create Volume Groups
vgcreate opt-vg /dev/xvdc
vgcreate var-vg /dev/xvde

#Create Logical Volumes
lvcreate -L $1G -n opt-lv opt-vg   #  The $1  is the first argument passed into the script
lvcreate -L $2G -n var-lv var-vg   #  The $2  is the first argument passed into the script

#Create Filesystems
mkfs.ext4 /dev/opt-vg/opt-lv
mkfs.ext4 /dev/var-vg/var-lv

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
/dev/mapper/opt--vg-opt--lv /opt ext4 defaults 0 0
/dev/mapper/var--vg-var--lv /var ext4 defaults 0 0
EOL

#Mount Filesystems
mount -a

#copy all files back 
rsync -aqxP /mnt/newvar/* /var
rsync -aqxP /mnt/newopt/* /opt

systemctl restart sshd
