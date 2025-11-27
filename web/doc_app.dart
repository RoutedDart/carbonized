import 'package:web/web.dart' as html;
import 'dart:js_interop';
import 'dart:async';
import 'package:carbon/docs/model.dart';

import 'live_sections.dart';
import 'section_renderer.dart';
import 'prism_highlighter.dart';

/// Main documentation application.
///
/// Manages navigation between doc sections, renders content,
/// and coordinates live updates for the Today page.
class DocApp {
  final List<DocSection> sections;
  DocSection? _currentSection;
  Timer? _liveUpdateTimer;

  DocApp(this.sections) {
    if (sections.isNotEmpty) {
      _currentSection = sections.first;
    }
  }

  /// Cleans up timers when the app is disposed.
  void dispose() {
    _liveUpdateTimer?.cancel();
  }

  /// Renders the entire application UI.
  void render() {
    final body = html.document.body!;
    body.className =
        'bg-gradient-to-br from-gray-50 to-gray-100 text-gray-900 font-sans h-screen flex overflow-hidden';
    body.innerText = '';

    // Initialize theme from localStorage or system preference
    _initializeTheme();

    _renderThemeToggle(body);
    _renderMobileMenu(body);
    _renderSidebar(body);
    _renderMainContent(body);

    // Trigger Prism syntax highlighting after DOM is ready
    PrismHighlighter.highlightAll();

    // Set up live updates for Today section
    _setupLiveUpdates();
  }

  /// Initializes the theme based on localStorage or system preference.
  void _initializeTheme() {
    final stored = html.window.localStorage.getItem('theme');
    if (stored != null) {
      html.document.documentElement?.setAttribute('data-theme', stored);
    } else {
      // Check system preference
      final prefersDark = html.window
          .matchMedia('(prefers-color-scheme: dark)')
          .matches;
      final theme = prefersDark ? 'dark' : 'light';
      html.document.documentElement?.setAttribute('data-theme', theme);
      html.window.localStorage.setItem('theme', theme);
    }
  }

  /// Renders the theme toggle button.
  void _renderThemeToggle(html.HTMLElement body) {
    final toggle = html.HTMLButtonElement()
      ..className = 'theme-toggle'
      ..setAttribute('aria-label', 'Toggle dark mode')
      ..innerHTML =
          '''
        <svg class="sun-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"></path>
        </svg>
        <svg class="moon-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"></path>
        </svg>
      '''
              .toJS
      ..addEventListener('click', _toggleTheme.toJS);
    body.append(toggle);
  }

  void _toggleTheme(html.Event e) {
    final current = html.document.documentElement?.getAttribute('data-theme');
    final newTheme = current == 'dark' ? 'light' : 'dark';
    html.document.documentElement?.setAttribute('data-theme', newTheme);
    html.window.localStorage.setItem('theme', newTheme);
  }

  /// Renders the mobile hamburger menu button and overlay.
  void _renderMobileMenu(html.HTMLElement body) {
    // Mobile menu button
    final mobileMenuBtn = html.HTMLButtonElement()
      ..id = 'mobile-menu-btn'
      ..className =
          'fixed top-4 left-4 z-50 md:hidden bg-slate-900 text-white p-3 rounded-lg shadow-lg hover:bg-slate-800 transition-colors'
      ..innerHTML =
          '<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path></svg>'
              .toJS
      ..addEventListener('click', _toggleMobileMenu.toJS);
    body.append(mobileMenuBtn);

    // Mobile overlay
    final mobileOverlay = html.HTMLDivElement()
      ..id = 'mobile-overlay'
      ..className = 'fixed inset-0 bg-black/50 z-40 md:hidden hidden'
      ..addEventListener('click', _closeMobileMenu.toJS);
    body.append(mobileOverlay);
  }

  void _toggleMobileMenu(html.Event e) {
    final sidebar = html.document.getElementById('mobile-sidebar');
    final overlay = html.document.getElementById('mobile-overlay');
    sidebar?.classList.toggle('translate-x-0');
    sidebar?.classList.toggle('-translate-x-full');
    overlay?.classList.toggle('hidden');
  }

  void _closeMobileMenu(html.Event e) {
    final sidebar = html.document.getElementById('mobile-sidebar');
    final overlay = html.document.getElementById('mobile-overlay');
    sidebar?.classList.add('-translate-x-full');
    sidebar?.classList.remove('translate-x-0');
    overlay?.classList.add('hidden');
  }

  /// Renders the navigation sidebar.
  void _renderSidebar(html.HTMLElement body) {
    final sidebar = html.HTMLDivElement()
      ..id = 'mobile-sidebar'
      ..className =
          'w-72 bg-gradient-to-b from-slate-900 to-slate-800 border-r border-slate-700 flex-shrink-0 overflow-y-auto shadow-2xl fixed md:static inset-y-0 left-0 z-40 -translate-x-full md:translate-x-0 transition-transform duration-300 ease-in-out';

    // Logo section
    final logo = html.HTMLDivElement()
      ..className = 'p-6 border-b border-slate-700';
    final heading = html.HTMLHeadingElement.h1()
      ..className =
          'text-2xl font-bold bg-gradient-to-r from-blue-400 to-cyan-400 bg-clip-text text-transparent'
      ..textContent = '⏰ Carbon for Dart';
    final subtitle = html.HTMLParagraphElement()
      ..className = 'text-slate-400 text-sm mt-2 font-light'
      ..textContent = 'DateTime made simple';
    logo.append(heading);
    logo.append(subtitle);
    sidebar.append(logo);

    // Navigation links
    final nav = html.HTMLUListElement()..className = 'p-4 space-y-1';
    for (final section in sections) {
      final li = html.HTMLLIElement();
      final isActive = section == _currentSection;
      final a = html.HTMLAnchorElement()
        ..href = '#${section.slug}'
        ..className = isActive
            ? 'block px-4 py-3 rounded-lg text-sm font-medium bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-lg shadow-blue-500/30 scale-105 transition-all duration-200 cursor-pointer'
            : 'block px-4 py-3 rounded-lg text-sm font-medium text-slate-300 hover:bg-slate-700/50 hover:text-white hover:translate-x-1 transition-all duration-200 cursor-pointer'
        ..textContent = section.title
        ..addEventListener(
          'click',
          ((html.Event e) {
            e.preventDefault();
            _navigateTo(section);
            _closeMobileMenu(e);
          }).toJS,
        );
      li.append(a);
      nav.append(li);
    }
    sidebar.append(nav);
    body.append(sidebar);
  }

  /// Renders the main content area with article and TOC.
  void _renderMainContent(html.HTMLElement body) {
    final mainContent = html.HTMLDivElement()
      ..className = 'flex-1 flex overflow-hidden';

    // Content scroll area
    final contentScroll = html.HTMLDivElement()
      ..className = 'flex-1 overflow-y-auto p-4 sm:p-6 md:p-8 bg-white/30';

    final article = html.HTMLDivElement()
      ..className =
          'max-w-4xl mx-auto bg-white rounded-2xl shadow-xl p-4 sm:p-6 md:p-8 lg:p-12 my-4 sm:my-6 md:my-8';

    if (_currentSection != null) {
      SectionRenderer.render(article, _currentSection!);
    }

    contentScroll.append(article);
    mainContent.append(contentScroll);

    // Table of contents (right sidebar)
    _renderTableOfContents(mainContent, article);

    body.append(mainContent);
  }

  /// Renders the table of contents sidebar.
  void _renderTableOfContents(
    html.HTMLElement mainContent,
    html.HTMLElement article,
  ) {
    final toc = html.HTMLDivElement()
      ..className =
          'w-64 bg-gradient-to-b from-slate-50 to-white border-l border-gray-200 flex-shrink-0 overflow-y-auto hidden xl:block p-6 shadow-inner';
    toc.innerHTML =
        '<h3 class="text-xs font-bold text-slate-600 uppercase tracking-widest mb-4 pb-2 border-b border-slate-200">📑 On this page</h3>'
            .toJS;

    final tocList = html.HTMLUListElement()..className = 'space-y-2 text-sm';
    final headers = article.querySelectorAll('h1, h2, h3');

    for (var i = 0; i < headers.length; i++) {
      final header = headers.item(i) as html.HTMLElement;
      final text = header.textContent ?? '';
      final id = text
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
          .replaceAll(RegExp(r'^-|-$'), '');
      header.id = id;

      final li = html.HTMLLIElement();
      final a = html.HTMLAnchorElement()
        ..href = '#$id'
        ..className =
            'block text-slate-600 hover:text-blue-600 hover:translate-x-1 transition-all duration-200 py-1 border-l-2 border-transparent hover:border-blue-600'
        ..textContent = text
        ..addEventListener(
          'click',
          ((html.Event e) {
            e.preventDefault();
            header.scrollIntoView();
          }).toJS,
        );

      if (header.tagName == 'H2') {
        a.classList.add('pl-3');
      } else if (header.tagName == 'H3') {
        a.classList.add('pl-6');
        a.classList.add('text-xs');
      }

      li.append(a);
      tocList.append(li);
    }
    toc.append(tocList);
    mainContent.append(toc);
  }

  /// Navigates to a different documentation section.
  void _navigateTo(DocSection section) {
    _currentSection = section;
    _liveUpdateTimer?.cancel();
    render();
  }

  /// Sets up live updates if the Today page is active.
  void _setupLiveUpdates() {
    final clockDiv = html.document.getElementById('live-clock');
    final worldDiv = html.document.getElementById('world-clocks');
    final examplesDiv = html.document.getElementById('live-examples');

    if (clockDiv != null || worldDiv != null || examplesDiv != null) {
      html.console.log('Live elements found, starting timer...'.toJS);
      _startLiveUpdates();
    } else {
      html.console.log('No live elements found'.toJS);
    }
  }

  void _startLiveUpdates() {
    _liveUpdateTimer?.cancel();
    LiveSections.updateAll();
    _liveUpdateTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => LiveSections.updateAll(),
    );
  }
}
