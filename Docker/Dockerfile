FROM centos:6
#FROM fedora:latest
RUN yum install -y httpd
MAINTAINER myself@mydomain.org
RUN yum install -y tar bzip2 php php-dom php-mbstring php-pdo php-gd
#ADD http://labossi.hpintelco.org/owncloud-7.0.15.tar.bz2 /var/www/html/
# if already downloaded you can use COPY instead
COPY owncloud-7.0.6.tar.bz2 /var/www/html/
RUN cd /var/www/html/ && tar xvfj owncloud-7.0.15.tar.bz2 && rm -f owncloud-7.0.15.tar.bz2
VOLUME /data
COPY config.php /var/www/html/owncloud/config/
RUN chown -R apache:apache /var/www/html/owncloud /data

CMD /usr/sbin/apachectl -DFOREGROUND -k start
EXPOSE 80
