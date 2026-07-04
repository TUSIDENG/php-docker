FROM php:7.0-fpm

ARG PHP_MODE=fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    vim \
    curl \
    wget \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libmemcached-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql \
        mysqli \
        gd \
        zip \
        curl \
        opcache \
        bcmath \
        mbstring \
        pcntl \
        sockets

RUN pecl install redis-4.3.0 \
    && pecl install memcached-3.1.5 \
    && docker-php-ext-enable redis memcached \
    && mkdir -p /var/log/php

COPY --from=composer:1.10 /usr/bin/composer /usr/bin/composer

RUN if [ "$PHP_MODE" = "fpm" ]; then \
        pecl install xdebug-2.9.8 \
        && docker-php-ext-enable xdebug; \
    elif [ "$PHP_MODE" = "swoole" ]; then \
        pecl install swoole-4.4.23 \
        && pecl install yasd-0.3.9 \
        && docker-php-ext-enable swoole yasd; \
    fi

COPY php.ini /usr/local/etc/php/php.ini
COPY www.conf /usr/local/etc/php-fpm.d/www.conf
COPY zz-xdebug.ini /tmp/zz-xdebug.ini
COPY zz-yasd.ini /tmp/zz-yasd.ini

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["entrypoint.sh"]