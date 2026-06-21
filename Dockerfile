FROM php:8.2-cli

# install OS dependency
RUN apt-get update && apt-get install -y \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl

# install PHP extension
RUN docker-php-ext-install pdo pdo_mysql mbstring

# install Node.js 18 (PENTING)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . .

# install PHP dependency
RUN composer install

# install JS dependency
RUN npm install

# FIX WEBPACK ERROR (INI PENTING)
ENV NODE_OPTIONS=--openssl-legacy-provider

# build assets Laravel Mix
RUN npm run production

CMD php artisan serve --host=0.0.0.0 --port=$PORT
