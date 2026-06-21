FROM php:8.2-cli

RUN docker-php-ext-install pdo pdo_mysql mbstring

WORKDIR /app
COPY . .

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install

CMD php artisan serve --host=0.0.0.0 --port=$PORT
