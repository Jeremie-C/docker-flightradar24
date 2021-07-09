#!/usr/bin/env bash
set -e
EXITCODE=0

# FR24 Feeder
SRV_DEATHS=$(s6-svdt /run/s6/services/fr24feed | grep -cv "exitcode 0")
if [ "$SRV_DEATHS" -ge 1 ]; then
    echo "readsb deaths: $SRV_DEATHS. UNHEALTHY"
    EXITCODE=1
else
    echo "readsb deaths: $SRV_DEATHS. HEALTHY"
fi
s6-svdt-clear /run/s6/services/fr24feed

# Redirect logs
SRV_DEATHS=$(s6-svdt /run/s6/services/fr24logs | grep -cv "exitcode 0")
if [ "$SRV_DEATHS" -ge 1 ]; then
    echo "readsb deaths: $SRV_DEATHS. UNHEALTHY"
    EXITCODE=1
else
    echo "readsb deaths: $SRV_DEATHS. HEALTHY"
fi
s6-svdt-clear /run/s6/services/fr24logs

# WebInterface
if netstat -an | grep LISTEN | grep 8754 > /dev/null; then
    echo "listening for connections on port 8754. HEALTHY"
else
    echo "not listening for connections on port 8754. UNHEALTHY"
    EXITCODE=1
fi

exit $EXITCODE
