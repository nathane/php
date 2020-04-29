FROM docker.pkg.github.com/nathane/php/php:7.0-base

ENV XDEBUG_VERSION 2.7.2

RUN pecl install xdebug-$XDEBUG_VERSION \
  && docker-php-ext-enable xdebug
