FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    git \
    zlib1g-dev \
    libzip-dev

RUN docker-php-ext-install \
    mysqli \
    pdo_mysql \
    zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get install -y libzip-dev
