FROM debian:buster-slim

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    BEAST_PORT=30005

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY rootfs/ /

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
  # S6 Install
  ca-certificates wget \
  dirmngr gnupg \
  binutils net-tools bc expect procps && \
  # Chmod scripts
  chmod +x /scripts/*.sh && \
  # i386 & amd64 specific
  /scripts/get-qemu.sh && \
  # Import GPG key for the APT repository
  KEY_ID=C969F07840C430F5 && \
  apt-key adv --recv-key --keyserver hkp://keyserver.ubuntu.com:80 ${KEY_ID} || \
  apt-key adv --recv-key --keyserver hkp://pool.sks-keyservers.net:80 ${KEY_ID} || \
  apt-key adv --recv-key --keyserver hkp://pgp.mit.edu:80 ${KEY_ID} && \
  # FlightRadar Repository
  echo "deb http://repo.feed.flightradar24.com flightradar24 raspberrypi-stable" > /etc/apt/sources.list.d/fr24.list && \
  # Arch Specific Operations
  /scripts/arch-specific.sh && \
  # S6 OVERLAY
  /scripts/s6-overlay.sh && \
  # Healthcheck
  chmod +x /healthcheck.sh && \
  # Cleanup
  apt-get remove -y ca-certificates wget gnupg && \
  apt-get autoremove -y && \
  rm -rf /scripts /tmp/* /var/lib/apt/lists/*

ENTRYPOINT ["/init"]
EXPOSE 8754/tcp
HEALTHCHECK --start-period=60s --interval=300s CMD /healthcheck.sh
LABEL maintainer="Jeremie-C <Jeremie-C@users.noreply.github.com>"
