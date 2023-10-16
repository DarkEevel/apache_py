#ARM
#FROM arm64v8/ubuntu:22.04

#x86
FROM ubuntu:22.04

EXPOSE 80

RUN apt-get update
RUN apt-get -y install apache2 libapache2-mod-wsgi-py3 python3 python3-pip inotify-tools nano cron

#load apache cgi module
RUN a2enmod wsgi cgid
RUN service apache2 restart

#enable cgi in the website root
COPY configs/apache2.conf /etc/apache2/apache2.conf

#script for permission change in /var/www/html to execute python files
COPY scripts/alter_permissions_auto.sh /var/tmp/alter_permissions_auto.sh
RUN chmod 0744 /var/tmp/alter_permissions_auto.sh

#add crontab
COPY configs/crontab_alter_permissions /etc/cron.d/crontab_alter_permissions
RUN chmod 0644 /etc/cron.d/crontab_alter_permissions
RUN crontab /etc/cron.d/crontab_alter_permissions

RUN ln -sf /usr/bin/python /usr/local/bin/python

CMD cron && /usr/sbin/apache2ctl -D FOREGROUND