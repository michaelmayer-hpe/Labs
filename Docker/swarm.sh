#!/bin/bash

# Helper script to setup the pre-swarm environment to help start the second part of the lab

CLIST="c6 c7 c8 c10 c11"

cat > /etc/yum.repos.d/docker.repo << EOF
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

# ssh-keygen -t rsa -q -f /root/.ssh/id_rsa -N ""
# Create fake keys
mkdir -p /root/.ssh
chmod 700 /root/.ssh
cat > /root/.ssh/id_rsa << EOF
EOF
cat > /root/.ssh/id_rsa.pub << EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAqK8LM9dkGFFYzqppbZigVe5OwOvpJTR8NnSO15TSn1CJq6lH
k2U0lCyUzbYaTBq12nfIhom8/dV9qtuEb5HJVzsx/odprGXHgxML8zAfe540pJxP
p5hYNYvVO7Aa4gM0yeNZRy8HNkQW5Zi+ALt4kk+6PoslQF3AdHeUNqvIGpcuszbK
eRqcH2Bil+LrT5ug2XYScYpqN+b4oiV3bPrxEScYsrFobTrhQqMzdI/ZtIaHSKpz
WTAEv/kLwwMaMbjLkItlvnKXrWCv/1Hv8ovB9DZ8YAlw/+RNp811Fw68Ig0Keb1+
ZzdCDfOi2c1oZzVsPI/4ZByrk0hZHKlphZPtYQIDAQABAoIBAFmUE3vlT1eGo4Wk
g7ZazhK0KghTf41tcOUuQskDVFKcX2/UxpjkruZdQmx330E5EgfBgrDHpqCZ5lF8
n7jsD6MOYX9Mg/a0Wh4mWDs9/AoWutgL1lUnFvjgmE1JOQ17LGZmIHwn4kmUISCu
W4BiDiaMxlf+ZrrmzpRLCF98HBjaAXRKYhynTIOVXF7t52vP0vJWjf4lInzZQaf2
1Gu68YKQyIc66OiCShiIBUhd0NLSMJyj2ik4tD0BM1QtMWE80oGzlf9mWFWn1YZZ
7giGQ/TkJV3xiwcQqHNl+rSe8dq1oWeDAiyN5k1PCjPrfR1YO+z11JpaH2OLB5Jd
ugvIrhECgYEA1qRNjLc8ztBQNet8HifMmquUItrmut9/8jPSPZ8Y0WVb9VeNSMde
Yxy8sYCSBgp3EFfXEsgL/rFu6mKk0q8wn85dKngLWKZsMhVyCi6vkC9CkvJRSQkS
eCLS/irKn7RJ5MyPymaiDN8Cd+R7rGdgIExfl6MBuNTrUGkjPZIsWOUCgYEAyS/B
ZHwWW8+606j+bdAr1ScCN7LNqqNHIm60OtKS09/TUwVRrwleGlcM3nDPOENrRm5k
J0A6qTzNugiajhtLGTnGqmmGMYtP4oudj6QvMUScKBVsHt43moL/HNGVCsy6Xvnq
2X9Xxit3uL1M9dS70IXoj2rehAr/zqHvOPs35s0CgYEAq5jLTtYnTQgJODI9Fjan
Qngtg/gRQhDwTwfS6uTIiI9KB0ipcSfCc+ZDjHzHQQEY0v4GucMoo8PicovOTYk1
jG0E2rECEStrkFbIxw8v2EuQI76J8aPJGjZtDDnVp/wQn1RTGHMY1sVrScJmhRxY
IzorqiTteYDvZ2fGfrDft2kCgYBg0BM/OJtFyRu9WPg+fctqAiCGDwv7TiEgB6fB
Gq2/OVkm/UtGcLqQ8EzoCd8d0wufU+XsIXNZF0JkgFlngujLlcrtHGSQGNrzSH4k
rjxrd/mxLEXgQMz/FISRKKWREd2pcJg725SwbyBojOeo8JsEiDvWL/YuEmDw3WoR
wIoxDQKBgAaaKKKYw8jfvqqa2uNPSEs+44kS25R0LdN0BgwbXhJZSJA8c2b2aAXI
UIvNJOY0UeCTWwvjVjvR00kPDciH5X3EMsmW2kJz7hc9M6++L0B4GLyMJYafI6op
EyW/IGNcHwHA70Oua9uTPQsrTHf0AIrKLS+5hMRm6Qnghg2Qrpxv
-----END RSA PRIVATE KEY-----
EOF
cat > /root/.ssh/authorized_keys << EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCq71vKUSP5RZ4beKoQ2OuieKMV6iXw4cS4ZYTp8u6lxWZBQnrbBSlXr8m3+g1uuXzcBbER4zQBrr78rJXiHUctKDs6UwdOZQtrAWAYuImVPiAKc8ybAIAKDOJFjTeDhLuS1VEq9tNJiyEKssQ+1fAV1nIq4Hu6lF5rGTvnAKY0wjqqvG7uR3Aojw+aAURf0p8fVr3jwga2U49DNO3oOSwUXCygv1+RF1ZY6rkGIYuRoPHg9QIt7xbodiV4D0HvFzw8QnLFEsIzdoMwhnOdZ20OEGaYLa67q4vrWeeUBpICUEjmMwoBsyK50+en6R1OpBgIMKi/HoKPO/GW5gA+58Fv bruno@morley.fra.hp.com
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0tyRl5qxbMEIoG8yGVsVU2nxEDeVf3QjCzZg+bohdQq2ibUr2adYl0KLIfS8Wd73DTet7GIHtKQ3tZlC8C3B+W4GIN3dqGEeyAZpZaesRsL0Fwotjs0E0enYfTiJCzLEKWMzshMU6AQVnSre6v1MpR+E7NPpnPwFbHeA9FvD16iLb4uXs3RpGZjw0edUTB7zulxASwfsrCNN0feyDfkQAtn8GZEQd56z2OEjCpsvDdAvKwmwSNq1LbpHEEOBSXtQ2ub+3HBL1u69qMK+mpicMMhpd++mIH/Z8FZ2eM/BNkHh7L/3E29WWtfd6o+wyGHMBGk8lfVJyXJE9DGzZDxYf bruno@victoria2.home.musique-ancienne.org
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCorwsz12QYUVjOqmltmKBV7k7A6+klNHw2dI7XlNKfUImrqUeTZTSULJTNthpMGrXad8iGibz91X2q24RvkclXOzH+h2msZceDEwvzMB97njSknE+nmFg1i9U7sBriAzTJ41lHLwc2RBblmL4Au3iST7o+iyVAXcB0d5Q2q8galy6zNsp5GpwfYGKX4utPm6DZdhJximo35viiJXds+vERJxiysWhtOuFCozN0j9m0hodIqnNZMAS/+QvDAxoxuMuQi2W+cpetYK//Ue/yi8H0NnxgCXD/5E2nzXUXDrwiDQp5vX5nN0IN86LZzWhnNWw8j/hkHKuTSFkcqWmFk+1h root@c6.labossi.hpintelco.org
EOF
chmod 600 /root/.ssh/authorized_keys
chcon -R unconfined_u:object_r:ssh_home_t:s0 .ssh

for i in $CLIST ; do 
	scp -rp /root/.ssh ${i}:/root/
	scp /etc/yum.repos.d/docker.repo ${i}:/etc/yum.repos.d/
	ssh ${i} "yum install docker-engine -y"
	# setup fw
	ssh ${i} "firewall-cmd --add-port=2376/tcp --permanent ; firewall-cmd --add-port=2377/tcp --permanent ; firewall-cmd --add-port=7946/tcp --permanent ; firewall-cmd --add-port=7946/udp --permanent ; firewall-cmd --add-port=4789/udp --permanent ; firewall-cmd --reload "
	ssh ${i} "systemctl start docker; systemctl enable docker ; docker info"
done

# Creation of the Swarm cluster
