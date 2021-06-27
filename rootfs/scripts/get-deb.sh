#!/bin/sh
arch=$(dpkg --print-architecture)

case $arch in
  amd64)
    FR24FILE="https://repo-feed.flightradar24.com/linux_x86_64_binaries/fr24feed_1.0.25-3_amd64.deb"
    ;;
  i386)
    FR24FILE="https://repo-feed.flightradar24.com/linux_x86_binaries/fr24feed_1.0.25-3_i386.deb"
    ;;
  armhf)
    FR24FILE="https://repo-feed.flightradar24.com/rpi_binaries/fr24feed_1.0.27-2_armhf.deb"
    ;;
  arm64)
  FR24FILE="https://repo-feed.flightradar24.com/rpi_binaries/fr24feed_1.0.27-2_armhf.deb"
    ;;
  armel)
  FR24FILE="https://repo-feed.flightradar24.com/rpi_binaries/fr24feed_1.0.27-2_armhf.deb"
    ;;
  *)
    exit 1
    ;;
esac

if curl --output /tmp/fr24feed.deb "${FR24FILE}"; then
  echo "Download OK"
else
  echo "Download failed!"
  exit 1
fi

# Deploy fr24feed.deb
cd /tmp || exit 1
ar x /tmp/fr24feed.deb
tar xzvf data.tar.gz
mv -v /tmp/usr/bin/* /usr/bin/
mv -v /tmp/usr/lib/fr24 /usr/lib/
mv -v /tmp/usr/share/fr24 /usr/share/
touch /var/log/fr24feed.log
rm -v /tmp/fr24feed.deb
