# Setup on All Machines

To install IBM Cloud Private you first need to prepare all of your virtual machines.  These instructions are specific to the install being done, and were derived from the [Preparing your cluster for installation](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/installing/prep.html) section of the ICP Knowledge Center. They are not reflective of all the steps necessary in all situations.  

!!! important
    There are two scripts that will help you prapare your virtual machines for installation of ICP.  
    [modify_fs_v2.sh](files/modify_fs_v2.sh) will prepare the disks and move the `/var` and `/opt` directories to the two additional disks provisioned when the VMs were created.  
    [install_prereqs.sh](files/install_prereqs.sh) takes care of installing MOST of what you will need for the prerequisites.

#Install Prerequisites

!!! note
    The first time you make a secure connection to a remote machine you may see this message:
    
    ```
    The authenticity of host '169.60.185.59 (169.60.185.59)' can't be established.
    ECDSA key fingerprint is SHA256:XAs372uCWTkOqLOkXwQYuCXq21GaJFoYIuItUf0xGpc.
    Are you sure you want to continue connecting (yes/no)?```
    
    Type in `yes` and the key fingerprint will be added to your `~/.ssh/known_hosts` file.

- Download [install_prereqs.sh](files/install_prereqs.sh) and use `scp` to transfer it to the virtual machine.
- Inside of the virtual machine use this command to change the permissions: `chmod 777 install_prereqs.sh`
- Execute the script: `./install_prereqs.sh`


#Modify the disks

When the virtual machine was created two additional disks were added to the configuration, but they are not yet configured inside the virtual machine.  These two disks are to be used for the `/opt` and `/var` directories.  

- Download [modify_fs_v2.sh](files/modify_fs_v2.sh) and use `scp` to transfer it to the virtual machine.
- Inside of the virtual machine use this command to change permissions: `chmod 777 modify_fs_v2.sh`
- Execute the script: `./modify_fs_v2.sh 199 499` <--- The parameters correspond to the sizes of `Disk 1` and `Disk 2` (minus 1)

#Install Docker


#Disable the firewall
```
systemctl disable firewalld
systemctl stop firewalld
```


#Rename the virtual machine

`hostnamectl set-hostname <new name>`


#Update the hosts file

Make sure that the `/etc/hosts` file on each virtual machine has entries for all of the other virtual machines so that they can talk to each other


#Setup SSH keys

##Generate the KEY on each node

`cd /root ;ssh-keygen -b 4096 -f /root/.ssh/id_rsa -N "" ;cat ~/.ssh/id_rsa.pub | sudo tee -a ~/.ssh/authorized_keys`

##Copy the key to each of the other nodes
`ssh-copy-id -i .ssh/id_rsa.pub root@dak311master`

`ssh-copy-id -i .ssh/id_rsa.pub root@dak311mgmt`

`ssh-copy-id -i .ssh/id_rsa.pub root@dak311va`

`ssh-copy-id -i .ssh/id_rsa.pub root@dak311worker1`

`ssh-copy-id -i .ssh/id_rsa.pub root@dak311worker2`

