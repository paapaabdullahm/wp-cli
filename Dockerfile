FROM pam79/php-fpm:v7.4.1
LABEL maintainer="Abdullah Morgan <paapaabdullahm@gmail.com>"

# Add Tini init
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# Add WP CLI
RUN apt update && apt install -y bash curl git openssh-server openssl zip unzip; \
    #
    # Download the installer to the current directory
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    #
    # Make binary globally accessible
    mv wp-cli.phar /usr/bin/wp; \
    #
    # Make binary executable
    chmod +x /usr/bin/wp;

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

WORKDIR /src
VOLUME /src

ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]
CMD ["wp"]
