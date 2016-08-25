# Ironic Standalone Lab Contents
This lab purpose is to install and use Ironic as a standalone deployment solution and handle some of the common use cases around it.

## Lab Writer and Trainer
Bruno.Cornec@hpe.com

<!--- [comment]: # Table of Content to be added --->

## Objectives of the Ironic Standalone Lab
At the end of the Lab students should be able to install Ironic, use the CLI to create enroll a system and deploy it.

This Lab is intended to be trial and error so that during the session students should understand really what is behind the tool, instead of blindly following instructions, which never teach people anything IMHO. You've been warned ;-)

Expected duration : 120 minutes

## Reference documents
When dealing with the installation and configuration of Ironic there are many documents that you need to read if you hope udnerstanding it ;-)
Some of them are:

Estimated time for the lab is placed in front of each part.

# Environment setup
Estimated time: 30 minutes

## Bug reports impacting this setup

BR:
https://bugs.launchpad.net/bifrost/+bug/1583539
https://bugs.launchpad.net/ironic/+bug/1412561
https://bugs.launchpad.net/bifrost/+bug/1587994
https://bugs.launchpad.net/ironic/+bug/1589627
https://bugs.launchpad.net/bifrost/+bug/1587940
https://bugs.launchpad.net/diskimage-builder/+bug/1589450
https://bugs.launchpad.net/diskimage-builder/+bug/1590176

RFE:
https://bugs.launchpad.net/ironic/+bug/1526477

## Ironic installation
Ironic is available externaly from 
As the installation is pretty complex per se, we will use Bifrost to ease it. Bifrost provides ansible playbooks to install and manage Ironic.

Related project and its doc is at https://github.com/openstack/bifrost

As we'll work on an CentOS 7 VM environment for the Lab, 

`#` **`git clone https://git.openstack.org/openstack/bifrost.git`**


### Preparation of the CentOS 7 Linux environment

yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install git -y

If your version doesn't include Fix for https://bugs.launchpad.net/bifrost/+bug/1583539
yum install libffi-devel openssl-devel

### Preparation of the ssh config
Check ./hosts/allinone and remove the ansible_ssh_port mention (we use port 22 on localhost)
then prepare by doing:
ssh-copy-id localhost
check with ssh localhost (should connect without passwd)

Do not change the MySQL passwd in the allinone file !

### Preparation of Bifrost
Read the instructions at https://git.openstack.org/openstack/bifrost.git and adapt the 2 conf files:
cd bifrost
vi ./playbooks/inventory/group_vars/*
# git diff
diff --git a/playbooks/inventory/group_vars/baremetal b/playbooks/inventory/group_vars/baremetal
index ef434ba..a4b5cdc 100644
--- a/playbooks/inventory/group_vars/baremetal
+++ b/playbooks/inventory/group_vars/baremetal
@@ -4,7 +4,7 @@
 
 # The network interface that bifrost will be operating on.  Defaults
 # to virbr0 in roles, can be overridden here.
-# network_interface: "virbr0"
+network_interface: "eth0"
 
 # The path to the SSH key to be utilized for testing and burn-in
 # to configuration drives. When set, it should be set in both baremetal
diff --git a/playbooks/inventory/group_vars/localhost b/playbooks/inventory/group_vars/localhost
index 94a4358..2fa9d54 100644
--- a/playbooks/inventory/group_vars/localhost
+++ b/playbooks/inventory/group_vars/localhost
@@ -4,15 +4,15 @@
 
 # The network interface that bifrost will be operating on.  Defaults
 # to virbr0 in roles, can be overridden here.
-# network_interface: "virbr0"
+network_interface: "eth0"
 
 
 # ironic_db_password ironic user password for rabbit
-ironic_db_password: aSecretPassword473z
+ironic_db_password: linux1
 # mysql_username: Default mysql admin username
 mysql_username: root
 # mysql_password: Default mysql admin user password
-mysql_password:
+mysql_password: linux1
 
 # The path to the SSH key to be utilized for testing and burn-in
 # to configuration drives. When set, it should be set in both baremetal

bash ./scripts/env-setup.sh

### Redfish Option 

# (cd /etc/yum.repos.d/ ; wget http://www.mondorescue.org/mondorescue/rhel/7/x86_64/pb.repo)
# yum install python-redfish



## Install using the ansible playbook

ansible-playbook -vvv -i hosts/allinone setup-ironic.yml





Check that the correct version is installed and operational:

`#` **`ironic --version`**
```
1.3.1

Now that Ironic has been installed, we'll use it to create and manage bare-metal servers.
# Using Ironic
Estimated time: 30 minutes.
## Start by enrolling your server
In order to be able to manage a first server, we have to enroll it in Ironic

## Continue by deploying your server
