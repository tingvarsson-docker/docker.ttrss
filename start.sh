#!/bin/sh

if [ "$ENABLE_BOOTSTRAP" = "true" ]; then
    /init.sh
    touch /bootstrap/complete
fi

if [ "$SKIP_DB_CHECK" != "true" ]; then
    while ! pg_isready -h $DB_HOST -U $DB_USER; do
        echo "waiting until database ($DB_HOST) is ready..."
        sleep 5
    done
fi

php-fpm -F
