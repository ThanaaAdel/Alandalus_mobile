import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
      methodCount: 0, // number of method calls to be displayed
      ),
);

log(String tag, String message) {
  logger.d('$tag : $message');
}
