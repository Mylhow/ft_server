if [ "${AUTOINDEX}" = "off" ]
then
  sed -i "s/autoindex on/autoindex off/" /etc/nginx/sites-available/default.conf;
  sed -i "s/#index index.php welcome.html;/index index.php welcome.html;/" /etc/nginx/sites-available/default.conf;
fi