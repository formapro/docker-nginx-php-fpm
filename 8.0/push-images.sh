#!/usr/bin/env bash

set -x
set -e

docker login -u $DOCKER_USER -p $DOCKER_PASSWORD
docker push formapro/nginx-php-fpm:8.0-latest
docker push formapro/nginx-php-fpm:8.0-latest-all-exts