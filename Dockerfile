FROM ghcr.io/nathane/php:7.2-base

ENV XDEBUG_VERSION 2.9.7

RUN pecl install xdebug-$XDEBUG_VERSION \
    && docker-php-ext-enable xdebug
