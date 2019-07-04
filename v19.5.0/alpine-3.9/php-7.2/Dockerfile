from gocd/gocd-agent-alpine-3.9:v19.5.0

ENV PHP_VERSION 7.2.19
ENV PHP_SUM 1cd2266a058f3224d3cba594540045542606996f026eeef96747f27f6b3d22b6

ENV COMPOSER_VERSION 1.8.6
ENV COMPOSER_SUM b66f9b53db72c5117408defe8a1e00515fe749e97ce1b0ae8bdaa6a5a43dd542

ENV PHING_VERSION 2.16.1
ENV PHING_SUM fc3ec05b6540642f4aa33e219d08b9c850eb0dc3921acf171b5055e07e62d06d934d6cd32e7b5bdfdd6a13a53acd600eaa36f8f19a37bb835919e339abd103af


RUN \
    apk --no-cache upgrade \
    apk add --no-cache git

RUN \
    set -e; \
    wget https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar -O /usr/local/bin/composer; \
    echo "$COMPOSER_SUM  /usr/local/bin/composer" | sha256sum -c; \
    wget https://www.phing.info/get/phing-$PHING_VERSION.phar -O /usr/local/bin/phing; \
    echo "$PHING_SUM  /usr/local/bin/phing" | sha512sum -c; \
    chmod +x /usr/local/bin/composer /usr/local/bin/phing

WORKDIR /build

RUN \
    set -e; \
    mkdir -p /build/php-src; \
    wget https://www.php.net/distributions/php-$PHP_VERSION.tar.gz -O php.tar.gz; \
    echo "$PHP_SUM  php.tar.gz" | sha256sum -c; \
    tar xzf php.tar.gz --strip-components=1 -C php-src

RUN \
    set -e; \
    apk add --no-cache bison re2c openssl curl tar xz bash; \
    apk add --no-cache gcc g++ libxml2-dev make file openssl-dev curl-dev libedit-dev libsodium-dev argon2-dev

WORKDIR /build/php-src

RUN \
    set -e; \
    ./configure --enable-option-checking=fatal --with-mhash --enable-ftp --enable-mbstring --enable-mysqlnd --with-password-argon2 --with-sodium=shared --with-curl --with-libedit --with-openssl --with-zlib --enable-soap; \
    make -j "$(nproc)"; \
    make install

WORKDIR /

RUN \
    set -e; \
    rm -rf /build; \
    apk del gcc g++ libxml2-dev make file openssl-dev curl-dev libedit-dev libsodium-dev argon2-dev
