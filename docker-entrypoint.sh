#!/usr/bin/env bash

isCommand() {
  for cmd in \
    "admin" \
    "cache" \
    "cap" \
    "cli" \
    "comment" \
    "config" \
    "core" \
    "cron" \
    "db" \
    "dist-archive" \
    "embed" \
    "eval" \
    "eval-file" \
    "export" \
    "find" \
    "help" \
    "i18n" \
    "import" \
    "language" \
    "maintenance-mode" \
    "media" \
    "menu" \
    "network" \
    "option" \
    "package" \
    "plugin" \
    "post" \
    "post-type" \
    "profile" \
    "rewrite" \
    "role" \
    "scaffold" \
    "search-replace" \
    "server" \
    "shell" \
    "sidebar" \
    "site" \
    "super-admin" \
    "taxonomy" \
    "term" \
    "theme" \
    "transient" \
    "user" \
    "widget"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

# check if the first argument passed in looks like a flag
if [ "$(printf %c "$1")" = '-' ]; then
  set -- /tini -- wp "$@"
# check if the first argument passed in is wp
elif [ "$1" = 'wp' ]; then
  set -- /tini -- "$@"
# check if the first argument passed in matches a known command
elif isCommand "$1"; then
  set -- /tini -- wp "$@"
fi

exec "$@"
