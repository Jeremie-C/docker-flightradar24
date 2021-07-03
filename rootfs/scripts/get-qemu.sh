#!/bin/sh
arch=$(dpkg --print-architecture)

case $arch in
  amd64)
    apt-get install -y --no-install-recommends qemu-user qemu-user-static binfmt-support
    echo "qemu installed."
    ;;
  i386)
    apt-get install -y --no-install-recommends qemu-user qemu-user-static binfmt-support
    echo "qemu installed."
    ;;
  armhf)
    echo "qemu not needed."
    ;;
  arm64)
    echo "qemu not needed."
    ;;
  armel)
    echo "qemu not needed."
    ;;
  *)
    exit 1
    ;;
esac
