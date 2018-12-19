#!/bin/bash

# Yum installs  
sudo yum upgrade
sudo yum -y install net-tools    
sudo yum -y install nfs-utils
sudo yum -y install nano
sudo yum install -y socat
sudo yum install -y ntp

# Sync Clocks 
systemctl enable ntpd
systemctl start ntpd
ntpq -p

# Increase the max map count 
sysctl -w vm.max_map_count=262144