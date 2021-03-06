#!/bin/sh

if [ "$ENABLE_BOOTSTRAP" = "true" ]; then
    /init.sh
    touch /bootstrap/complete
fi

if [ "$SKIP_DB_CHECK" != "true" ]; then
    while ! pg_isready -h $TTRSS_DB_HOST -U $TTRSS_DB_USER; do
        echo "waiting until database ($TTRSS_DB_HOST) is ready..."
        sleep 5
    done
fi

php-fpm -F
