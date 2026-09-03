FROM php:7.1-cli

RUN rm -rf /var/lib/apt/lists/* \
    && echo "deb http://mirrors.aliyun.com/debian-archive/debian/ buster main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian-archive/debian/ buster-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian-archive/debian-security/ buster/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update -o Acquire::Check-Valid-Until=false \
    && apt-get -y --allow-unauthenticated dist-upgrade \
    && apt-get install -y --allow-unauthenticated \
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

RUN curl -sS https://getcomposer.org/download/1.10.26/composer.phar -o /usr/bin/composer \
    && chmod +x /usr/bin/composer

RUN pecl install swoole-4.5.11 \
    && docker-php-ext-enable swoole

COPY php.ini /usr/local/etc/php/php.ini

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/html

EXPOSE 8888

ENTRYPOINT ["entrypoint.sh"]
