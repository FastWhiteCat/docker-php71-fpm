FROM php:7.1-fpm

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxslt1-dev \
    git \
    vim \
    wget \
    lynx \
    psmisc \
    jpegoptim \
    optipng \
    cron \
    supervisor \
    libmagickwand-dev \
    bzip2 \
    gnupg \
    gnupg2 \
    && apt-get clean

RUN docker-php-ext-configure mcrypt \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/lib64/ --with-png-dir=/usr/lib64/ --with-freetype-dir=/usr/lib64/ \
    && docker-php-ext-install \
      gd \
      intl \
      mbstring \
      mcrypt \
      bcmath \
      pdo_mysql \
      xsl \
      zip \
      opcache \
      soap

RUN pecl install imagick \
    && docker-php-ext-enable imagick

# Install Composer
RUN curl -sS https://getcomposer.org/installer | \
    php -- \
      --install-dir=/usr/local/bin \
      --filename=composer \
      --version=1.1.2

# Install Node.js
RUN curl -sL  https://deb.nodesource.com/setup_8.x | bash - && \
  apt-get install -y nodejs

# Install MageRun
RUN cd /usr/local/bin && \
    wget https://files.magerun.net/n98-magerun.phar && \
    chmod +x ./n98-magerun.phar