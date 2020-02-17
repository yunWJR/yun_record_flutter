import 'package:intl/intl.dart';

class DateUtils {
  static String dayStr(DateTime dateTime) {
    if (dateTime != null) {
      return ymdDf().format(dateTime);
    }

    return null;
  }

  static bool sameDay(DateTime selDate, DateTime date) {
    if (selDate != null && date != null) {
      return ymdDf().format(selDate) == ymdDf().format(date);
    }

    return false;
  }

  static DateFormat ymdDf() {
    return new DateFormat('yyyy-MM-dd');
  }
}
