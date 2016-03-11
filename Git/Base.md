# Git Lab Contents
This lab purpose is to install and use Git to become familiar with this distributed configuration management system and handle some of the common use cases around it.

## Lab Writers and Trainers
- Bruno.Cornec@hpe.com
- Clement.Poulain@hpe.com

<!--- [comment]: # Table of Content to be added --->

## Objectives of the Git Lab
At the end of the Lab students should be able to install git, use the CLI to clone a new repository, make modifications to projects, providing updates in the project, manages branches, conflicts, multi developers aspects, and have some best practices references. They should also become more familiar with the Web based interface provided by GitLab and the Pull Requests, issue tracking aspects it provides in addition.

This Lab is intended to be trial and error so that during the session students should understand really what is behind the tool, instead of blindly following instructions, which never teach people anything IMHO. You've been warned ;-)

Expected duration : 120 minutes

## Reference documents
When dealing with the installation and configuration of Git, the first approach is to look at the reference Web site https://git-scm.com/docs. Students could also download the Cheat Sheet at https://training.github.com/kit/downloads/github-git-cheat-sheet.pdf.
For details on additional web based interface tools, you may want to look at https://training.github.com/kit/courses/github-for-developers.html and https://www.digitalocean.com/community/tutorials/how-to-use-the-gitlab-user-interface-to-manage-projects.

This lab would not have been possible without work done by people at Atlassian at https://www.atlassian.com/git/
<!--- and http://gitref.org/ --->

Estimated time for the lab is placed in front of each part.

# Environment setup
Estimated time: 15 minutes (including remote access to the platform described elsewhere)
## Git installation
Git is available externaly from https://git-scm.com/downloads or using your distribution packages.
Version 2.7.3 is the current stable release. The version used in this Lab will be the default version of Ubuntu LTS 14.04 1.9.1.

As we'll work on an Ubuntu environment for the Lab, you may want to use apt to do the installation of Git with all its dependencies. 

`#` **`apt-get update`**

`#` **`apt-get install -y git`**
```none
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following extra packages will be installed:
  git-man liberror-perl
Suggested packages:
  git-daemon-run git-daemon-sysvinit git-doc git-el git-email git-gui gitk
  gitweb git-arch git-bzr git-cvs git-mediawiki git-svn
Recommended packages:
  patch
The following NEW packages will be installed:
  git git-man liberror-perl
0 upgraded, 3 newly installed, 0 to remove and 0 not upgraded.
Need to get 3,421 kB of archives.
After this operation, 21.9 MB of additional disk space will be used.
Get:1 http://ftp.free.fr/mirrors/ftp.ubuntu.com/ubuntu/ trusty/main liberror-perl all 0.17-1.1 [21.1 kB]
[...]
Fetched 3,421 kB in 0s (4,643 kB/s)
Selecting previously unselected package liberror-perl.
(Reading database ... 52804 files and directories currently installed.)
Preparing to unpack .../liberror-perl_0.17-1.1_all.deb ...
[...]
Setting up git (1:1.9.1-1ubuntu0.2) ...
[...]
```
Other distributions should be as easy to deal with by providing the same packages out of the box (Case of most non-commercial distributions such as Debian, Fedora, Mageia, OpenSuSE, …)
Check that the correct version is installed and operational:

`#` **`git --version`**
```
git version 1.9.1
```
`#` **`git `**

[Display online help]

Now that the software has been installed, we'll use it to create and manage software repositories.
# Using Git
Estimated time: 15 minutes.
## The first local repository
In order to be able to manage a first repository, the easiest approach is to create a local one. For that issue:

`userX$` **`git init`**
```
```

So we've got a success  ! Of course, we do not really go far, but what can you expect from an hello-world example ;-)
However, we can already get some info on our modified docker environment:

### Adding content
### ...

## The second remote repository
In order to have a more interesting environment, we'll now look for 

Answer the questions:
1. xxx
2. yyy

# Best practices and collaborative development with Git

Estimated time: 30 minutes.

# Web based interaction with Git using GitLab

## ...
## ...
