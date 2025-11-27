# Common Formats

All RFC/ISO helpers from the PHP docs are available in Dart (`toAtomString()`,
`toIso8601String()`, `toRfc1123String()`, `toRfc3339String()`, etc.). These are
thin wrappers that keep Dart apps in sync with PHP examples and avoid memorizing
`DateFormat` patterns for well-known specs.


## Example: exporting canonical strings

```dart
import 'package:carbon/carbon.dart';

Future<void> main() async {
  final dt = Carbon.parse('2019-02-01T03:45:27.612584Z');

  print('toAtomString -> ${dt.toAtomString()}');
  print('toIso8601String -> ${dt.toIso8601String()}');
  print('toIso8601ZuluString -> ${dt.toIso8601ZuluString()}');
  print('toISOString -> ${dt.toISOString()}');
  print('toJSON -> ${dt.toJSON()}');
  print('toDateTimeLocalString -> ${dt.toDateTimeLocalString()}');
  print('toRfc1123String -> ${dt.toRfc1123String()}');
  print('toRfc3339String -> ${dt.toRfc3339String()}');
  print('toRfc7231String -> ${dt.toRfc7231String()}');
  print('toW3cString -> ${dt.toW3cString()}');
}

```

Output:

```
toAtomString -> 2019-02-01T03:45:27+00:00
toIso8601String -> 2019-02-01T03:45:27.612584Z
toIso8601ZuluString -> 2019-02-01T03:45:27.612584Z
toISOString -> 2019-02-01T03:45:27.612584Z
toJSON -> 2019-02-01T03:45:27.612584Z
toDateTimeLocalString -> 2019-02-01T03:45:27
toRfc1123String -> Fri, 01 Feb 2019 03:45:27 +0000
toRfc3339String -> 2019-02-01T03:45:27+00:00
toRfc7231String -> Fri, 01 Feb 2019 03:45:27 GMT
toW3cString -> 2019-02-01T03:45:27+00:00
```


## Differences compared to the PHP docs

- `toIso8601String()` always emits the extended ISO-8601 form with a colon in
  the offset (matching PHP Carbon's decision). Pass `keepOffset: true` if you do
  not want the value converted to UTC.
- PHP's note about `DateTime::ISO8601` incompatibility still applies. Use
  `dt.format(DateFormat('yyyy-MM-ddTHH:mm:ssZ'))` if you need the legacy compact
  form without a colon.
- Some niche helpers (`toHtmlString()`, `toHtmlDiffString()`) remain TODO until
  the corresponding PHP sections are ported.

