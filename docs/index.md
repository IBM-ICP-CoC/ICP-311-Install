# Installing IBM Cloud Private in IBM Cloud Virtual Machines

This document will walk you through the steps needed to create virtual machines in IBM Cloud and use them to run IBM Cloud Private. It should be noted that the instructions on this site were captured while configuring and installing on RHEL virtual servers hosted on IBM Cloud (Softlayer). Some of the server setup steps may vary if you are attempting to provision virtual servers in another cloud provider or if you are installing on a different OS. 



!!! tip
    The latest version of this document can always be found at <a href="https://ibm.biz/installicp" target="_blank">https://ibm.biz/installicp</a>.

    If you find any typos, errors, or just want to provide helpful feedback to make this document better, please click the `Github` link at the bottom of the left navigation menu and create an issue in the repository.  Thanks for your feedback!

In this example, we will be installing Docker EE and ICP 3.1.1 Enterprise edtion on RHEL. The docker EE edition is install file is included with the download of ICP 3.1.1. These are the files you will need. 

- ibm-cloud-private-x86_64-3.1.1.tar.gz  
- icp-docker-18.03.1_x86_64.bin

!!! note
    If you are an IBM'er, you can download the install files from the [Software Sellerrs Workplace](https://w3-03.ibm.com/software/xl/download/ticket.wss). 
    
    You will need to log in and do a search for **_IBM Cloud Private 3.1.1_**. 
    The package assembly you need to look for is: **IBM Cloud Private Installation Packages eAssembly  (CJ4MTEN)**

    IBM Cloud Private 3.1.1 for Linux (x86_64) Docker (CNZ4WEN)
    IBM Cloud Private 3.1.1 Docker for Linux (x86_64) (CNXD2EN)



## Acknowledgments
- Dave Wakeman (Public) & Dave Krier (Distribution) are the authors of this install guide.
- Dave Weilert (COC Team) was the pioneer who documented the install process and perfected all the pre-requisite steps.
- Jim Conallen (COC Team) authored the LDAP setup and configuration guide.
- Tom Watson (Distribution) tested and added comments.

!!! danger
    _This is **NOT** a replacement for the official [documentation](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.1.1/kc_welcome_containers.html) for IBM Cloud Private!  It is intended only to be a learning guide, and uses an arbitrary configuration that may not be appropriate for production use._

