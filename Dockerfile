FROM php:8.2-cli

# 1. install dependency OS dulu
RUN apt-get update && apt-get install -y \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl

# 2. baru install extension PHP
RUN docker-php-ext-install pdo pdo_mysql mbstring

# 3. install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . .

RUN composer install

CMD php artisan serve --host=0.0.0.0 --port=$PORT
