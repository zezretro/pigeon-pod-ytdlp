# Wrapper around the upstream PigeonPod image that bakes in a fresh yt-dlp.
# Upstream: https://github.com/aizhimou/pigeon-pod
ARG UPSTREAM_IMAGE=ghcr.io/aizhimou/pigeon-pod:latest
FROM ${UPSTREAM_IMAGE}

# Set by the workflow to the latest release on PyPI. Empty = newest available.
ARG YTDLP_VERSION=""

# Upstream runs as root on Wolfi and installs yt-dlp with pip3, so we upgrade
# the same way. The fallback handles pip's "externally-managed-environment"
# guard in case upstream's base image ever starts enforcing it.
RUN set -eux; \
    PKG="yt-dlp[default,curl-cffi]${YTDLP_VERSION:+==${YTDLP_VERSION}}"; \
    pip3 install --no-cache-dir -U "$PKG" \
      || pip3 install --no-cache-dir -U --break-system-packages "$PKG"; \
    yt-dlp --version

# Entrypoint, ports, env and volumes are all inherited from upstream.
