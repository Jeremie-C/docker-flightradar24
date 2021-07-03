#!/bin/sh

FR24FILE="https://repo-feed.flightradar24.com/rpi_binaries/fr24feed_1.0.28-1_armhf.deb"
if wget -O /tmp/fr24feed.deb $FR24FILE; then
  echo "Download OK"
else
  echo "Download failed!"
  exit 1
fi

# Deploy fr24feed.deb
cd /tmp || exit 1
ar xv fr24feed.deb
tar xzvf data.tar.gz
mv -v /tmp/usr/bin/* /usr/bin/
mv -v /tmp/usr/share/fr24 /usr/share/

mkdir -p /var/log/fr24feed || true
chmod -R a+rx /var/log/fr24feed || true
mkdir -p /run/fr24feed || true
chmod -R a+rx /run/fr24feed || true

arch=$(dpkg --print-architecture)
case $arch in
  amd64)
    rm -f /etc/services.d/fr24feed/run
    mv /etc/services.d/fr24feed/run.qemu /etc/services.d/fr24feed/run    
    ;;
  i386)
    rm -f /etc/services.d/fr24feed/run
    mv /etc/services.d/fr24feed/run.qemu /etc/services.d/fr24feed/run    
    ;;
  armhf)
    rm -f /etc/services.d/fr24feed/run.qemu
    ;;
  arm64)
    rm -f /etc/services.d/fr24feed/run.qemu
    ;;
  armel)
    rm -f /etc/services.d/fr24feed/run.qemu
    ;;
  *)
    exit 1
    ;;
esac
