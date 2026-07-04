#!/bin/sh

if [ -z "$(ls -A /etc/nginx/conf.d)" ]; then
    cp /etc/nginx/conf.d.default/* /etc/nginx/conf.d/
fi