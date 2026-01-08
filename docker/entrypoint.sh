#!/bin/bash

echo "==================================="
echo "VaahCMS + VaahStore Setup"
echo "==================================="

cd /var/www/html

# Start PHP-FPM in the background first so nginx can connect
echo "Starting PHP-FPM..."
php-fpm -D

# Wait for database
echo "Waiting for database..."
timeout=60
counter=0
until php -r "try { new PDO('mysql:host=${DB_HOST};port=${DB_PORT}', '${DB_USERNAME}', '${DB_PASSWORD}'); } catch(PDOException \$e) { exit(1); }" 2>/dev/null; do
    sleep 1
    counter=$((counter + 1))
    if [ $counter -ge $timeout ]; then
        echo "Database connection timeout!"
        break
    fi
done
echo "Database is ready!"

# Check if Laravel/VaahCMS is already installed
if [ ! -f "artisan" ]; then
    echo "Installing Laravel application..."
    cd /tmp
    rm -rf /tmp/laravel-app
    COMPOSER_MEMORY_LIMIT=-1 composer create-project --prefer-dist laravel/laravel:^10.0 laravel-app --no-interaction
    
    echo "Copying Laravel files..."
    cp -r /tmp/laravel-app/. /var/www/html/
    rm -rf /tmp/laravel-app
    
    cd /var/www/html
    
    echo "Installing VaahCMS package..."
    COMPOSER_MEMORY_LIMIT=-1 composer require webreinvent/vaahcms --no-interaction
    
    echo "Laravel + VaahCMS installed successfully!"
    
    # Copy environment file
    if [ ! -f ".env" ]; then
        cp .env.example .env
        
        # Configure database
        sed -i "s/DB_HOST=.*/DB_HOST=${DB_HOST}/" .env
        sed -i "s/DB_PORT=.*/DB_PORT=${DB_PORT}/" .env
        sed -i "s/DB_DATABASE=.*/DB_DATABASE=${DB_DATABASE}/" .env
        sed -i "s/DB_USERNAME=.*/DB_USERNAME=${DB_USERNAME}/" .env
        sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=${DB_PASSWORD}/" .env
        
        # Generate application key
        php artisan key:generate --force || true
    fi
    
    # Set permissions
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
    chmod -R 775 storage bootstrap/cache 2>/dev/null || true
    
    echo "VaahCMS installed successfully!"
else
    echo "VaahCMS already installed."
fi

# Create modules directory if it doesn't exist
mkdir -p /var/www/html/VaahCms/Modules/Store

# Copy VaahStore module if not already present
if [ ! -f "/var/www/html/VaahCms/Modules/Store/composer.json" ]; then
    echo "Installing VaahStore module..."
    cp -r /var/www/vaahstore/* /var/www/html/VaahCms/Modules/Store/
    chown -R www-data:www-data /var/www/html/VaahCms/Modules
    echo "VaahStore module copied!"
fi

# Run migrations if needed
if [ ! -f "/var/www/html/.installed" ]; then
    echo "Running migrations..."
    php artisan migrate --force || true
    touch /var/www/html/.installed
fi

echo "Setup complete!"
echo "Access the application at: http://localhost:8080"

# Keep container running by tailing PHP-FPM logs
tail -f /usr/local/var/log/php-fpm.log 2>/dev/null || tail -f /dev/null
