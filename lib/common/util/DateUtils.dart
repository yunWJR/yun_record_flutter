import 'package:intl/intl.dart';

class DateUtils {
  static String dayStr(DateTime dateTime) {
    if (dateTime != null) {
      var formatter = new DateFormat('yyyy-MM-dd');
      return formatter.format(dateTime);
    }

    return null;
  }
}
