import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateTime convertMillisecondsToDateTime(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }
}

class DateUtilss {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, y, hh:mm a').format(dateTime);
  }
}
