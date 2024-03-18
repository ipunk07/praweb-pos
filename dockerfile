FROM php:7.4-fpm

RUN apt-get update && apt-get install -y curl

RUN curl -sS https://getcomposer.org/installer | php

RUN composer install --no-interaction

COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html

CMD ["php-fpm"]