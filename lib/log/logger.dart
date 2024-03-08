import 'console_output.dart';
import 'log_entity.dart';
import 'log_output.dart';
import 'log_printer.dart';
import 'pretty_printer.dart';

class Logger {
  static Logger _instance = _getInstance();

  static Level level = Level.debug;

  final LogPrinter _printer;
  final LogOutput _output;
  final bool _loggable;

  Logger._internal({
    bool? loggable,
    LogPrinter? printer,
    LogOutput? output,
    Level? level,
  })  : _loggable = loggable ?? true,
        _printer = printer ?? PrettyPrinter(),
        _output = output ?? ConsoleOutput() {
    _printer.init();
    _output.init();
  }

  static init(bool loggable) {
    _getInstance(loggable: loggable);
  }

  static Logger _getInstance(
      {bool? loggable, LogPrinter? p, LogOutput? o, Level? l}) {
    _instance =
        Logger._internal(loggable: loggable, printer: p, output: o, level: l);
    return _instance;
  }

  /// Log a message at level [Level.debug].
  static void d(dynamic message, [String? tag, StackTrace? stackTrace]) {
    _instance.log(Level.debug, message,
        "D/PRETTY_LOGGER${tag == null ? "" : " [$tag] "}", stackTrace);
  }

  /// Log a message at level [Level.error].
  static void e(dynamic message, [String? tag, StackTrace? stackTrace]) {
    _instance.log(Level.error, message,
        "E/PRETTY_LOGGER${tag == null ? "" : " [$tag] "}", stackTrace);
  }

  /// Log a message with [level].
  void log(Level level, dynamic message, dynamic tag, StackTrace? stackTrace) {
    var logEvent = LogEvent(level, message, tag, stackTrace);
    if (_loggable) {
      var output = _printer.log(logEvent);
      if (output.isNotEmpty) {
        var outputEvent = OutputEvent(level, output);
        _output.output(outputEvent);
      }
    }
  }

  /// Closes the logger and releases all resources.
  void close() {
    _printer.destroy();
    _output.destroy();
  }
}
