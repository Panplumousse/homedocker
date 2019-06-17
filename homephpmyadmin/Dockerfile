FROM php:7.2-apache
MAINTAINER Levrez Matthias "matthias.levrez@gmail.fr"

#ACTIVATION MODE NON INTERACTIF APT
	ENV 	DEBIAN_FRONTEND noninteractive 

#MISE A JOUR DES PAQUETS APT
	RUN 	apt-get update

#INSTALLATION DES PACKAGES OPTIONNELS
	RUN 	apt-get install -y --no-install-recommends \
			python-pip \
			python-wheel \
			python-setuptools \
			supervisor && \
		pip install jinja2

#INSTALLATION LIB POUR PHP
	RUN 	apt-get install -y --no-install-recommends \
			libbz2-dev \
			libfreetype6-dev \
			libjpeg-dev \
			libpng-dev \
			libwebp-dev \
			libxpm-dev 
#CONFIGURE MODULE PHP
	RUN 	docker-php-ext-configure gd \
			--with-freetype-dir=/usr \
			--with-jpeg-dir=/usr \
			--with-png-dir=/usr \
			--with-webp-dir=/usr \
			--with-xpm-dir=/usr && \
	    	docker-php-ext-install \
			bz2 \
			gd \
			mysqli \
			opcache \
			zip

#PURGE CACHE APT
	RUN	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
		rm -rf /var/lib/apt/lists/*
	
#PREPARATION URL SOURCE PHPMYADMIN	
	ENV 	VERSION 4.9+snapshot
	ENV 	URL https://files.phpmyadmin.net/snapshots/phpMyAdmin-${VERSION}-all-languages.tar.xz
	ENV 	TAR phpMyAdmin.tar.xf
	ENV 	SRC /usr/src/phpmyadmin
	LABEL 	version=$VERSION

#TELECHARGEMENT DES SOURCES ET INSTALLATION

	RUN	curl --output $TAR --location $URL && \
		tar -xf $TAR -C /usr/src && \
		rm -r $TAR && \
		mv /usr/src/phpMyAdmin-${VERSION}-all-languages /usr/src/phpmyadmin && \
		rm -rf \
			$SRC/setup/ \
			$SRC/examples/ \
			$SRC/test/ \
			$SRC/po/ \	
			$SRC/composer.json \
			$SRC/RELEASE-DATE-$VERSION && \
		sed -i "s@define('CONFIG_DIR'.*@define('CONFIG_DIR', '/etc/phpmyadmin/');@" /usr/src/phpmyadmin/libraries/vendor_config.php

#CREATION DES REPERTOIRES POUR LES SESSIONS PERSISTENTES
		
	RUN 	mkdir /sessions && \
		mkdir -p /var/nginx/client_body_temp

# Copy configuration
	COPY 	/conf/config.inc.php /etc/phpmyadmin/config.inc.php
	COPY 	/conf/php.ini /usr/local/etc/php/conf.d/php-phpmyadmin.ini

# Copy main script
	COPY 	/conf/docker-entrypoint.sh /docker-entrypoint.sh

	ENTRYPOINT [ "/docker-entrypoint.sh" ]
	CMD 	["apache2-foreground"]
