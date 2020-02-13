#!/bin/bash


# Yum installs  
sudo yum upgrade
sudo yum -y install net-tools    
sudo yum -y install nfs-utils
sudo yum -y install nano
sudo yum install -y socat
sudo yum install -y ntp
sudo yum install -y wget
sudo yum install -y git
sudo yum install -y bind-utils 
sudo yum install -y yum-utils 
sudo yum install -y iptables-services 
sudo yum install -y bridge-utils 
sudo yum install -y bash-completion 
sudo yum install -y kexec-tools 
sudo yum install -y sos 
sudo yum install -y psacct 
sudo yum install -y lvm2
sudo yum install -y httpd-tools 
sudo yum install -y ansible 
sudo yum install -y vim
yum update


# Sync Clocks 
systemctl enable ntpd
systemctl start ntpd
ntpq -p


# Increase the max map count 
sysctl -w vm.max_map_count=1048575
sysctl -p
