## Carbon for Dart

This package rebuilds the fluent [Carbon](https://carbon.nesbot.com/) API for
Dart and Flutter applications. It focuses on providing readable chains such as
`Carbon.now().addWeeks(2).startOfMonth()` while maintaining strict parity with
the original PHP library so feature work can be validated quickly.

## Features

- Fluent creation helpers (`now`, `today`, `create`, `parse`).
- Calendar math with overflow options, rounding, and comparison helpers.
- Locale-aware formatting, human-readable differences, and timezone support.
- Macro system for user-defined helpers plus mutable/immutable variants.

## Getting started

1. Fetch Dart dependencies:
   ```bash
   dart pub get
   ```
2. Run the Dart test suite:
   ```bash
   dart test
   ```
3. (Optional) Spin up the PHP comparison sandbox via Docker (see below).

## PHP reference sandbox via Docker

The repo now includes a lightweight Docker Compose setup that initializes a PHP
project under `php_app/`. The sandbox installs `nesbot/carbon` so you can verify
behavior against the upstream implementation without polluting your host system.

```bash
# Install PHP dependencies once
docker compose run --rm phpapp composer install

# Execute the demo script (prints a JSON payload)
docker compose run --rm phpapp composer start

# Open an interactive shell for ad-hoc experiments
docker compose run --rm phpapp bash
```

Because the entire repository is mounted into the container at `/workspace`,
you can edit Dart sources locally and immediately re-run PHP experiments.

## Usage (Dart)

```dart
import 'package:carbon/carbon.dart';

void main() {
  final payday = Carbon.now().addWeeks(2).endOfWeek();
  print(payday.format('yyyy-MM-dd HH:mm'));
}
```

## Additional information

- Specs and change proposals live under `openspec/`.
- PHP comparison assets live under `php_app/` and can be executed through the
  Docker workflow above.
- Issues and contributions should include repro steps plus any relevant PHP
  parity notes so we can keep both implementations aligned.
