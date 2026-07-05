FROM nginx:1.25-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

COPY conf.d/ /etc/nginx/conf.d.default/

COPY entrypoint.sh /docker-entrypoint.d/99-nginx-conf.sh
RUN chmod +x /docker-entrypoint.d/99-nginx-conf.sh

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]