# This will build PHP from scratch (source I should say) rather than from an apt, dnf or yum repo 
# To build this file into a docker image, run something like:
# docker build -t php563 .
# It is quite fat and some tuning needs to be done

FROM centos:latest
#Dockerfile Author:
MAINTAINER Name david@davidstclair.co.uk
RUN yum install -y epel-release
RUN yum -y update
RUN useradd phpuser
RUN yum install -y tcpdump curl telnet git sudo 
RUN yum groupinstall -y 'Development Tools'
RUN yum install -y bzip2 libyaml libyaml-devel libxml2 libxml2-devel openssl openssl-devel libcurl libcurl-devel \ 
    libpnglibpng-devel libjpeg-turbo libjpeg-turbo-devel readdline readline-devel libtidy libtidy-devel \
    libxslt libxslt-devel ImageMagick ImageMagick-devel cyrus-sasl-plain libtcvcvc:q!ol-ltdl-devel libmcrypt \
    libmcrypt-devel libicu-devel expat expat-devel gcc php-devel libpng-devel 

RUN git clone git://github.com/CHH/php-build.git /usr/local/src/php-build
RUN /usr/local/src/php-build/install.sh
RUN mkdir /usr/local/php-version
RUN mkdir /php-fpm
RUN /usr/bin/curl -sSL https://github.com/wilmoore/php-version/tarball/master | /bin/tar -C /usr/local/php-version -xz --strip 1
RUN /usr/local/bin/php-build 5.6.30 /home/phpuser/.phps/5.6.30
RUN chown -R phpuser.phpuser /home/phpuser/

