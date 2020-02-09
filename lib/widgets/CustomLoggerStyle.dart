import 'package:logger/logger.dart';

class CustomLoggerStyle extends LogPrinter {
  @override

  List<String> log(LogEvent event) {
    print(event.message);
    return [event.message];
  }
}