FROM ubuntu:16.04

MAINTAINER Kotliar Maksym kotlyar.maksim@gmail.com

RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests nginx php php-fpm ca-certificates && \
    rm -rf /var/lib/apt/lists/*


# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
	&& ln -sf /dev/stderr /var/log/php7.0-fpm.log

RUN rm -f /etc/nginx/sites-enabled/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php/7.0/fpm/pool.d/www.conf

RUN mkdir -p /run/php && touch /run/php/php7.0-fpm.sock && touch /run/php/php7.0-fpm.pid

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

EXPOSE 80

CMD ["/entrypoint.sh"]
