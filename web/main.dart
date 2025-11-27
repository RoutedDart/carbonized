import 'package:carbon/carbon.dart';
import 'package:carbon/docs/content.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'components/analog_clock_component.dart';
import 'doc_app.dart';

/// Entry point for the Carbon documentation site.
///
/// Initializes the Carbon library and renders the documentation app.
void main() async {
  // Initialize date formatting for locales
  await initializeDateFormatting('en');

  // Configure timezone database (required for named timezones)
  await Carbon.configureTimeMachine();

  // Register custom web components
  registerAnalogClockComponent();

  // Load documentation sections and render the app
  final sections = await getAllSections();
  final app = DocApp(sections);
  app.render();
}
