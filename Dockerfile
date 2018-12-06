FROM steamcache/ubuntu:latest
MAINTAINER SteamCache.Net Team <team@steamcache.net>
ARG DEBIAN_FRONTEND=noninteractive
COPY overlay/ /
ENV SSL_KEY=/ssl/ssl.key \
    SSL_CERT=/ssl/ssl.crt \
    DOCUMENT_ROOT=html
RUN apt-get update && apt-get install -y nginx inotify-tools
RUN \
    chmod 777 /opt/nginx/startnginx.sh && \
    sed -i -e '/sendfile on;/a\        client_max_body_size 0\;' /etc/nginx/nginx.conf && \
    sed -i -e 's/gzip on/#gzip on/' /etc/nginx/nginx.conf && \
    sed -i -e 's/gzip_disable/#gzip_disable/' /etc/nginx/nginx.conf && \
    rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default && \
	mkdir -p /etc/nginx/sites-enabled/ && \
	for SITE in /etc/nginx/sites-available/*; do [ -e "$SITE" ] || continue; ln -s $SITE /etc/nginx/sites-enabled/`basename $SITE`; done && \
    mkdir -p /var/www/html && \
    chmod 777 /var/www/html /var/lib/nginx /etc/DOCUMENT_ROOT && \
    chmod -R 777 /var/log/nginx && \
    chmod -R 755 /hooks /init && \
    chmod 755 /var/www && \
    chmod -R 666 /etc/nginx/sites-* /etc/nginx/conf.d/*

EXPOSE 80 443
