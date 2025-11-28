import 'package:web/web.dart' as html;
import 'dart:js_interop';
import 'package:carbon/carbon.dart';

/// Renders live updating sections for the Today page.
class LiveSections {
  /// Updates all live content sections with current time data.
  static void updateAll() {
    final now = Carbon.now();
    _updateClock(now);
    _updateWorldClocks(now);
    _updateExamples(now);
  }

  /// Updates the main "Right Now" clock section.
  static void _updateClock(CarbonInterface now) {
    final clockDiv = html.document.getElementById('live-clock');
    if (clockDiv == null) return;

    final endOfDayDiff = now.copy().endOfDay().diffForHumans(
      reference: now,
      parts: 2,
    );

    clockDiv.innerHTML =
        '''
      <div class="right-now-container">
        <h2 class="right-now-title">
          <svg class="right-now-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
          </svg>
          Right Now
        </h2>
        <div class="right-now-grid">
          <div class="right-now-card">
            <div class="right-now-label">Current Time</div>
            <div class="right-now-time">${now.format('HH:mm:ss')}</div>
            <div class="right-now-detail">${now.format('dddd, MMMM Do, YYYY')}</div>
          </div>
          <div class="right-now-card">
            <div class="right-now-label">Day of Year</div>
            <div class="right-now-value">${now.dayOfYear}</div>
            <div class="right-now-detail">Week ${now.weekOfYear} of ${now.weeksInYear}</div>
          </div>
          <div class="right-now-card">
            <div class="right-now-label">Time Until</div>
            <div class="right-now-diff">$endOfDayDiff</div>
            <div class="right-now-detail">End of day</div>
          </div>
        </div>
      </div>
    '''
            .toJS;
  }

  /// Updates the world clocks grid section.
  static void _updateWorldClocks(CarbonInterface now) {
    final worldDiv = html.document.getElementById('world-clocks');
    if (worldDiv == null) return;

    final cities = [
      {'name': 'New York', 'tz': 'America/New_York'},
      {'name': 'London', 'tz': 'Europe/London'},
      {'name': 'Tokyo', 'tz': 'Asia/Tokyo'},
      {'name': 'Sydney', 'tz': 'Australia/Sydney'},
      {'name': 'Dubai', 'tz': 'Asia/Dubai'},
      {'name': 'Los Angeles', 'tz': 'America/Los_Angeles'},
    ];

    final cityRows = cities
        .map((city) {
          final cityTime = Carbon.now(timeZone: city['tz']!);
          return '''
        <div class="world-clock-row">
          <div class="city-info">
            <span class="city-name">${city['name']}</span>
            <span class="city-tz">${city['tz']}</span>
          </div>
          <div class="city-time-info">
            <span class="city-time">${cityTime.format('HH:mm:ss')}</span>
            <span class="city-date">${cityTime.format('MMM dd, yyyy')}</span>
          </div>
        </div>
      ''';
        })
        .join('');

    worldDiv.innerHTML =
        '''
      <div class="world-clocks-container">
        <div class="world-clocks-header">
          <h2 class="world-clocks-title">
            <svg class="world-clocks-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
            World Clocks
          </h2>
        </div>
        <div class="world-clocks-list">
          $cityRows
        </div>
      </div>
    '''
            .toJS;
  }

  /// Updates the live examples section with elapsed time calculations.
  static void _updateExamples(CarbonInterface now) {
    final examplesDiv = html.document.getElementById('live-examples');
    if (examplesDiv == null) return;

    final startOfDay = now.copy().startOfDay();
    final startOfWeek = now.copy().startOfWeek();
    final startOfMonth = now.copy().startOfMonth();
    final startOfYear = now.copy().startOfYear();

    String elapsedText(CarbonInterface start) =>
        start.diffForHumans(reference: now, parts: 2);

    final elapsedDay = elapsedText(startOfDay);
    final elapsedWeek = elapsedText(startOfWeek);
    final elapsedMonth = elapsedText(startOfMonth);
    final elapsedYear = elapsedText(startOfYear);

    final dayHours = now.diffInHours(startOfDay, absolute: true);
    final dayMinutes = now.diffInMinutes(startOfDay, absolute: true) % 60;
    final weekDays = now.diffInDays(startOfWeek, absolute: true);
    final monthDays = now.diffInDays(startOfMonth, absolute: true);
    final yearDays = now.diffInDays(startOfYear, absolute: true);

    final hourAgo = now.copy().subHours(1);
    final hourAhead = now.copy().addHours(1);
    final yesterday = now.copy().subDay();
    final tomorrow = now.copy().addDay();

    examplesDiv.innerHTML =
        '''
      <div class="live-examples-container">
        <h2 class="text-lg sm:text-xl md:text-2xl font-bold mb-4 sm:mb-6 flex items-center gap-2 sm:gap-3 live-examples-title">
          <svg class="w-5 h-5 sm:w-6 sm:h-6 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path>
          </svg>
          Live Examples
        </h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 sm:gap-4 md:gap-6">
          <div class="elapsed-card">
            <div class="text-xs sm:text-sm font-bold text-emerald-600 mb-1 sm:mb-2">ELAPSED TODAY</div>
            <div class="text-lg sm:text-xl md:text-2xl font-bold mb-1 elapsed-value">$elapsedDay</div>
            <div class="text-xs font-mono elapsed-detail">$dayHours hours, $dayMinutes minutes</div>
          </div>
          <div class="elapsed-card">
            <div class="text-xs sm:text-sm font-bold text-blue-600 mb-1 sm:mb-2">ELAPSED THIS WEEK</div>
            <div class="text-lg sm:text-xl md:text-2xl font-bold mb-1 elapsed-value">$elapsedWeek</div>
            <div class="text-xs font-mono elapsed-detail">$weekDays days</div>
          </div>
          <div class="elapsed-card">
            <div class="text-xs sm:text-sm font-bold text-purple-600 mb-1 sm:mb-2">ELAPSED THIS MONTH</div>
            <div class="text-lg sm:text-xl md:text-2xl font-bold mb-1 elapsed-value">$elapsedMonth</div>
            <div class="text-xs font-mono elapsed-detail">Day ${now.day} of ${now.daysInMonth} · $monthDays days elapsed</div>
          </div>
          <div class="elapsed-card">
            <div class="text-xs sm:text-sm font-bold text-orange-600 mb-1 sm:mb-2">ELAPSED THIS YEAR</div>
            <div class="text-lg sm:text-xl md:text-2xl font-bold mb-1 elapsed-value">$elapsedYear</div>
            <div class="text-xs font-mono elapsed-detail">Day ${now.dayOfYear} of ${now.daysInYear} · $yearDays days elapsed</div>
          </div>
        </div>
        <div class="relative-times-box">
          <div class="text-xs font-bold mb-2 relative-times-title">RELATIVE TIMES</div>
          <div class="grid grid-cols-2 gap-2 sm:gap-4 text-xs sm:text-sm">
            <div><span class="relative-label">1 hour ago:</span> <span class="font-mono relative-value">${hourAgo.format('HH:mm')}</span></div>
            <div><span class="relative-label">In 1 hour:</span> <span class="font-mono relative-value">${hourAhead.format('HH:mm')}</span></div>
            <div><span class="relative-label">Yesterday:</span> <span class="font-mono relative-value">${yesterday.format('MMM dd')}</span></div>
            <div><span class="relative-label">Tomorrow:</span> <span class="font-mono relative-value">${tomorrow.format('MMM dd')}</span></div>
          </div>
        </div>
      </div>
    '''
            .toJS;
  }
}
