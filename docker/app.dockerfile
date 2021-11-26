# FROM alpine

# CMD tail -f /dev/null # keep container up
FROM php:8-apache

RUN apt-get update && \
    apt-get install -y --no-install-recommends nano zip unzip git

RUN docker-php-ext-install pdo_mysql

ADD vhost.conf /etc/apache2/sites-enabled/000-default.conf

WORKDIR /

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

RUN a2enmod rewrite

WORKDIR /var/www/html



