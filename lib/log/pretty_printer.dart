import 'dart:convert';

import 'ansi_color.dart';
import 'log_entity.dart';
import 'log_printer.dart';

/// Default implementation of [LogPrinter].
///
/// Outut looks like this:
/// ```
/// ┌──────────────────────────
/// │ Error info
/// ├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
/// │ Method stack history
/// ├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
/// │ Log message
/// └──────────────────────────
/// ```
class PrettyPrinter extends LogPrinter {
  static const topLeftCorner = '┌';
  static const bottomLeftCorner = '└';
  static const middleCorner = '├';
  static const verticalLine = '│';
  static const doubleDivider = '─';
  static const singleDivider = '┄';

  static const String DOUBLE_DIVIDER =
      "────────────────────────────────────────────────────────";
  static const String SINGLE_DIVIDER =
      "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄";

  static final levelColors = {
    Level.debug: AnsiColor.fg(11),
    Level.error: AnsiColor.fg(38),
  };

  /// Matches a stacktrace line as generated on Android/iOS devices.
  /// For example:
  /// #1      Logger.log (package:logger/src/logger.dart:115:29)
  static final _deviceStackTraceRegex =
      RegExp(r'#[0-9]+[\s]+(.+) \(([^\s]+)\)');

  /// Matches a stacktrace line as generated by Flutter web.
  /// For example:
  /// packages/logger/src/printers/pretty_printer.dart 91:37
  static final _webStackTraceRegex =
      RegExp(r'^((packages|dart-sdk)\/[^\s]+\/)');

  static DateTime? _startTime;

  final int methodCount;
  final int errorMethodCount;
  final int lineLength;
  final bool colors;
  final bool printTime;

  String _topBorder = '';
  String _middleBorder = '';
  String _bottomBorder = '';

  PrettyPrinter({
    this.methodCount = 0,
    this.errorMethodCount = 8,
    this.lineLength = 100,
    this.colors = false,
    this.printTime = true,
  }) {
    _startTime ??= DateTime.now();

    _topBorder = '$topLeftCorner$DOUBLE_DIVIDER';
    _middleBorder = '$middleCorner$SINGLE_DIVIDER';
    _bottomBorder = '$bottomLeftCorner$DOUBLE_DIVIDER';
  }

  @override
  List<String> log(LogEvent event) {
    var messageStr = stringifyMessage(event.message);

    String? stackTraceStr;
    if (event.stackTrace == null) {
      if (methodCount > 0) {
        stackTraceStr = formatStackTrace(StackTrace.current, methodCount);
      }
    } else if (errorMethodCount > 0) {
      stackTraceStr = formatStackTrace(event.stackTrace, errorMethodCount);
    }

    var errorStr = event.error?.toString();

    String? timeStr;
    if (printTime) {
      timeStr = getTime();
    }

    return _formatAndPrint(event.level, messageStr, timeStr ?? "",
        errorStr ?? "", stackTraceStr ?? "");
  }

  String? formatStackTrace(StackTrace? stackTrace, int methodCount) {
    var lines = stackTrace.toString().split('\n');
    var formatted = <String>[];
    var count = 0;
    for (var line in lines) {
      if (_discardDeviceStacktraceLine(line) ||
          _discardWebStacktraceLine(line)) {
        continue;
      }
      formatted.add('#$count   ${line.replaceFirst(RegExp(r'#\d+\s+'), '')}');
      if (++count == methodCount) {
        break;
      }
    }

    if (formatted.isEmpty) {
      return null;
    } else {
      return formatted.join('\n');
    }
  }

  bool _discardDeviceStacktraceLine(String line) {
    var match = _deviceStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(2)?.startsWith('package:logger') ?? false;
  }

  bool _discardWebStacktraceLine(String line) {
    var match = _webStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return (match.group(1)?.startsWith('packages/logger') ?? false) ||
        (match.group(1)?.startsWith('dart-sdk/lib') ?? false);
  }

  String getTime() {
    String _threeDigits(int n) {
      if (n >= 100) return '$n';
      if (n >= 10) return '0$n';
      return '00$n';
    }

    String _twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    var now = DateTime.now();
    var y = now.year;
    var m = _twoDigits(now.month);
    var d = _twoDigits(now.day);
    var h = _twoDigits(now.hour);
    var min = _twoDigits(now.minute);
    var sec = _twoDigits(now.second);
    var ms = _threeDigits(now.millisecond);
    var timeSinceStart =
        now.difference(_startTime ?? DateTime.now()).toString();
    return '$y/$m/$d  $h:$min:$sec.$ms (+$timeSinceStart)';
  }

  String stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      var encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }

  AnsiColor _getLevelColor(Level level) {
    if (colors) {
      return levelColors[level]!;
    } else {
      return AnsiColor.none();
    }
  }

  AnsiColor _getErrorColor(Level level) {
    if (colors) {
      return levelColors[level]!;
    } else {
      return AnsiColor.none();
    }
  }

  List<String> _formatAndPrint(
    Level level,
    String message,
    String time,
    String error,
    String stacktrace,
  ) {
    // This code is non trivial and a type annotation here helps understanding.
    // ignore: omit_local_variable_types
    List<String> buffer = [];
    var color = _getLevelColor(level);
    buffer.add(color(_topBorder));

    if (error != null) {
      var errorColor = _getErrorColor(level);
      for (var line in error.split('\n')) {
        buffer.add(
          color('$verticalLine ') +
              errorColor.resetForeground +
              errorColor(line) +
              errorColor.resetBackground,
        );
      }
      buffer.add(color(_middleBorder));
    }

    if (stacktrace != null) {
      for (var line in stacktrace.split('\n')) {
        buffer.add('$color$verticalLine $line');
      }
      buffer.add(color(_middleBorder));
    }

    if (time != null) {
      buffer
        ..add(color('$verticalLine $time'))
        ..add(color(_middleBorder));
    }

    for (var line in message.split('\n')) {
      buffer.add(color('$verticalLine $line'));
    }
    buffer.add(color(_bottomBorder));

    return buffer;
  }
}
