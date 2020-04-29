FROM php:7.1.33-fpm

RUN apt-get update && apt-get -y install git libjpeg-dev libmagickwand-dev \
  libmemcached-dev libpng-dev libpq-dev libsqlite3-dev libxml2-dev unzip \
  wget zlib1g-dev && \
  rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr && \
  docker-php-ext-install bcmath gd intl opcache pcntl pdo pdo_mysql \
  pdo_pgsql pdo_sqlite soap sockets zip
RUN pecl install ast-1.0.6 imagick-3.4.4 memcached-3.1.5 mongodb-1.8.0beta1 \
  uuid-1.1.0 redis-5.2.1 && docker-php-ext-enable ast imagick memcached \
  mongodb uuid redis

RUN mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini && \
  rm $PHP_INI_DIR/php.ini-development && \
  sed 's/short_open_tag=On/short_open_tag=Off/' $PHP_INI_DIR/php.ini && { \
  echo 'memory_limit=1024M'; \
  echo 'upload_max_filesize=128M'; \
  echo 'post_max_size=128M'; \
  } > /usr/local/etc/php/conf.d/memory-limit.ini && \
  sed -i 's/www-data/root/g' /usr/local/etc/php-fpm.d/www.conf

CMD ["php-fpm", "-R"]
