FROM php:8.0.0rc1-fpm

RUN apt-get update && apt-get -y install git libjpeg-dev libmagickwand-dev \
    libmemcached-dev libpng-dev libpq-dev libsqlite3-dev libxml2-dev \
    libzip-dev uuid-dev unzip wget zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*
RUN wget http://pear.php.net/go-pear.phar && php go-pear.phar \
    && pecl update-channels && rm -rf /tmp/pear ~/.pearrc go-pear.phar
RUN docker-php-ext-configure gd --with-jpeg && docker-php-ext-install bcmath \
    gd intl opcache pcntl pdo pdo_mysql pdo_pgsql pdo_sqlite soap sockets zip
RUN pecl install -f ast-1.0.10 memcached-3.1.5 uuid-1.1.0 \
    && git clone git://github.com/krakjoe/apcu.git && cd apcu && phpize \
    && ./configure && make && make install && cd ../ && rm -rf apcu \
    && git clone git://github.com/Imagick/imagick.git && cd imagick && phpize \
    && ./configure && make && make install && cd ../ && rm -rf imagick \
    && git clone git://github.com/phpredis/phpredis.git && cd phpredis && phpize \
    && ./configure && make && make install && cd ../ && rm -rf phpredis \
    && docker-php-ext-enable apcu ast imagick memcached uuid redis

RUN mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini && \
    rm $PHP_INI_DIR/php.ini-development && \
    sed 's/short_open_tag=On/short_open_tag=Off/' $PHP_INI_DIR/php.ini && { \
		echo 'memory_limit=1024M'; \
		echo 'upload_max_filesize=128M'; \
		echo 'post_max_size=128M'; \
	} > /usr/local/etc/php/conf.d/memory-limit.ini && \
    sed -i 's/www-data/root/g' /usr/local/etc/php-fpm.d/www.conf

CMD ["php-fpm", "-R"]
