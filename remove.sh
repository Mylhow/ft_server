#!/bin/sh

./stop.sh
echo "Suppression du serveur en cours"
docker rm ft_server
echo "Suppression du serveur termine"
echo "Suppression de l'image en cours"
docker image rm ft_server
echo "Suppression de l'image termine"