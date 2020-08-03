FROM debian:buster

WORKDIR /var/www/html/

RUN apt-get update -y && apt upgrade -y \
    && apt-get install -y git wget zsh vim nginx \
    mariadb-server mariadb-client php-cgi php-common php-fpm php-pear \
    php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext \
    php-mysql php-bcmath unzip \
    && sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" \
    && service mysql start \
    && echo "CREATE DATABASE wpdb;" | mysql \
    && echo "CREATE USER 'user42'@'localhost' identified by 'user42';" | mysql \
    && echo "GRANT ALL PRIVILEGES ON wpdb.* TO 'user42'@'localhost';" | mysql \
    && echo "FLUSH PRIVILEGES;" | mysql \
    && wget -O wordpress.tar.gz "https://wordpress.org/latest.tar.gz" \
    && wget -O phpmyadmin.tar.gz "https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz" \
    && tar -xzf wordpress.tar.gz && tar -xzf phpmyadmin.tar.gz \
    && mv phpMyAdmin-5.0.2-all-languages phpmyadmin \
    && mkdir /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/default.key -out /etc/nginx/ssl/default.crt \
    -subj "/C=FR/ST=France/L=Lyon/O=42Lyon/OU=42Network/CN=localhost/emailAddress=dgascon@student.42lyon.fr" \
    && chown -R www-data:www-data /var/www/html/wordpress \
    && chown -R www-data:www-data /var/www/html/phpmyadmin \
    && ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/

ENV AUTOINDEX="off"

COPY srcs/. /

EXPOSE 80 443

CMD /bin/bash /etc/nginx/sites-available/index.sh && service mysql restart && service php7.3-fpm start && nginx -g 'daemon off;'
