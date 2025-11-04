#!/usr/bin/env bash
set -e
export DEBIAN_FRONTEND=noninteractive

echo ">>> Provisioning web: update & install apache + php + psql ext"
apt-get update -y
apt-get install -y apache2 php libapache2-mod-php php-cli php-pgsql

# Copiar contenido del folder sincronizado al directorio web
if [ -d /vagrant_data ]; then
  echo ">>> Copiando archivos web a /var/www/html"
  rm -rf /var/www/html/*
  cp -R /vagrant_data/* /var/www/html/
  chown -R www-data:www-data /var/www/html
fi

a2enmod rewrite || true

echo ">>> Reiniciando Apache"
systemctl restart apache2

echo ">>> Web provisioning finalizado"
