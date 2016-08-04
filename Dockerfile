FROM ubuntu:14.04
MAINTAINER bizruntime

RUN apt-get  update  &&  DEBIAN_FRONTEND=noninteractive
RUN  apt-get install -y -q apache2 libapache2-mod-php5 php5 php5-cli php5-xmlrpc php5-ldap php5-gd php5-mysql mcrypt php5-mcrypt \
	mysql-client unzip wget supervisor nano

RUN php5enmod mcrypt

RUN mkdir /var/www/i-doit 

RUN wget -O i-doit.zip http://sourceforge.net/projects/i-doit/files/i-doit/1.4.7/idoit-open-1.4.7.zip/download
RUN unzip i-doit.zip -d /var/www/i-doit
RUN rm i-doit.zip

RUN chmod +x /var/www/i-doit/idoit-rights.sh
RUN cd /var/www/i-doit && ./idoit-rights.sh

COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]

