#Installing and Configuring LDAP

You can run the LDAP server on any one of the nodes, but I would suggest you run it either on the master or boot node. I choose to run this on a separate stand alone server. All it requires is that docker is installed.  

!!! warning
    If you plan in [Customizing the cluster access URL](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/user_management/custom_url.html) you should configure that BEFORE you configure any LDAP connections.  

Create two new directories:

`mkdir -p /opt/openldap/slapd.d`

`mkdir -p /opt/openldap/ldap`

```
docker run -d -e DOMAIN=mycluster.icp --net=host --name=openldap \--restart unless-stopped \
-v /opt/openldap/ldap:/var/lib/ldap \
-v /opt/openldap/slapd.d:/etc/ldap/slapd.d \
siji/openldap:2.4.42
```
!!! note
    The command above will run a docker image containing LDAP and set it to automatically restart if the virtual machine is restarted.


THANK YOU to Jim Conallen, for the following documentation!! 
Directions for configuring LDAP can be found [here](https://ibm.ent.box.com/s/6q6h74cdx5zkd0t7y2rhohaiujo99a4u).