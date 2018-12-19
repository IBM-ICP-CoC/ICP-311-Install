# Create the Virtual Machines

Provision 5 virtual machines with this configuration:

- RHEL Minimal (7.x)
- 8 CPU / 16G  Mem
- 100GB Boot Disk
- 200GB Disk 1
- 500GB Disk 2

!!! tip
    You can create all 5 VMs at the same time with the same configuration by using the `Quantity` field on the order page.


!!! important
    There are two scripts that will help you prapare your virtual machines for installation of ICP.  
    [modify_fs_v2.sh](files/modify_fs_v2.sh) will prepare the disks and move the `/var` and `/opt` directories to the two additional disks provisioned when the VMs were created.  
    [install_prereqs.sh](files/install_prereqs.sh) takes care of installing MOST of what you will need for the prerequisites.

When your machines are provisioned it will be helpful for you to collect some information together that you will need later.  The table below is an example of what you should collect.  The hostnames can be whatever values you want.  The passwords are for the `root` user and can be obtained on the `Passwords` tab of the Details page for your device.

| Machine Role      | hostname       | IP Address      | Password |
| ----------------- | -------------- | --------------- | -------- |
| Master/Proxy/Boot | my-icp-master  | xxx.xxx.xxx.xxx | xxxxxxxx |
| Management        | my-icp-mgmt    | xxx.xxx.xxx.xxx | xxxxxxxx |
| VA                | my-icp-va      | xxx.xxx.xxx.xxx | xxxxxxxx |
| Worker1           | my-icp-worker1 | xxx.xxx.xxx.xxx | xxxxxxxx |
| Worker2           | my-icp-worker2 | xxx.xxx.xxx.xxx | xxxxxxxx |

!!! note
    You should use the Public IPs for your virtual machines.