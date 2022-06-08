#!/bin/sh
arch=$(dpkg --print-architecture)

case $arch in
  amd64)
    url=https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-amd64-installer
    ;;
  i386)
    url=https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-x86-installer
    ;;
  armhf)
    url=https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-armhf-installer
    ;;
  arm64)
    url=https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-aarch64-installer
    ;;
  armel)
    url=https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-arm-installer
    ;;
  *)
    exit 1
    ;;
esac

wget -O /tmp/s6-overlay-installer $url && \
chmod +x /tmp/s6-overlay-installer && \
/tmp/s6-overlay-installer / && \
rm /tmp/s6-overlay-installer
