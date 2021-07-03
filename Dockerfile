FROM debian:buster-slim

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    BEAST_PORT=30005

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY rootfs/ /

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
  # S6 Install
  ca-certificates wget \
  binutils net-tools bc expect procps && \
  # Chmod scripts
  chmod +x /scripts/*.sh && \
  # i386 & amd64 specific
  /scripts/get-qemu.sh && \
  # Arch Specific Operations
  /scripts/arch-specific.sh && \
  # S6 OVERLAY
  /scripts/s6-overlay.sh && \
  # Healthcheck
  chmod +x /healthcheck.sh && \
  # Cleanup
  apt-get remove -y ca-certificates wget && \
  apt-get autoremove -y && \
  rm -rf /scripts /tmp/* /var/lib/apt/lists/*

ENTRYPOINT ["/init"]
EXPOSE 8754/tcp
HEALTHCHECK --start-period=60s --interval=300s CMD /healthcheck.sh
LABEL maintainer="Jeremie-C <Jeremie-C@users.noreply.github.com>"
