import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  late final Logger logger;

  factory AppLogger() {
    return _instance;
  }

  AppLogger._internal() {
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0, // Без лишних стеков вызовов
        errorMethodCount: 5,
        lineLength: 80,
        colors: true,
        printEmojis: true,
      ),
    );
  }
}

final logger = AppLogger().logger;
