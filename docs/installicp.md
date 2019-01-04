#Install IBM Cloud Private

!!! note
    The rest of the installation will take place only on the Master node.  At this time you should `ssh` into your master node as `root`.


## Unpack the installer

- Inside of the virtual machine for your master node, create a new directory called `/opt/icp311`
- in a terminal window on your laptop, execute this command:

```
scp ibm-cloud-private-x86_64-3.1.1.tar.gz root@<your-master-node-ip>:/opt/icp311
```

!!! note
    If you have already transferred it the file will be in `/tmp` so you can use this command instead:

    `mv /tmp/ibm-cloud-private-x86_64-3.1.1.tar.gz /opt/icp311`

- Expand the tarball (from `/opt/icp311` directory)

```
/usr/bin/tar xf ibm-cloud-private-x86_64-3.1.1.tar.gz -O | docker load
```

!!! note
    This command may take several minutes to run

- Create inception (run the docker image from the `/opt/icp311` directory)

```
docker run -v $(pwd):/data -e LICENSE=accept ibmcom/icp-inception-amd64:3.1.1-ee cp -r cluster /data
```

- Move the image files for your cluster to the `/<installation_directory>/cluster/images` folder.

- Create a new folder under the /cluster directory called `images`. 

```
mv ibm-cloud-private-x86_64-3.1.1.tar.gz  cluster/images/
```

- Copy the SSH Key to the keys (run this command from the `/opt/icp311` directory)

```
cp ~/.ssh/id_rsa ./cluster/ssh_key
```

- Edit the `hosts` file (found in the `/opt/icp311/cluster` directory)

```
[master]
<your-master-ip>

[worker]
<your-worker1-ip>
<your-worker2-ip>

[proxy]
<your-master-ip>

[management]
<your-management-ip>

[va]
<your-va-ip>
```

!!! warning
    The default hosts file has the `management` and `va` sections commented out.  Be sure to remove the `#` comment markers or your install will fail!!  Also, remove the line with the three dots `...` in the `[worker]` section.

- Edit `cluster/config.yaml` file for custom settings

```
## Advanced Settings
default_admin_user: admin
default_admin_password: <set your admin password here>

management_services:
 vulnerability-advisor: enabled
```

- As `root` run the installer (from the `/opt/icp311/cluster` directory)

```
docker run --net=host -t -e LICENSE=accept -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.1.1-ee install
```

!!! success
    If all goes well your install will finish successfully and you will be good to go.

!!! failure
    If the install fails you need to run the uninstall command before you run the installer again.

```
    docker run --net=host -t -e LICENSE=accept -v "$(pwd)":/installer/cluster ibmcom/icp-inception-amd64:3.1.1-ee uninstall
```

Happy hosting!