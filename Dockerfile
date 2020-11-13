FROM lancachenet/ubuntu:latest
MAINTAINER LanCache.Net Team <team@lancache.net>
ARG DEBIAN_FRONTEND=noninteractive
COPY overlay/ /
RUN apt-get update && apt-get install -y nginx-full inotify-tools
RUN \
    chmod 777 /opt/nginx/startnginx.sh && \
    rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default && \
	mkdir -p /etc/nginx/sites-enabled/ && \
	mkdir -p /etc/nginx/stream-enabled/ && \
	for SITE in /etc/nginx/sites-available/*; do [ -e "$SITE" ] || continue; ln -s $SITE /etc/nginx/sites-enabled/`basename $SITE`; done && \
	for SITE in /etc/nginx/stream-available/*; do [ -e "$SITE" ] || continue; ln -s $SITE /etc/nginx/stream-enabled/`basename $SITE`; done && \
    mkdir -p /var/www/html && \
    chmod 777 /var/www/html /var/lib/nginx && \
    chmod -R 777 /var/log/nginx && \
    chmod -R 755 /hooks /init && \
    chmod 755 /var/www && \
    chmod -R 666 /etc/nginx/sites-* /etc/nginx/conf.d/* /etc/nginx/stream.d/* /etc/nginx/stream-*

EXPOSE 80
