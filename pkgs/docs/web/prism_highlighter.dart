import 'package:web/web.dart' as html;
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

/// Utility for initializing Prism.js syntax highlighting.
class PrismHighlighter {
  /// Waits for Prism to load and then highlights all code blocks.
  static void highlightAll() {
    var attempts = 0;

    void checkPrism() {
      attempts++;
      try {
        final win = html.window as JSObject;
        if (win.has('Prism')) {
          final prism = win['Prism'] as JSObject;
          html.console.log('Prism loaded successfully!'.toJS);

          // Debug: log code blocks found
          final codeBlocks = html.document.querySelectorAll('pre code');
          html.console.log('Found ${codeBlocks.length} code blocks'.toJS);

          prism.callMethod('highlightAll'.toJS);
          html.console.log('Syntax highlighting applied'.toJS);
        } else if (attempts < 50) {
          html.window.setTimeout(checkPrism.toJS, 100.toJS);
        } else {
          html.console.error('Prism failed to load after 5 seconds'.toJS);
        }
      } catch (e) {
        if (attempts < 50) {
          html.window.setTimeout(checkPrism.toJS, 100.toJS);
        } else {
          html.console.error('Error waiting for Prism: $e'.toJS);
        }
      }
    }

    checkPrism();
  }
}
