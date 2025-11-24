# PHP Reference Sandbox

This folder hosts a small PHP project that installs [`nesbot/carbon`](https://github.com/briannesbitt/Carbon)
so we can compare semantics while building the Dart port.

## Getting Started

1. Build the Docker image and install dependencies:

   ```bash
   docker compose run --rm phpapp composer install
   ```

2. Run the demonstration script:

   ```bash
   docker compose run --rm phpapp composer start
   ```

3. Drop into an interactive shell for ad-hoc experiments:

   ```bash
   docker compose run --rm phpapp bash
   ```

The container mounts the entire repo at `/workspace`, so you can freely edit the
Dart sources and re-run PHP comparisons without rebuilding.
