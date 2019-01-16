# Setup on All Machines

To install IBM Cloud Private you first need to prepare all of your virtual machines.  These instructions are specific to the install being done, and were derived from the [Preparing your cluster for installation](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/installing/prep.html) section of the ICP Knowledge Center. They are not reflective of all the steps necessary in all situations.  

!!! important
    There are two scripts that will help you prapare your virtual machines for installation of ICP.  
    [modify_fs_v2.sh](files/modify_fs_v2.sh) will prepare the disks and move the `/var` and `/opt` directories to the two additional disks provisioned when the VMs were created.  
    [install_prereqs.sh](files/install_prereqs.sh) takes care of installing MOST of what you will need for the prerequisites.
    I would encourage you to look at the contents of these scripts to understand what they do. It should also be noted that they are specific to RHEL, so if your using another OS, such as Ubuntu you will have to perform these steps manually using the proper os commands. 

!!! new 
    We have added an additional script to the repo that will expand the `/var` directory only. We have found that the space requirements for v3.1.1 have changed from previous the version. For this reason, we have a 3rd script you can choose to use if you only want to increase the size of the `/var` directory. 
    [modify_fs_v3.sh](files/modify_fs_v3.sh) will prepare the disk and move the `/var` directorie to the additional disk provisioned when the VMs were created.  

## Install Prerequisites

!!! note
    The first time you make a secure connection to a remote machine you may see this message:
    
    > The authenticity of host '169.60.185.59 (169.60.185.59)' can't be established.
    > ECDSA key fingerprint is SHA256:XAs372uCWTkOqLOkXwQYuCXq21GaJFoYIuItUf0xGpc.
    > Are you sure you want to continue connecting (yes/no)?
    
    Type in `yes` and the key fingerprint will be added to your `~/.ssh/known_hosts` file.

- Download [install_prereqs.sh](files/install_prereqs.sh) and use `scp` to transfer it to the virtual machine.
- Inside of the virtual machine use this command to change the permissions: `chmod 777 install_prereqs.sh`
- Execute the script: `./install_prereqs.sh`


## Modify the disks

When the virtual machine was created two additional disks were added to the configuration, but they are not yet configured inside the virtual machine.  These two disks are to be used for the `/opt` and `/var` directories.  

- Download [modify_fs_v2.sh](files/modify_fs_v2.sh) and use `scp` to transfer it to the virtual machine.
- Inside of the virtual machine use this command to change permissions: 

    `chmod 777 modify_fs_v2.sh`

- Execute the script: 

    `./modify_fs_v2.sh 199 499` <--- The parameters correspond to the sizes of `Disk 1` and `Disk 2` (minus 1)

## Install Docker

- SCP copy the docker file (This is the IBM Docker Enterprise version) to your local machine
    (icp-docker-18.03.1_x86_64.bin is available with the download of ICP 3.1.1 EE)
- From your local machine you need to SCP transfer the file to each ICP server
- Make an install dir on server (In this example I created the install dir on the root dir)

    ```mkdir install ```

    ```chmod dir 777 install```

- Open Terminal window on local machine
- Navigate to dir where file is located
- scp command:    

    ```scp ./icp-docker-18.03.1_x86_64.bin login@icp-server-ip:/install/```

On the server you should now see the docker file. 

### Docker install commands

```
    chmod 777 on the file
    ./icp-docker-18.03.1_x86_64.bin --install

    systemctl start docker
    systemctl enable docker
```

## Disable the firewall
```
systemctl disable firewalld
systemctl stop firewalld
```


## Rename the virtual machine

```
hostnamectl set-hostname <new name>
```


## Update the hosts file

Make sure that the `/etc/hosts` file on each virtual machine has entries for all of the other virtual machines so that they can talk to each other. Take note of what your host names are, you will need them in the following steps. 


## Setup SSH keys

### Generate the KEY on each node

```
cd /root ;ssh-keygen -b 4096 -f /root/.ssh/id_rsa -N "" ;cat ~/.ssh/id_rsa.pub | sudo tee -a ~/.ssh/authorized_keys
```

### Copy the key to each of the other nodes 

**DO NOT** just copy these commands below, they are for example ONLY. You need to edit the host names at the end of each of these commands. You will need to run ALL of these commands to copy the SSH key from the current VM to all the rest of the VM's in the cluster. We are sharing the SSH keys, so that the install script can SSH into the other boxes without authentication. 
```
ssh-copy-id -i .ssh/id_rsa.pub root@dak311master

ssh-copy-id -i .ssh/id_rsa.pub root@dak311mgmt

ssh-copy-id -i .ssh/id_rsa.pub root@dak311va

ssh-copy-id -i .ssh/id_rsa.pub root@dak311worker1

ssh-copy-id -i .ssh/id_rsa.pub root@dak311worker2
```

### Test the SSH keys

You can perform a simple test to ensure that the SSH keys are setup correctly. At this point you should be able to SSH into any one of the VM's from any one of the VM's. Try it out and spot check the SSH keys. 

As an example:  I am logged into the master node. I should be able to type this command below and log directly into the worker1 node without any authentication propts. The example below assumes the host name for worker1 is dak311worker1, yours may be different. 

```
ssh dak311worker1
```
 

!!! note
    You should now see that your logged into the worker 1 node and you didn't see any prompts for userid or password.

