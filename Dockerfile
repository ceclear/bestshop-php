FROM php:7.3-fpm

RUN apt-get update && apt-get install -y \
         libfreetype6-dev \
         libjpeg62-turbo-dev \
         libpng-dev \
         libssl-dev \
         libzip-dev \
     && apt-get autoclean && apt-get clean \
     && docker-php-ext-configure gd  \
     && docker-php-ext-install -j$(nproc) gd \
     && pecl install redis-5.3.2 \
     && docker-php-ext-enable redis \
     && docker-php-ext-install zip \
     && docker-php-ext-install bcmath  \
     && docker-php-ext-install mysqli pdo pdo_mysql \
     && apt-get clean \
     && apt-get autoclean \
     && cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
     && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

MAINTAINER ceclear<594652523@qq.com>

WORKDIR /www/web/bestshop-php

COPY  . /www/web/bestshop-php

#COPY . .
RUN chmod -R 777 /www/web/bestshop-php
EXPOSE 9000
