#!/bin/sh

cd /srs/trunk

case "$1" in
    master)
        ./objs/srs -c conf/master.conf
        ;;
    relay)
        ./objs/srs -c conf/relay.conf
        ;;
esac

exec "$@"

