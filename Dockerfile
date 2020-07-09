# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Kwillum <daniilxod@gmail.com>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/07/07 22:50:26 by Kwillum           #+#    #+#              #
#    Updated: 2020/07/09 20:45:09 by Kwillum          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update
#RUN apt-get upgrade
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server
RUN apt-get -y install php-fpm php-mysql
RUN apt-get -y install php7.3
RUN apt-get -y install php-curl
RUN apt-get -y install php-gd
RUN apt-get -y install php-intl
RUN apt-get -y install php-mbstring
RUN apt-get -y install php-soap
RUN apt-get -y install php-xml
RUN apt-get -y install php-xmlrpc
RUN apt-get -y install php-zip
RUN apt-get -y install wget
RUN apt-get -y install vim

WORKDIR /var/www/localhost/

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz https://wordpress.org/latest.tar.gz
RUN tar xzf latest.tar.gz
RUN cp -a wordpress/. .
RUN rm -rf wordpress
RUN tar xzf phpMyAdmin-5.0.2-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.2-all-languages phpMyAdmin
RUN chown -R www-data:www-data /var/www/*
RUN chmod 777 -R /var/*

RUN apt-get -y install certbot python-certbot-nginx
RUN apt-get -y install openssl
RUN apt-get -y install curl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=AB/ST=CD/L=EF/O=21/CN=kwillum" -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt
COPY ./srcs/nginx.conf /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

COPY ./srcs/wp-config.php .
COPY ./srcs/start.sh .
COPY ./srcs/autoindex_mod.sh .

EXPOSE 80 443

CMD ["bash", "start.sh"]
