FROM php:7.1.33-cli

RUN apt-get update && apt-get -y install git libjpeg-dev libmagickwand-dev \
    libmemcached-dev libpng-dev libpq-dev libsqlite3-dev libxml2-dev uuid-dev \
    unzip wget zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr && \
    docker-php-ext-install bcmath gd intl opcache pcntl pdo pdo_mysql \
    pdo_pgsql pdo_sqlite soap sockets zip
RUN pecl install apcu-5.1.20 ast-1.0.10 imagick-3.4.4 memcached-3.1.5 \
    mongodb-1.9.0 uuid-1.2.0 redis-5.3.4 && docker-php-ext-enable ast apcu \
    imagick memcached mongodb uuid redis

RUN mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini && \
    rm $PHP_INI_DIR/php.ini-development && \
    sed 's/short_open_tag=On/short_open_tag=Off/' $PHP_INI_DIR/php.ini && { \
		echo 'memory_limit=2048M'; \
		echo 'upload_max_filesize=128M'; \
		echo 'post_max_size=128M'; \
	} > /usr/local/etc/php/conf.d/memory-limit.ini
