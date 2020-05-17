#!/bin/sh

./build.sh
echo "Demarrage du serveur en cours"
docker run --name ft_server -p 80:80 -p 443:443 -d ft_server
echo "Demarrage du serveur termine"