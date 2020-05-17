FROM debian:buster

RUN apt-get update -y \
    && apt upgrade -y \
    && apt-get install -y git wget zsh \
    && sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" \
    && apt-get install -y \
    nginx mariadb-server mariadb-client php-cgi php-common php-fpm php-pear \
    php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext \
    php-mysql php-bcmath unzip \
    && service mysql start \
    && echo "CREATE DATABASE wpdb;" | mysql

CMD service mysql restart && nginx -g 'daemon off;'