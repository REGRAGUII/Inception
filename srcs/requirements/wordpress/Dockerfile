FROM debian:bullseye

# Install required packages
RUN apt update -y && apt install -y \
    wget \
    php \
    php-fpm \
    php-mysql \
    mariadb-client \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and extract WordPress
# RUN wget https://wordpress.org/wordpress-6.8.1.tar.gz -P /var/www \
    # && cd /var/www \
    # && tar -xzf wordpress-6.8.1.tar.gz \
    # && rm wordpress-6.8.1.tar.gz
RUN		apt update -y && apt install -y wget php php-fpm php-mysql mariadb-client
RUN		wget https://wordpress.org/wordpress-6.8.1.tar.gz -P /var/www
RUN 	cd /var/www && tar -xzf wordpress-6.8.1.tar.gz && rm wordpress-6.8.1.tar.gz

# Set correct permissions
RUN chmod -R 755 /var/www/wordpress

# Copy PHP-FPM config
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod 755 wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy WordPress setup script
COPY tools/wpconfig.sh /
RUN chmod +x /wpconfig.sh

# Set working directory
# WORKDIR /var/www/wordpress

EXPOSE 9000

# Run WordPress init + PHP-FPM
CMD ["/wpconfig.sh"]
