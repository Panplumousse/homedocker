FROM php:7.2-apache
MAINTAINER Levrez Matthias "matthias.levrez@gmail.fr"

#ACTIVATION MODE NON INTERACTIF APT
	ENV	DEBIAN_FRONTEND noninteractive

#MISE A JOUR DES PAQUETS APT
	RUN	apt-get update

#INSTALLATION DES PACKAGES OPTIONNELS
	RUN	apt-get  install -y --no-install-recommends \
			python-pip \
			python-wheel \
			python-setuptools \
			supervisor
	 #	pip install jinja2

#INSTALLATION DES PACKAGES POUR CACTI
	RUN 	apt-get install -y --no-install-recommends \
			rrdtool \
			snmp \
			snmpd
#INSTALLATION LIB POUR PHP
	RUN 	apt-get install -y --no-install-recommends \
			libbz2-dev \
			libpng-dev \
			libjpeg-dev \
			libwebp-dev \
			libxpm-dev \
			libfreetype6-dev

#CONFIGURATION MODULE PHP
	RUN 	docker-php-ext-configure gd \
			--with-freetype-dir=/usr \
			--with-jpeg-dir=/usr \
			--with-png-dir=/usr \
			--with-xmp-dir=/usr \
			--with-webp-dir=/usr && \
		docker-php-ext-install \
			bz2 \
			gd \
			mysqli \
			opcache \
			zip
#PURGE CACHE APT
	RUN 	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommensImportant=false && \
		rm -rf /var/lib/apt/lists/*
#PREPARATION URL SOURCE CACTIi
	ENV 	VERSION 1.2.4
	ENV	URL https://www.cacti.net/downloads/cacti-$VERSION.tar.gz
	ENV 	TAR cacti.tar.gz
	LABEL 	version=$VERSION

#TELECHARGEMENT DES SOURCES ET INSTALLATION
	RUN 	curl --output $TAR --location $URL && \ 
		tar -xzvf $TAR -C /usr/src && \
		rm -r $TAR && \
		mv /usr/src/cacti-${VERSION} /usr/src/cacti
#COPY DES CONF
	COPY 	/conf/config.php.j2 /usr/src/
	COPY 	/conf/run.sh /run.sh

#EXECUTION DU SCRIP
	#ENTRYPOINT [ "/run.sh" ]
	CMD 	["apache2-foreground"]	
		
