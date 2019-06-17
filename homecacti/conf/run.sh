#!/bin/bash
set -e #exit on error

#Variables pour jinja
export DB_TYPE=${DB_TYPE:-"mysql"}
export DB_DEFAULT=$DB_DEFAULT:-"cacti"}
export DB_HOST=${DB_HOST:-"localhost"}
export DB_USER=${DB_USER:-"cactiuser"}
export DB_PASSWORD=${DB_PASSWORD:-"cactiuser"}
export DB_PORT=${DB_PORT:-"3306"}

#Copie de cacti vers apaches
cd /var/www/html
mkdir cacti
cd cacti
                user="${APACHE_RUN_USER:-www-data}"
                group="${APACHE_RUN_GROUP:-www-data}"
         	tar --create \
            	--file - \
            	--one-file-system \
            	--directory /usr/src/cacti \
            	--owner "$user" --group "$group" \
            	. | tar --extract --file -
        	echo >&2 "Complete! cacti  has been successfully copied to $PWD"
       	 	mkdir -p tmp; \
        	chmod -R 777 tmp; \
#Templates j2 / > /
j2 /usr/src/config.php.j2 > /var/www/html/cacti/include/config.php
