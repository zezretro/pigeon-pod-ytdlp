# pigeon-pod with fresh yt-dlp

A thin wrapper around the upstream [PigeonPod](https://github.com/aizhimou/pigeon-pod)
image (`ghcr.io/aizhimou/pigeon-pod:latest`) with the newest yt-dlp baked in.
This is not a fork: no app code lives here.

## How it works

A GitHub Actions workflow runs every Monday at 04:00 UTC, when you click
**Actions → Build image with fresh yt-dlp → Run workflow**, and when the
Dockerfile or workflow changes. It:

1. looks up the latest yt-dlp release on PyPI,
2. pulls the current upstream image and installs that yt-dlp on top,
3. smoke-tests that yt-dlp, Java and ffmpeg run,
4. pushes to `ghcr.io/zezretro/pigeon-pod` as `:latest` and `:ytdlp-<version>`,
   for the same CPU architectures upstream publishes.

## Using it

In your `docker-compose.yml`, change only the image line:

    image: ghcr.io/zezretro/pigeon-pod:latest

then `docker compose pull && docker compose up -d`. Repeat those two commands
(or let Watchtower do it) to pick up new builds.

## Rolling back

If a yt-dlp release misbehaves, pin a previous tag, e.g.
`ghcr.io/zezretro/pigeon-pod:ytdlp-2026.09.01`, until the next fix lands.
