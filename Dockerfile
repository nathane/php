FROM ghcr.io/nathane/php:7.3-base

ENV XDEBUG_VERSION 3.0.3

RUN pecl install xdebug-$XDEBUG_VERSION \
    && docker-php-ext-enable xdebug
