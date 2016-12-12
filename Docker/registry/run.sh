#!/bin/bash
umask 277 && openssl genrsa 2048 > ca/ca.key
umask 007 && openssl req -new -x509 -days 365 -subj "/C=FR/ST=/L=Grenoble/O=HPE/CN=ca" -key ca/ca.key > ca/ca.crt
umask 002 && openssl genrsa 2048 > srv/repo.key
umask 002 && openssl req -new -subj "/C=FR/ST=/L=Grenoble/O=HPE/CN=$PUBIP" -key srv/repo.key > srv/repo.csr
umask 002 && openssl x509 -req -in srv/repo.csr -out srv/repo.crt -CA ca/ca.crt -CAkey ca/ca.key -CAcreateserial -CAserial ca/ca.srl
cp /home/pki/ca/ca.crt /var/www/html
chown pki:pki /var/www/html/ca.crt && chmod 644 /var/www/html/ca.crt
/usr/sbin/apachectl -DFOREGROUND -k start
