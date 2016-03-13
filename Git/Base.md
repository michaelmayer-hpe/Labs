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
Estimated time: 20 minutes.

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

So we've got a success  ! Of course, we do not really go far, but you see that you now have a place to store Git metadata.
We can now start using it to manage some content. But before that, we want to configure our Git setup a little.

## Managing content in your local repository

### Populating the repository

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

Here Git suggest that we add the newly created directory to track it and its content in the future, so we can manage its history as modifications are made to it. Let's do that.

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

### Modifying content

Now that we have some content, let's start making modifications and see how Git deals with them ! Edit 2 files in the `ssh` directory, modify some content in it (we do not care of correctness at that point) and validate these 2 sets of modifications. Review your modification (expressed as a patch format - lines starting with a '+' will be added and those starting with a '-' will be removed):

`userX:~/localrepo$` **`git status`**
```
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   ssh/ssh_config
        modified:   ssh/sshd_config

no changes added to commit (use "git add" and/or "git commit -a")
```
`userX:~/localrepo$` **`git diff`**
```
diff --git a/ssh/ssh_config b/ssh/ssh_config
index 3810e13..4bdd247 100644
--- a/ssh/ssh_config
+++ b/ssh/ssh_config
@@ -1,3 +1,6 @@
+#   RhostsRSAAuthentication no
+#   RSAAuthentication yes
+#   PasswordAuthentication yes
 
 # This is the ssh client system-wide configuration file.  See
 # ssh_config(5) for more information.  This file provides defaults for
@@ -20,9 +23,6 @@ Host *
 #   ForwardAgent no
 #   ForwardX11 no
 #   ForwardX11Trusted yes
-#   RhostsRSAAuthentication no
-#   RSAAuthentication yes
-#   PasswordAuthentication yes
 #   HostbasedAuthentication no
 #   GSSAPIAuthentication no
 #   GSSAPIDelegateCredentials no
diff --git a/ssh/sshd_config b/ssh/sshd_config
index fa6377d..38ef297 100644
--- a/ssh/sshd_config
+++ b/ssh/sshd_config
@@ -22,6 +22,7 @@ ServerKeyBits 1024
 # Logging
 SyslogFacility AUTH
 LogLevel INFO
+#AuthorizedKeysFile    %h/.ssh/authorized_keys
 
 # Authentication:
 LoginGraceTime 120
@@ -30,7 +31,6 @@ StrictModes yes
 
 RSAAuthentication yes
 PubkeyAuthentication yes
-#AuthorizedKeysFile    %h/.ssh/authorized_keys
 
 # Don't read the user's ~/.rhosts and ~/.shosts files
 IgnoreRhosts yes
@@ -61,12 +61,12 @@ ChallengeResponseAuthentication no
 #GSSAPIAuthentication no
 #GSSAPICleanupCredentials yes
 
+#UseLogin no
 X11Forwarding yes
 X11DisplayOffset 10
 PrintMotd no
 PrintLastLog yes
 TCPKeepAlive yes
-#UseLogin no
 
 #MaxStartups 10:30:60
 #Banner /etc/issue.net
```
These modifications are for now in your working directory. Nothing happened to your repository. You can easily cancel all these modifications if you want (Hint use `git reset`). Now, as previously, we'll use the `git add` command to place these changes in the staging area. From there, you'll be able to add them to your repository if you want. Git can help you commit only changes relevant to a coherent modification. For that use the following (do not choose all modifications):

`userX:~/localrepo$` **`git add -p`**
```
diff --git a/ssh/ssh_config b/ssh/ssh_config
index 3810e13..4bdd247 100644
--- a/ssh/ssh_config
+++ b/ssh/ssh_config
@@ -1,3 +1,6 @@
+#   RhostsRSAAuthentication no
+#   RSAAuthentication yes
+#   PasswordAuthentication yes
 
 # This is the ssh client system-wide configuration file.  See
 # ssh_config(5) for more information.  This file provides defaults for
Stage this hunk [y,n,q,a,d,/,j,J,g,e,?]? y
@@ -20,9 +23,6 @@ Host *
 #   ForwardAgent no
 #   ForwardX11 no
 #   ForwardX11Trusted yes
-#   RhostsRSAAuthentication no
-#   RSAAuthentication yes
-#   PasswordAuthentication yes
 #   HostbasedAuthentication no
 #   GSSAPIAuthentication no
 #   GSSAPIDelegateCredentials no
Stage this hunk [y,n,q,a,d,/,K,g,e,?]? y
diff --git a/ssh/sshd_config b/ssh/sshd_config
index fa6377d..38ef297 100644
--- a/ssh/sshd_config
+++ b/ssh/sshd_config
@@ -22,6 +22,7 @@ ServerKeyBits 1024
 # Logging
 SyslogFacility AUTH
 LogLevel INFO
+#AuthorizedKeysFile    %h/.ssh/authorized_keys
 
 # Authentication:
 LoginGraceTime 120
Stage this hunk [y,n,q,a,d,/,j,J,g,e,?]? n
@@ -30,7 +31,6 @@ StrictModes yes
 
 RSAAuthentication yes
 PubkeyAuthentication yes
-#AuthorizedKeysFile    %h/.ssh/authorized_keys
 
 # Don't read the user's ~/.rhosts and ~/.shosts files
 IgnoreRhosts yes
Stage this hunk [y,n,q,a,d,/,K,j,J,g,e,?]? n
@@ -61,12 +61,12 @@ ChallengeResponseAuthentication no
 #GSSAPIAuthentication no
 #GSSAPICleanupCredentials yes
 
+#UseLogin no
 X11Forwarding yes
 X11DisplayOffset 10
 PrintMotd no
 PrintLastLog yes
 TCPKeepAlive yes
-#UseLogin no
 
 #MaxStartups 10:30:60
 #Banner /etc/issue.net
Stage this hunk [y,n,q,a,d,/,K,g,s,e,?]? y
```

In fact, as a best practice, you should systematically use that `-p` option in order to select precisely the modifications which are part of a commit you want to create that will be documented using the editor during the commit. Especially, contrary to what git says, avoid using `git commit -a` especially blindly when you have not touched your repository in the last 10 days e.g.

`userX:~/localrepo$` **`git status`**
```
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        modified:   ssh/ssh_config
        modified:   ssh/sshd_config

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   ssh/sshd_config
```

`userX:~/localrepo$` **`git diff`**
```
diff --git a/ssh/sshd_config b/ssh/sshd_config
index 4c294c6..38ef297 100644
--- a/ssh/sshd_config
+++ b/ssh/sshd_config
@@ -22,6 +22,7 @@ ServerKeyBits 1024
 # Logging
 SyslogFacility AUTH
 LogLevel INFO
+#AuthorizedKeysFile    %h/.ssh/authorized_keys
 
 # Authentication:
 LoginGraceTime 120
@@ -30,7 +31,6 @@ StrictModes yes
 
 RSAAuthentication yes
 PubkeyAuthentication yes
-#AuthorizedKeysFile    %h/.ssh/authorized_keys
 
 # Don't read the user's ~/.rhosts and ~/.shosts files
 IgnoreRhosts yes
```
So one modification wasn't accepted and is shown with the diff command. The other modifications are now in the staging area, ready to be committed. However, as indicated by Git, you can still revert these modification, if you realize they were incorrect. But how can you review them before committing to be sure ?

`userX:~/localrepo$` **`git diff --cached`**
```
diff --git a/ssh/ssh_config b/ssh/ssh_config
index 3810e13..4bdd247 100644
--- a/ssh/ssh_config
+++ b/ssh/ssh_config
@@ -1,3 +1,6 @@
+#   RhostsRSAAuthentication no
+#   RSAAuthentication yes
+#   PasswordAuthentication yes
 
 # This is the ssh client system-wide configuration file.  See
 # ssh_config(5) for more information.  This file provides defaults for
@@ -20,9 +23,6 @@ Host *
 #   ForwardAgent no
 #   ForwardX11 no
 #   ForwardX11Trusted yes
-#   RhostsRSAAuthentication no
-#   RSAAuthentication yes
-#   PasswordAuthentication yes
 #   HostbasedAuthentication no
 #   GSSAPIAuthentication no
 #   GSSAPIDelegateCredentials no
diff --git a/ssh/sshd_config b/ssh/sshd_config
index fa6377d..38ef297 100644
--- a/ssh/sshd_config
+++ b/ssh/sshd_config
@@ -61,12 +61,12 @@ ChallengeResponseAuthentication no
 #GSSAPIAuthentication no
 #GSSAPICleanupCredentials yes
 
+#UseLogin no
 X11Forwarding yes
 X11DisplayOffset 10
 PrintMotd no
 PrintLastLog yes
 TCPKeepAlive yes
-#UseLogin no
 
 #MaxStartups 10:30:60
 #Banner /etc/issue.net
```
`userX:~/localrepo$` **`git commit`**
**`Moves comments around`**

**`- Improve comments for ssh configuration`**
**`- another modification for sshd config`**
```
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# On branch master
# Changes to be committed:
#       modified:   ssh/ssh_config
#       modified:   ssh/sshd_config
#
# Changes not staged for commit:
#       modified:   ssh/sshd_config
#
[master d63d43d] Moves comments around
 2 files changed, 4 insertions(+), 4 deletions(-)
```
`userX:~/localrepo$` **`git log`**
```
commit d63d43d38e6cce80e8ad4240ecb03f033a84dbf7
Author: group3 <gitlab_group3@gmail.com>
Date:   Fri Mar 11 20:30:54 2016 +0100

    Moves comments around
    
    - Improve comments for ssh configuration
    - another modification for sshd config

commit da8a15fdd80aa40c97b4501d1a342eba052639fd
Author: group3 <gitlab_group3@gmail.com>
Date:   Fri Mar 11 19:33:54 2016 +0100

    Import of content into the repository
    
    - Adds ssh conf files
```
`userX:~/localrepo$` **`git status`**
```
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   ssh/sshd_config

no changes added to commit (use "git add" and/or "git commit -a")
```

If you used -a then git would have also included your last modification which wasn't staged. This is not what we want, so just use `git commit`. Our last modification is still in our working directory waiting to be finalyzed and committed.

You may want to have a look at https://www.atlassian.com/git/tutorials/saving-changes for more discussions around these aspects.

As you can start to see, there is *always* a way to solve an issue with Git. But if you now look at the man pages of say the `git log`, you will see how rich each subcommand is, so very powerful, but also sometimes confusing, espeically for newcomers with regards to finding the right option to perform the action you look at.

`userX:~/localrepo$` **`man git-log | wc -l`**
```
1449
```
`userX:~/localrepo$` **`man git-log | grep -E '^\s*-' | wc -l`**
```
167
```
Yes, 167 options to the single `git log` command. Suffice to say that lab will just cover the surface of Git, as we're all still learning (Linus excepted ;-) But let's explore some useful among them.

`userX:~/localrepo$` **`git log --oneline`**
```
d63d43d Moves comments around
da8a15f Import of content into the repository
```
`userX:~/localrepo$` **`git log --oneline --stat`**
```
d63d43d Moves comments around
 ssh/ssh_config  | 6 +++---
 ssh/sshd_config | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
da8a15f Import of content into the repository
 ssh/moduli                   | 261 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ssh/ssh_config               |  54 ++++++++++++++++++++++
 ssh/ssh_host_dsa_key.pub     |   1 +
 ssh/ssh_host_ecdsa_key.pub   |   1 +
 ssh/ssh_host_ed25519_key.pub |   1 +
 ssh/ssh_host_rsa_key.pub     |   1 +
 ssh/sshd_config              |  88 +++++++++++++++++++++++++++++++++++
 7 files changed, 407 insertions(+)
```
`userX:~/localrepo$` **`git log --graph --decorate --oneline`**
```
* d63d43d (HEAD, master) Moves comments around
* da8a15f Import of content into the repository
```

That last one will become more useful later one, once we have more content in our history. But these commands may also help us reverting changes. You may again want to look at this page https://www.atlassian.com/git/tutorials/inspecting-a-repository for more insights

### Reverting modifications

Of course, you may make mistakes and revert your modifications sometimes. For example, you currently have a unvalidated modification in your working directory. Revert it with `git checkout`

`userX:~/localrepo$` **`git status`**
```
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        modified:   ssh/sshd_config

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   ssh/sshd_config
```
`userX:~/localrepo$` **`git checkout -- ssh/sshd_config`**

`userX:~/localrepo$` **`git status`**
```
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        modified:   ssh/sshd_config

```
So you lost the local modifications made which were not added yet. Now what about the one committed if you also don't want it either ?

`userX:~/localrepo$` **`git reset HEAD ssh/sshd_config`**
```
Unstaged changes after reset:
M       ssh/sshd_config
```
`userX:~/localrepo$` **`git status`**
```
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   ssh/sshd_config

no changes added to commit (use "git add" and/or "git commit -a")
```
`userX:~/localrepo$` **`git diff`**
```
diff --git a/ssh/sshd_config b/ssh/sshd_config
index 4c294c6..7449d4d 100644
--- a/ssh/sshd_config
+++ b/ssh/sshd_config
@@ -4,8 +4,8 @@
 # What ports, IPs and protocols we listen for
 Port 22
 # Use these options to restrict which interfaces/protocols sshd will bind to
-#ListenAddress ::
 #ListenAddress 0.0.0.0
+#ListenAddress ::
 Protocol 2
 # HostKeys for protocol version 2
 HostKey /etc/ssh/ssh_host_rsa_key
```
`userX:~/localrepo$` **`git checkout -- ssh/sshd_config`**

`userX:~/localrepo$` **`git status`**
```
On branch master
nothing to commit, working directory clean
```

Finally you may want to revert a modification already pushed to your repository. The best practice with this is to create a new commit that will revert the action of the old one instead of going back to history to avoid messing it up and those who may depend on it.

`userX:~/localrepo$` **`git log --oneline`**
```
d63d43d Moves comments around
da8a15f Import of content into the repository
```
Let's imagine we want to come back to our initial state on our repository (commit da8a15f) and revert the modification made in commit d63d43d.
`userX:~/localrepo$` **`git revert d63d43d`**
```
Revert "Moves comments around"

This reverts commit d63d43d38e6cce80e8ad4240ecb03f033a84dbf7.

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# On branch master
# Changes to be committed:
#       modified:   ssh/ssh_config
#       modified:   ssh/sshd_config
#
[master 42b2008] Revert "Moves comments around"
 2 files changed, 4 insertions(+), 4 deletions(-)
```
`userX:~/localrepo$` **`git log --oneline`**
```
42b2008 Revert "Moves comments around"
d63d43d Moves comments around
da8a15f Import of content into the repository
```

For a more detailed explanation on this topic, and looking at more options to manage going back and forth in your history you may refer to https://www.atlassian.com/git/tutorials/viewing-old-commits and https://www.atlassian.com/git/tutorials/undoing-changes

It's now time to organize a bit better our development approach.

### Managing branches

Branches are at the heart of the development method with Git. Each time you want to make modifciations to an existing code base, it is advised to create a branch to develop that feature. It will ease greatly management of features integration, errors, share with upstream, ... Also look at https://www.atlassian.com/git/tutorials/using-branches/git-branch.

`userX:~/localrepo$` **`git branch`**
```
* master
```
`userX:~/localrepo$` **`git branch comment`**

`userX:~/localrepo$` **`git branch`**
```
  comment
* master
```
`userX:~/localrepo$` **`git checkout comment`**
```
Switched to branch 'comment'
```

So you've now created the `comment` branch and have moved to it. All what you do from now on will be on this branch which originates from `master`.

`userX:~/localrepo$` **`git log --oneline`**
```
42b2008 Revert "Moves comments around"
d63d43d Moves comments around
da8a15f Import of content into the repository
```

Redo multiple local modifications as earlier and commit them into your banch (use `git add -p` and `git commit` each time). Your history should then look like this in that branch, but doesn't affect `master`:

`userX:~/localrepo$` **`git log --oneline`**
```
695521e Activate banner + comments moved again
4ad763e Change comments
42b2008 Revert "Moves comments around"
d63d43d Moves comments around
da8a15f Import of content into the repository
```
`userX:~/localrepo$` **`git checkout master`**
```
Switched to branch 'master'
```
`userX:~/localrepo$` **`git log --oneline`**
```
42b2008 Revert "Moves comments around"
d63d43d Moves comments around
da8a15f Import of content into the repository
```
If you are in a multi-user environment, working with a remote repository, that branch may even have progressed during the time you developed you feature in your `comment` branch. Commit a change in your `master` branch to simulate this in a separate file from the one you touched during your feature addition.

`userX:~/localrepo$` **`git log --oneline`**
```
d5a50f4 Modify a key
42b2008 Revert "Moves comments around"
d63d43d Moves comments around
da8a15f Import of content into the repository
```

Now what happens when you go bak into your feature branch ? Let's test !

`userX:~/localrepo$` **`git checkout comment`**
```
Switched to branch 'comment'
```
`userX:~/localrepo$` **`git log --oneline`**
```
695521e Activate banner + comments moved again
4ad763e Change comments
42b2008 Revert "Moves comments around"
d63d43d Moves comments around
da8a15f Import of content into the repository
```

So we just see the modifications done in that branch, not the one done in `master`. But we would like to get that modification made in `master` so we can propose our feature to `master` later on, including it instead of creating a conflict. So it's time to rebase !

`userX:~/localrepo$` **`git rebase master`**
```
First, rewinding head to replay your work on top of it...
Applying: Change comments
Applying: Activate banner + comments moved again
```
`userX:~/localrepo$` **`git log --oneline`**
```
df3e445 Activate banner + comments moved again
82f564d Change comments
d5a50f4 Modify a key
42b2008 Revert "Moves comments around"
d63d43d Moves comments around
da8a15f Import of content into the repository
```

So the magic happened ! Git took the `master` branch and re-applied our 2 patches on top of that tree so our `comment` branch is now uptodate. Remark the new commit IDs created for our 2 commits. Add a final modification, commit it and it's now time to declare our feature complete and ready for integration into master.

`userX:~/localrepo$` **`git log --oneline`**
```
7965bf5 Adds limits
df3e445 Activate banner + comments moved again
82f564d Change comments
d5a50f4 Modify a key
42b2008 Revert "Moves comments around"
d63d43d Moves comments around
da8a15f Import of content into the repository
```
`userX:~/localrepo$` **`git checkout master`**
```
Switched to branch 'master'
```
`userX:~/localrepo$` **`git log --oneline`**
```
d5a50f4 Modify a key
42b2008 Revert "Moves comments around"
d63d43d Moves comments around
da8a15f Import of content into the repository
```

So `master` has no knowledge of the feature branch, let's merge it into this branch.

`userX:~/localrepo$` **`git merge --no-ff comment`**
```
Merge branch 'comment'

- Adds more comments and activatr some features
# Please enter a commit message to explain why this merge is necessary,
# especially if it merges an updated upstream into a topic branch.
#
# Lines starting with '#' will be ignored, and an empty message aborts
# the commit.
Merge made by the 'recursive' strategy.
 ssh/ssh_config  | 4 ++--
 ssh/sshd_config | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)
```
`userX:~/localrepo$` **`git log --graph --decorate --oneline`**
```
*   a18fdd3 (HEAD, master) Merge branch 'comment'
|\  
| * 7965bf5 (comment) Adds limits
| * df3e445 Activate banner + comments moved again
| * 82f564d Change comments
|/  
* d5a50f4 Modify a key
* 42b2008 Revert "Moves comments around"
* d63d43d Moves comments around
* da8a15f Import of content into the repository
```
`userX:~/localrepo$` **`git branch -d comment`**
```
Deleted branch comment (was 7965bf5).
```

Using the `--no-ff` option has allowed us to keep track of the origin of the path set (a feature branch) and integrate all the changes into our `master` branch which now contains everything we want. Of course, sometimes rebasing or merging doesn't succeed and you have to deal with merge conflicts, solving them, before being able to continue. Git guides you throughout the process so you can fix your conflicts. You should now have an understanding of all the basics to manipulate content with Git. It's then time to collaborate with others.

## Working with a remote repository
In order to have a more interesting environment, we'll now look for 

Answer the questions:
1. xxx
2. yyy

# Best practices and collaborative development with Git

Estimated time: 10 minutes.

You should read the blog article from Vincent Driessen available at http://nvie.com/posts/a-successful-git-branching-model/ to familiarize yourself with some best practices around collaborative development.

# Web based interaction with Git using GitLab

Estimated time: 50 minutes.

## ...
## ...
