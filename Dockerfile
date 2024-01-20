FROM php:8.2-apache

RUN apt-get update && \
    docker-php-ext-install \
    mysqli \
    pdo_mysql

RUN apt-get install -y libzip-dev
