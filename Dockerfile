# Original Dockerfile: https://github.com/nginxinc/docker-nginx/blob/b0e153a1b644ca8b2bd378b14913fff316e07cf2/stable/alpine/Dockerfile
FROM fabiocicerchia/nginx-lua:alpine
LABEL MAINTAINER="Ehsan Rahimi <esnrhm2@gmail.com>"
RUN apk add --no-cache openssl


COPY resources/nginx.conf /etc/nginx/nginx.conf


ENV USERNAME="admin" \
    PASSWORD="admin" \
    SECRET_KEY="4FpyKHqnSTAMUAdsfdyDZIFYa8favIA4UqM69XtCDjyzrdnAvXFt63vreX78dk57"

