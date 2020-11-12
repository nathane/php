FROM ghcr.io/nathane/php:7.3-base

RUN git clone git://github.com/xdebug/xdebug.git && cd xdebug && phpize \
    && ./configure --enable-xdebug && make && make install && cd ../ \
    && rm -rf xdebug && docker-php-ext-enable xdebug
