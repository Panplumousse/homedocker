FROM php:7.2-apache
MAINTAINER Levrez Matthias "matthias.levrez@gmail.fr"

#ACTIVATION MODE NON INTERACTIF APT
	ENV DEBIAN_FRONTEND noninteractive 

#MISE A JOUR DES PAQUETS APT
	RUN apt-get update

#INSTALLATION DES PACKAGES OPTIONNELS
	RUN apt-get install -y --no-install-recommends \
		python-pip \
		python-wheel \
		python-setuptools \
		supervisor \
	&& pip install jinja2
