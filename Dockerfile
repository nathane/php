FROM docker.pkg.github.com/nathane/php/php:7.3-cli

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_VERSION 1.10.5
ENV PRESTISSIMO_VERSION 0.3.10

RUN wget https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar \
  && mv composer.phar /usr/local/bin/composer \
  && chmod +x /usr/local/bin/composer \
  && composer global require "hirak/prestissimo:$PRESTISSIMO_VERSION"

