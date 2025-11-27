import 'package:web/web.dart' as html;
import 'dart:js_interop';
import 'package:markdown/markdown.dart' as md;
import 'package:docs/docs/model.dart';

/// Renders documentation section content (markdown text and code examples).
class SectionRenderer {
  /// Prose styling classes for markdown content.
  static const String _proseClasses =
      'prose prose-lg prose-slate max-w-none mb-10 '
      'prose-headings:font-bold '
      'prose-h1:text-5xl prose-h1:mb-10 prose-h1:mt-4 prose-h1:text-slate-900 prose-h1:leading-tight prose-h1:tracking-tight '
      'prose-h2:text-3xl prose-h2:mt-16 prose-h2:mb-6 prose-h2:text-slate-800 prose-h2:border-b-4 prose-h2:pb-4 prose-h2:border-gradient-to-r prose-h2:from-blue-500 prose-h2:to-cyan-500 prose-h2:border-slate-300 prose-h2:bg-gradient-to-r prose-h2:from-slate-50 prose-h2:to-transparent prose-h2:px-4 prose-h2:py-2 prose-h2:rounded-t-lg prose-h2:-mx-4 '
      'prose-h3:text-xl prose-h3:mt-10 prose-h3:mb-4 prose-h3:text-slate-700 prose-h3:border-l-4 prose-h3:border-blue-500 prose-h3:pl-4 prose-h3:py-1 prose-h3:bg-blue-50/30 prose-h3:-ml-5 '
      'prose-h4:text-lg prose-h4:mt-6 prose-h4:mb-3 prose-h4:text-slate-600 prose-h4:font-semibold '
      'prose-a:text-blue-600 prose-a:no-underline hover:prose-a:text-blue-700 hover:prose-a:underline '
      'prose-code:text-pink-600 prose-code:bg-pink-50 prose-code:px-1.5 prose-code:py-0.5 prose-code:rounded prose-code:text-sm prose-code:font-medium prose-code:before:content-none prose-code:after:content-none '
      'prose-strong:text-slate-900 prose-strong:font-semibold '
      'prose-ul:my-6 prose-li:my-2 prose-p:my-4 prose-p:leading-relaxed prose-p:text-slate-700';

  /// Renders a documentation section into the given container element.
  static void render(html.HTMLElement container, DocSection section) {
    for (final item in section.items) {
      if (item is TextItem) {
        _renderTextItem(container, item);
      } else if (item is ExampleItem) {
        _renderExampleItem(container, item);
      }
    }
  }

  /// Renders a markdown text item.
  static void _renderTextItem(html.HTMLElement container, TextItem item) {
    final div = html.HTMLDivElement()
      ..className = _proseClasses
      ..innerHTML = md
          .markdownToHtml(item.text, extensionSet: md.ExtensionSet.gitHubWeb)
          .toJS;
    container.append(div);
  }

  /// Renders a code example with output.
  static void _renderExampleItem(html.HTMLElement container, ExampleItem item) {
    final wrapper = html.HTMLDivElement()
      ..className =
          'mb-10 border border-slate-200 rounded-xl overflow-hidden shadow-lg hover:shadow-2xl transition-shadow duration-300 bg-gradient-to-br from-slate-50 to-white';

    // Code header with window controls
    final codeHeader = html.HTMLDivElement()
      ..className =
          'bg-gradient-to-r from-slate-800 to-slate-700 px-6 py-3 border-b border-slate-600 text-xs font-semibold text-slate-300 uppercase tracking-wider flex items-center gap-2'
      ..innerHTML =
          '<span class="w-3 h-3 rounded-full bg-red-500 shadow-lg"></span>'
                  '<span class="w-3 h-3 rounded-full bg-yellow-500 shadow-lg"></span>'
                  '<span class="w-3 h-3 rounded-full bg-green-500 shadow-lg"></span>'
                  '<span class="flex-1 text-center flex items-center justify-center gap-2">'
                  '<svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">'
                  '<path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>'
                  '</svg>Dart Code</span>'
              .toJS;
    wrapper.append(codeHeader);

    // Code block
    final codeBlock = html.HTMLPreElement.pre()
      ..className =
          'overflow-x-auto text-sm m-0 leading-relaxed shadow-inner line-numbers';
    final codeElement = html.HTMLElement.code()
      ..className = 'language-dart'
      ..textContent = item.code;
    codeBlock.append(codeElement);
    wrapper.append(codeBlock);

    // Divider between code and output
    final divider = html.HTMLDivElement()
      ..className =
          'bg-slate-700 px-6 py-2 flex items-center gap-2 text-slate-300 text-xs'
      ..innerHTML =
          '<svg class="w-4 h-4 text-emerald-400" fill="currentColor" viewBox="0 0 20 20">'
                  '<path d="M6.3 2.841A1.5 1.5 0 004 4.11V15.89a1.5 1.5 0 002.3 1.269l9.344-5.89a1.5 1.5 0 000-2.538L6.3 2.84z"/>'
                  '</svg>'
                  '<span class="font-semibold">Example Output</span>'
                  '<span class="flex-1"></span>'
                  '<span class="text-emerald-400 text-xs">✓ Runnable</span>'
              .toJS;
    wrapper.append(divider);

    // Output block
    final outputLines = item.output.split('\n');
    final hasMultipleLines = outputLines.length > 1;

    final outputBlock = html.HTMLPreElement.pre()
      ..className =
          'bg-gradient-to-br from-slate-50 to-emerald-50 text-slate-800 p-6 overflow-x-auto text-sm m-0 font-mono leading-relaxed border-l-4 border-emerald-500 relative';

    if (hasMultipleLines) {
      // Add line numbers for multi-line output
      final numberedOutput = StringBuffer();
      for (var i = 0; i < outputLines.length; i++) {
        numberedOutput.write(
          '${(i + 1).toString().padLeft(2)} │ ${outputLines[i]}',
        );
        if (i < outputLines.length - 1) numberedOutput.write('\n');
      }
      outputBlock.textContent = numberedOutput.toString();
    } else {
      outputBlock.textContent = item.output;
    }

    wrapper.append(outputBlock);
    container.append(wrapper);
  }
}
