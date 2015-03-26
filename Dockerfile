FROM ubuntu:14.04

RUN echo debconf debconf/frontend select Noninteractive | debconf-set-selections

RUN apt-get update
RUN apt-get dist-upgrade -y

RUN echo mysql-server mysql-server/root_password password "" | sudo debconf-set-selections
RUN echo mysql-server mysql-server/root_password_again password "" | sudo debconf-set-selections

RUN apt-get install -y mysql-server
RUN apt-get install -y apache2
RUN apt-get install -y libapache2-mod-php5
RUN apt-get install -y php5-mysql
RUN apt-get install -y php5-mysqlnd

RUN sed -i 's/^log_error/#&/' /etc/mysql/my.cnf

RUN mkdir /docker
ADD entrypoint.sh /docker/

RUN rm /var/www/html/index.html
RUN echo '<?php phpinfo();' > /var/www/html/index.php

ENTRYPOINT [ "/bin/sh", "-c" ]
CMD [ "/docker/entrypoint.sh" ]
EXPOSE 80
VOLUME /var/www/html
VOLUME /var/data/mysql
