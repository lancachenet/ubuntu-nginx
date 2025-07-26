# hadolint ignore=DL3007
FROM lancachenet/ubuntu:latest

LABEL org.opencontainers.image.authors="LanCache.Net Team <team@lancache.net>"

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

# hadolint ignore=DL3008
RUN <<EOF
  apt-get update
  apt-get install -y nginx-full inotify-tools --no-install-recommends
  apt-get -y clean
  rm -rf /var/lib/apt/lists/*
EOF

COPY --link overlay/ /

RUN <<EOF
  rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
  mkdir -p /etc/nginx/{sites,stream}-enabled/ /var/lib/nginx /var/www/html
  chmod -R 664 /etc/nginx/{conf,stream}.d/*
  for file in /etc/nginx/{sites,stream}-available/*; do
    ln -s "${file}" "${file/available/enabled}"
  done
EOF

EXPOSE 80
