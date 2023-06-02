FROM debian:11

LABEL maintainer="aanzorena" \
image="aanzorena/php7.0-apache" \
description="Apache2 Web server with php7.0 mod" \
version="1.0"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update \
    && apt install -y software-properties-common ca-certificates lsb-release apt-transport-https wget gnupg

RUN sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' \
    && wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - 

RUN apt update && apt install -y php7.0 php7.0-mysql php7.0-mbstring php7.0-zip php7.0-gd
RUN a2enmod rewrite

EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]