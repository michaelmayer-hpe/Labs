FROM centos:6
#FROM fedora:latest
RUN yum update -y
RUN yum install -y httpd tar bzip2 php php-dom php-mbstring php-pdo php-gd php-mysql
MAINTAINER myself@mydomain.org
#ADD http://labossi.hpintelco.org/owncloud-7.0.15.tar.bz2 /var/www/html/
# if already downloaded you can use COPY instead
COPY owncloud-7.0.15.tar.bz2 /var/www/html/
RUN cd /var/www/html/ && tar xfj owncloud-7.0.15.tar.bz2 && rm -f owncloud-7.0.15.tar.bz2
COPY config.php /var/www/html/owncloud/config/
RUN mkdir -p /data
RUN chown -R apache:apache /var/www/html/owncloud /data
# Put VOLUME at the end so the previous chown works
VOLUME /data

CMD /usr/sbin/apachectl -DFOREGROUND -k start
EXPOSE 80
