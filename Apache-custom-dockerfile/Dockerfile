From rhel7:7.5

MAINTAINER Himanshu Dogra <hdogra@redhat.com>

ENV PORT 8080

ADD training.repo /etc/yum.repos.d/training.repo

RUN yum -y install httpd && yum clean all && rm -rf /var/cache/yum 

RUN sed -ri -e '/^Listen 80/c\Listen ${PORT}' /etc/httpd/conf/httpd.conf \
&& chown -R apache:apache /etc/httpd/logs/ \
&& chown -R apache:apche /run/httpd/

USER apache

#Expose the custom port  that you provided in the ENV var
EXPOSE ${PORT}

#Copy the index.html file under src/ folder to Apache DocumentRoot (/var/www/html)
COPY src/ /var/www/html/

#Start Apache in ForeGround
CMD [ "httpd", "-D", "FOREGROUND" ]
