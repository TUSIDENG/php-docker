#!/bin/bash

if [ "$PHP_MODE" = "swoole" ]; then
    cp /tmp/zz-yasd.ini /usr/local/etc/php/conf.d/zz-yasd.ini
    rm -f /usr/local/etc/php/conf.d/zz-xdebug.ini 2>/dev/null
    echo "Starting PHP in Swoole mode..."
    echo "Use 'docker exec -it php71-fpm bash' to run your Swoole scripts"
    tail -f /dev/null
else
    cp /tmp/zz-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug.ini
    rm -f /usr/local/etc/php/conf.d/zz-yasd.ini 2>/dev/null
    echo "Starting PHP-FPM..."
    exec php-fpm
fi