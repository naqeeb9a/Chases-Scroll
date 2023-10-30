import 'package:intl/intl.dart';

String formatEpoch(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String amPm = dateTime.hour < 12 ? 'AM' : 'PM';
  int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
  String formattedTime = "$hour:${dateTime.minute} $amPm";

  return formattedTime;
}

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
