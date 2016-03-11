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
`#` **`git`**

[Display online help]

Now that the software has been installed, we'll use it to create and manage software repositories. For that, we'll connect now a simple user, as we don't need any priviledge anymore. Your user is group**X** and password ilovegit**X** where **X** has to be replaced by the group number given by your instructor. Please substitute **X** later in this document by your group number.

# Using Git
Estimated time: 15 minutes.

## Git setup

`userX:~$` **`git config --global user.name groupX`**

`userX:~$` **`git config --global user.email gitlab_groupX@gmail.com`**
 
`userX:~$` **`git config core.editor vim`**

This will allow us to get correct information in the log and be able to track who does what, especially when reviewing history and also when using GitLab later. For edition uses either vim if your comfortable with vi type of editors or emacs, or do not use it to use a basic beginners friendly one. Check with:

`userX:~$` **`git config -l`**
```
user.name=groupX
user.email=gitlab_groupX@gmail.com
[...]
core.editor=vim
```

This is stored in your `~/.gitconfig` file.

## The first local repository
In order to be able to manage a first repository, the easiest approach is to create a local one. For that issue:

`userX:~$` **`git init localrepo`**
```
Initialized empty Git repository in /home/groupX/localrepo/.git/
```
`userX:~$` **`ls -al localrepo`**
```
total 12
drwxrwxr-x 3 group3 group3 4096 Mar 11 19:07 .
drwxr-xr-x 4 group3 group3 4096 Mar 11 19:13 ..
drwxrwxr-x 7 group3 group3 4096 Mar 11 19:07 .git
```

So we've got a success  ! Of course, we do not really go far, but you see that you now have a place to store Git metadata
We can now start using it to manage some content. But before that, we want to configure our Git setup a little.

## Managing content in your local repository

We will add some content in our local directory, start making modifications, verify how Git react and try to check them in.

`userX:~$` **`cp -a /etc/ssh localrepo/`**

`userX:~$` **`cd localrepo/`**

`userX:~/localrepo$` **`cd localrepo/`**

`userX:~/localrepo$` **`ls ssh`**
```
moduli  ssh_config  sshd_config  ssh_host_dsa_key.pub  ssh_host_ecdsa_key.pub  ssh_host_ed25519_key.pub  ssh_host_rsa_key.pub
```
`userX:~/localrepo$` **`git status`**
```
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        ssh/

nothing added to commit but untracked files present (use "git add" to track)
```

Si Git suggest that we add the new created directory to track it and its content in the future, so we can manage its history as modifications are made to it. Let's do that.

`userX:~/localrepo$` **`git add ssh`**

`userX:~/localrepo$` **`git status`**
```
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   ssh/moduli
        new file:   ssh/ssh_config
        new file:   ssh/ssh_host_dsa_key.pub
        new file:   ssh/ssh_host_ecdsa_key.pub
        new file:   ssh/ssh_host_ed25519_key.pub
        new file:   ssh/ssh_host_rsa_key.pub
        new file:   ssh/sshd_config

```
So Git is now aware that we want to keep track of all these files. We will now initiate our repository with this first content, enter in the editor to comment on the reasons we do that change and validate this.

`userX:~/localrepo$` **`git commit`**

**`Import of content into the repository`**

**`- Adds ssh conf files`**
```
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# On branch master
#
# Initial commit
#
# Changes to be committed:
#       new file:   ssh/moduli
#       new file:   ssh/ssh_config
#       new file:   ssh/ssh_host_dsa_key.pub
#       new file:   ssh/ssh_host_ecdsa_key.pub
#       new file:   ssh/ssh_host_ed25519_key.pub
#       new file:   ssh/ssh_host_rsa_key.pub
#       new file:   ssh/sshd_config
#
```
```
[master (root-commit) da8a15f] Import of content into the repository
 7 files changed, 407 insertions(+)
 create mode 100644 ssh/moduli
 create mode 100644 ssh/ssh_config
 create mode 100644 ssh/ssh_host_dsa_key.pub
 create mode 100644 ssh/ssh_host_ecdsa_key.pub
 create mode 100644 ssh/ssh_host_ed25519_key.pub
 create mode 100644 ssh/ssh_host_rsa_key.pub
 create mode 100644 ssh/sshd_config
```
`userX:~/localrepo$` **`git log`**
```
commit da8a15fdd80aa40c97b4501d1a342eba052639fd
Author: groupX <gitlab_groupX@gmail.com>
Date:   Fri Mar 11 19:33:54 2016 +0100

    Import of content into the repository
    
    - Adds ssh conf files
```

As you can see, Git identifies our import by a unique commit ID, which will remain valid during the whole life of the project.

Now that we have some content, let's start making modifications and see how Git deals with them ! Edit 2 files in the `ssh` directory, modify some content in it (we do not care of correctnees at that point) and validate these 2 set of modifications.

And can thus gives us more useful details.

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
