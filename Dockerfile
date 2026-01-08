FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    nodejs \
    npm \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create entrypoint script
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
# Wait for database\n\
echo "Waiting for database..."\n\
until php artisan migrate:status > /dev/null 2>&1 || [ $? -eq 1 ]; do\n\
  sleep 2\n\
done\n\
\n\
# Check if VaahCMS is installed\n\
if [ ! -f "/var/www/html/.vaahcms-installed" ]; then\n\
  echo "Installing VaahCMS..."\n\
  \n\
  # Install VaahCMS if not exists\n\
  if [ ! -f "composer.json" ]; then\n\
    composer create-project --prefer-dist webreinvent/vaahcms .\n\
  fi\n\
  \n\
  # Copy .env if not exists\n\
  if [ ! -f ".env" ]; then\n\
    cp .env.example .env\n\
  fi\n\
  \n\
  # Generate app key\n\
  php artisan key:generate\n\
  \n\
  # Run migrations\n\
  php artisan migrate --force\n\
  \n\
  # Mark as installed\n\
  touch /var/www/html/.vaahcms-installed\n\
fi\n\
\n\
# Set permissions\n\
chown -R www-data:www-data /var/www/html\n\
chmod -R 755 /var/www/html\n\
chmod -R 775 storage bootstrap/cache\n\
\n\
exec php-fpm\n\
' > /entrypoint.sh && chmod +x /entrypoint.sh

# Expose port 9000
EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
