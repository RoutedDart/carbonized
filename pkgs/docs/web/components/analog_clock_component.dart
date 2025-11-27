import 'dart:async';
import 'dart:js_interop';
import 'package:carbon/carbon.dart';
import 'package:html_web_components/helpers.dart';
import 'package:html_web_components/html_web_components.dart';
import 'package:web/web.dart' as html;

const String analogClockTag = 'carbon-analog-clock';
bool _analogClockRegistered = false;

void registerAnalogClockComponent() {
  if (_analogClockRegistered) {
    return;
  }
  WebComponent.define(analogClockTag, AnalogClockComponent.new);
  _analogClockRegistered = true;
}

class AnalogClockComponent extends WebComponent
    with WebComponentShadowDomMixin, WebComponentCleanupMixin {
  Timer? _ticker;
  html.ShadowRoot? _root;

  @override
  void connectedCallback() {
    super.connectedCallback();
    _root = getRoot<html.ShadowRoot>();
    _renderShell();
    _startTicker();
  }

  @override
  void disconnectedCallback() {
    _ticker?.cancel();
    super.disconnectedCallback();
  }

  String get _timezone => element.getAttribute('timezone') ?? 'UTC';
  String get _label => element.getAttribute('label') ?? _timezone;

  void _renderShell() {
    _root?.innerHTML =
        '''
      <style>
        :host {
          display: block;
          width: 100%;
          
          /* Light mode (default) - dark clock */
          --clock-bg-from: #1e293b;
          --clock-bg-to: #0f172a;
          --clock-border: rgba(148, 163, 184, 0.25);
          --clock-shadow: rgba(15, 23, 42, 0.45);
          --clock-face-from: rgba(255,255,255,0.05);
          --clock-face-to: rgba(15,23,42,0.85);
          --clock-face-border: rgba(255,255,255,0.08);
          --clock-face-shadow: rgba(0,0,0,0.45);
          --tick-color: rgba(226, 232, 240, 0.85);
          --tick-major-color: #38bdf8;
          --hand-hour: #f8fafc;
          --hand-minute: #38bdf8;
          --hand-second: #f97316;
          --center-cap-bg: #f97316;
          --center-cap-border: #0f172a;
          --label-color: rgba(226, 232, 240, 0.65);
          --digital-color: #f1f5f9;
          --day-color: rgba(226, 232, 240, 0.6);
        }
        
        /* Dark mode - light clock */
        :host-context([data-theme="dark"]) {
          --clock-bg-from: #f8fafc;
          --clock-bg-to: #e2e8f0;
          --clock-border: rgba(100, 116, 139, 0.25);
          --clock-shadow: rgba(100, 116, 139, 0.2);
          --clock-face-from: rgba(255,255,255,0.9);
          --clock-face-to: rgba(241,245,249,0.95);
          --clock-face-border: rgba(100,116,139,0.15);
          --clock-face-shadow: rgba(0,0,0,0.1);
          --tick-color: rgba(51, 65, 85, 0.7);
          --tick-major-color: #2563eb;
          --hand-hour: #1e293b;
          --hand-minute: #2563eb;
          --hand-second: #ea580c;
          --center-cap-bg: #ea580c;
          --center-cap-border: #f8fafc;
          --label-color: rgba(51, 65, 85, 0.7);
          --digital-color: #1e293b;
          --day-color: rgba(51, 65, 85, 0.6);
        }
        
        .clock-shell {
          background: radial-gradient(circle at 30% 30%, var(--clock-bg-from), var(--clock-bg-to));
          border-radius: 1.5rem;
          padding: 1.5rem;
          box-shadow: 0 20px 45px var(--clock-shadow);
          border: 1px solid var(--clock-border);
        }
        .clock-face-wrapper {
          position: relative;
          width: 100%;
          max-width: 220px;
          margin: 0 auto;
        }
        .clock-face-wrapper::before {
          content: '';
          display: block;
          padding-top: 100%; /* 1:1 aspect ratio */
        }
        .clock-face {
          position: absolute;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          border-radius: 50%;
          background: radial-gradient(circle, var(--clock-face-from), var(--clock-face-to));
          border: 4.5% solid var(--clock-face-border);
          box-shadow: inset 0 0 20px var(--clock-face-shadow);
        }
        .tick {
          position: absolute;
          left: 50%;
          top: 6%;
          width: 1.8%;
          height: 6%;
          margin-left: -0.9%;
          background: var(--tick-color);
          border-radius: 999px;
          transform-origin: center calc(44% / 0.06);
        }
        .tick.major {
          top: 4%;
          height: 9%;
          background: var(--tick-major-color);
          transform-origin: center calc(46% / 0.09);
        }
        .hand {
          position: absolute;
          left: 50%;
          bottom: 50%;
          transform-origin: bottom center;
          transform: translate(-50%, 0);
          border-radius: 999px;
        }
        .hand.hour {
          width: 3.6%;
          height: 27%;
          background: var(--hand-hour);
        }
        .hand.minute {
          width: 2.7%;
          height: 36%;
          background: var(--hand-minute);
        }
        .hand.second {
          width: 1.4%;
          height: 43%;
          background: var(--hand-second);
          box-shadow: 0 0 8px rgba(249, 115, 22, 0.7);
        }
        .center-cap {
          position: absolute;
          width: 8%;
          height: 8%;
          background: var(--center-cap-bg);
          border-radius: 50%;
          border: 2px solid var(--center-cap-border);
          top: calc(50% - 4%);
          left: calc(50% - 4%);
        }
        .meta {
          margin-top: 1.5rem;
          display: flex;
          flex-direction: column;
          align-items: center;
          gap: 0.35rem;
        }
        .meta .label {
          text-transform: uppercase;
          letter-spacing: 0.2rem;
          font-size: 0.65rem;
          color: var(--label-color);
        }
        .meta .digital {
          font-family: 'Fira Code', 'Menlo', monospace;
          font-size: 1.5rem;
          font-weight: 600;
          color: var(--digital-color);
        }
        .meta .day {
          font-size: 0.8rem;
          color: var(--day-color);
        }
        @media (max-width: 400px) {
          .clock-shell {
            padding: 1rem;
          }
          .meta .digital {
            font-size: 1.25rem;
          }
          .meta .label {
            font-size: 0.55rem;
            letter-spacing: 0.15rem;
          }
        }
      </style>
      <div class="clock-shell">
        <div class="clock-face-wrapper">
          <div class="clock-face">
            ${List.generate(12, _buildTick).join()}
            <div class="hand hour" id="hour-hand"></div>
            <div class="hand minute" id="minute-hand"></div>
            <div class="hand second" id="second-hand"></div>
            <div class="center-cap"></div>
          </div>
        </div>
        <div class="meta">
          <span class="label">$_label</span>
          <span class="digital" id="digital">--:--:--</span>
          <span class="day" id="day-label"></span>
        </div>
      </div>
    '''
            .toJS;
  }

  static String _buildTick(int index) {
    final isMajor = index % 3 == 0;
    final classes = isMajor ? 'tick major' : 'tick';
    final rotation = index * 30;
    return '<div class="$classes" style="transform: rotate(${rotation}deg);"></div>';
  }

  void _startTicker() {
    _updateHands();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _updateHands());
    cleanup.add(() => _ticker?.cancel());
  }

  void _updateHands() {
    final now = Carbon.now(timeZone: _timezone);
    final seconds = now.second + now.millisecond / 1000;
    final minutes = now.minute + seconds / 60;
    final hours = (now.hour % 12) + minutes / 60;

    _setRotation('hour-hand', hours / 12);
    _setRotation('minute-hand', minutes / 60);
    _setRotation('second-hand', seconds / 60);

    final digital = _root?.getElementById('digital') as html.HTMLElement?;
    final dayLabel = _root?.getElementById('day-label') as html.HTMLElement?;
    digital?.textContent = now.format('HH:mm:ss');
    dayLabel?.textContent = now.isoFormat('dddd, MMMM Do');
  }

  void _setRotation(String id, double ratio) {
    final hand = _root?.getElementById(id) as html.HTMLElement?;
    if (hand == null) return;
    final degrees = ratio * 360;
    hand.style.transform =
        'translate(-50%, 0) rotate(${degrees.toStringAsFixed(3)}deg)';
  }
}
