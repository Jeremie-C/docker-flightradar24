#!/bin/sh
arch=$(dpkg --print-architecture)

case $arch in
  amd64)
    dpkg --add-architecture armhf
    apt-get update
    apt-get install --no-install-recommends \
    -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    -y fr24feed:armhf
    rm -f /etc/services.d/fr24feed/run
    mv /etc/services.d/fr24feed/run.qemu /etc/services.d/fr24feed/run    
    ;;
  i386)
    dpkg --add-architecture armhf
    apt-get update
    apt-get install --no-install-recommends \
    -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    -y fr24feed:armhf
    rm -f /etc/services.d/fr24feed/run
    mv /etc/services.d/fr24feed/run.qemu /etc/services.d/fr24feed/run    
    ;;
  armhf)
    apt-get update
    apt-get install --no-install-recommends \
    -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    -y fr24feed
    ;;
  arm64)
    dpkg --add-architecture armhf
    apt-get update
    apt-get install --no-install-recommends \
    -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    -y fr24feed:armhf
    ;;
  armel)
    dpkg --add-architecture armhf
    apt-get update
    apt-get install --no-install-recommends \
    -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
    -y fr24feed:armhf
    ;;
  *)
    exit 1
    ;;
esac
