FROM docker.pkg.github.com/nathane/php/php:7.2-cli

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_1_VERSION 1.10.13
ENV COMPOSER_2_VERSION 2.0.0-RC1

RUN wget https://getcomposer.org/download/$COMPOSER_1_VERSION/composer.phar \
    && mv composer.phar /usr/local/bin/composer1 \
    && chmod +x /usr/local/bin/composer1 \
    && wget https://getcomposer.org/download/$COMPOSER_2_VERSION/composer.phar \
    && mv composer.phar /usr/local/bin/composer2 \
    && chmod +x /usr/local/bin/composer2 \
    && ln /usr/local/bin/composer2 /usr/local/bin/composer

RUN curl -sS https://get.symfony.com/cli/installer | bash - \
    && mv /root/.symfony/bin/symfony /usr/local/bin/symfony

RUN wget https://scrutinizer-ci.com/ocular.phar \
    && mv ocular.phar /usr/local/bin/ocular \
    && chmod 755 /usr/local/bin/ocular
