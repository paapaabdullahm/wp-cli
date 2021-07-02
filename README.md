# WP-CLI
WordPress CLI Tool. This image does not contain WordPress itself, but instead contains only the cli tool.

**Current WP-CLI Tag: v2.5.0**

## Install as native binary

First export version
```sh
$ export WP_CLI_VERSION="v2.5.0"
```

Persist version by appending to /etc/environment
$ echo 'WP_CLI_VERSION="v2.5.0"' | sudo tee -a /etc/environment > /dev/null

Pull image from docker.io
$ docker pull pam79/wp:${WP_CLI_VERSION}

Create a wrapper script with your favourite editor
```sh
$ sudo vim /usr/local/bin/wp
```

Add the following docker run command to the file
```sh
#!/bin/sh

# A wrapper script for invoking wp-cli with docker
# Put this script in $PATH as wp

TTY_FLAG=``

if [ -t 1 ]; then TTY_FLAG="-t"; fi

exec docker run --rm -i ${TTY_FLAG} \
     --volume "$(pwd)":/src \
     --workdir /src \
     --user $(id -u):$(id -g) \
     "pam79/wp:${WP_CLI_VERSION}" "$@";
```

Make script executable
```sh
$ sudo chmod +x /usr/local/bin/wp
```

Test script
```sh
$ wp --info
```

## Execute commands with installed script
> We will do this from your WordPress project root, and with redis-cache plugin as an example.

Install plugin
```sh
$ wp plugin install redis-cache
```

Activate plugin
```sh
$ wp plugin activate redis-cache
```

Show the redis object cache status and (when possible) client.
```sh
$ wp redis status
```

To enable the redis object cache
```sh
$ wp redis enable
```

To disables the plugin. Default behavior is to delete the object
```sh
$ wp redis disable
```

To update the redis object cache drop-in
```sh
$ wp redis update-dropin
```

For more info on wp-cli commands, visit their [official website](https://wp-cli.org/).
