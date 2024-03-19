# Gunakan PHP sebagai dasar
FROM php:7.4-fpm

# Install dependensi yang diperlukan
RUN apt-get update && apt-get install -y \
    nginx \
    git \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql mbstring zip exif pcntl

# Salin konfigurasi Nginx
COPY nginx.conf /etc/nginx/sites-available/default

# Set direktori kerja
WORKDIR /var/www/html

# Salin kode aplikasi
COPY . .

# Instal Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Hapus composer.lock dan vendor
#RUN rm -rf composer.lock vendor

# Install dependensi PHP menggunakan Composer
#RUN composer install --no-scripts --no-autoloader

# Generate autoload dan selesai instalasi
#RUN composer dump-autoload --optimize && php artisan route:cache && php artisan config:cache

# Expose port 80 untuk Nginx
EXPOSE 80

# Perintah untuk menjalankan aplikasi
CMD service nginx start && php-fpm
