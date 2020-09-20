FROM ghcr.io/nathane/php:5.6-base

ENV XDEBUG_VERSION 2.5.5

RUN pecl install xdebug-$XDEBUG_VERSION \
    && docker-php-ext-enable xdebug
