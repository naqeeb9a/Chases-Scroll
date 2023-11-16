import 'package:intl/intl.dart';

String formatEpoch(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String amPm = dateTime.hour < 12 ? 'AM' : 'PM';
  int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
  String formattedTime = "$hour:${dateTime.minute} $amPm";

  return formattedTime;
}

String timeAgoFromEpoch(int epochMillis) {
  final now = DateTime.now();
  final dateTime = DateTime.fromMillisecondsSinceEpoch(epochMillis);
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    final hours = difference.inHours;
    return hours == 1 ? 'one hour ago' : '$hours hours ago';
  } else if (difference.inDays < 7) {
    final days = difference.inDays;
    return days == 1 ? 'one day ago' : '$days days ago';
  } else {
    final formatter = DateFormat('MMM d, HH:mm a');
    return 'on ${formatter.format(dateTime)}';
  }
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
